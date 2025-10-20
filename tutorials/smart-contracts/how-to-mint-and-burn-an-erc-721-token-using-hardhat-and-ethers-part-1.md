# How to Mint & Burn an ERC-721 Token Using Hardhat and Ethers (Part 1)

In this tutorial, you'll learn how to deploy, mint, and burn [ERC-721](../../support-and-community/glossary.md#erc-721) tokens (NFTs) using Hardhat, Ethers, and OpenZeppelin contracts on the Hedera Testnet. We'll cover setting up your project, writing and deploying an ERC-721 smart contract, minting an NFT to your account, and finally, burning an NFT.&#x20;

By the end, you'll have hands-on experience with essential ERC-721 operations and interacting with smart contracts on Hedera.

{% hint style="info" %}
You can take a look at the **complete code** in the [**Hedera-Code-Snippets repository**](https://github.com/hedera-dev/hedera-code-snippets/tree/main/hardhat-erc-721-mint-burn).
{% endhint %}

***

## Prerequisites

* Complete Tutorial: [Configure Hardhat with Hedera localnet/testnet](configuring-hardhat-with-hiero-local-node-a-step-by-step-guide.md)
* Basic understanding of smart contracts.
* Basic understanding of [Node.js](https://nodejs.org/en/download) and JavaScript.
* Basic understanding of [Hardhat EVM Development Tool](https://hardhat.org/docs/getting-started#getting-started-with-hardhat-3) and [Ethers](https://docs.ethers.org/v6/).
* ECDSA account from the [Hedera Portal](https://portal.hedera.com/).

***

## Table of Contents

1. [Project Setup](how-to-mint-and-burn-an-erc-721-token-using-hardhat-and-ethers-part-1.md#step-1-project-setup)
   1. [Initialize Project](how-to-mint-and-burn-an-erc-721-token-using-hardhat-and-ethers-part-1.md#initialize-project)
   2. [Configure Hardhat](how-to-mint-and-burn-an-erc-721-token-using-hardhat-and-ethers-part-1.md#configure-hardhat)
2. [Creating the ERC-721 Contract](how-to-mint-and-burn-an-erc-721-token-using-hardhat-and-ethers-part-1.md#step-2-creating-the-erc-721-contract)
3. [Deploy Your Smart Contract](how-to-mint-and-burn-an-erc-721-token-using-hardhat-and-ethers-part-1.md#step-3-deploy-your-erc-721-smart-contract)
4. [Minting an NFT](how-to-mint-and-burn-an-erc-721-token-using-hardhat-and-ethers-part-1.md#step-4-minting-an-nft)
5. [Adding the Burn Functionality](how-to-mint-and-burn-an-erc-721-token-using-hardhat-and-ethers-part-1.md#step-5-adding-the-burn-functionality)
6. [Burning an NFT](how-to-mint-and-burn-an-erc-721-token-using-hardhat-and-ethers-part-1.md#step-6-burning-an-nft)
7. [Run tests](how-to-mint-and-burn-an-erc-721-token-using-hardhat-and-ethers-part-1.md#step-7-run-tests-optional)

***

## Video Tutorial

You can watch the video tutorial (which uses **Hardhat version 2**) or follow the step-by-step tutorial below (which uses **Hardhat version 3**).

{% include "../../.gitbook/includes/hardhat-2-3.md" %}

{% embed url="https://www.youtube.com/watch?t=3s&v=B23aVhaCARU" %}

***

## Step 1: Project Setup

#### **Initialize Project**&#x20;

Set up your project by initializing the hardhat project:

```bash
mkdir hardhat-erc-721-mint-burn
cd hardhat-erc-721-mint-burn
npx hardhat --init
```

Make sure to select "**Hardhat 3 -> Typescript Hardhat Project using Mocha and Ethers.js"** and accept the default values. Hardhat will configure your project correctly and install the required dependencies.

#### Install Dependencies

Next, install the required dependencies:

```bash
npm install @openzeppelin/contracts
```

{% include "../../.gitbook/includes/hardhat-keystore.md" %}

{% hint style="danger" %}
#### Note

[_Hashio_](https://www.hashgraph.com/hashio/) _is intended for development and testing purposes only. For production use cases, it's recommended to use commercial-grade JSON-RPC Relay or host your own instance of the_ [_Hiero JSON-RPC Relay_](https://github.com/hiero-ledger/hiero-json-rpc-relay)_._&#x20;
{% endhint %}

#### Configure Hardhat

Update your `hardhat.config.ts`file in the root directory of your project. This file contains the network settings so Hardhat knows how to interact with the Hedera Testnet.&#x20;

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

You can verify the connection by running:

```bash
npx hardhat console --network testnet
```

This command launches an interactive JavaScript console connected directly to the Hedera Testnet, providing access to the Ethers.js library for blockchain interactions. If you successfully enter this interactive environment, your Hardhat configuration is correct. To exit the interactive console, press `ctrl + c` twice.

We won't be using `ignition` and we will be removing the default contracts that comes with hardhat default project so we will remove all the unnecessary directories and files first:

```bash
rm -rf contracts/* scripts/* test/*
rm -rf ignition
```

***

## Step 2: Creating the ERC-721 Contract

Create a new Solidity file (`MyToken.sol`) in our `contracts` directory:

{% code title="contracts/MyToken.sol" %}
```solidity
// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.28;

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
npx hardhat build
```

This command will generate the smart contract artifacts, including the [ABI](https://docs.hedera.com/hedera/core-concepts/smart-contracts/compiling-smart-contracts). We are now ready to deploy the smart contract.

***

## Step 3: Deploy Your ERC-721 Smart Contract

Create a deployment script (`deploy.ts`) in `scripts` directory:

{% code title="scripts/deploy.ts" %}
```typescript
import { network } from "hardhat";

const { ethers } = await network.connect({
  network: "testnet"
});

async function main() {
  // Get the signer of the tx and address for minting the token
  const [deployer] = await ethers.getSigners();
  console.log("Deploying contract with the account:", deployer.address);

  // The deployer will also be the owner of our NFT contract
  const MyToken = await ethers.getContractFactory("MyToken", deployer);
  const contract = await MyToken.deploy(deployer.address);

  await contract.waitForDeployment();

  const address = await contract.getAddress();
  console.log("Contract deployed at:", address);
}

main().catch(console.error);
```
{% endcode %}

In this script, we first retrieve your account (the deployer) using Ethers.js. This account will own the deployed smart contract. Next, we use this account to deploy the contract by calling `MyToken.deploy(deployer.address)`. This passes your account address as the initial owner and signer of the deployment transaction.

Deploy your contract by executing the script:

```bash
npx hardhat run scripts/deploy.ts --network testnet
```

{% hint style="success" %}
Copy the deployed address—you'll need this in subsequent steps.
{% endhint %}

The output looks like this:

```bash
~/projects/hardhat-erc-721-mint-burn >> npx hardhat run scripts/deploy.ts --network testnet
Compiling your Solidity contracts...
Compiled 1 Solidity file with solc 0.8.28 (evm target: cancun)

Deploying contract with the account: 0xA98556A4deeB07f21f8a66093989078eF86faa30
Contract deployed at: 0x6035bA3BCa9595637B463Aa514c3a1cE3f67f3de
```

***

## Step 4: Minting an NFT

Create a `mint.ts` script in your `scripts` directory to mint an NFT. Don't forget to replace the `<your-contract-address>` with the address you've just copied.&#x20;

{% code title="scripts/mint.ts" %}
```typescript
import { network } from "hardhat";

const { ethers } = await network.connect({
  network: "testnet"
});

async function main() {
  const [deployer] = await ethers.getSigners();

  // Get the ContractFactory of your MyToken ERC-721 contract
  const MyToken = await ethers.getContractFactory("MyToken", deployer);

  // Connect to the deployed contract
  // (REPLACE WITH YOUR CONTRACT ADDRESS)
  const contractAddress = "<your-contract-address>";
  const contract = MyToken.attach(contractAddress);

  // Mint a token to ourselves
  const mintTx = await contract.safeMint(deployer.address);
  const receipt = await mintTx.wait();
  console.log("receipt: ", JSON.stringify(receipt, null, 2));
  const mintedTokenId = receipt?.logs[0].topics[3];
  console.log("Minted token ID:", mintedTokenId);

  // Check the balance of the token
  const balance = await contract.balanceOf(deployer.address);
  console.log("Balance:", balance.toString(), "NFTs");
}

main().catch(console.error);
```
{% endcode %}

The code mints a new NFT to your account ( `deployer.address` ). Then we verify the balance to see if we own an ERC-721 token of type `MyToken`.

Mint an NFT:

```bash
npx hardhat run scripts/mint.ts --network testnet
```

Expected output:

```json
~/projects/hardhat-erc-721-mint-burn >> npx hardhat run scripts/mint.ts --network testnet
Compiling your Solidity contracts...

Nothing to compile

receipt:  {
  "_type": "TransactionReceipt",
  "blockHash": "0x110b2de909e2f4d515b76de4ffd7a8a9f4c3e68c79f8aa083f9baf2a7d082a5c",
  "blockNumber": 23836191,
  "contractAddress": "0x6035bA3BCa9595637B463Aa514c3a1cE3f67f3de",
  "cumulativeGasUsed": "800000",
  "from": "0xA98556A4deeB07f21f8a66093989078eF86faa30",
  "gasPrice": "350000000000",
  "blobGasUsed": null,
  "blobGasPrice": null,
  "gasUsed": "800000",
  "hash": "0xb0a67ee89e224208599b29a71bc5de1abc5aba4cf64553893aaf0aeb051f7a91",
  "index": 9,
  "logs": [
    {
      "_type": "log",
      "address": "0x6035bA3BCa9595637B463Aa514c3a1cE3f67f3de",
      "blockHash": "0x110b2de909e2f4d515b76de4ffd7a8a9f4c3e68c79f8aa083f9baf2a7d082a5c",
      "blockNumber": 23836191,
      "data": "0x",
      "index": 0,
      "topics": [
        "0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef",
        "0x0000000000000000000000000000000000000000000000000000000000000000",
        "0x000000000000000000000000a98556a4deeb07f21f8a66093989078ef86faa30",
        "0x0000000000000000000000000000000000000000000000000000000000000000"
      ],
      "transactionHash": "0xb0a67ee89e224208599b29a71bc5de1abc5aba4cf64553893aaf0aeb051f7a91",
      "transactionIndex": 9
    }
  ],
  "logsBloom": "0x00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008000000000000002001000000000000000000000000000000020000000000000000000800000000000000000000000010000000000000000000000400000000020000000000000000000000000000000000000000000000000000000040000000000000000000000000000000000000000000000000000003000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000000000",
  "root": "0x56e81f171bcc55a6ff8345e692c0f86e5b48e01b996cadc001622fb5e363b421",
  "status": 1,
  "to": "0x6035bA3BCa9595637B463Aa514c3a1cE3f67f3de"
}
Minted token ID: 0x0000000000000000000000000000000000000000000000000000000000000000
Balance: 1 NFTs
```

***

## Step 5: Adding the Burn Functionality

Update your contract to add NFT burning capability by importing the burnable extension and adding it to the interfaces list for your contract:

```solidity
// [...]
import {ERC721Burnable} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";

contract MyToken is ERC721, ERC721Burnable, Ownable {
// [...]
```

Redeploy:

```bash
npx hardhat run scripts/deploy.ts --network testnet
```

Copy the new smart contract address and replace the address in the `scripts/mint.ts` script with your new address. Let's mint a new NFT for the redeployed contract:

```bash
npx hardhat run scripts/mint.ts --network testnet
```

***

## Step 6: Burning an NFT

Create a burn script (`burn.ts` ) in your `scripts` directory:

{% code title="scripts/burn.ts" %}
```typescript
import { network } from "hardhat";

const { ethers } = await network.connect({
  network: "testnet"
});

async function main() {
  const [deployer] = await ethers.getSigners();

  // Get the ContractFactory of your MyToken ERC-721 contract
  const MyToken = await ethers.getContractFactory("MyToken", deployer);

  // Connect to the deployed contract
  // (REPLACE WITH YOUR CONTRACT ADDRESS)
  const contractAddress = "0x00f2753A689C3bdd1a733430c7b63A3993B1eFBc";
  const contract = MyToken.attach(contractAddress);

  // Burn the token
  const burnTx = await contract.burn(0);
  const receipt = await burnTx.wait();
  console.log("receipt: ", JSON.stringify(receipt, null, 2));
  const burnedTokenId = receipt?.logs[0].topics[3];
  console.log("Burned token with ID:", burnedTokenId);

  // Check the balance of the token
  const balance = await contract.balanceOf(deployer.address);
  console.log("Balance:", balance.toString(), "NFTs");
}

main().catch(console.error);
```
{% endcode %}

Again, ensure you update `<your-contract-address>` to interact with your correct contract. The script will burn the ERC-721 token with the ID set to `0`, which is the ERC-721 token you've just minted. To be sure the token has been deleted, let's print the balance for our account to the terminal. The balance should show a balance of `0`.

Burn the NFT:

```bash
npx hardhat run scripts/burn.ts --network testnet
```

**Congratulations! 🎉 You have successfully learned how to deploy an ERC-721 smart contract using Hardhat, OpenZeppelin, and Ethers. Feel free to reach out in** [**Discord**](https://hedera.com/discord)**!**

## Step 7: Run tests(Optional)

You can find both types of tests in the [**Hedera-Code-Snippets repository**](https://github.com/hedera-dev/hedera-code-snippets/tree/main/hardhat-erc-721-mint-burn). You will find the following files:

* `contracts/MyToken.t.sol`
* `test/MyToken.ts`

Copy these files and then run the tests:

```bash
npx hardhat test
```

You can also run tests individually with either of these

```bash
npx hardhat test solidity
npx hardhat test mocha
```

***

## Additional Resources

* [OpenZeppelin ERC-721 Documentation](https://docs.openzeppelin.com/contracts/5.x/erc721)
* [Full Code in Hedera-Code-Snippets Repository](https://github.com/hedera-dev/hedera-code-snippets/tree/main/hardhat-erc-721-mint-burn)

<table data-card-size="large" data-view="cards"><thead><tr><th align="center"></th><th data-hidden data-card-target data-type="content-ref"></th></tr></thead><tbody><tr><td align="center"><p>Writer: Michiel, DevRel Engineer</p><p><a href="https://github.com/michielmulders">GitHub</a> | <a href="https://www.linkedin.com/in/michielmulders/">LinkedIn</a></p></td><td><a href="https://www.linkedin.com/in/michielmulders/">https://www.linkedin.com/in/michielmulders/</a></td></tr><tr><td align="center"><p>Editor: Luis, Sr Software Developer</p><p><a href="https://github.com/acuarica">GitHub</a></p></td><td><a href="https://github.com/acuarica">https://github.com/acuarica</a></td></tr><tr><td align="center"><p>Editor: Krystal, DX Engineer</p><p><a href="https://github.com/theekrystallee">GitHub</a> | <a href="https://x.com/theekrystallee">X</a></p></td><td><a href="https://x.com/theekrystallee">https://x.com/theekrystallee</a></td></tr><tr><td align="center"><p>Editor: Kiran, Developer Advocate</p><p><a href="https://github.com/kpachhai">GitHub</a> | <a href="https://www.linkedin.com/in/kiranpachhai/">LinkedIn</a></p></td><td><a href="https://github.com/kpachhai">https://github.com/kpachhai</a></td></tr></tbody></table>
