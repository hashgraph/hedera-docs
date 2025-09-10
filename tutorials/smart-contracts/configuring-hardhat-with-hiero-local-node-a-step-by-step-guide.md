# Configuring Hardhat with Hedera Localnet/Testnet: A Step-by-Step Guide

Developers building smart contracts on Hedera often use the **Hedera JSON-RPC Relay** to enable EVM tools like **Hardhat**. In this post, we'll walk through how to set up Hardhat to work with the **Hiero Local Node**, allowing for local deployment, debugging, and testing of smart contracts without using testnet resources.

{% hint style="success" %}
Not sure whether to use the Hiero Local Node, Hashio, or a custom relay setup? Read this [blog post](https://docs.hedera.com/hedera/tutorials/local-node/how-to-set-up-a-hedera-local-node) comparing the different options.
{% endhint %}

{% hint style="info" %}
You can take a look at the **complete code** in the [**Hedera-Code-Snippets repository**](https://github.com/hedera-dev/hedera-code-snippets/tree/main/tutorial-local-hardhat).
{% endhint %}

## Prerequisites

* Basic understanding of smart contracts.
* Basic understanding of [Node.js](https://nodejs.org/en/download) and JavaScript/TypeScript.
* Basic understanding of [Hardhat EVM Development Tool](https://hardhat.org/docs/getting-started#getting-started-with-hardhat-3) and [Ethers](https://docs.ethers.org/v6/).
* ECDSA account from the [Hedera Portal](https://portal.hedera.com/).

***

## Video Tutorial

You can watch the video tutorial (which uses **Hardhat version 2**) or follow the step-by-step tutorial below (which uses **Hardhat version 3**).

{% include "../../.gitbook/includes/hardhat-2-3.md" %}

{% embed url="https://www.youtube.com/watch?v=F34uHc0hVAg" %}

***

## Step 1: Set Up the Hiero Local Node

Hedera provides a local node configuration that includes a mirror node, a consensus node, and the JSON-RPC relay. You can run it via `npm`.

**Clone, install, and run the node:**

```bash
git clone https://github.com/hiero-ledger/hiero-local-node.git
cd hiero-local-node
npm install
npm run start
```

Once all the containers have started, the Hiero Local Node is up and running. This includes a Consensus Node, Mirror Node and explorer, JSON RPC Relay, Block Node, Grafana UI, and Prometheus UI. &#x20;

This command will also generate accounts on startup, which we will use later in our `hardhat.config.ts`.

<figure><img src="../../.gitbook/assets/hedera local node.png" alt=""><figcaption><p>Auto-generated accounts for Hiero Local Node</p></figcaption></figure>

***

## Step 2: Create a Hardhat Project

If you don’t already have a Hardhat project, create one:

```bash
mkdir tutorial-local-hardhat
cd tutorial-local-hardhat
npx hardhat --init
```

Make sure to select "**Hardhat 3 -> Typescript Hardhat Project using Mocha and Ethers.js"** and accept the default values. Hardhat will configure your project correctly and install the required dependencies like `hardhat` and `@nomicfoundation/hardhat-ethers` (This includes plugins for Ethers, Mocha, Chai, and more).

<figure><img src="../../.gitbook/assets/Screenshot 2025-08-14 at 16.19.31.png" alt=""><figcaption></figcaption></figure>

### Project Structure

The Hardhat project initialization from the previous section creates the following file structure:

```
hardhat.config.ts

contracts
├── Counter.sol
└── Counter.t.sol
test
└── Counter.ts
ignition
└── modules
    └── Counter.ts
scripts
└── send-op-tx.ts
```

Here's a quick overview of these files and directories:

* `hardhat.config.ts`: The main configuration file for your project. It defines settings like the Solidity compiler version, network configurations, and the plugins and tasks your project uses.
* `contracts`: Contains your project's Solidity contracts. You can also include Solidity test files here by using the `.t.sol` extension.
* `test`: Used for TypeScript integration tests. You can also include Solidity test files here.
* `ignition`: Holds your [Hardhat Ignition](https://hardhat.org/ignition) deployment modules, which describe how your contracts should be deployed.
* `scripts`: A place for any custom scripts that automate parts of your workflow. Scripts have full access to Hardhat's runtime and can use plugins, connect to networks, deploy contracts, and more.

***

## Step 3: Configure "hardhat.config.ts"

Before we make any changes to our Hardhat configuration file, let's set some configuration variables we will be referring to within the file later.

```bash
# If you have already set this before, please use the --force flag
npx hardhat keystore set HEDERA_RPC_URL
```

For `HEDERA_RPC_URL`, we'll have `https://localhost:7546`

```bash
# If you have already set this before, please use the --force flag
npx hardhat keystore set HEDERA_PRIVATE_KEY
```

For `HEDERA_PRIVATE_KEY`, enter  `0x105d050185ccb907fba04dd92d8de9e32c18305e097ab41dadda21489a211524`

{% hint style="info" %}
**Note:** We got this private key from our console when we started our Hiero Local Node.
{% endhint %}

Now, we can update our Hardhat config file to include the Hiero Local Node as a custom network:

{% code title="hardhat.config.ts" %}
```typescript
import type { HardhatUserConfig } from "hardhat/config";

import hardhatToolboxViemPlugin from "@nomicfoundation/hardhat-toolbox-viem";
import { configVariable } from "hardhat/config";

const config: HardhatUserConfig = {
  plugins: [hardhatToolboxViemPlugin],
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
    hedera: {
      type: "http",
      url: configVariable("HEDERA_RPC_URL"),
      accounts: [configVariable("HEDERA_PRIVATE_KEY")]
    },
    hardhatMainnet: {
      type: "edr-simulated",
      chainType: "l1"
    },
    hardhatOp: {
      type: "edr-simulated",
      chainType: "op"
    },
  }
};

export default config;
```
{% endcode %}

🔍 **Key Highlights**

* **Network config: `local`**
  * `url`:\
    ➤ This is the **Hedera JSON-RPC Relay** endpoint provided by the local node (via Docker). It enables EVM-compatible tools like Hardhat and Ethers.js to interact with the Hedera network.
  * `accounts`:\
    ➤ One predefined **ECDSA private key** provided by the Hiero Local Node.\
    ➤ This account is already **funded**, and can be used immediately to deploy and interact with smart contracts.
* **Set paths**:
  * `./cache` & `./artifacts`: Manage build outputs and compilation caching to speed up repeated runs.

***

## Step 4: Build and Deploy

You can build the project using:

```bash
# You can also do `npx hardhat compile`
npx hardhat build
```

You can run all the tests in your project—both Solidity and TypeScript—using the `test` task:

```bash
npx hardhat test
# If you only want to run your Solidity tests, you can use this instead:
npx hardhat test solidity
# If you only want to run your mocha tests, you can use this instead:
npx hardhat test mocha
```

We won't be using `ignition` so we will remove all the unnecessary directories and files first:

```bash
rm -rf ignition
# Let's rename the existing script 
mv scripts/send-op-tx.ts scripts/send-tx.ts
```

Update the script `scripts/send-tx.ts`

```typescript
import { network } from "hardhat";

const { ethers } = await network.connect({
  network: "hedera"
});

console.log("Sending transaction on Hedera network");

const [sender] = await ethers.getSigners();

console.log("Sending 10_000_000_000 wei from", sender.address, "to itself");

console.log("Sending transaction");
const tx = await sender.sendTransaction({
  to: sender.address,
  value: 10_000_000_000n
});

await tx.wait();

console.log("Transaction sent successfully");

```

Let's run our script to make sure everything works:

```bash
~/projects/tutorial-local-hardhat >> npx hardhat run scripts/send-tx.ts
Compiling your Solidity contracts...
Sending transaction on Hedera network
Sending 10_000_000_000 wei from 0x67D8d32E9Bf1a9968a5ff53B87d777Aa8EBBEe69 to itself
Sending transaction
Transaction sent successfully
```

Let's write a deploy script that we will use to deploy the `Counter` contract.

```bash
touch scripts/deploy.ts
```

The `scripts/deploy.ts` will have the following code:

```typescript
import { network } from "hardhat";

const { ethers } = await network.connect({
  network: "hedera"
});

async function main(): Promise<void> {
  // Get the signer of the tx and address for minting the token
  const [deployer] = await ethers.getSigners();
  console.log("Deploying contract with the account:", deployer.address);

  const Counter = await ethers.getContractFactory("Counter", deployer);
  const contract = await Counter.deploy();

  await contract.waitForDeployment();

  const address = await contract.getAddress();
  console.log("Contract deployed at:", address);
}

main().catch(console.error);
```

Now, let's go ahead and deploy the contract:

```bash
~/projects/tutorial-local-hardhat >> npx hardhat run scripts/deploy.ts 
Compiling your Solidity contracts...
Compiled 1 Solidity file with solc 0.8.28 (evm target: cancun)

Deploying contract with the account: 0x67D8d32E9Bf1a9968a5ff53B87d777Aa8EBBEe69
Contract deployed at: 0xB3e022eBC7D5C5B1f4ca50b3D4A55173b34ceD49
```

***

## Step 5: Deploy on Testnet

If you would like to instead deploy and interact with testnet hedera network rather than a local hedera network, all you need to do is the following:

```bash
npx hardhat keystore set HEDERA_RPC_URL --force # Set this to "https://testnet.hashio.io/api"
npx hardhat keystore set HEDERA_PRIVATE_KEY --force # Set this to your private key. Eg. 0xd434asdfa...
npx hardhat run scripts/deploy.ts
```

## Further Learning & Next Steps

Want to take your local development setup even further? Here are some excellent tutorials to help you dive deeper into smart contract development on Hedera using Hardhat and Ethers.js:

1. [**How to Mint and Burn an ERC-721 Token** (Part 1)](https://docs.hedera.com/hedera/tutorials/smart-contracts/how-to-mint-and-burn-an-erc-721-token-using-hardhat-and-ethers-part-1)\
   Learn how to create a basic ERC-721 NFT, mint it, and burn it on Hedera.
2. [**Access Control, Token URI, Pause & Transfer** (Part 2)](https://docs.hedera.com/hedera/tutorials/smart-contracts/how-to-set-access-control-a-token-uri-pause-and-transfer-an-erc-721-token-using-hardhat-part-2)\
   Extend your NFT with features like pausing, setting token URIs, and restricting minting to specific roles.
3. [**Upgrade Your NFT with UUPS Proxies** (Part 3)](https://docs.hedera.com/hedera/tutorials/smart-contracts/how-to-upgrade-an-erc-721-token-with-openzeppelin-uups-proxies-and-hardhat-part-3)\
   Learn how to add upgradability to your smart contracts using OpenZeppelin’s UUPS proxy pattern on Hedera.
4. [**How to Set Up a Hedera Local Node**](https://docs.hedera.com/hedera/tutorials/local-node/how-to-set-up-a-hedera-local-node)\
   A hands-on guide to spinning up a local Hedera test environment with a built-in JSON-RPC Relay. Perfect for fast, zero-cost smart contract development and testing.

<table data-card-size="large" data-view="cards"><thead><tr><th align="center"></th><th data-hidden data-card-target data-type="content-ref"></th></tr></thead><tbody><tr><td align="center"><p>Writer: Michiel, DevRel Engineer</p><p><a href="https://github.com/michielmulders">GitHub</a> | <a href="https://www.linkedin.com/in/michielmulders/">LinkedIn</a></p></td><td><a href="https://www.linkedin.com/in/michielmulders/">https://www.linkedin.com/in/michielmulders/</a></td></tr><tr><td align="center"><p>Editor: Krystal, Technical Writer</p><p><a href="https://github.com/theekrystallee">GitHub</a> | <a href="https://x.com/theekrystallee">X</a></p></td><td><a href="https://x.com/theekrystallee">https://x.com/theekrystallee</a></td></tr><tr><td align="center"><p>Editor: Kiran, Developer Advocate</p><p><a href="https://github.com/kpachhai">GitHub</a> | <a href="https://www.linkedin.com/in/kiranpachhai/">LinkedIn</a></p></td><td><a href="https://github.com/kpachhai">https://github.com/kpachhai</a></td></tr></tbody></table>
