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

### Feature 1: Multi-Network Execution

The **`network use <network>`**&#x63;ommand gives you the ability to switch between different networks if you have configured accounts for each of the Hedera networks.&#x20;

### Feature 2: Script Blocks

[**Script blocks**](https://github.com/hashgraph/hedera-cli?tab=readme-ov-file#backup-commands) allow you to chain multiple commands to prepare a testing environment on a specific network. Let's take a look at some examples.

**A. Simple account and token creation**

The script block switches to the testnet and then creates an account with a randomly generated alias. The command uses the `--args` parameter to store variables, which we can reference in future commands in the script block. For example, we store the `privateKey`of the account as `myAdminKey` . Next, we create a new token and use the `accountAlias`  variable as the token name. We also set the stored `privateKey` as the admin key for the token.

{% code overflow="wrap" %}
```json
{
  "name": "random-token-create",
  "commands": [
    "network use testnet",
    "account create -a random --args privateKey,myAdminKey --args alias,accountAlias",
    "token create -n {{accountAlias}} --symbol rand --decimals 2 --initial-supply 1000 --supply-type infinite --admin-key {{myAdminKey}} --treasury-id 0.0.4536940 --treasury-key 302302[...]"
  ]
}
```
{% endcode %}

**B. Advanced token creation and transfer**

The following example is a bit more complex. Here's a breakdown:

* Create three random accounts and store key variables like the private key, alias, and account ID.
* Create a token called `mytoken` and use account 1 as the admin key and account 2 as the treasury account. Again, we store the token ID in a variable conveniently called `tokenId` .
* Associate account 3 with our newly created token and transfer one unit of our token from account 2 to account 3. The wait command has been added to make sure the operation has been completed.&#x20;
* Let's wait three seconds to make sure the mirror nodes have picked up the balance changes, then look up the balance for account 3 for our newly created token. Finally, we print the stored state for our new token to the terminal.&#x20;

{% code overflow="wrap" %}
```json
{
  "name": "transfer",
  "commands": [
    "network use testnet",
    "account create -a random --args privateKey,privKeyAcc1 --args alias,aliasAcc1 --args accountId,idAcc1",
    "account create -a random --args privateKey,privKeyAcc2 --args alias,aliasAcc2 --args accountId,idAcc2",
    "account create -a random --args privateKey,privKeyAcc3 --args alias,aliasAcc3 --args accountId,idAcc3",
    "token create -n mytoken -s MTK -d 2 -i 1000 --supply-type infinite -a {{privKeyAcc1}} -t {{idAcc2}} -k {{privKeyAcc2}} --args tokenId,tokenId",
    "token associate --account-id {{idAcc3}} --token-id {{tokenId}}",
    "token transfer -t {{tokenId}} -b 1 --from {{aliasAcc2}} --to {{aliasAcc3}}",
    "wait 3",
    "account balance --account-id-or-alias {{aliasAcc3}} --token-id {{tokenId}}",
    "state view --token-id {{tokenId}}"
  ]
}
```
{% endcode %}

{% hint style="success" %}
Scripts can also be downloaded from external sources using the [`state download` command](https://github.com/hashgraph/hedera-cli?tab=readme-ov-file#usage-7) to make it easier to set up your Hedera CLI in CI/CD pipelines.
{% endhint %}

### Feature 3: State Management

The Hedera CLI tool **tracks state**. Each account, token, or topic you create gets stored in its internal state. Additionally, you can **assign aliases** to each entity type to make it easier to reference them, eliminating the need to remember account IDs or private keys. The tool automatically looks up the account alias in the state and signs a transaction using the found account's private key. This makes it a lot easier to execute commands.

Additionally, you can [**create state backups**](https://github.com/hashgraph/hedera-cli?tab=readme-ov-file#backup-commands) **or** [**download a state file**](https://github.com/hashgraph/hedera-cli?tab=readme-ov-file#state-commands) **from an external location**. This is useful if you want to use the same base state to run your tests. It also avoids the need to prepare the testing environment manually.

### Feature 4: Supports Local Node

You can configure the default account for the Hedera Local Node in your Hedera CLI tool so you can run tests locally on your local node.&#x20;

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
