# HTS x EVM - How to Mint NFTs (Part 1)

On Hedera, we can create, mint, burn and transfer non-fungible tokens(NFTs) without deploying or dealing with any smart contracts. We can do this using only the Hedera Token Service(HTS) and official SDKs available in varrious languages such as Javascript, Rust, Go, Python, Java, etc. If you want to learn how to perform these operations using the SDK, refer to [this documentation](../token/hedera-token-service-part-1-how-to-mint-nfts.md).

However, it is also possible to create a token on Hedera using a **smart contract** and still benefit from the native Hedera Token Service. However, the contract needs to interact with the [HTS System Contract](../../core-concepts/smart-contracts/system-smart-contracts/), which provides Hedera-specific token operations. By combining **HTS** and **Solidity**, you:

* Get all the performance, cost-efficiency, and security of native HTS tokens.
* Can embed custom, decentralized logic in your contract for advanced use cases.

In this tutorial, you’ll:

* **Create** an NFT collection with a royalty fee schedule.
* **Mint** new NFTs with metadata pointing to IPFS.
* **Burn** an existing NFT.

{% hint style="info" %}
You can take a look at the **complete code** in the [**Hedera-Code-Snippets repository**](https://github.com/hedera-dev/hedera-code-snippets/tree/main/hts-evm-mint-nfts).
{% endhint %}

***

## Prerequisites

* ECDSA account from the [Hedera Portal](https://portal.hedera.com/).
* Basic understanding of Solidity.

***

## Table of Contents <a href="#table-of-contents" id="table-of-contents"></a>

1. [Setup Project](hts-x-evm-part-1-how-to-mint-nfts.md#setup-project)
2. [Step 1: Configure Hardhat](hts-x-evm-part-1-how-to-mint-nfts.md#step-1-configure-hardhat)
3. [Step 2: Creating an NFT collection via HTS(similar to ERC721)](hts-x-evm-part-1-how-to-mint-nfts.md#step-2.-creating-an-nft-collection-via-hts-similar-to-erc721)
4. [Step 3: Deploy HTS NFT Smart Contract](hts-x-evm-part-1-how-to-mint-nfts.md#step-3-deploy-your-hts-nft-smart-contract)
5. [Step 4: Minting an HTS NFT](hts-x-evm-part-1-how-to-mint-nfts.md#step-4-minting-an-hts-nft)
6. [Step 5: Burning an HTS NFT](hts-x-evm-part-1-how-to-mint-nfts.md#step-5-burning-an-hts-nft)
7. [Step 6: Run tests](hts-x-evm-part-1-how-to-mint-nfts.md#step-6-run-tests-optional)
8. [Conclusion](hts-x-evm-part-1-how-to-mint-nfts.md#conclusion)
9. [Additional Resources](hts-x-evm-part-1-how-to-mint-nfts.md#additional-resources)

***

## Setup Project

Set up your project by initializing the hardhat project. &#x20;

```bash
mkdir hts-evm-mint-nfts
cd hts-evm-mint-nfts
npx hardhat --init
```

Make sure to select "**Hardhat 3 -> Typescript Hardhat Project using Mocha and Ethers.js"** and accept the default values. Hardhat will configure your project correctly and install the required dependencies.

{% include "../../.gitbook/includes/hardhat-2-3.md" %}

{% include "../../.gitbook/includes/hardhat-keystore.md" %}

#### Install Dependencies

Next, install the required dependencies:

```bash
npm install @openzeppelin/contracts 
npm install github:hashgraph/hedera-smart-contracts
```

Note that we are installing the latest code from the main branch when we install `github:hashgraph/hedera-smart-contracts` . This also gets installed at `@hashgraph/smart-contracts` so we can easily call these contracts from our own contract.

***

## Step 1: Configure Hardhat

Update your `hardhat.config.ts`file in the root directory of your project. This file contains the network settings so Hardhat knows how to interact with the Hedera Testnet.

{% code title="hardhat.config.ts" %}
```typescript
import type { HardhatUserConfig } from "hardhat/config";

import hardhatToolboxMochaEthersPlugin from "@nomicfoundation/hardhat-toolbox-mocha-ethers";
import { configVariable } from "hardhat/config";

const config: HardhatUserConfig = {
  plugins: [hardhatToolboxMochaEthersPlugin],
  solidity: {
    profiles: {
      default: {
        version: "0.8.28"
      },
      production: {
        version: "0.8.28",
        settings: {
          optimizer: {
            enabled: true,
            runs: 200
          }
        }
      }
    }
  },
  networks: {
    testnet: {
      type: "http",
      url: configVariable("HEDERA_RPC_URL"),
      accounts: [configVariable("HEDERA_PRIVATE_KEY")]
    }
  }
};

export default config;
```
{% endcode %}

We won't be using `ignition` and we will be removing the default contracts that comes with hardhat default project so we will remove all the unnecessary directories and files first:

```bash
rm -rf contracts/* scripts/* test/*
rm -rf ignition
```

***

## Step 2. Creating an NFT collection via HTS(similar to ERC721)

Create a new Solidity file (`MyHTSToken.sol`) in our `contracts` directory:

{% code title="contracts/MyHTSToken.sol" %}
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
 * - Holders use the token’s ERC721 facade directly (SDK or EVM).
 * - Royalty: 10% with 1 HBAR fallback to initialOwner.
 */
contract MyHTSToken is HederaTokenService, KeyHelper, Ownable {
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

        // Keys: SUPPLY + ADMIN -> contractId
        IHederaTokenService.TokenKey[]
            memory keys = new IHederaTokenService.TokenKey[](2);
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
        token.tokenKeys = keys;

        // Royalty: 10% with 1 HBAR fallback to the owner
        IHederaTokenService.RoyaltyFee[]
            memory royaltyFees = new IHederaTokenService.RoyaltyFee[](1);
        royaltyFees[0] = IHederaTokenService.RoyaltyFee({
            numerator: 1,
            denominator: 10,
            amount: 100_000_000, // 1 HBAR in tinybars
            tokenId: address(0),
            useHbarsForPayment: true,
            feeCollector: owner()
        });

        IHederaTokenService.FixedFee[]
            memory fixedFees = new IHederaTokenService.FixedFee[](0);

        (int rc, address created) = createNonFungibleTokenWithCustomFees(
            token,
            fixedFees,
            royaltyFees
        );
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

{% hint style="info" %}
**How It Works**

1. **Royalty fee**: Sets a network-enforced 10% royalty with a 1 HBAR fallback (to initialOwner) via createNonFungibleTokenWithCustomFees.
2. **Token creation**: Builds the HederaToken (name, symbol, treasury=this contract) and creates the NFT collection at deployment; tokenAddress is stored immutably.
3. **Keys and security**: SUPPLY and ADMIN keys are set to the contractId, so mint/burn and any admin updates can only occur through this contract (not directly via SDK by EOAs).
4. **ERC721 facade**: Dapps/wallets interact with the token like a standard ERC721 using IERC721(tokenAddress) for transfers/approvals; ownerOf and balanceOf are true view functions.
5. **Minting (safeMint)**: Only owner can mint; each mint creates a serial to the treasury, then transfers it to the recipient via ERC721 transferFrom. Recipient must be associated (or have auto-association) or the transfer will revert.
6. **Burning (ERC721Burnable-like)**: Owner or approved operator calls burn(tokenId). If not already in treasury, the contract (when approved) pulls the token from the owner, then burns it via HTS.
7. **HBAR handling**: Contract can receive HBAR (receive/fallback) and the owner can withdraw any balance with withdrawHBAR().
8. **HTS nuances**: NFT metadata is limited to 100 bytes per serial; token IDs are HTS serials (start at 1); association is required on Hedera for receiving NFTs.
{% endhint %}

{% hint style="info" %}
Hedera Native Tokens(created via HTS) are highly interoperable with their corresponding ERC Contracts. Hedera Accounts are able to transfer native NFTs as though they are ERC-721 Smart Contracts!
{% endhint %}

Let's build this contract by running:

```bash
npx hardhat build
```

This command will generate the smart contract artifacts, including the [ABI](https://docs.hedera.com/hedera/core-concepts/smart-contracts/compiling-smart-contracts). We are now ready to deploy the smart contract.

***

## Step 3: Deploy Your HTS NFT Smart Contract

Create a deployment script (`deploy.ts`) in `scripts` directory:

{% code title="scripts/deploy.ts" %}
```typescript
import { network } from "hardhat";

const { ethers } = await network.connect({ network: "testnet" });

async function main() {
  const [deployer] = await ethers.getSigners();
  console.log("Deploying contract with the account:", deployer.address);

  // 1) Deploy the wrapper contract
  // The deployer will also be the owner of our NFT contract
  const MyHTSToken = await ethers.getContractFactory("MyHTSToken", deployer);
  const contract = await MyHTSToken.deploy();
  await contract.waitForDeployment();

  // 2) Create the HTS NFT collection by calling createNFTCollection()
  //    NOTE: createNFTCollection() must be payable to accept this value.
  const NAME = "MyHTSTokenNFTCollection";
  const SYMBOL = "MHT";
  const HBAR_TO_SEND = "15"; // HBAR to send with createNFTCollection()
  console.log(
    `Calling createNFTCollection() with ${HBAR_TO_SEND} HBAR to create the HTS collection...`
  );
  const tx = await contract.createNFTCollection(NAME, SYMBOL, {
    gasLimit: 250_000,
    value: ethers.parseEther(HBAR_TO_SEND)
  });
  await tx.wait();
  console.log("createNFTCollection() tx hash:", tx.hash);

  // 3) Read the created HTS token address
  const contractAddress = await contract.getAddress();
  console.log("MyHTSToken contract deployed at:", contractAddress);
  const tokenAddress = await contract.tokenAddress();
  console.log(
    "Underlying HTS NFT Collection (ERC721 facade) address:",
    tokenAddress
  );
}

main().catch(console.error);
```
{% endcode %}

In this script, we first retrieve your account (the deployer) using Ethers.js. This account will own the deployed smart contract. Next, we use this account to deploy the contract by calling `MyHTSToken.deploy()`.&#x20;

{% hint style="info" %}
**Note**

For most HTS [System Smart Contract](../../core-concepts/smart-contracts/system-smart-contracts/) calls, an HBAR value **is not** required to be sent in the contract call; the gas fee will cover it. However, for expensive transactions, like [Create HTS NFT Collection](hts-x-evm-part-1-how-to-mint-nfts.md#step-3-deploy-your-hts-nft-smart-contract), the gas fee is reduced, and the transaction cost is covered by the payable amount. This is to reduce the gas consumed by the contract call.
{% endhint %}

Deploy your contract by executing the script:

```bash
npx hardhat run scripts/deploy.ts --network testnet
```

{% hint style="success" %}
Copy the deployed address—you'll need this in subsequent steps.
{% endhint %}

The output looks like this:

```bash
Deploying contract with the account: 0xA98556A4deeB07f21f8a66093989078eF86faa30
Calling createNFTCollection() with 15 HBAR to create the HTS collection...
createNFTCollection() tx hash: 0x5c5f584cae867a3b5dce130756f48921b3071671717a7d646f68654c1396cf67
MyHTSToken contract deployed at: 0xC244Cf8d1c123B1A2C8c12c780ce41d813eb70be
Underlying HTS NFT Collection (ERC721 facade) address: 0x000000000000000000000000000000000068D3eF
```

***

## Step 4: Minting an HTS NFT

Create a `mintNFT.ts` script in your `scripts` directory to mint an NFT. Don't forget to replace the `<your-contract-address>` with the address you've just copied.&#x20;

{% code title="scripts/mintNFT.ts" %}
```typescript
import { network } from "hardhat";

const { ethers } = await network.connect({ network: "testnet" });

async function main() {
  const [signer] = await ethers.getSigners();
  console.log("Using signer:", signer.address);

  const contractAddress = "<your-contract-address>";
  const recipient = signer.address;

  const myHTSTokenContract = await ethers.getContractAt(
    "MyHTSToken",
    contractAddress,
    signer
  );

  // Display the underlying HTS token address
  const tokenAddress = await myHTSTokenContract.tokenAddress();
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
  const tx = await myHTSTokenContract["mintNFT(address,bytes)"](
    recipient,
    metadata,
    {
      gasLimit: 350_000
    }
  );
  await tx.wait();
  console.log("Mint tx hash:", tx.hash);

  // Check recipient's NFT balance on the ERC721 facade (not on MyHTSToken)
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

1. Connects to Hedera testnet, gets the first signer, and attaches to your deployed MyHTSToken contract.
2. Reads the underlying HTS ERC721 facade address (tokenAddress) from the contract.
3. Constructs <=100-byte UTF-8 metadata and calls mintNFT(recipient, metadata), then waits for the transaction receipt.
4. Queries balanceOf(recipient) on the ERC721 facade and logs the current NFT count.
{% endhint %}

The code mints a new NFT to your account ( `signer.address` ). Then we verify the balance to see if we own an HTS NFT.

Mint an NFT:

```bash
npx hardhat run scripts/mintNFT.ts --network testnet
```

Expected output:

```bash
Using signer: 0xA98556A4deeB07f21f8a66093989078eF86faa30
HTS ERC721 facade address: 0x000000000000000000000000000000000068D3eF
Associating signer to token via token.associate() ...
Associate tx hash: 0x08dd0150d9a356cac3e949b26841a6688c7aab4b017224cfea7330d1b3cb432e
Minting NFT to 0xA98556A4deeB07f21f8a66093989078eF86faa30 with metadata: 0x697066733a2f2f6261666b7265696272376379786d79346979636b6d6c797a69676534797763637979676f6d7772636e346c64636c64616377336e786533696b6771 ...
Mint tx hash: 0x55fe1d9cb4126913eb07fc2e2d596c0bcb41eab66e0dbcd4c93be9e73c69beed
Balance: 1 NFTs
```

***

## Step 5: Burning an HTS NFT

Create a burn script (`burnNFT.ts` ) in your `scripts` directory. Make sure to replace `<your-contract-address>` to the MyHTSToken contract address you got from deploying and replace `<your-token-id>` with the tokenId you want to burn(eg. "1") :

{% code title="scripts/burnNFT.ts" %}
```typescript
import { network } from "hardhat";
import type { ContractTransactionResponse } from "ethers";

const { ethers } = await network.connect({ network: "testnet" });

async function main() {
  const [signer] = await ethers.getSigners();
  console.log("Using signer:", signer.address);

  const contractAddress = "<your-contract-address>";
  const tokenId = BigInt("1");

  const myHTSTokenContract = await ethers.getContractAt(
    "MyHTSToken",
    contractAddress,
    signer
  );

  const tokenAddress: string = await myHTSTokenContract.tokenAddress();
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

  // Check if already approved for this tokenId; if not, approve MyHTSToken contract
  const currentApproved: string = await erc721.getApproved(tokenId);
  if (currentApproved.toLowerCase() !== contractAddress.toLowerCase()) {
    console.log(
      `Approving MyHTSToken contract ${contractAddress} for tokenId ${tokenId.toString()}...`
    );
    const approveTx = (await erc721.approve(
      contractAddress,
      tokenId
    )) as unknown as ContractTransactionResponse;
    await approveTx.wait();
    console.log("Approval tx hash:", approveTx.hash);
  } else {
    console.log("MyHTSToken contract is already approved for this tokenId.");
  }

  // Burn via MyHTSToken
  console.log(`Burning tokenId ${tokenId.toString()}...`);
  const burnTx = (await myHTSTokenContract.burnNFT(tokenId, {
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

1. Connects to Hedera testnet, gets the signer, attaches to MyHTSToken, and reads the ERC721 facade tokenAddress.
2. Checks token ownership and existing approval; if needed, approves the MyHTSToken contract for the specific tokenId.
3. Calls burnNFT(tokenId) on MyHTSToken and waits for the transaction receipt.
4. Reads and logs the signer’s NFT balance from the ERC721 facade after the burn.
{% endhint %}

The script will burn the HTS NFT with the ID set to `1`, which is the HTS NFT you've just minted. To be sure the token has been deleted, let's print the balance for our account to the terminal. The balance should show a balance of `0`.

Burn the NFT:

```bash
npx hardhat run scripts/burnNFT.ts --network testnet
```

You should get an output similar to:

```bash
Using signer: 0xA98556A4deeB07f21f8a66093989078eF86faa30
HTS ERC721 facade address: 0x000000000000000000000000000000000068D3eF
Current owner of token: 0xA98556A4deeB07f21f8a66093989078eF86faa30
Approving MyHTSToken contract 0xC244Cf8d1c123B1A2C8c12c780ce41d813eb70be for tokenId 1...
Approval tx hash: 0xf41d3696908fab800bfe36c32be149e05c8738c32c85e71eff534cf49a5e1e7f
Burning tokenId 1...
Burn tx hash: 0x0483a4616af64e150ba52fe092c3d9fabf81439a90067e6dd3efaad299a601cd
Balance after burn: 0 NFTs
```

**Congratulations! 🎉 You have successfully learned how to deploy an HTS NFT collection smart contract using Hardhat, OpenZeppelin, and Ethers. Feel free to reach out in** [**Discord**](https://hedera.com/discord)**!**

***

## Step 6: Run tests(Optional)

You can find both types of tests in the [**Hedera-Code-Snippets repository**](https://github.com/hedera-dev/hedera-code-snippets/tree/main/hts-evm-mint-nfts). You will find the following files:

* `contracts/MyHTSToken.t.sol`

{% hint style="info" %}
- **Ownership and access control**: Ensures constructor sets the correct owner and that onlyOwner is enforced for createNFTCollection (non-owners revert with OwnableUnauthorizedAccount).
- **Pre-creation guards:** Confirms HTS-dependent functions (mint, burn) revert with "HTS: not created" before the collection is created.
- **HBAR handling:** Verifies the contract can receive HBAR (HBARReceived event), blocks non-owner withdrawals, and lets the owner withdraw all HBAR (HBARWithdrawn event) leaving the contract balance at zero.
{% endhint %}

* `test/MyHTSToken.ts`

{% hint style="info" %}
- **Deployment and setup**: Deploys the wrapper, creates the HTS NFT collection (funded with 15 HBAR), and retrieves/validates the ERC721 facade address.
- **Mint with metadata**: Mints an NFT to the deployer with metadata (<= 100 bytes), asserts the NFTMinted event, and extracts the tokenId from wrapper logs.
- **ERC721 interactions**: Uses a minimal ERC721 ABI to query owner/balance and manage approvals without relying on full artifacts.
- **Burn flow**: Ensures the wrapper is approved for the specific tokenId (approves if needed), then burns via the wrapper and asserts the NFTBurned event.
- **Post-burn check**: Reads the deployer’s ERC721 balance after burn to confirm calls succeed (balance may vary if multiple NFTs exist).
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

Using Solidity on Hedera, you can **create**, **mint and** **burn** native NFTs with minimal code thanks to the **HTS System Contract**. In this tutorial, you saw how to:

* **Create** a new NFT class with royalty fees (`createNFTCollection`).
* **Mint** new tokens (`mintNFT`).
* **Burn** tokens when they are no longer needed (`burnNFT`).

Continue exploring our [Part 2: KYC & Update](hts-x-evm-part-2-kyc-and-update.md) to see how advanced compliance flags (e.g., KYC) or updating tokens can be handled natively.

{% content-ref url="hts-x-evm-part-2-kyc-and-update.md" %}
[hts-x-evm-part-2-kyc-and-update.md](hts-x-evm-part-2-kyc-and-update.md)
{% endcontent-ref %}

***

## Additional Resources

Check out our GitHub repo to find the full contract and Hardhat test scripts, along with the configuration files you need to deploy and test on Hedera!

* [Full Contract and Tests Repository](https://github.com/hedera-dev/hedera-code-snippets/tree/main/hts-evm-mint-nfts)

<table data-card-size="large" data-view="cards"><thead><tr><th align="center"></th><th data-hidden data-card-target data-type="content-ref"></th></tr></thead><tbody><tr><td align="center"><p>Writer: Jake, Developer Relations Engineer</p><p><a href="https://github.com/jaycoolh">GitHub</a> | <a href="https://x.com/jaycoolh">X</a></p></td><td><a href="https://github.com/jaycoolh">https://github.com/jaycoolh</a></td></tr><tr><td align="center"><p>Editor: Michiel, Developer Relations Engineer</p><p><a href="https://github.com/michielmulders">GitHub</a> | <a href="https://www.linkedin.com/in/michielmulders/">LinkedIn</a></p></td><td><a href="https://www.linkedin.com/in/michielmulders/">https://www.linkedin.com/in/michielmulders/</a></td></tr><tr><td align="center"><p>Editor: Krystal, Technical Writer</p><p><a href="https://github.com/theekrystallee">GitHub</a> | <a href="https://x.com/theekrystallee">X</a></p></td><td><a href="https://x.com/theekrystallee">https://x.com/theekrystallee</a></td></tr><tr><td align="center"><p>Editor: Kiran, Developer Advocate</p><p><a href="https://github.com/kpachhai">GitHub</a> | <a href="https://www.linkedin.com/in/kiranpachhai/">LinkedIn</a></p></td><td></td></tr></tbody></table>
