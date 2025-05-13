# How to Mint & Burn an ERC-721 Token Using Hardhat and Ethers (Part 1)

In this tutorial, you'll learn how to deploy, mint, and burn [ERC-721](../../support-and-community/glossary.md#erc-721) tokens (NFTs) using Hardhat, Ethers, and OpenZeppelin contracts on the Hedera Testnet. We'll cover setting up your project, writing and deploying an ERC-721 smart contract, minting an NFT to your account, and finally, burning an NFT.&#x20;

By the end, you'll have hands-on experience with essential ERC-721 operations and interacting with smart contracts on Hedera.

{% hint style="info" %}
You can take a look at the **complete code** in the [**Hedera-Code-Snippets repository**](https://github.com/hedera-dev/hedera-code-snippets/tree/main/hardhat-erc-721-mint-burn).
{% endhint %}

***

## Prerequisites

* Basic understanding of smart contracts.
* Basic understanding of [Node.js](https://nodejs.org/en/download) and JavaScript.
* Basic understanding of [Hardhat Ethereum Development Tool](https://hardhat.org/hardhat-runner/docs/guides/project-setup) and [Ethers](https://docs.ethers.org/v5/).
* ECDSA account from the [Hedera Portal](https://portal.hedera.com/).

***

## Table of Contents

1. [Project Setup](how-to-mint-and-burn-an-erc-721-token-using-hardhat-and-ethers-part-1.md#step-1-project-setup)
   1. [Initialize Project](how-to-mint-and-burn-an-erc-721-token-using-hardhat-and-ethers-part-1.md#initialize-project)
   2. [Create .env File](how-to-mint-and-burn-an-erc-721-token-using-hardhat-and-ethers-part-1.md#create-.env-file)
   3. [Configure Hardhat](how-to-mint-and-burn-an-erc-721-token-using-hardhat-and-ethers-part-1.md#configure-hardhat)
2. [Creating the ERC-721 Contract](how-to-mint-and-burn-an-erc-721-token-using-hardhat-and-ethers-part-1.md#step-2-creating-the-erc-721-contract)
3. [Deploy Your Smart Contract](how-to-mint-and-burn-an-erc-721-token-using-hardhat-and-ethers-part-1.md#step-3-deploy-your-erc-721-smart-contract)
4. [Minting an NFT](how-to-mint-and-burn-an-erc-721-token-using-hardhat-and-ethers-part-1.md#step-4-minting-an-nft)
5. [Adding the Burn Functionality](how-to-mint-and-burn-an-erc-721-token-using-hardhat-and-ethers-part-1.md#step-5-adding-the-burn-functionality)
6. [Burning an NFT](how-to-mint-and-burn-an-erc-721-token-using-hardhat-and-ethers-part-1.md#step-6-burning-an-nft)

***

## Step 1: Project Setup

#### Initialize Project&#x20;

Set up your Node.js project by initializing npm:

```bash
npm init -y
```

#### Install Dependencies

Next, install the required dependencies:

```bash
npm install @openzeppelin/contracts dotenv
```

We also need a bunch of developer dependencies to be able to deploy and interact with smart contracts through [Hardhat](https://hardhat.org/hardhat-runner/plugins/nomicfoundation-hardhat-toolbox):

```bash
npm install --save-dev @nomicfoundation/hardhat-toolbox
```

#### Create `.env` File

To create your `.env` file, you can either run one of the following commands or simply rename the `.env.example` file in the project's root directory:

_option 1_: create a new `.env` file

```bash
touch .env
```

_option 2_: duplicate the `.env.example` file

```bash
cp .env.example .env
```

Securely store your sensitive data like the `OPERATOR_KEY` in a `.env` file. For the JSON `RPC_URL`, we'll use the [Hashio RPC endpoint for testnet](https://www.hashgraph.com/hashio/).&#x20;

{% code title=".env" %}
```bash
OPERATOR_KEY=your-operator-key
RPC_URL=https://testnet.hashio.io/api
```
{% endcode %}

{% hint style="warning" %}
Replace the `your-operator-key` environment variable the **HEX Encoded Private Key** for your **ECDSA** **account** from the [Hedera Portal](https://portal.hedera.com/).&#x20;
{% endhint %}

{% hint style="danger" %}
_**Please note**:_ _that Hashio is intended for development and testing purposes only. for production use cases, it's recommended to use commercial-grade JSON-RPC Relay or host your own instance of the_ [_Hiero JSON-RPC Relay_](https://github.com/hiero-ledger/hiero-json-rpc-relay)_._&#x20;
{% endhint %}

#### Configure Hardhat

Create a `hardhat.config.js`file in the root of your project. This file contains the network settings so Hardhat knows how to interact with the Hedera Testnet. We'll use the variables you've stored in your `.env` file.&#x20;

{% code title="hardhat.config.js" %}
```javascript
require("dotenv").config();
require("@nomicfoundation/hardhat-toolbox");

module.exports = {
  solidity: {
    version: "0.8.22",
  },
  defaultNetwork: "testnet",
  networks: {
    testnet: {
      // HashIO RPC testnet endpoint in the .env file
      url: process.env.RPC_URL,
      // Your ECDSA account private key pulled from the .env file
      accounts: [process.env.OPERATOR_KEY],
    }
  }
};
```
{% endcode %}

You can verify the connection by running:

```bash
npx hardhat console --network testnet
```

This command launches an interactive JavaScript console connected directly to the Hedera Testnet, providing access to the Ethers.js library for blockchain interactions. If you successfully enter this interactive environment, your Hardhat configuration is correct. To exit the interactive console, press `ctrl + c` twice.

***

## Step 2: Creating the ERC-721 Contract

Create a new Solidity file (`erc-721.sol` ) in a new `contracts` directory:

{% code title="erc-721.sol" %}
```solidity
// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.22;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract MyToken is ERC721, Ownable {
    uint256 private _nextTokenId;

    constructor(address initialOwner)
        ERC721("MyToken", "MTK")
        Ownable(initialOwner)
    {}

    function safeMint(address to) public onlyOwner returns (uint256) {
        uint256 tokenId = _nextTokenId++;
        _safeMint(to, tokenId);
        return tokenId;
    }
}
```
{% endcode %}

This contract was created using the [OpenZeppelin Contracts Wizard](https://wizard.openzeppelin.com/#erc721) and OpenZeppelin's ERC-721 standard implementation with an ownership model. The ERC-721 token's name has been set to "MyToken." The contract implements the `safeMint` function, which accepts the address of the owner of the new token and uses auto-increment IDs, starting from 0.&#x20;

Let's compile this contract by running:

```bash
npx hardhat compile
```

This command will generate the smart contract artifacts, including the [ABI](https://docs.hedera.com/hedera/core-concepts/smart-contracts/compiling-smart-contracts). We are now ready to deploy the smart contract.

***

## Step 3: Deploy Your ERC-721 Smart Contract

Create a deployment script (`deploy.js`) in a new `scripts` directory:

{% code title="deploy.js" %}
```javascript
async function main() {
  // Get the signer of the tx and address for minting the token
  const [deployer] = await ethers.getSigners();
  console.log("Deploying contracts with the account:", deployer.address);

  // The deployer will also be the owner of our NFT contract
  const MyToken = await ethers.getContractFactory("MyToken", deployer);
  const contract = await MyToken.deploy(deployer.address);

  console.log("Contract deployed at:", contract.target);
}

main().catch(console.error);
```
{% endcode %}

In this script, we first retrieve your account (the deployer) using Ethers.js. This account will own the deployed smart contract. Next, we use this account to deploy the contract by calling `MyToken.deploy(deployer.address)`. This passes your account address as the initial owner and signer of the deployment transaction.

Deploy your contract by executing the script:

```bash
npx hardhat run scripts/deploy.js --network testnet
```

{% hint style="success" %}
Copy the deployed address—you'll need this in subsequent steps.
{% endhint %}

The output looks like this:

<figure><img src="../../.gitbook/assets/Untitled design (13).png" alt=""><figcaption></figcaption></figure>

***

## Step 4: Minting an NFT

Create a `mint.js` script in your `scripts` directory to mint an NFT. Don't forget to replace the `<your-contract-address>` with the address you've just copied.&#x20;

{% code title="mint.js" %}
```javascript
async function main() {
    const [deployer] = await ethers.getSigners();
    
    // Get the ContractFactory of your MyToken ERC-721 contract
    const MyToken = await ethers.getContractFactory("MyToken", deployer);
    
    // Connect to the deployed contract 
    // (REPLACE WITH YOUR CONTRACT ADDRESS)
    const contractAddress = "<your-contract-address>";
    const contract = await MyToken.attach(contractAddress);
    
    // Mint a token to ourselves
    const mintTx = await contract.safeMint(deployer.address);
    const receipt = await mintTx.wait();
    const mintedTokenId = receipt.logs[0].topics[3];
    console.log('Minted token ID:', mintedTokenId);
    
    // Check the balance of the token
    const balance = await contract.balanceOf(deployer.address);
    console.log('Balance:', balance.toString(), "NFTs");
}

main().catch(console.error);
```
{% endcode %}

The code mints a new NFT to your account ( `deployer.address` ). Then we verify the balance to see if we own an ERC-721 token of type `MyToken`.

Mint an NFT:

```bash
npx hardhat run scripts/mint.js --network testnet
```

Expected output:

<pre class="language-bash" data-overflow="wrap"><code class="lang-bash"><strong>Minted token ID: 0x0000000000000000000000000000000000000000000000000000000000000000 // Represents ID 0
</strong><strong>Balance: 1 NFT
</strong></code></pre>

***

## Step 5: Adding the Burn Functionality

Update your contract to add NFT burning capability by importing the burnable extension and adding it to the interfaces list for your contract:

```solidity
// [...]
import {ERC721Burnable} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";

contract MyToken is ERC721, ERC721Burnable, Ownable {
// [...]
```

Recompile and redeploy:

```bash
npx hardhat compile
npx hardhat run scripts/deploy.js --network testnet
```

Copy the new smart contract address and replace the address in the `scripts/mint.js` script with your new address. Let's mint a new NFT for the redeployed contract:

```bash
npx hardhat run scripts/mint.js --network testnet
```

***

## Step 6: Burning an NFT

Create a burn script (`burn.js` ) in your `scripts` directory:

{% code title="burn.js" %}
```javascript
async function main() {
    const [deployer] = await ethers.getSigners();
    const MyToken = await ethers.getContractFactory("MyToken", deployer);
    
    // Connect to the deployed contract (REPLACE WITH YOUR CONTRACT ADDRESS)
    const contractAddress = "<your-contract-address>";
    const contract = await MyToken.attach(contractAddress);
    
    // Burn the token
    const burnTx = await contract.burn(0);
    await burnTx.wait();
    console.log('Burned token with ID:', 0);
    
    // Check the balance of the token
    const balance = await contract.balanceOf(deployer.address);
    console.log('Balance:', balance.toString(), "NFTs");
}

main().catch(console.error);
```
{% endcode %}

Again, ensure you update `<your-contract-address>` to interact with your correct contract. The script will burn the ERC-721 token with the ID set to `0`, which is the ERC-721 token you've just minted. To be sure the token has been deleted, let's print the balance for our account to the terminal. The balance should show a balance of `0`.

Burn the NFT:

```bash
npx hardhat run scripts/burn.js --network testnet
```

**Congratulations! 🎉 You have successfully learned how to deploy an ERC-721 smart contract using Hardhat, OpenZeppelin, and Ethers. Feel free to reach out in** [**Discord**](https://hedera.com/discord)**!**

***

## Additional Resources

* [OpenZeppelin ERC-721 Documentation](https://docs.openzeppelin.com/contracts/5.x/erc721)
* [Hedera Smart Contracts Workshop](hscs-workshop/)
* [Full Code in Hedera-Code-Snippets Repository](https://github.com/hedera-dev/hedera-code-snippets/tree/main/hardhat-erc-721-mint-burn)

<table data-card-size="large" data-view="cards"><thead><tr><th align="center"></th><th data-hidden data-card-target data-type="content-ref"></th></tr></thead><tbody><tr><td align="center"><p>Writer: Michiel, Developer Relations Engineer</p><p><a href="https://github.com/michielmulders">GitHub</a> | <a href="https://www.linkedin.com/in/michielmulders/">LinkedIn</a></p></td><td><a href="https://www.linkedin.com/in/michielmulders/">https://www.linkedin.com/in/michielmulders/</a></td></tr><tr><td align="center"><p>Editor: Luis, Sr Software Developer</p><p><a href="https://github.com/acuarica">GitHub</a></p></td><td><a href="https://github.com/acuarica">https://github.com/acuarica</a></td></tr><tr><td align="center"><p>Editor: Krystal, Technical Writer</p><p><a href="https://github.com/theekrystallee">GitHub</a> | <a href="https://x.com/theekrystallee">X</a></p></td><td><a href="https://x.com/theekrystallee">https://x.com/theekrystallee</a></td></tr></tbody></table>
