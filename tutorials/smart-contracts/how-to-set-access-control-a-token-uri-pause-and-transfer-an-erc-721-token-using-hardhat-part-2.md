# How to Set Access Control, a Token URI, Pause, and Transfer an ERC-721 Token Using Hardhat (Part 2)

In this tutorial, you'll learn how to create and manage an advanced ERC-721 token smart contract using Hardhat and OpenZeppelin. We'll cover deploying the contract, minting NFTs, pausing and unpausing the contract, and transferring tokens. You'll gain experience with [Access Control](https://docs.openzeppelin.com/contracts/5.x/access-control#using-access-control) (admin, minting, pausing roles), URI storage, and Pausable functionalities.

{% hint style="info" %}
You can take a look at the **complete code** in the [**Hedera-Code-Snippets repository**](https://github.com/hedera-dev/hedera-code-snippets/tree/main/hardhat-erc-721-mint-burn).
{% endhint %}

***

## Prerequisites

* ⚠️ **Complete** [**tutorial part 1**](how-to-mint-and-burn-an-erc-721-token-using-hardhat-and-ethers-part-1.md) **as we continue from this example.**
* Basic understanding of smart contracts.
* Basic understanding of [Node.js](https://nodejs.org/en/download) and JavaScript.
* Basic understanding of [Hardhat EVM Development Tool](https://hardhat.org/hardhat-runner/docs/guides/project-setup) and [Ethers](https://docs.ethers.org/v5/).
* ECDSA account from the [Hedera Portal](https://portal.hedera.com/).

***

## Table of Contents

1. [Create and Compile the Solidity Contract](how-to-set-access-control-a-token-uri-pause-and-transfer-an-erc-721-token-using-hardhat-part-2.md#step-1-create-and-compile-the-solidity-contract)
2. [Deploying the Smart Contract and Minting a Token](how-to-set-access-control-a-token-uri-pause-and-transfer-an-erc-721-token-using-hardhat-part-2.md#step-2-deploying-the-smart-contract-and-minting-a-token)
3. [Fixing Permissions, Redeploying, and Minting](how-to-set-access-control-a-token-uri-pause-and-transfer-an-erc-721-token-using-hardhat-part-2.md#step-3-fixing-permissions-redeploying-and-minting)
4. [Pausing the Contract](how-to-set-access-control-a-token-uri-pause-and-transfer-an-erc-721-token-using-hardhat-part-2.md#step-4-pausing-the-contract)[Pausing the Contract](how-to-set-access-control-a-token-uri-pause-and-transfer-an-erc-721-token-using-hardhat-part-2.md#step-4-pausing-the-contract)
5. [Transferring NFTs](how-to-set-access-control-a-token-uri-pause-and-transfer-an-erc-721-token-using-hardhat-part-2.md#step-5-transferring-nfts)

***

## Step 1: Create and Compile the Solidity Contract

Create a new Solidity file named `erc-721-advanced.sol` in your `contracts` directory, and paste this Solidity code:

{% code title="erc-721-advanced.sol" %}
```solidity
// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.22;

import {AccessControl} from "@openzeppelin/contracts/access/AccessControl.sol";
import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {ERC721Pausable} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721Pausable.sol";
import {ERC721URIStorage} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract MyTokenAdvanced is ERC721, ERC721URIStorage, ERC721Pausable, AccessControl {
    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    uint256 private _nextTokenId;

    constructor(address defaultAdmin, address pauser, address minter)
        ERC721("MyTokenAdvanced", "MTK")
    {
        _grantRole(DEFAULT_ADMIN_ROLE, defaultAdmin);
        _grantRole(PAUSER_ROLE, pauser);
        _grantRole(MINTER_ROLE, minter);
    }

    function pause() public onlyRole(PAUSER_ROLE) {
        _pause();
    }

    function unpause() public onlyRole(PAUSER_ROLE) {
        _unpause();
    }

    function safeMint(address to, string memory uri)
        public
        onlyRole(MINTER_ROLE)
        returns (uint256)
    {
        uint256 tokenId = _nextTokenId++;
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
        return tokenId;
    }

    // The following functions are overrides required by Solidity.

    function _update(address to, uint256 tokenId, address auth)
        internal
        override(ERC721, ERC721Pausable)
        returns (address)
    {
        return super._update(to, tokenId, auth);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721URIStorage, AccessControl)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
```
{% endcode %}

The contract implements the `ERC721URIStorage`, `ERC721Pausable`, and `AccessControl` interfaces from OpenZeppelin. You can create the contract yourself using the OpenZeppelin Wizard and enable "Mintable," "Pausable," "URI Storage," and "Access Control -> Roles."&#x20;

Compile your new contract:

```bash
npx hardhat compile
```

***

## Step 2: Deploying the Smart Contract and Minting a Token

Create `deploy-advanced.js` in your `scripts` folder:

{% code title="deploy-advanced.js" %}
```javascript
async function main() {
  const [deployer] = await ethers.getSigners();
  const MyTokenAdvanced = await ethers.getContractFactory("MyTokenAdvanced", deployer);
  
  // Third argument is the minting role set to an unknown address
  const contract = await MyTokenAdvanced.deploy(deployer.address, deployer.address, "0xc0ffee254729296a45a3885639AC7E10F9d54979");
  console.log("Contract deployed at:", contract.target);
}

main().catch(console.error);
```
{% endcode %}

Note that we are providing three arguments to the `MyTokenAdvanced.deploy()` function. When we look at the constructor of our smart contract, we can provide the admin, pauser, and minter roles.

```javascript
constructor(address defaultAdmin, address pauser, address minter)
```

The `deploy-advanced.js` script sets the minter role to an unknown (random) address. This should prevent the deployer account from minting new tokens in the next step. First, let's run the deployer script:

```bash
npx hardhat run scripts/deploy-advanced.js --network testnet
```

Here's the output of the command:

```bash
Deploying contracts with the account: 0x7203b2B56CD700e4Df7C2868216e82bCCA225423
Contract deployed at: 0x28abF02031C65866c9D1F8fbc9c73e12A1a6A878
```

**Copy the contract address of your newly deployed contract.** Next, create `mint-advanced.js` in your `scripts` folder:

{% code title="mint-advanced.js" %}
```javascript
async function main() {
  const [deployer] = await ethers.getSigners();
  const MyTokenAdvanced = await ethers.getContractFactory(
    "MyTokenAdvanced",
    deployer
  );

  // Connect to the deployed contract (REPLACE WITH YOUR CONTRACT ADDRESS)
  const contractAddress = "0x6F5F9Ed50140bb9C94246257241Ed5AA5d40A25d";
  const contract = await MyTokenAdvanced.attach(contractAddress);

  // Mint a token to ourselves
  const mintTx = await contract.safeMint(
    deployer.address,
    "https://myserver.com/8bitbeard/8bitbeard-tokens/tokens/1"
  );
  const receipt = await mintTx.wait();
  const mintedTokenId = receipt.logs[0].topics[3];
  console.log("Minted token ID:", mintedTokenId);

  // Check the balance of the token
  const balance = await contract.balanceOf(deployer.address);
  console.log("Balance:", balance.toString(), "NFTs");

  // Check the token URI
  const tokenURI = await contract.tokenURI(mintedTokenId);
  console.log("Token URI:", tokenURI);
}

main().catch(console.error);

```
{% endcode %}

This contract tries to mint a new token and sets the token URI to <mark style="color:blue;">`https://myserver.com/8bitbeard/8bitbeard-tokens/tokens/1`</mark> . This transaction will fail because our deployer account doesn't have the `minter` permission. Run the script:

```bash
npx hardhat run scripts/mint-advanced.js --network testnet
```

Notice minting fails due to incorrect permissions. Let's fix this in the next step.

***

## Step 3: Fixing Permissions, Redeploying, and Minting

Update the minting role to your deployer account by modifying the following line of code in your `deploy-advanced.js` script:

{% code title="deploy-advanced.js" overflow="wrap" %}
```javascript
const contract = await MyTokenAdvanced.deploy(deployer.address, deployer.address, deployer.address); // Deployer account gets all roles
```
{% endcode %}

Now that the deployer account has all the roles, redeploy the contract:

```bash
npx hardhat run scripts/deploy-advanced.js --network testnet
```

Don't forget to **copy the new contract address and update** the `contractAddress` variable in your `mint-advanced.js` script with this new address.&#x20;

Next, execute the minting logic:

```bash
npx hardhat run scripts/mint-advanced.js --network testnet
```

The new token will be minted with token ID `0` and the corresponding token URI is printed to your terminal.&#x20;

***

## Step 4: Pausing the Contract

Create a new `pause-advanced.js` script and make sure to replace the `contractAddress` variable with your address:

{% code title="pause-advanced.js" %}
```javascript
async function main() {
    const [deployer] = await ethers.getSigners();
    const MyTokenAdvanced = await ethers.getContractFactory("MyTokenAdvanced", deployer);
  
    // Connect to the deployed contract (REPLACE WITH YOUR CONTRACT ADDRESS)
    const contractAddress = "0x11828533C93F8A1e19623343308dFb4a811005dE";
    const contract = await MyTokenAdvanced.attach(contractAddress);
  
    // Pause the token
    const pauseTx = await contract.pause();
    await pauseTx.wait();
    console.log("Paused token");

    // Read the paused state
    const pausedState = await contract.paused();
    console.log("Contract paused state is:", pausedState);
}
  
main().catch(console.error);
```
{% endcode %}

The script calls the pause function on your contract. As we have the correct role, the token will be paused and its paused state will be printed to the terminal. Execute the script:

```bash
npx hardhat run scripts/pause-advanced.js --network testnet
```

The contract will return `true` when it is paused. Now, nobody can mint new tokens.

{% hint style="success" %}
Pausing an ERC-721 contract temporarily disables critical functions, including minting, transferring, and burning tokens. While the contract is paused, users cannot perform these operations, making it particularly useful in emergency scenarios or maintenance periods. However, read operations such as checking token balances or URIs are still possible.
{% endhint %}

***

## Step 5: Transferring NFTs

Create a `transfer-advanced.js` script to transfer an NFT to another address. Don't forget to replace the `contractAddress` with your smart contract address.

{% code title="transfer-advanced.js" %}
```javascript
async function main() {
  const [deployer] = await ethers.getSigners();
  const MyTokenAdvanced = await ethers.getContractFactory(
    "MyTokenAdvanced",
    deployer
  );

  // Connect to the deployed contract (REPLACE WITH YOUR CONTRACT ADDRESS)
  const contractAddress = "0x11828533C93F8A1e19623343308dFb4a811005dE";
  const contract = await MyTokenAdvanced.attach(contractAddress);

  // Unpause the token
  const unpauseTx = await contract.unpause();
  await unpauseTx.wait();
  console.log("Unpaused token");

  // Read the paused state
  const pausedState = await contract.paused();
  console.log("Contract paused state is:", pausedState);

  // Transfer the token with ID 0
  const transferTx = await contract.transferFrom(
    deployer.address,
    "0x5FbDB2315678afecb367f032d93F642f64180aa3",
    0
  );

  await transferTx.wait();

  const balance = await contract.balanceOf("0x5FbDB2315678afecb367f032d93F642f64180aa3");
  console.log("Balance:", balance.toString(), "NFTs");
}

main().catch(console.error);
```
{% endcode %}

This script will first unpause your contract and then transfer the token to a random address <mark style="color:green;">`0x5FbDB2315678afecb367f032d93F642f64180aa3`</mark> using the [`transferFrom` function](https://docs.openzeppelin.com/contracts/2.x/api/token/erc721#ERC721-transferFrom-address-address-uint256-) on your contract. This function accepts the sender address, receiver address, and the token ID you want to transfer.  Next, we check if the account has actually received the token by verifying its balance.&#x20;

Execute the script to transfer the token:

```bash
npx hardhat run scripts/transfer-advanced.js --network testnet
```

**If the balance for the&#x20;**<mark style="color:green;">**`0x5FbDB2315678afecb367f032d93F642f64180aa3`**</mark>**&#x20;account shows `1` , then you've successfully transferred the NFT and completed this tutorial! 🎉**

***

## Additional Resources

* [OpenZeppelin ERC-721 Docs](https://docs.openzeppelin.com/contracts/5.x/erc721)
* [Access Control Docs](https://docs.openzeppelin.com/contracts/5.x/access-control#using-access-control)

<table data-card-size="large" data-view="cards"><thead><tr><th align="center"></th><th data-hidden data-card-target data-type="content-ref"></th></tr></thead><tbody><tr><td align="center"><p>Writer: Michiel, Developer Relations Engineer</p><p><a href="https://github.com/michielmulders">GitHub</a> | <a href="https://www.linkedin.com/in/michielmulders/">LinkedIn</a></p></td><td><a href="https://www.linkedin.com/in/michielmulders/">https://www.linkedin.com/in/michielmulders/</a></td></tr><tr><td align="center"><p>Editor: Luis, Sr Software Developer</p><p><a href="https://github.com/acuarica">GitHub</a></p></td><td><a href="https://github.com/acuarica">https://github.com/acuarica</a></td></tr><tr><td align="center"><p>Editor: Krystal, Technical Writer</p><p><a href="https://github.com/theekrystallee">GitHub</a> | <a href="https://x.com/theekrystallee">X</a></p></td><td><a href="https://x.com/theekrystallee">https://x.com/theekrystallee</a></td></tr></tbody></table>
