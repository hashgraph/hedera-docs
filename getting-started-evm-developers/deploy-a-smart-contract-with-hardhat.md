# Deploy a Smart Contract with Hardhat

## Deploying a Contract Using Hardhat Scripts

This tutorial will walk you through writing and compiling an ERC-721  Solidity smart contract. You'll then deploy and interact with it on the Hedera network using the [Hedera Smart Contract Service (HSCS)](../support-and-community/glossary.md#hedera-smart-contract-service-hscs) and familiar EVM tools like Ethers.js, connecting via the [JSON-RPC relay](../core-concepts/smart-contracts/json-rpc-relay.md).&#x20;

#### What you will accomplish

By the end of this tutorial, you will be able to:

* Compile and deploy a smart contract using Hardhat
* Interact with a smart contract using Hardhat

{% hint style="info" %}
**Note:** This tutorial is currently supported only in the Getting Started [JavaScript](https://github.com/hedera-dev/hello-future-world-js) series and is not available for other languages.
{% endhint %}

***

## Prerequisites

Before you begin, you should have **completed** the following tutorial:

* [x] [Create and Fund a Testnet Account via the Hedera Faucet](hedera-testnet-faucet.md)

***

## Table of Contents

1. [Step 1: Project Setup](deploy-a-smart-contract-with-hardhat.md#step-1-project-setup)
2. [Step 2: Creating the ERC-721 Contract](deploy-a-smart-contract-with-hardhat.md#step-2-creating-the-erc-721-contract)
3. [Step 3: Deploy Your ERC-721 Smart Contract](deploy-a-smart-contract-with-hardhat.md#step-3-deploy-your-erc-721-smart-contract)
4. [Step 4: Minting an ERC-721 Token](deploy-a-smart-contract-with-hardhat.md#step-4-minting-an-erc-721-token)

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

To create your `.env` file, you can run the below command:

```bash
touch .env
```

Securely store your sensitive data like the `OPERATOR_KEY` in a `.env` file. For the JSON `RPC_URL`, we'll use the [Hashio RPC endpoint for testnet](https://www.hashgraph.com/hashio/).&#x20;

{% code title=".env" %}
```bash
OPERATOR_KEY=your-operator-key
RPC_URL=https://testnet.hashio.io/api
```
{% endcode %}

{% hint style="warning" %}
Replace the `your-operator-key` environment variable wiht the **HEX Encoded Private Key** for your **ECDSA** **account** from the [Hedera Portal](https://portal.hedera.com/).&#x20;
{% endhint %}

{% hint style="danger" %}
_**Please note**:_ _that Hashio is intended for development and testing purposes only. For production use cases, it's recommended to use commercial-grade JSON-RPC Relay or host your own instance of the_ [_Hiero JSON-RPC Relay_](https://github.com/hiero-ledger/hiero-json-rpc-relay)_._&#x20;
{% endhint %}

#### Configure Hardhat

Create a `hardhat.config.js`file in the root of your project. This file contains the network settings so Hardhat knows how to interact with the Hedera Testnet. We'll use the variables you've stored in your `.env` file. Don't forget to import the `dotenv` package to load environment variables and the Hardhat Toolbox package to be able to use Hardhat scripts.

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

{% code title="contracts/erc-721.sol" %}
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

{% code title="scripts/deploy.js" %}
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

<figure><img src="../.gitbook/assets/Untitled design (13).png" alt=""><figcaption></figcaption></figure>

***

## Step 4: Minting an ERC-721 Token

Create a `mint.js` script in your `scripts` directory to mint an ERC-721 token. Don't forget to replace the `<your-contract-address>` with the address you've just copied.&#x20;

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

**Congratulations! 🎉 You have successfully learned how to deploy an ERC-721 smart contract using Hardhat, OpenZeppelin, and Ethers. Feel free to reach out in** [**Discord**](https://hedera.com/discord)**!**

***

## Next Steps

* Learn how to add [Access Control, Pause, and Transfer ERC-721 ](../tutorials/smart-contracts/how-to-set-access-control-a-token-uri-pause-and-transfer-an-erc-721-token-using-hardhat-part-2.md)tokens
* Check out [OpenZeppelin ERC-721 Documentation](https://docs.openzeppelin.com/contracts/5.x/erc721)
* See the full code in the [Hedera-Code-Snippets Repository](https://github.com/hedera-dev/hedera-code-snippets/tree/main/hardhat-erc-721-mint-burn)
