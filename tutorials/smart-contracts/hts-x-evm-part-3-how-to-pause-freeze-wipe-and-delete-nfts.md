# HTS x EVM - How to Pause, Freeze, Wipe, and Delete NFTs (Part 3)

In [HTS x EVM - Part 2](hts-x-evm-part-2-kyc-and-update.md), you learned how to grant / revoke KYC and manage a token using the [Hedera Token Service (HTS) System Smart Contract](../../core-concepts/smart-contracts/system-smart-contracts/#hedera-token-service). But those aren't all the token operations you can do!

In this guide, you will learn how to:

* **Pause** a token (stop all operations)
* **Freeze** a token for a specific account
* **Wipe** NFTs from a specific account
* **Delete** a token

***

## Prerequisites

* ECDSA account from the [Hedera Portal](https://portal.hedera.com/).
* Basic understanding of Solidity.

***

## Table of Contents <a href="#table-of-contents" id="table-of-contents"></a>

1. [Step 1: Creating, minting, and transferring an NFT](hts-x-evm-part-3-how-to-pause-freeze-wipe-and-delete-nfts.md#step-2.-creating-minting-and-transferring-an-nft)
2. [Step 2: Pause a Token](hts-x-evm-part-3-how-to-pause-freeze-wipe-and-delete-nfts.md#step-3.-pause-a-token)
3. [Step 3: Unpause a Token](hts-x-evm-part-3-how-to-pause-freeze-wipe-and-delete-nfts.md#step-4.-unpause-a-token)
4. [Step 4: Freeze a Token for a Specific Account](hts-x-evm-part-3-how-to-pause-freeze-wipe-and-delete-nfts.md#step-5.-freeze-a-token-for-a-specific-account)
5. [Step 5: Unfreeze a Token for a Specific Account](hts-x-evm-part-3-how-to-pause-freeze-wipe-and-delete-nfts.md#step-6.-unfreeze-a-token-for-a-specific-account)
6. [Step 6: Wipe a Token](hts-x-evm-part-3-how-to-pause-freeze-wipe-and-delete-nfts.md#step-7.-wipe-a-token)
7. [Step 7: Delete a Token](hts-x-evm-part-3-how-to-pause-freeze-wipe-and-delete-nfts.md#step-8.-delete-a-token)
8. [Step 8: Deploy Your HTS NFT Smart Contract](hts-x-evm-part-3-how-to-pause-freeze-wipe-and-delete-nfts.md#step-8-deploy-your-hts-nft-smart-contract)
9. [Step 9: Minting an HTS NFT ](hts-x-evm-part-3-how-to-pause-freeze-wipe-and-delete-nfts.md#step-9-minting-an-hts-nft-with-kyc)
10. [Step 10: Burning an HTS NFT](hts-x-evm-part-3-how-to-pause-freeze-wipe-and-delete-nfts.md#step-10-burning-an-hts-nft)
11. [Step 11: Run tests](hts-x-evm-part-3-how-to-pause-freeze-wipe-and-delete-nfts.md#step-11-run-tests-optional)
12. [Conclusion](hts-x-evm-part-3-how-to-pause-freeze-wipe-and-delete-nfts.md#conclusion)
13. [Additional Resources](hts-x-evm-part-3-how-to-pause-freeze-wipe-and-delete-nfts.md#additional-resources)

***

## Step 1. Creating, minting, and burning an NFT

These steps of the flow have been covered in the [Part 1](hts-x-evm-part-1-how-to-mint-nfts.md#id-2.-minting-an-nft) and [Part 2](hts-x-evm-part-2-kyc-and-update.md). The only difference here is that we set a few different keys to handle pausing, freezing, and wiping.

The previous tutorials covered creating NFT collection. Everything remains largely the same except for the following changes:

* Add one additional line for managing the PAUSE key that can be used to prevent the token from being involved in any kind of operation.
* Add one additional line for managing the FREEZE key that can be used to freeze transfers of the specified token for the account.
* Add one additional line for managing the WIPE key that can be used to wipe the provided amount of fungible or non-fungible tokens from the specified Hedera account. This transaction does not delete tokens from the treasury account. Wiping an account's tokens burns the tokens and decreases the total supply.
* Add one additional line for managing the DELETE key that can be used to mark a token as deleted, though it will remain in the ledger. Once deleted update, mint, burn, wipe, freeze, unfreeze, grant KYC, revoke KYC and token transfer transactions will resolve to TOKEN\_WAS\_DELETED. You cannot delete a specific NFT. You can delete the class of the NFT specified by the token ID after you have burned all associated NFTs associated with the token class

#### **Key Code Snippet:**

{% code title="contracts/MyHTSTokenPFWD.sol" overflow="wrap" %}
```solidity
contract MyHTSTokenPFWD is HederaTokenService, KeyHelper, Ownable {
    ... 
    function createNFTCollection(
        string memory _name,
        string memory _symbol
    ) external payable onlyOwner {
        require(tokenAddress == address(0), "Already initialized");

        name = _name;
        symbol = _symbol;

        // Build token definition
        IHederaTokenService.HederaToken memory token;
        token.name = name;
        token.symbol = symbol;
        token.treasury = address(this);
        token.memo = "";

        // Keys: SUPPLY + ADMIN + PAUSE + FREEZE + WIPE + DELETE -> contractId
        IHederaTokenService.TokenKey[]
            memory keys = new IHederaTokenService.TokenKey[](6);
        keys[0] = getSingleKey(
            KeyType.SUPPLY,
            KeyValueType.CONTRACT_ID,
            address(this)
        );
        keys[1] = getSingleKey(
            KeyType.ADMIN,
            KeyValueType.CONTRACT_ID,
            address(this)
        );
        keys[2] = getSingleKey(
            KeyType.PAUSE,
            KeyValueType.CONTRACT_ID,
            address(this)
        );
        keys[3] = getSingleKey(
            KeyType.FREEZE,
            KeyValueType.CONTRACT_ID,
            address(this)
        );
        keys[4] = getSingleKey(
            KeyType.WIPE,
            KeyValueType.CONTRACT_ID,
            address(this)
        );
        keys[5] = getSingleKey(
            KeyType.DELETE,
            KeyValueType.CONTRACT_ID,
            address(this)
        );
        token.tokenKeys = keys;

        (int rc, address created) = createNonFungibleToken(token);
        require(rc == HederaResponseCodes.SUCCESS, "HTS: create NFT failed");
        tokenAddress = created;

        emit NFTCollectionCreated(created);
    }
    ...
}
```
{% endcode %}

***

## Step 2. Pause a Token

Let's update our contract by:

* Adding a new function `pauseToken` to pause the token so it prevents the token from being involved in any kind of operation.&#x20;
* We will also define a new event `TokenPaused`.  &#x20;

#### **Key Code Snippet:**

{% code title="contracts/MyHTSTokenPFWD.sol" overflow="wrap" %}
```solidity
contract MyHTSTokenPFWD is HederaTokenService, KeyHelper, Ownable {
    ... 
    event TokenPaused();
    ...
    function pauseToken() external onlyOwner {
        require(tokenAddress != address(0), "HTS: not created");
        int response = pauseToken(tokenAddress);
        require(
            response == HederaResponseCodes.SUCCESS,
            "HTS: pause token failed"
        );
        emit TokenPaused();
    }
    ...
}
```
{% endcode %}

***

## Step 3. Unpause a Token

Let's update our contract by:

* Adding a new function `unpauseToken` to unpause the token so the token operations can be executed again.&#x20;
* We will also define a new event `TokenPaused`.  &#x20;

#### **Key Code Snippet:**

{% code title="contracts/MyHTSTokenPFWD.sol" overflow="wrap" %}
```solidity
contract MyHTSTokenPFWD is HederaTokenService, KeyHelper, Ownable {
    ... 
    event TokenUnpaused();
    ...
    function unpauseToken() external onlyOwner {
        require(tokenAddress != address(0), "HTS: not created");
        int response = unpauseToken(tokenAddress);
        require(
            response == HederaResponseCodes.SUCCESS,
            "HTS: unpause token failed"
        );
        emit TokenUnpaused();
    }
    ...
}
```
{% endcode %}

***

## Step 4. Freeze a Token for a Specific Account

Let's update our contract by:

* Adding a new function `freezeAccount` to freezes a specific account, meaning it can neither send nor receive the token. Freezing is more granular than pausing; it only affects a specific account. This is useful for making soul-bound tokens.
* We will also define a new event `AccountFrozen`.

#### **Key Code Snippet:**

{% code title="contracts/MyHTSTokenPFWD.sol" overflow="wrap" %}
```solidity
contract MyHTSTokenPFWD is HederaTokenService, KeyHelper, Ownable {
    ... 
    event AccountFrozen(address indexed account);
    ...
    function freezeAccount(address account) external onlyOwner {
        require(tokenAddress != address(0), "HTS: not created");
        int response = freezeToken(tokenAddress, account);
        require(
            response == HederaResponseCodes.SUCCESS,
            "HTS: freeze account failed"
        );
        emit AccountFrozen(account);
    }
    ...
}
```
{% endcode %}

***

## Step 5. Unfreeze a Token for a Specific Account

Let's update our contract by:

* Adding a new function `unfreezeAccount` to unfreeze the token for a specific account.
* We will also define a new event `AccountUnFrozen`.

#### **Key Code Snippet:**

{% code title="contracts/MyHTSTokenPFWD.sol" overflow="wrap" %}
```solidity
contract MyHTSTokenPFWD is HederaTokenService, KeyHelper, Ownable {
    ... 
    event AccountUnFrozen(address indexed account);
    ...
    function unfreezeAccount(address account) external onlyOwner {
        require(tokenAddress != address(0), "HTS: not created");
        int response = unfreezeToken(tokenAddress, account);
        require(
            response == HederaResponseCodes.SUCCESS,
            "HTS: unfreeze account failed"
        );
        emit AccountUnfrozen(account);
    }
    ...
}
```
{% endcode %}

After unfreezing, the `owner` account can transact freely again.

***

## Step 6. Wipe a Token

Let's update our contract by:

*   Adding a new function `wipeTokenFromAccount` to wipe the NFT from an account. This effectively burns that token (i.e., reduces the total supply) from a non-treasury account.

    For [**fungible tokens**](../../support-and-community/glossary.md#fungible-token), specify an amount to wipe; for [**non-fungible tokens (NFTs)**](../../support-and-community/glossary.md#non-fungible-token-nft), we specify the serial numbers to be wiped.
* We will also define a new event `TokenWiped`.

#### **Key Code Snippet:**

{% code title="contracts/MyHTSTokenPFWD.sol" %}
```solidity
contract MyHTSTokenPFWD is HederaTokenService, KeyHelper, Ownable {
    ... 
    event TokenWiped(address indexed account, int64[] serialNumbers);
    ...
    function wipeTokenFromAccount(
        address account,
        int64[] memory serialNumbers
    ) external onlyOwner {
        require(tokenAddress != address(0), "HTS: not created");
        int response = wipeTokenAccountNFT(
            tokenAddress,
            account,
            serialNumbers
        );
        require(
            response == HederaResponseCodes.SUCCESS,
            "HTS: wipe token failed"
        );
        emit TokenWiped(account, serialNumbers);
    }
    ...
}
```
{% endcode %}

***

## Step 7. Delete a Token

Let's update our contract by:

* Adding a new function `deleteToken` to delete the token. This renders a token completely unusable for future operations. The token still exists on the ledger (you can query it), but all transactions (e.g., minting, transfers, etc.) will fail. The **ADMIN** key is required to delete.
* We will also define a new event `TokenDeleted`.

#### **Key Code Snippet**:

{% code title="contracts/MyHTSTokenPFWD.sol" %}
```solidity
contract MyHTSTokenPFWD is HederaTokenService, KeyHelper, Ownable {
    ... 
    event TokenDeleted();
    ...
    function deleteToken() external onlyOwner {
        require(tokenAddress != address(0), "HTS: not created");
        int response = deleteToken(tokenAddress);
        require(
            response == HederaResponseCodes.SUCCESS,
            "HTS: delete token failed"
        );
        emit TokenDeleted();
    }

    ...
}
```
{% endcode %}

Once deleted, attempting further operations like minting will fail.



Here's the complete contract code for `MyHTSTokenPFWD.sol`:

{% code title="contracts/MyHTSTokenPFWD.sol" overflow="wrap" %}
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

// Admin/ownership like the OZ example
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
// Read/transfer via ERC721 facade exposed at the HTS token EVM address
import {IERC721} from "@openzeppelin/contracts/interfaces/IERC721.sol";

// Hedera HTS system contracts (as in your setup)
// Hedera HTS system contracts (v1, NOT v2)
import {HederaTokenService} from "@hashgraph/smart-contracts/contracts/system-contracts/hedera-token-service/HederaTokenService.sol";
import {IHederaTokenService} from "@hashgraph/smart-contracts/contracts/system-contracts/hedera-token-service/IHederaTokenService.sol";
import {HederaResponseCodes} from "@hashgraph/smart-contracts/contracts/system-contracts/HederaResponseCodes.sol";
import {KeyHelper} from "@hashgraph/smart-contracts/contracts/system-contracts/hedera-token-service/KeyHelper.sol";

/**
 * HTS-backed ERC721-like collection:
 * - Creates the HTS NFT collection in the constructor (like deploying an ERC721).
 * - SUPPLY key = this contract (mint/burn only via contract).
 * - ADMIN key  = this contract (admin updates only via contract).
 * - PAUSE key  = this contract (pause/unpause via contract).
 * - FREEZE key  = this contract (freeze/unfreeze via contract).
 * - WIPE key  = this contract (wipe via contract).
 * - Holders use the token’s ERC721 facade directly (SDK or EVM).
 */
contract MyHTSTokenPFWD is HederaTokenService, KeyHelper, Ownable {
    // Underlying HTS NFT token EVM address (set during initialize. This is the "ERC721-like" token)
    address public tokenAddress;

    // Cosmetic copies for convenience (optional)
    string public name;
    string public symbol;

    // Small non-empty default metadata for simple mints (<=100 bytes as per HTS limit)
    bytes private constant DEFAULT_METADATA = hex"01";
    uint256 private constant INT64_MAX = 0x7fffffffffffffff;

    event NFTCollectionCreated(address indexed token);
    event NFTMinted(
        address indexed to,
        uint256 indexed tokenId,
        int64 newTotalSupply
    );
    event NFTBurned(uint256 indexed tokenId, int64 newTotalSupply);
    event TokenPaused();
    event TokenUnpaused();
    event AccountFrozen(address indexed account);
    event AccountUnfrozen(address indexed account);
    event TokenWiped(address indexed account, int64[] serialNumbers);
    event TokenDeleted();
    event HBARReceived(address indexed from, uint256 amount);
    event HBARFallback(address sender, uint256 amount, bytes data);
    event HBARWithdrawn(address indexed to, uint256 amount);

    /**
     * Constructor sets ownership.
     * Actual HTS token creation happens in createNFTCollection().
     */
    constructor() Ownable(msg.sender) {}

    /**
     * Creates the HTS NFT collection with custom fees.
     * Can be called exactly once by the owner after deployment.
     *
     * @param _name         Token/collection name
     * @param _symbol       Token/collection symbol
     */
    function createNFTCollection(
        string memory _name,
        string memory _symbol
    ) external payable onlyOwner {
        require(tokenAddress == address(0), "Already initialized");

        name = _name;
        symbol = _symbol;

        // Build token definition
        IHederaTokenService.HederaToken memory token;
        token.name = name;
        token.symbol = symbol;
        token.treasury = address(this);
        token.memo = "";

        // Keys: SUPPLY + ADMIN/DELETE + PAUSE + FREEZE + WIPE -> contractId
        IHederaTokenService.TokenKey[]
            memory keys = new IHederaTokenService.TokenKey[](5);
        keys[0] = getSingleKey(
            KeyType.SUPPLY,
            KeyValueType.CONTRACT_ID,
            address(this)
        );
        keys[1] = getSingleKey(
            KeyType.ADMIN,
            KeyValueType.CONTRACT_ID,
            address(this)
        );
        keys[2] = getSingleKey(
            KeyType.PAUSE,
            KeyValueType.CONTRACT_ID,
            address(this)
        );
        keys[3] = getSingleKey(
            KeyType.FREEZE,
            KeyValueType.CONTRACT_ID,
            address(this)
        );
        keys[4] = getSingleKey(
            KeyType.WIPE,
            KeyValueType.CONTRACT_ID,
            address(this)
        );
        token.tokenKeys = keys;

        (int rc, address created) = createNonFungibleToken(token);
        require(rc == HederaResponseCodes.SUCCESS, "HTS: create NFT failed");
        tokenAddress = created;

        emit NFTCollectionCreated(created);
    }

    // ---------------------------------------------------------------------------
    // ERC721-like minting (admin via Ownable + SUPPLY key on contract)
    // ---------------------------------------------------------------------------

    // Minimal API parity: mintNFT(to) onlyOwner -> returns new tokenId (serial)
    function mintNFT(address to) public onlyOwner returns (uint256) {
        return _mintAndSend(to, DEFAULT_METADATA);
    }

    // Optional overload with custom metadata (<= 100 bytes)
    function mintNFT(
        address to,
        bytes memory metadata
    ) public onlyOwner returns (uint256) {
        require(metadata.length <= 100, "HTS: metadata >100 bytes");
        return _mintAndSend(to, metadata);
    }

    function _mintAndSend(
        address to,
        bytes memory metadata
    ) internal returns (uint256 tokenId) {
        require(tokenAddress != address(0), "HTS: not created");

        // 1) Mint to treasury (this contract)
        bytes[] memory arr = new bytes[](1);
        arr[0] = metadata;
        (int rc, int64 newTotalSupply, int64[] memory serials) = mintToken(
            tokenAddress,
            0,
            arr
        );
        require(
            rc == HederaResponseCodes.SUCCESS && serials.length == 1,
            "HTS: mint failed"
        );

        // 2) Transfer from treasury -> recipient via ERC721 facade
        uint256 serial = uint256(uint64(serials[0]));
        // Recipient must be associated (or have auto-association available)
        IERC721(tokenAddress).transferFrom(address(this), to, serial);

        emit NFTMinted(to, serial, newTotalSupply);
        return serial;
    }

    // ---------------------------------------------------------------------------
    // ERC721Burnable-like flow for holders
    // ---------------------------------------------------------------------------

    // Holder-initiated burn:
    // - User approves this contract for tokenId (approve or setApprovalForAll)
    // - Calls burn(tokenId); contract pulls to treasury and burns via HTS
    // Allows onlyOwner to burn when the NFT is already in treasury,
    // avoiding the need for ERC721 approvals in that case.
    function burnNFT(uint256 tokenId) external {
        require(tokenAddress != address(0), "HTS: not created");

        address owner_ = IERC721(tokenAddress).ownerOf(tokenId);

        // Match ERC721Burnable semantics: only the token owner or an approved operator may trigger burn
        require(
            msg.sender == owner_ ||
                IERC721(tokenAddress).getApproved(tokenId) == msg.sender ||
                IERC721(tokenAddress).isApprovedForAll(owner_, msg.sender),
            "caller not owner nor approved"
        );

        // If not already in treasury, ensure this contract is approved to pull the token and then pull it
        if (owner_ != address(this)) {
            bool contractApproved = IERC721(tokenAddress).getApproved(
                tokenId
            ) ==
                address(this) ||
                IERC721(tokenAddress).isApprovedForAll(owner_, address(this));
            require(contractApproved, "contract not approved to transfer");
            IERC721(tokenAddress).transferFrom(owner_, address(this), tokenId);
        }

        // Burn via HTS (requires token to be in treasury)
        int64[] memory serials = new int64[](1);
        serials[0] = _toI64(tokenId);
        (int rc, int64 newTotalSupply) = burnToken(tokenAddress, 0, serials);
        require(rc == HederaResponseCodes.SUCCESS, "HTS: burn failed");

        emit NFTBurned(tokenId, newTotalSupply);
    }

    function pauseToken() external onlyOwner {
        require(tokenAddress != address(0), "HTS: not created");
        int response = pauseToken(tokenAddress);
        require(
            response == HederaResponseCodes.SUCCESS,
            "HTS: pause token failed"
        );
        emit TokenPaused();
    }

    function unpauseToken() external onlyOwner {
        require(tokenAddress != address(0), "HTS: not created");
        int response = unpauseToken(tokenAddress);
        require(
            response == HederaResponseCodes.SUCCESS,
            "HTS: unpause token failed"
        );
        emit TokenUnpaused();
    }

    function freezeAccount(address account) external onlyOwner {
        require(tokenAddress != address(0), "HTS: not created");
        int response = freezeToken(tokenAddress, account);
        require(
            response == HederaResponseCodes.SUCCESS,
            "HTS: freeze account failed"
        );
        emit AccountFrozen(account);
    }

    function unfreezeAccount(address account) external onlyOwner {
        require(tokenAddress != address(0), "HTS: not created");
        int response = unfreezeToken(tokenAddress, account);
        require(
            response == HederaResponseCodes.SUCCESS,
            "HTS: unfreeze account failed"
        );
        emit AccountUnfrozen(account);
    }

    function wipeTokenFromAccount(
        address account,
        int64[] memory serialNumbers
    ) external onlyOwner {
        require(tokenAddress != address(0), "HTS: not created");
        int response = wipeTokenAccountNFT(
            tokenAddress,
            account,
            serialNumbers
        );
        require(
            response == HederaResponseCodes.SUCCESS,
            "HTS: wipe token failed"
        );
        emit TokenWiped(account, serialNumbers);
    }

    function deleteToken() external onlyOwner {
        require(tokenAddress != address(0), "HTS: not created");
        int response = deleteToken(tokenAddress);
        require(
            response == HederaResponseCodes.SUCCESS,
            "HTS: delete token failed"
        );
        emit TokenDeleted();
    }

    // ---------------------------------------------------------------------------
    // HBAR handling
    // ---------------------------------------------------------------------------

    // Accept HBAR
    receive() external payable {
        emit HBARReceived(msg.sender, msg.value);
    }

    fallback() external payable {
        emit HBARFallback(msg.sender, msg.value, msg.data);
    }

    function withdrawHBAR() external onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, "No HBAR to withdraw");
        (bool success, ) = owner().call{value: balance}("");
        require(success, "Failed to withdraw HBAR");
        emit HBARWithdrawn(owner(), balance);
    }

    // --------------------- internal helpers ---------------------
    function _toI64(uint256 x) internal pure returns (int64) {
        require(x <= INT64_MAX, "cast: > int64.max");
        return int64(uint64(x));
    }
}
```
{% endcode %}

***

## Step 8: Deploy Your HTS NFT Smart Contract

Create a deployment script (`deployPFWD.ts`) in `scripts` directory:

{% code title="scripts/deployPWD.ts" %}
```typescript
import { network } from "hardhat";

const { ethers } = await network.connect({ network: "testnet" });

async function main() {
  const [deployer] = await ethers.getSigners();
  console.log("Deploying contract with the account:", deployer.address);

  // 1) Deploy the PFWD wrapper contract
  const MyHTSTokenPFWD = await ethers.getContractFactory(
    "MyHTSTokenPFWD",
    deployer
  );
  const contract = await MyHTSTokenPFWD.deploy();
  await contract.waitForDeployment();

  // 2) Create the HTS NFT collection by calling createNFTCollection()
  const NAME = "MyHTSTokenPFWDCollection";
  const SYMBOL = "MHTPFWD";
  const HBAR_TO_SEND = "15"; // HBAR to send with createNFTCollection()

  console.log(
    `Calling createNFTCollection() with ${HBAR_TO_SEND} HBAR to create the HTS collection...`
  );
  const tx = await contract.createNFTCollection(NAME, SYMBOL, {
    gasLimit: 350_000,
    value: ethers.parseEther(HBAR_TO_SEND)
  });
  await tx.wait();
  console.log("createNFTCollection() tx hash:", tx.hash);

  // 3) Read the created HTS token address
  const contractAddress = await contract.getAddress();
  console.log("MyHTSTokenPFWD contract deployed at:", contractAddress);
  const tokenAddress = await contract.tokenAddress();
  console.log(
    "Underlying HTS NFT Collection (ERC721 facade) address:",
    tokenAddress
  );
}

main().catch(console.error);
```
{% endcode %}

In this script, we first retrieve your account (the deployer) using Ethers.js. This account will own the deployed smart contract. Next, we use this account to deploy the contract by calling `MyHTSTokenPFWD.deploy()`.&#x20;

{% hint style="info" %}
**Note**

For most HTS [System Smart Contract](../../core-concepts/smart-contracts/system-smart-contracts/) calls, an HBAR value **is not** required to be sent in the contract call; the gas fee will cover it. However, for expensive transactions, like [Create HTS NFT Collection](hts-x-evm-part-3-how-to-pause-freeze-wipe-and-delete-nfts.md#step-3-deploy-your-hts-nft-smart-contract), the gas fee is reduced, and the transaction cost is covered by the payable amount. This is to reduce the gas consumed by the contract call.
{% endhint %}

Deploy your contract by executing the script:

```bash
npx hardhat run scripts/deployPFWD.ts --network testnet
```

{% hint style="success" %}
Copy the deployed address—you'll need this in subsequent steps.
{% endhint %}

The output looks like this:

```bash
Deploying contract with the account: 0xA98556A4deeB07f21f8a66093989078eF86faa30
Calling createNFTCollection() with 15 HBAR to create the HTS collection...
createNFTCollection() tx hash: 0xaece990a241306d6c3e506347406232d1209e2e7037ccb3c808d872a3c91b280
MyHTSTokenPFWD contract deployed at: 0xFe70397079f479539977F60340ffa68Ff41d520f
Underlying HTS NFT Collection (ERC721 facade) address: 0x000000000000000000000000000000000068d4fd
```

## Step 9: Minting an HTS NFT

Create a `mintNFTPFWD.ts` script in your `scripts` directory to mint an NFT. Don't forget to replace the `<your-contract-address>` with the address you've just copied.&#x20;

{% code title="scripts/mintNFTPFWD.ts" %}
```typescript
import { network } from "hardhat";

const { ethers } = await network.connect({ network: "testnet" });

async function main() {
  const [signer] = await ethers.getSigners();
  console.log("Using signer:", signer.address);

  // Replace with your deployed MyHTSTokenPFWD contract address
  const contractAddress = "<your-contract-address>";
  const recipient = signer.address;

  const myHTSTokenPFWDContract = await ethers.getContractAt(
    "MyHTSTokenPFWD",
    contractAddress,
    signer
  );

  // Display the underlying HTS token address
  const tokenAddress = await myHTSTokenPFWDContract.tokenAddress();
  console.log("HTS ERC721 facade address:", tokenAddress);

  // 1) Associate the signer via token.associate() (EOA -> token contract)
  const tokenAssociateAbi = ["function associate()"];
  const token = new ethers.Contract(tokenAddress, tokenAssociateAbi, signer);
  console.log("Associating signer to token via token.associate() ...");
  const assocTx = await token.associate({ gasLimit: 800_000 });
  await assocTx.wait();
  console.log("Associate tx hash:", assocTx.hash);

  // 2) Prepare metadata (<= 100 bytes)
  const metadata = ethers.hexlify(
    ethers.toUtf8Bytes(
      "ipfs://bafkreibr7cyxmy4iyckmlyzige4ywccyygomwrcn4ldcldacw3nxe3ikgq"
    )
  );
  const byteLen = ethers.getBytes(metadata).length;
  if (byteLen > 100) {
    throw new Error(
      `Metadata is ${byteLen} bytes; must be <= 100 bytes for HTS`
    );
  }

  // 3) Mint the NFT via the wrapper (wrapper holds supply key)
  console.log(`Minting NFT to ${recipient} with metadata: ${metadata} ...`);
  // Note: Our mintNFT function is overloaded; we must use this syntax to disambiguate
  // or we get a typescript error.
  const tx = await myHTSTokenPFWDContract["mintNFT(address,bytes)"](
    recipient,
    metadata,
    {
      gasLimit: 400_000
    }
  );
  await tx.wait();
  console.log("Mint tx hash:", tx.hash);

  // Check recipient's NFT balance on the ERC721 facade (not on MyHTSTokenPFWD)
  const erc721 = new ethers.Contract(
    tokenAddress,
    ["function balanceOf(address owner) view returns (uint256)"],
    signer
  );
  const balance = (await erc721.balanceOf(recipient)) as bigint;
  console.log("Balance:", balance.toString(), "NFTs");
}

main().catch(console.error);
```
{% endcode %}

{% hint style="info" %}
**How It Works**

1. Connects to Hedera testnet, gets the first signer, and attaches to your deployed MyHTSTokenPFWD contract.
2. Reads the underlying HTS ERC721 facade address (tokenAddress) from the contract.
3. Associates the signer via `token.associate()`(EOA -> token contract)
4. Constructs <=100-byte UTF-8 metadata and calls mintNFT(recipient, metadata), then waits for the transaction receipt.
5. Mints NFT to recipient
6. Queries balanceOf(recipient) on the ERC721 facade and logs the current NFT count.
{% endhint %}

The code mints a new NFT to your account ( `signer.address` ). Then we verify the balance to see if we own an HTS NFT.

Mint an NFT:

```bash
npx hardhat run scripts/mintNFTPFWD.ts --network testnet
```

Expected output:

```bash
Using signer: 0xA98556A4deeB07f21f8a66093989078eF86faa30
HTS ERC721 facade address: 0x000000000000000000000000000000000068d4fd
Associating signer to token via token.associate() ...
Associate tx hash: 0xa99f461511b1dc497aaa1a03234dfd915b531cb4433eacb27fb63006f5310bdf
Minting NFT to 0xA98556A4deeB07f21f8a66093989078eF86faa30 with metadata: 0x697066733a2f2f6261666b7265696272376379786d79346979636b6d6c797a69676534797763637979676f6d7772636e346c64636c64616377336e786533696b6771 ...
Mint tx hash: 0x71e5e810ef098ceb45542e29a2c2f88dedf078f92b35847021e982ef5059c6cc
Balance: 1 NFTs
```

***

## Step 10: Burning an HTS NFT

Create a burn script (`burnNFTPFWD.ts` ) in your `scripts` directory. Make sure to replace `<your-contract-address>` to the MyHTSToken contract address you got from deploying and replace `<your-token-id>` with the tokenId you want to burn(eg. "1") :

{% code title="scripts/burnNFTPFWD.ts" %}
```typescript
import { network } from "hardhat";
import type { ContractTransactionResponse } from "ethers";

const { ethers } = await network.connect({ network: "testnet" });

async function main() {
  const [signer] = await ethers.getSigners();
  console.log("Using signer:", signer.address);

  // Replace with your deployed MyHTSTokenPFWD contract address and the tokenId to burn
  const contractAddress = "<your-contract-address>";
  const tokenId = BigInt("<your-token-id>");

  const myHTSTokenPFWDContract = await ethers.getContractAt(
    "MyHTSTokenPFWD",
    contractAddress,
    signer
  );

  const tokenAddress: string = await myHTSTokenPFWDContract.tokenAddress();
  console.log("HTS ERC721 facade address:", tokenAddress);

  // Minimal ERC721 ABI for approvals and balance
  const erc721 = new ethers.Contract(
    tokenAddress,
    [
      "function approve(address to, uint256 tokenId) external",
      "function getApproved(uint256 tokenId) external view returns (address)",
      "function ownerOf(uint256 tokenId) external view returns (address)",
      "function balanceOf(address owner) external view returns (uint256)"
    ],
    signer
  );

  const ownerOfToken: string = await erc721.ownerOf(tokenId);
  console.log("Current owner of token:", ownerOfToken);

  // Check if already approved for this tokenId; if not, approve MyHTSTokenPFWD contract
  const currentApproved: string = await erc721.getApproved(tokenId);
  if (currentApproved.toLowerCase() !== contractAddress.toLowerCase()) {
    console.log(
      `Approving MyHTSTokenPFWD contract ${contractAddress} for tokenId ${tokenId.toString()}...`
    );
    const approveTx = (await erc721.approve(
      contractAddress,
      tokenId
    )) as unknown as ContractTransactionResponse;
    await approveTx.wait();
    console.log("Approval tx hash:", approveTx.hash);
  } else {
    console.log(
      "MyHTSTokenPFWD contract is already approved for this tokenId."
    );
  }

  // Burn via MyHTSTokenPFWD
  console.log(`Burning tokenId ${tokenId.toString()}...`);
  const burnTx = (await myHTSTokenPFWDContract.burnNFT(tokenId, {
    gasLimit: 200_000
  })) as unknown as ContractTransactionResponse;
  await burnTx.wait();
  console.log("Burn tx hash:", burnTx.hash);

  // Show caller's balance after burn
  const balanceAfter = (await erc721.balanceOf(signer.address)) as bigint;
  console.log("Balance after burn:", balanceAfter.toString(), "NFTs");
}

main().catch(console.error);

```
{% endcode %}

{% hint style="info" %}
**How It Works**

1. Connects to Hedera testnet, gets the signer, attaches to MyHTSTokenPFWD, and reads the ERC721 facade tokenAddress.
2. Checks token ownership and existing approval; if needed, approves the MyHTSTokenPFWD contract for the specific tokenId.
3. Calls burnNFT(tokenId) on MyHTSTokenPFWD and waits for the transaction receipt.
4. Reads and logs the signer’s NFT balance from the ERC721 facade after the burn.
{% endhint %}

The script will burn the HTS NFT with the ID set to `1`, which is the HTS NFT you've just minted. To be sure the token has been deleted, let's print the balance for our account to the terminal. The balance should show a balance of `0`.

Burn the NFT:

```bash
npx hardhat run scripts/burnNFTPFWD.ts --network testnet
```

You should get an output similar to:

```bash
Using signer: 0xA98556A4deeB07f21f8a66093989078eF86faa30
HTS ERC721 facade address: 0x000000000000000000000000000000000068d4fd
Current owner of token: 0xA98556A4deeB07f21f8a66093989078eF86faa30
Approving MyHTSTokenPFWD contract 0xFe70397079f479539977F60340ffa68Ff41d520f for tokenId 1...
Approval tx hash: 0x25b3db7091071adc56ec08ec3b15d341d535e8e7e2928d64890cfea259d2e9ce
Burning tokenId 1...
Burn tx hash: 0x6376fb7fee4278cac286c72d81dc787ed8e2e052b1ae719e2bb4dcf8bb279b30
Balance after burn: 0 NFTs
```

**Congratulations! 🎉 You have successfully learned how to deploy an HTS NFT collection smart contract using Hardhat, OpenZeppelin, and Ethers. Feel free to reach out in** [**Discord**](https://hedera.com/discord)**!**

## Step 11: Run tests(Optional)

You can find both types of tests in the [**Hedera-Code-Snippets repository**](https://github.com/hedera-dev/hedera-code-snippets/tree/main/hts-evm-mint-nfts). You will find the following files:

* `contracts/MyHTSTokenPFWD.t.sol`

{% hint style="info" %}
- **Ownership and access control:** Verifies the constructor sets owner correctly and onlyOwner is enforced for create/pause/unpause/freeze/unfreeze/wipe/delete (non-owners revert with OwnableUnauthorizedAccount).
- **Pre-creation guards and validation:** Ensures all HTS-dependent functions revert with "HTS: not created" before collection setup, and rejects minting when metadata exceeds 100 bytes.
- **Native HBAR flow:** Confirms the contract can receive HBAR (HBARReceived event), blocks non-owner withdrawals, and allows the owner to withdraw all HBAR (HBARWithdrawn event) leaving balance at zero.
{% endhint %}

* `test/MyHTSTokenPFWD.ts`

{% hint style="info" %}
- **End-to-end setup:** Deploys the PFWD wrapper, creates the HTS NFT collection (with PAUSE/FREEZE/WIPE/ADMIN keys), retrieves the ERC721 facade address, generates/funds a second wallet, and associates both accounts on-chain via token.associate().
- **Minting and event parsing**: Mints NFT to deployer (tokenIdA) and to user2 (tokenIdB), parsing the NFTMinted event from wrapper logs; validates ownership/balances via the ERC721 facade.
- **Pause/unpause lifecycle:** Asserts transfers revert while paused and succeed after unpausing, confirming correct enforcement of the PAUSE key.
- **Freeze/unfreeze enforcement:** Freezes user2 to block outgoing transfers, then unfreezes and verifies transfers succeed again, demonstrating account-level restrictions.
- **Cleanup and failure handling:** Attempts a wipe of user2’s token (freezing if necessary) and falls back to user-approved burn if wipe isn’t permitted; then approves and burns the remaining token, deletes the token (when supply is zero), and verifies subsequent mints fail.
{% endhint %}

Copy these files and then run the tests:

```bash
# This will run the tests via hardhat
npx hardhat test solidity 
# This will run the tests via hedera testnet as the precompiles 
# are not available on hardhat locally and we must use the testnet
npx hardhat test mocha 
```

You can also run both the solidity and mocha tests altogether:

```bash
npx hardhat test
```

***

## Conclusion

In this guide, you saw how to replicate key HTS operations (pause, freeze, wipe, delete) **directly in a Solidity contract** by calling the HTS System Contract functions on Hedera. This approach provides fine-grained control via the contract’s ownership and key management, which is especially useful if you need all relevant HTS functionality in a single deployable smart contract.

**Key Takeaways:**

* If you want to perform the respective operations later, you must set the **ADMIN**, **FREEZE**, **PAUSE**, **WIPE**, and **SUPPLY** keys when creating a token via a contract.
* Any account that needs to receive or send the token must be associated with it.
* Pausing affects **all** operations globally while freezing targets a **single** account.
* Wiping NFTs effectively burns them, reducing total supply.
* Deleting a token makes it unusable for future operations but remains queryable on the ledger.

***

## Additional Resources

Check out our GitHub repo to find the full contract and Hardhat test scripts, along with the configuration files you need to deploy and test on Hedera!

* [Full Contract and Tests Repository](https://github.com/hedera-dev/hedera-code-snippets/tree/main/hts-evm-mint-nfts)

<table data-card-size="large" data-view="cards"><thead><tr><th align="center"></th><th data-hidden data-card-target data-type="content-ref"></th></tr></thead><tbody><tr><td align="center"><p>Writer: Jake, Developer Relations Engineer</p><p><a href="https://github.com/jaycoolh">GitHub</a> | <a href="https://x.com/jaycoolh">X</a></p></td><td><a href="https://github.com/jaycoolh">https://github.com/jaycoolh</a></td></tr><tr><td align="center"><p>Editor: Michiel, Developer Relations Engineer</p><p><a href="https://github.com/michielmulders">GitHub</a> | <a href="https://www.linkedin.com/in/michielmulders/">LinkedIn</a></p></td><td><a href="https://www.linkedin.com/in/michielmulders/">https://www.linkedin.com/in/michielmulders/</a></td></tr><tr><td align="center"><p>Editor: Krystal, Technical Writer</p><p><a href="https://github.com/theekrystallee">GitHub</a> | <a href="https://x.com/theekrystallee">X</a></p></td><td><a href="https://x.com/theekrystallee">https://x.com/theekrystallee</a></td></tr><tr><td align="center"><p>Editor: Kiran, Developer Advocate</p><p><a href="https://github.com/kpachhai">GitHub</a> | <a href="https://www.linkedin.com/in/kiranpachhai/">LinkedIn</a></p></td><td></td></tr></tbody></table>
