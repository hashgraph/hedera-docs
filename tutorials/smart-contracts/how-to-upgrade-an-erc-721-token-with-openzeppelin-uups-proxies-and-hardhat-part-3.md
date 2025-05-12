# How to Upgrade an ERC-721 Token with OpenZeppelin UUPS Proxies and Hardhat (Part 3)

In this tutorial, you'll learn how to upgrade your ERC-721 smart contract using the [OpenZeppelin UUPS](https://docs.openzeppelin.com/upgrades-plugins/proxies) (Universal Upgradeable Proxy Standard) pattern and Hardhat. We'll first cover how the upgradeable proxy pattern works, then go through step-by-step implementation and upgrade verification, explaining each part clearly.

{% hint style="info" %}
You can take a look at the **complete code** in the [**Hedera-Code-Snippets repository**](https://github.com/hedera-dev/hedera-code-snippets/tree/main/hardhat-erc-721-mint-burn).
{% endhint %}

## Understanding the Upgradeable Proxy Pattern (Simplified)

In traditional smart contracts, you can't change the logic once deployed, which can be risky if you find bugs or want to add new features. The upgradeable proxy pattern solves this by separating your contract into two parts:

1. **Proxy Contract**: Stores the state (data) and delegates all calls to the logic contract.
2. **Logic Contract**: Contains the actual business logic and can be replaced or upgraded.

When you upgrade your smart contract, you deploy a new logic contract and point your proxy contract to this new logic. The proxy stays at the same address, retaining your data and allowing seamless upgrades.

**Important Note:** In upgradeable contracts, constructors aren't used because the proxy doesn't call the constructor of the logic contract. Instead, we use an `initialize` function marked with the `initializer` modifier. This function serves the role of the constructor—setting up initial values and configuring inherited modules like `ERC721` or `Ownable`. The `initializer` modifier ensures this function can only be called once, helping protect against accidental or malicious re-initialization.

***

## Prerequisites

* ⚠️ **Complete** [**tutorial part 1**](how-to-mint-and-burn-an-erc-721-token-using-hardhat-and-ethers-part-1.md) **as we continue from this example. Part 2 is optional.**
* Basic understanding of smart contracts.
* Basic understanding of [Node.js](https://nodejs.org/en/download) and JavaScript.
* Basic understanding of [Hardhat EVM Development Tool](https://hardhat.org/hardhat-runner/docs/guides/project-setup) and [Ethers](https://docs.ethers.org/v5/).
* ECDSA account from the [Hedera Portal](https://portal.hedera.com/).

***

## Table of Contents

1. [Step 1: Set Up Your Project](how-to-upgrade-an-erc-721-token-with-openzeppelin-uups-proxies-and-hardhat-part-3.md#step-1-set-up-your-project)
2. [Step 2: Create Your Initial Upgradeable ERC-721 Contract](how-to-upgrade-an-erc-721-token-with-openzeppelin-uups-proxies-and-hardhat-part-3.md#step-2-create-your-initial-upgradeable-erc-721-contract)
3. [Step 3: Deploy Your Upgradeable Contract](how-to-upgrade-an-erc-721-token-with-openzeppelin-uups-proxies-and-hardhat-part-3.md#step-3-deploy-your-upgradeable-contract)
4. [Step 4: Upgrade Your ERC-721 Contract](how-to-upgrade-an-erc-721-token-with-openzeppelin-uups-proxies-and-hardhat-part-3.md#step-4-upgrade-your-erc-721-contract)
5. [Step 5: Deploy the Upgrade and Verify](how-to-upgrade-an-erc-721-token-with-openzeppelin-uups-proxies-and-hardhat-part-3.md#step-5-deploy-the-upgrade-and-verify)
6. [Why Use the UUPS Pattern?](how-to-upgrade-an-erc-721-token-with-openzeppelin-uups-proxies-and-hardhat-part-3.md#why-use-the-uups-pattern)

***

## Step 1: Set Up Your Project

Install necessary dependencies if you haven't done so. For part 3 of this tutorial series, we're adding two extra dependencies:

* `@openzeppelin/contracts-upgradeable` : This is a version of the OpenZeppelin Contracts library designed for upgradeable contracts. It contains modular and reusable smart contract components that are compatible with proxy deployment patterns, such as UUPS.
* `@openzeppelin/hardhat-upgrades` : This Hardhat plugin simplifies deploying and managing upgradeable contracts. It provides utilities like `deployProxy` and `upgradeProxy` and automatically manages the underlying proxy contracts. This plugin is imported in the `hardhat.config.js` file, so we can use it.

<pre class="language-javascript"><code class="lang-javascript"><strong>// hardhat.config.js
</strong><strong>require("dotenv").config();
</strong>require("@nomicfoundation/hardhat-toolbox");
require("@openzeppelin/hardhat-upgrades"); // Plugin for upgradeable contracts
require("@nomicfoundation/hardhat-ethers");
</code></pre>

## Step 2: Create Your Initial Upgradeable ERC-721 Contract

Create `erc-721-upgrade.sol` in the `contracts` directory:

```solidity
// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.22;

import {ERC721Upgradeable} from "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";
import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

contract MyTokenUpgradeable is Initializable, ERC721Upgradeable, OwnableUpgradeable, UUPSUpgradeable {
    uint256 private _nextTokenId;

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize(address initialOwner) public initializer {
        __ERC721_init("MyTokenUpgradeable", "MTU");
        __Ownable_init(initialOwner);
        __UUPSUpgradeable_init();
    }

    function safeMint(address to) public onlyOwner returns (uint256) {
        uint256 tokenId = _nextTokenId++;
        _safeMint(to, tokenId);
        return tokenId;
    }

    function _authorizeUpgrade(address newImplementation)
        internal
        override
        onlyOwner
    {}
}

```

* **`initialize` function**: Replaces the constructor in upgradeable contracts, setting initial values and calling necessary initializers.
* **`initializer` modifier**: Ensures the initialize function is only called once.
* **`_authorizeUpgrade`**: Ensures only the owner can authorize upgrades.

Compile the contract:

```bash
npx hardhat compile
```

## Step 3: Deploy Your Upgradeable Contract

Create `deploy-upgradeable.js` under the `scripts` directory:

```javascript
const { ethers, upgrades } = require("hardhat");

async function main() {
  const [deployer] = await ethers.getSigners();

  const Token = await ethers.getContractFactory("MyTokenUpgradeable");
  const token = await upgrades.deployProxy(Token, [deployer.address], { initializer: "initialize" });
  await token.waitForDeployment();

  console.log("Upgradeable ERC721 deployed to:", await token.getAddress());
}

main().catch(console.error);
```

* **`deployProxy` function**: Deploys the logic contract behind a proxy, calling the initializer function (`initialize`) automatically.
* **`initializer: "initialize"`**: Explicitly specifies which function initializes the contract.
* **`kind: "uups"`**: Specifies using the UUPS proxy pattern.

Deploy your contract:

```bash
npx hardhat run scripts/deploy-upgradeable.js --network testnet
```

**Make sure to copy the smart contract address for your ERC-721 token.**

<pre><code><strong>// output
</strong><strong>Compiled 32 Solidity files successfully (evm target: paris).
</strong>Upgradeable ERC721 deployed to: 0xb54c97235A7a90004fEb89dDccd68f36066fea8c
</code></pre>

## Step 4: Upgrade Your ERC-721 Contract

Let's upgrade your contract by adding a new `version` function. Create `erc-721-upgrade-v2.sol` in your `contracts` folder:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import "./erc-721-upgrade.sol";

contract MyTokenUpgradeableV2 is MyTokenUpgradeable {

    // New function for demonstration
    function version() public pure returns (string memory) {
        return "v2";
    }
}

```

* Adds a simple `version` method to demonstrate the upgrade. Note that we are extending the "MyTokenUpgradeable" contract.

Compile the upgraded version:

```bash
npx hardhat compile
```

## Step 5: Deploy the Upgrade and Verify

Create `upgrade.js` script to upgrade and verify the new functionality:

```javascript
const { ethers, upgrades } = require("hardhat");

async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Upgrading contract with the account:", deployer.address);

  const MyTokenUpgradeableV2 = await ethers.getContractFactory(
    "MyTokenUpgradeableV2"
  );

  // REPLACE with your deployed proxy contract address
  const proxyAddress = "<YOUR-PROXY-CONTRACT-ADDRESS>";

  const upgraded = await upgrades.upgradeProxy(
    proxyAddress,
    MyTokenUpgradeableV2
  );
  await upgraded.waitForDeployment();

  console.log(
    "Contract successfully upgraded at:",
    await upgraded.getAddress()
  );

  // Verify the upgrade by calling the new version() function
  const contractVersion = await upgraded.version();
  console.log("Contract version after upgrade:", contractVersion);
}

main().catch(console.error);
```

* **`upgradeProxy`**: Replaces the logic contract behind your existing proxy with the new version.
* **`proxyAddress`**: Points to the proxy contract that manages storage and delegates calls to logic contracts. Upgrading involves replacing the logic without altering the stored data. **Make sure to replace the proxy contract address with the address you've copied.**
* **Verification step**: Calls the new `version` method to ensure the upgrade succeeded.

Run this upgrade script:

```bash
npx hardhat run scripts/upgrade.js --network testnet
```

Output confirms the upgrade:

```bash
// output
Upgrading contract with the account: 0x7203b2B56CD700e4Df7C2868216e82bCCA225423
Contract successfully upgraded at: 0xb54c97235A7a90004fEb89dDccd68f36066fea8c
Contract version after upgrade: v2
```

## Why Use the UUPS Pattern?

* **Security**: Upgrade functions can be restricted, ensuring only authorized roles can perform upgrades.
* **Data Retention**: Maintains all token balances and stored data during upgrades.
* **Flexibility**: Enables easy updates for new features, improvements, or critical fixes without redeploying a completely new contract.

Congratulations! 🎉 You've successfully implemented and upgraded an ERC-721 smart contract using OpenZeppelin’s UUPS proxy pattern with Hardhat.

***

## Additional Resources

* [Proxy Upgrade Pattern (OpenZeppelin)](https://docs.openzeppelin.com/upgrades-plugins/proxies)

<table data-card-size="large" data-view="cards"><thead><tr><th align="center"></th><th data-hidden data-card-target data-type="content-ref"></th></tr></thead><tbody><tr><td align="center"><p>Writer: Michiel, Developer Relations Engineer</p><p><a href="https://github.com/michielmulders">GitHub</a> | <a href="https://www.linkedin.com/in/michielmulders/">LinkedIn</a></p></td><td><a href="https://www.linkedin.com/in/michielmulders/">https://www.linkedin.com/in/michielmulders/</a></td></tr><tr><td align="center"><p>Editor: Luis, Sr Software Developer</p><p><a href="https://github.com/acuarica">GitHub</a></p></td><td><a href="https://github.com/acuarica">https://github.com/acuarica</a></td></tr><tr><td align="center"><p>Editor: Krystal, Technical Writer</p><p><a href="https://github.com/theekrystallee">GitHub</a> | <a href="https://x.com/theekrystallee">X</a></p></td><td><a href="https://x.com/theekrystallee">https://x.com/theekrystallee</a></td></tr></tbody></table>
