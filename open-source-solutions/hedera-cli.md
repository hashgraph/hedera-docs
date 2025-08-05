# Hedera CLI

## Introduction to Hedera CLI

The [Hedera CLI ](https://github.com/hashgraph/hedera-cli)is a command‑line interface that offers a simple way to interact with the Hedera network. It consolidates many common network operations into easy-to‑use commands so you can:

* **Test** your Hedera applications quickly.
* **Automate** repetitive tasks without writing bulky code.
* **Simplify** key management, letting you focus on building and scaling your solutions.

## Who Is It For?

* **Developers Building and Testing:**\
  This is ideal for developers looking for a quick way to interact with Hedera to set up a testing environment with multiple accounts, tokens, topics, etc.&#x20;
* **Automation Enthusiasts:**\
  If you prefer to integrate simple scripts and command-based automation with your CI/CD pipelines or routine operations, the Hedera CLI offers a clean, command-oriented approach using "script blocks." These allow you to chain commands together and pass variables dynamically between them.
* **Experimenters:**\
  This is perfect for those who want to validate network behaviors or run quick experiments without delving into Hedera's implementation details.

***

## Getting Started

**Prerequisites**:

* Node.js installation: LTS 16.20.2 or higher
* [Hedera Account](https://portal.hedera.com/) (for mainnet, testnet, or previewnet) or [Hedera Local Node](https://docs.hedera.com/hedera/tutorials/local-node/how-to-set-up-a-hedera-local-node) (for localnet)

[**Follow the installation steps in the Hedera CLI repository.**](https://github.com/hashgraph/hedera-cli?tab=readme-ov-file#installation)

{% @github-files/github-code-block url="https://github.com/hashgraph/hedera-cli" %}

***

## Key Features

### Feature 1: Multi-Network Execution and Local Node

The **`network use <network>`** command gives you the ability to switch between different networks if you have configured accounts for each of the Hedera networks. You can also configure the default account for the [Hedera Local Node in your Hedera CLI](https://github.com/hashgraph/hedera-cli?tab=readme-ov-file#4-set-up-operator-credentials)  so you can run tests locally on your local node.&#x20;

### Feature 2: Script Blocks

[**Script blocks**](https://github.com/hashgraph/hedera-cli?tab=readme-ov-file#backup-commands) allow you to chain multiple commands to prepare a testing environment on a specific network. Let's take a look at some examples.

**A. Account creation and fetching a balance (basic example)**

This script block is a simple example that shows how the Script Block feature works. The script switches to the testnet, creates an account (called Alice), stores the account's ID, and queries the account's balance using the stored account ID.

```json
{
  "name": "account-create",
  "commands": [
    "network use testnet",
    "account create --name alice -b 100000000 --args accountId:idAcc1",
    "wait 3",
    "account balance --account-id-or-name {{idAcc1}} --only-hbar"
  ],
  "args": {}
}
```

**B. Advanced token creation and transfer**

The following example is a bit more complex. Here's a breakdown:

* Create three random accounts and store outputs as variables like the private key, internal account name, and account ID.
* Create a token called `mytoken` and use account 1 as the admin key and account 2 as the treasury account. Again, we store the token ID in a variable conveniently called `tokenId` .
* Associate account 3 with our newly created token and transfer one unit of our token from account 2 to account 3. The wait command has been added to make sure the operation has been completed.&#x20;
* Let's wait three seconds to make sure the mirror nodes have picked up the balance changes, then look up the balance for account 3 for our newly created token. Finally, we print the stored state for our new token to the terminal.&#x20;

{% code overflow="wrap" %}
```json
{
  "name": "transfer",
  "commands": [
   "network use testnet",
    "account create --name alice --args privateKey:privKeyAcc1 --args name:nameAcc1 --args accountId:idAcc1",
    "account create --name bob --args privateKey:privKeyAcc2 --args name:nameAcc2 --args accountId:idAcc2",
    "account create --name greg --args privateKey:privKeyAcc3 --args name:nameAcc3 --args accountId:idAcc3",
    "token create -n mytoken -s MTK -d 2 -i 1000 --supply-type infinite --admin-key {{privKeyAcc1}} --treasury-id {{idAcc2}} --treasury-key {{privKeyAcc2}} --args tokenId:tokenId",
    "token associate --account-id {{idAcc3}} --token-id {{tokenId}}",
    "token transfer -t {{tokenId}} -b 1 --from {{nameAcc2}} --to {{nameAcc3}}",
    "wait 3",
    "account balance --account-id-or-name {{nameAcc3}} --token-id {{tokenId}}",
    "state view --token-id {{tokenId}}"
  ],
  "args": {}
}
```
{% endcode %}

{% hint style="success" %}
Scripts can also be downloaded from external sources using the [`state download` command](https://github.com/hashgraph/hedera-cli?tab=readme-ov-file#usage-7) to make it easier to set up your Hedera CLI in CI/CD pipelines.
{% endhint %}

### Feature 3: Smart Contract Deployment and Interactions

You can use the CLI to deploy and interact with smart contracts. Currently, the CLI supports only Hardhat scripts for these operations. We've also added support for storing data as variables within Hardhat scripts, allowing you to maintain state and share it between scripts and commands. This is especially useful when using the Script Blocks feature (see [bullet 3 in the announcement blog post](https://hedera.com/blog/an-early-look-at-the-hedera-cli-simplify-automate-and-accelerate-development-on-hedera)).

{% code title="scripts/deploy.js" %}
```javascript
const stateController = require('../../state/stateController.js').default;

async function main() {
  const [deployer] = await ethers.getSigners();

  console.log('Deploying contracts with the account:', deployer.address);

  // The deployer will also be the owner of our token contract
  const ERC721Token = await ethers.getContractFactory('ERC721Token', deployer);
  const contract = await ERC721Token.deploy(deployer.address);
  await contract.waitForDeployment();

  const contractAddress = await contract.getAddress();
  console.log('ERC721 Token contract deployed at:', contractAddress);

  // Store address in script arguments as "erc721address"
  stateController.saveScriptArgument('erc721address', contractAddress);
}

main().catch(console.error);
```
{% endcode %}

### Feature 4: State Management

The Hedera CLI tool **tracks state**. Each account, token, or topic you create gets stored in its internal state. Additionally, you can **assign names** to each entity type to make it easier to reference them, eliminating the need to remember account IDs or private keys. The tool automatically looks up the account name in the state and signs a transaction using the found account's private key. This makes it a lot easier to execute commands.

Additionally, you can [**create state backups**](https://github.com/hashgraph/hedera-cli?tab=readme-ov-file#backup-commands) **or** [**download a state file**](https://github.com/hashgraph/hedera-cli?tab=readme-ov-file#state-commands) **from an external location**. This is useful if you want to use the same base state to run your tests. It also avoids the need to prepare the testing environment manually.

{% hint style="info" %}
#### 💡 Feature Requests?

Feel free to contribute to the Hedera CLI or submit a feature request or bug via the [**issues tab**](https://github.com/hashgraph/hedera-cli/issues)**.**
{% endhint %}

***

## Future Roadmap

Upcoming roadmap work includes:

* **Telemetry**: Collect anonymized data to better understand how developers use the tool to make it better. We only collect commands without parameters or sensitive data. For example, we collect `account create` or `state view` .
* **Smart Contracts:** Deploying and interacting with smart contracts.
* **Sign module:** Rework the key signing module to make it more flexible.&#x20;

***

## Commands Overview

<table data-view="cards"><thead><tr><th></th></tr></thead><tbody><tr><td><p><strong>Setup Commands:</strong><br>Designed to initialize and configure your working environment.</p><pre><code>setup init
setup reload
</code></pre></td></tr><tr><td><p><strong>Network Commands:</strong><br>Designed to manage and interact with the different Hedera network environments.</p><pre><code>network use
network list
</code></pre></td></tr><tr><td><p><strong>Wait Command:</strong><br>Designed to pause the execution of commands. Useful to wait for mirror nodes to receive data.</p><pre><code>wait
</code></pre></td></tr><tr><td><p><strong>Account Commands:</strong><br>Designed to manage accounts.<br><br></p><pre><code>account create
account balance
account list
account import
account clear
account delete
account view
</code></pre></td></tr><tr><td><p><strong>Token Commands:</strong><br>Designed to create, associate, and transfer tokens.</p><pre><code>token create-from-file
token create
token associate
token transfer
</code></pre></td></tr><tr><td><p><strong>Topic Commands:</strong><br>Designed to create topics and retrieve information for topics.</p><pre><code>topic create
topic list
topic message submit
topic message find
</code></pre></td></tr><tr><td><p><strong>HBAR Commands:</strong><br>Designed to transfer HBAR.<br><br></p><pre><code>hbar transfer
</code></pre></td></tr><tr><td><p><strong>Backup Commands:</strong><br>Designed to create state backups.<br><br></p><pre><code>backup create
backup restore
</code></pre></td></tr><tr><td><p><strong>State Commands:</strong><br>Designed to manage and view state.</p><pre><code>state download
state view
state clear
</code></pre></td></tr><tr><td><p><strong>Script Commands:</strong><br>Designed to load and execute scripts. </p><pre><code>script load
script list
script delete
</code></pre></td></tr></tbody></table>

***

## Additional Resources

* [**Hedera CLI Repository**](https://github.com/hashgraph/hedera-cli)
* [**CLI Full List of Commands**](https://github.com/hashgraph/hedera-cli?tab=readme-ov-file#commands)
* **Learn about** [**Script Blocks**](https://github.com/hashgraph/hedera-cli?tab=readme-ov-file#script-commands) **and how you can use** [**dynamic variables**](https://github.com/hashgraph/hedera-cli?tab=readme-ov-file#dynamic-variables-in-scripts)
