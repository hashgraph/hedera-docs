# Configuring Hardhat with Hiero Local Node: A Step-by-Step Guide

Developers building smart contracts on Hedera often use the **Hedera JSON-RPC Relay** to enable Ethereum tools like **Hardhat**. In this post, we'll walk through how to set up Hardhat to work with the **Hiero Local Node**, allowing for local deployment, debugging, and testing of smart contracts without using testnet resources.

{% hint style="success" %}
Not sure whether to use the Hiero Local Node, Hashio, or a custom relay setup? Read this [blog post](https://docs.hedera.com/hedera/tutorials/local-node/how-to-set-up-a-hedera-local-node) comparing the different options.
{% endhint %}

## Prerequisites

* Basic understanding of smart contracts.
* Basic understanding of [Node.js](https://nodejs.org/en/download) and JavaScript.
* Basic understanding of [Hardhat Ethereum Development Tool](https://hardhat.org/hardhat-runner/docs/guides/project-setup) and [Ethers](https://docs.ethers.org/v5/).
* ECDSA account from the [Hedera Portal](https://portal.hedera.com/).

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

This command will also generate accounts on startup, which we will use later in our `hardhat.config.js`.

<figure><img src="../../.gitbook/assets/hedera local node.png" alt=""><figcaption><p>Auto-generated accounts for Hiero Local Node</p></figcaption></figure>

## Step 2: Create a Hardhat Project

If you don’t already have a Hardhat project, create one:

```bash
mkdir tutorial-local-hardhat
cd tutorial-local-hardhat
npx hardhat init
```

Make sure to select "**Create a JavaScript project"** and accept the default values. Hardhat will configure your project correctly and install the required dependencies like `hardhat` and `@nomicfoundation/hardhat-toolbox` (This includes plugins for Ethers, Waffle, Chai, and more).

<figure><img src="../../.gitbook/assets/Screenshot 2025-06-04 at 2.48.36 PM.png" alt=""><figcaption><p>Console logs for "npx hardhat init"</p></figcaption></figure>

## Step 3: Configure "hardhat.config.js"

Update your config to include the Hiero Local Node as a custom network:

<pre class="language-javascript"><code class="lang-javascript"><strong>require("@nomicfoundation/hardhat-toolbox");
</strong>
module.exports = {
  solidity: {
    version: "0.8.28",
  },
  paths: {
    sources: "./contracts",
    tests: "./test",
    cache: "./cache",
    artifacts: "./artifacts",
  },
  defaultNetwork: "local",
  networks: {
    local: {
      url: 'http://localhost:7546',
      accounts: [
        "0x105d050185ccb907fba04dd92d8de9e32c18305e097ab41dadda21489a211524",
        "0x2e1d968b041d84dd120a5860cee60cd83f9374ef527ca86996317ada3d0d03e7"
      ],
      chainId: 298,
    }
  },
};
</code></pre>

🔍 **Key Highlights**

* **Network config: `local`**
  * `url: 'http://localhost:7546'`:\
    ➤ This is the **Hedera JSON-RPC Relay** endpoint provided by the local node (via Docker). It enables Ethereum-compatible tools like Hardhat and Ethers.js to interact with the Hedera network.
  * `accounts`:\
    ➤ Two predefined **ECDSA private keys** provided by the Hiero Local Node.\
    ➤ These accounts are already **funded**, and can be used immediately to deploy and interact with smart contracts.
  * `chainId: 298`:\
    ➤ This is the chain ID used by the Hiero Local Node to distinguish it from mainnet (295) or testnet (296).
* **Set paths**:
  * `./contracts`: Where your smart contracts are located.
  * `./tests`: Directory for writing and running Hardhat tests.
  * `./cache` & `./artifacts`: Manage build outputs and compilation caching to speed up repeated runs.
* **Default network: `"local"`**
  * Automatically uses the local Hedera environment for all tasks like compiling, deploying, testing, and scripting.

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

<table data-card-size="large" data-view="cards"><thead><tr><th align="center"></th><th data-hidden data-card-target data-type="content-ref"></th></tr></thead><tbody><tr><td align="center"><p>Writer: Michiel, Developer Relations Engineer</p><p><a href="https://github.com/michielmulders">GitHub</a> | <a href="https://www.linkedin.com/in/michielmulders/">LinkedIn</a></p></td><td><a href="https://www.linkedin.com/in/michielmulders/">https://www.linkedin.com/in/michielmulders/</a></td></tr><tr><td align="center"><p>Editor: Krystal, Technical Writer</p><p><a href="https://github.com/theekrystallee">GitHub</a> | <a href="https://x.com/theekrystallee">X</a></p></td><td><a href="https://x.com/theekrystallee">https://x.com/theekrystallee</a></td></tr></tbody></table>
