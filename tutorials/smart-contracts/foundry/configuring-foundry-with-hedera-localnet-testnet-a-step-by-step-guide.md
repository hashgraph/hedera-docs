# Configuring Foundry with Hedera Localnet/Testnet: A Step-by-Step Guide

Developers building smart contracts on Hedera often use the **Hedera JSON-RPC Relay** to enable EVM tools like **Foundry**. In this post, we'll walk through how to set up Foundry to work with the **Hiero Local Node**, allowing for local deployment, debugging, and testing of smart contracts without using testnet resources.

{% hint style="success" %}
Not sure whether to use the Hiero Local Node, Hashio, or a custom relay setup? Read this [blog post](https://docs.hedera.com/hedera/tutorials/local-node/how-to-set-up-a-hedera-local-node) comparing the different options.
{% endhint %}

{% hint style="info" %}
You can take a look at the **complete code** in the [**Hedera-Code-Snippets repository**](https://github.com/hedera-dev/hedera-code-snippets/tree/main/tutorial-local-hardhat).
{% endhint %}

This guide shows you how to configure Foundry to deploy, interact with, and test Solidity smart contracts on:

* Hedera Localnet (via the Hiero Local Node + JSON-RPC Relay)
* Hedera Testnet (via Hashio JSON-RPC Relay)

You’ll set up environment variables, configure `foundry.toml`, write a simple contract and a Foundry deployment script, and learn how to switch between Localnet and Testnet with a single flag.

If you’re looking for an end-to-end “Hello, ERC-20” tutorial, see: “[Getting started with Foundry](../../../getting-started-evm-developers/deploy-a-smart-contract-with-foundry.md)” (deploy, interact, verify on Hashscan). This guide focuses on environment configuration and workflow for Localnet/Testnet.

***

## What you will accomplish

* Configure Foundry to talk to the Hedera JSON-RPC Relay (Localnet and Testnet)
* Deploy and interact with a sample contract using `forge script` and `cast`
* Verify contracts on Hashscan (Testnet)

***

## Prerequisites

* Foundry installed (forge, cast, anvil, chisel):
  * `curl -L https://foundry.paradigm.xyz | bash`
  * `foundryup`
* ECDSA account and private key
  * For Testnet: create/fund an account via the [Hedera Portal](https://portal.hedera.com/)
* Basic Solidity / CLI familiarity

***

## Table of Contents

1. [Option A: Run Hedera Localnet](configuring-foundry-with-hedera-localnet-testnet-a-step-by-step-guide.md#option-a-run-hedera-localnet-hiero-local-node)
2. [Option B: Use Hedera Testnet](configuring-foundry-with-hedera-localnet-testnet-a-step-by-step-guide.md#option-b-use-hedera-testnet-hashio)
3. [Step 1: Initialize a Foundry project](configuring-foundry-with-hedera-localnet-testnet-a-step-by-step-guide.md#step-1-initialize-a-foundry-project)
4. [Step 2: Add environment variables](configuring-foundry-with-hedera-localnet-testnet-a-step-by-step-guide.md#step-2-add-environment-variables)
5. [Step 3: Configure foundry](configuring-foundry-with-hedera-localnet-testnet-a-step-by-step-guide.md#step-3-configure-foundry.toml)
6. [Step 4: Add a simple contract](configuring-foundry-with-hedera-localnet-testnet-a-step-by-step-guide.md#step-4-add-a-simple-contract)
7. [Step 5: Update the deploy script](configuring-foundry-with-hedera-localnet-testnet-a-step-by-step-guide.md#step-5-update-the-deploy-script)
8. [Step 6: Deploy the contract](configuring-foundry-with-hedera-localnet-testnet-a-step-by-step-guide.md#step-6-deploy-the-contract)
9. [Step 7: Run tests](configuring-foundry-with-hedera-localnet-testnet-a-step-by-step-guide.md#step-7-run-tests)
10. [Step 8: Verifying the contract on Hashscan](configuring-foundry-with-hedera-localnet-testnet-a-step-by-step-guide.md#step-8-verifying-the-contract-on-hashscan)
11. [Interact using cast](configuring-foundry-with-hedera-localnet-testnet-a-step-by-step-guide.md#interact-using-cast)

***

## Option A: Run Hedera Localnet (Hiero Local Node)

Hedera provides a local node configuration that includes a mirror node, a consensus node, and the JSON-RPC relay. You can run it via `npm`.

**Clone, install, and run the node:**

```bash
git clone https://github.com/hiero-ledger/hiero-local-node.git
cd hiero-local-node
npm install
npm run start
```

Once all the containers have started, the Hiero Local Node is up and running. This includes a Consensus Node, Mirror Node and explorer, JSON RPC Relay, Block Node, Grafana UI, and Prometheus UI. &#x20;

{% hint style="info" %}
* On startup, the Local Node prints funded ECDSA accounts to the console logs. You can use one of these for local development. Make sure to only use accounts listed under "Accounts list (Alias ECDSA keys)"
* The JSON-RPC Relay is typically on port 7546. So, the URL would be `http://localhost:7546`
{% endhint %}

***

## Option B: Use Hedera Testnet (Hashio)

Hashio is a community relay node suitable for development/testing:

* RPC URL: `https://testnet.hashio.io/api`

**Note**: For production, prefer a commercial-grade JSON-RPC relay or host your own Hiero JSON-RPC Relay.

***

## Step 1: Initialize a Foundry project

```bash
forge init foundry-hello-world
cd foundry-hello-world
```

This creates `src`, `script`, `test`, and `lib`.

### Project Structure

The Foundry project initialization creates the following file structure:

```
foundry.toml
lib
└── forge-std
src
└── Counter.sol
script
└── Counter.s.sol
test
└── Counter.t.sol
```

Here's a quick overview of these files and directories:

* `foundry.toml`: You can configure Foundry's behavior using this file such as defining RPC URLs
* `src`: Serves as the default for storing your smart contract source code
* `script`: This is where you store Solidity scripts for deploying contracts and performing other on-chain operations
* `test`: Serves as the dedicated location for Solidity-based unit and integration tests for your smart contracts

***

## Step 2: Add environment variables

Create an `.env` for your RPC URL and private key.&#x20;

```bash
touch .env
```

Put the following into your environment file.

{% code title=".env" %}
```bash
HEDERA_RPC_URL=your-rpc-url
HEDERA_PRIVATE_KEY=0x-your-private-key
```
{% endcode %}

Now, let's also load these to the terminal:

```bash
source .env
```

{% hint style="warning" %}
Replace the `your-rpc-url` environment variable with:

* For Testnet: `https://testnet.hashio.io/api`, or&#x20;
* For Localnet: `http://localhost:7546`

Replace the `0x-your-private-key` environment variable with:

* For Testnet: the **HEX Encoded Private Key** for your **ECDSA** **account** from the [Hedera Portal](https://portal.hedera.com/), or&#x20;
* For Localnet: the ECDSA private key from the terminal where you are running Hiero Local Node(eg. `0x105d050185ccb907fba04dd92d8de9e32c18305e097ab41dadda21489a211524` )
{% endhint %}

{% hint style="danger" %}
_**Please note**:_ _that Hashio is intended for development and testing purposes only. For production use cases, it's recommended to use commercial-grade JSON-RPC Relay or host your own instance of the_ [_Hiero JSON-RPC Relay_](https://github.com/hiero-ledger/hiero-json-rpc-relay)_._&#x20;
{% endhint %}

***

## Step 3: Configure "foundry.toml"

Foundry uses the `foundry.toml` file for configuration. Open it and add profiles for the Hedera RPC endpoint.

{% code title="foundry.toml" lineNumbers="true" %}
```toml
[profile.default]
src = "src"
out = "out"
libs = ["lib"]
remappings = [
  "forge-std/=lib/forge-std/src/"
]

# Add this section for Hedera Testnet
[rpc_endpoints]
hedera = "${HEDERA_RPC_URL}"
```
{% endcode %}

***

## Step 4: Add a simple contract

Use a tiny `Counter` contract to focus on configuration rather than external dependencies for this exercise.

Compile with:

```bash
forge build
```

***

## Step 5: Update the deploy script

We are going to update our deploy script a little bit so we can use our private key instead of passing it as a flag every time:

{% code title="script/Counter.s.sol" %}
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import {Script, console} from "forge-std/Script.sol";
import {Counter} from "../src/Counter.sol";

contract CounterScript is Script {
    Counter public counter;

    function run() external returns (address) {
        // Load the private key from the .env file
        uint256 deployerPrivateKey = vm.envUint("HEDERA_PRIVATE_KEY");

        // Start broadcasting transactions with the loaded private key
        vm.startBroadcast(deployerPrivateKey);

        // Deploy the contract
        counter = new Counter();

        // Stop broadcasting
        vm.stopBroadcast();

        console.log("Counter Contract deployed to:", address(counter));

        return address(counter);
    }
}
```
{% endcode %}

***

## Step 6: Deploy the contract

Now, execute the script to deploy your contract:

```bash
forge script script/Counter.s.sol:CounterScript --rpc-url hedera --broadcast
```

After a few moments, you will see the address of your newly deployed contract:

```
[⠊] Compiling...
No files changed, compilation skipped
Script ran successfully.

== Return ==
0: address 0x061A1DdE963792192eA823C2F57285111812630b

== Logs ==
  Counter Contract deployed to: 0x061A1DdE963792192eA823C2F57285111812630b

## Setting up 1 EVM.

==========================

Chain 296

Estimated gas price: 720.000000001 gwei

Estimated total gas used for script: 203856

Estimated amount required: 0.146776320000203856 ETH

==========================

##### 296
✅  [Success] Hash: 0x279d667c3a31bb0956449d819bdd4b99619a25b8387a0765f28c9407d158069b
Contract Address: 0x061A1DdE963792192eA823C2F57285111812630b
Block: 25089799
Paid: 0.0554489 ETH (163085 gas * 340 gwei)

✅ Sequence #1 on 296 | Total Paid: 0.0554489 ETH (163085 gas * avg 340 gwei)
                                                                                                             

==========================

ONCHAIN EXECUTION COMPLETE & SUCCESSFUL
```

{% hint style="success" %}
Note that Foundry hardcodes “ETH” in its summary. However, even if it says `ETH`, because we're connected to Hedera, the currency used is `HBAR`. &#x20;
{% endhint %}

Now, go ahead and update your `.env` values to point to another Hedera Network(Localnet or Testnet) and try again.&#x20;

***

## Step 7: Run tests

You can also run the test suite that's included as part of `test/` directory:

```bash
forge test
```

***

## Step 8: Verifying the Contract on Hashscan

Verifying your smart contract makes its source code publicly available on Hashscan.&#x20;

_**Note**: Please note that verification of the contract can not be done on Localnet and this process is relevant only for Hedera Testnet/Mainnet. Also, make sure to replace `<your-contract-address>` with your own contract address you got after the deployment above._

Run the following command, using the variables you set earlier.

```bash
forge verify-contract <your-contract-address> src/Counter.sol:Counter \
    --chain-id 296 \
    --verifier sourcify \
    --verifier-url "https://server-verify.hashscan.io/"
```

After running the command, you should see a success message.

```
Submitting verification for [Counter] "0x061A1DdE963792192eA823C2F57285111812630b".
Contract successfully verified
```

**Congratulations! 🎉 You have successfully deployed, interacted with, and verified a smart contract on the Hedera Testnet using Foundry.  Feel free to reach out in** [**Discord**](https://hedera.com/discord)**!**

***

## Interact using cast

Set helpers:

```bash
export CONTRACT_ADDRESS=<your-contract-address>
export MY_ADDRESS=$(cast wallet address $HEDERA_PRIVATE_KEY)
```

Read:

```bash
cast call $CONTRACT_ADDRESS "number()(uint256)" --rpc-url hedera
```

Write:

```bash
cast send $CONTRACT_ADDRESS "setNumber(uint256)" 42 \
  --private-key $HEDERA_PRIVATE_KEY \
  --rpc-url hedera

cast send $CONTRACT_ADDRESS "increment()" \
  --private-key $HEDERA_PRIVATE_KEY \
  --rpc-url hedera
```

Read again:

```bash
cast call $CONTRACT_ADDRESS "number()(uint256)" --rpc-url hedera
```

You should get an output of `43` since the counter is at 43 now after having added 42 + 1.

***

## Further Learning & Next Steps

Want to take your local development setup even further? Here are some excellent tutorials to help you dive deeper into smart contract development on Hedera using Foundry:

1. [**How to Mint and Burn an ERC-721 Token (Part 1)**](how-to-mint-and-burn-an-erc-721-token-using-foundry-part-1.md)\
   Learn how to create a basic ERC-721 NFT, mint it, and burn it on Hedera.
2. [How to Write Tests in Solidity (Part 2)](how-to-write-tests-in-solidity-part-2.md)\
   Learn how to start writing tests in Foundry using Solidity
3. [How to Fork the Hedera Network for Local Testing](how-to-fork-the-hedera-network-for-local-testing.md)\
   Learn how to fork hedera network(testnet/mainnet) locally so you can start testing against the forked network

<table data-card-size="large" data-view="cards"><thead><tr><th align="center"></th><th data-hidden data-card-target data-type="content-ref"></th></tr></thead><tbody><tr><td align="center"><p>Writer: Kiran, Developer Advocate</p><p><a href="https://github.com/kpachhai">GitHub</a> | <a href="https://www.linkedin.com/in/kiranpachhai/">LinkedIn</a></p></td><td><a href="https://www.linkedin.com/in/kiranpachhai/">https://www.linkedin.com/in/kiranpachhai/</a></td></tr><tr><td align="center"><p>Editor: Krystal, Technical Writer</p><p><a href="https://github.com/theekrystallee">GitHub</a> | <a href="https://x.com/theekrystallee">X</a></p></td><td><a href="https://x.com/theekrystallee">https://x.com/theekrystallee</a></td></tr></tbody></table>
