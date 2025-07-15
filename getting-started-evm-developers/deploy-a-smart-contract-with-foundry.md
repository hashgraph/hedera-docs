# Deploy a Smart Contract with Foundry

## Deploying a Contract Using Foundry

This tutorial will walk you through writing and compiling an ERC-20  Solidity smart contract. You'll then deploy and interact with it on the Hedera network using the [Hedera Smart Contract Service (HSCS)](../support-and-community/glossary.md#hedera-smart-contract-service-hscs) and [Foundry](https://getfoundry.sh/), connecting via the [JSON-RPC relay](../core-concepts/smart-contracts/json-rpc-relay.md).&#x20;

#### What you will accomplish

By the end of this tutorial, you will be able to:

* Compile and deploy a smart contract using Foundry
* Interact with a smart contract using Foundry's `cast` command
* Verify your smart contract on [Hashscan](https://hashscan.io/)

***

## Prerequisites

Before you begin, you should have **completed** the following tutorial:

* [x] [Create and Fund a Testnet Account via the Hedera Faucet](hedera-testnet-faucet.md)
* [x] [Install Foundry](https://getfoundry.sh/)

```bash
curl -L https://foundry.paradigm.xyz | bash
foundryup
```

This will install `forge`, `cast`, `anvil`, and `chisel`.

***

## Table of Contents

1. [Step 1: Project Setup](deploy-a-smart-contract-with-foundry.md#step-1-project-setup)
2. [Step 2: Creating the ERC20 Contract](deploy-a-smart-contract-with-foundry.md#step-2-creating-the-erc20-contract)
3. [Step 3: Create a Deployment Script](deploy-a-smart-contract-with-foundry.md#step-3-create-a-deployment-script)
4. [Step 4: Deploy your ERC20 Smart Contract](deploy-a-smart-contract-with-foundry.md#step-4-deploy-your-erc20-smart-contract)
5. [Step 5: Interacting with the Contract](deploy-a-smart-contract-with-foundry.md#step-5-interacting-with-the-contract)
6. [Step 6: Verifying the Contract on Hashscan](deploy-a-smart-contract-with-foundry.md#step-6-verifying-the-contract-on-hashscan)

***

## Step 1: Project Setup

#### Initialize Project&#x20;

Set up your Foundry project:

```bash
forge init hedera-foundry-erc20-tutorial
cd hedera-foundry-erc20-tutorial
```

This creates a new directory with a standard Foundry project structure, including `src`, `test`, and `script` folders.

#### Install Dependencies

Foundry uses git submodules to manage dependencies. We'll install the OpenZeppelin Contracts library, which provides a standard and secure implementation of the ERC20 token.

```bash
forge install OpenZeppelin/openzeppelin-contracts
```

This command will download the contracts and add them to your `lib` folder.

#### Create `.env` File

Create a \`.env\` file in your project's root directory to securely store your private key and the RPC URL for the Hedera Testnet.

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
Replace the `your-operator-key` environment variable with the **HEX Encoded Private Key** for your **ECDSA** **account** from the [Hedera Portal](https://portal.hedera.com/).&#x20;
{% endhint %}

{% hint style="danger" %}
_**Please note**:_ _that Hashio is intended for development and testing purposes only. For production use cases, it's recommended to use commercial-grade JSON-RPC Relay or host your own instance of the_ [_Hiero JSON-RPC Relay_](https://github.com/hiero-ledger/hiero-json-rpc-relay)_._&#x20;
{% endhint %}

#### Configure Foundry

Foundry uses the `foundry.toml` file for configuration. Open it and add profiles for the Hedera Testnet RPC endpoint.

{% code title="foundry.toml" lineNumbers="true" %}
```toml
[profile.default]
src = "src"
out = "out"
libs = ["lib"]

# Add this section for Hedera Testnet
[rpc_endpoints]
testnet = "${RPC_URL}"
```
{% endcode %}

***

## Step 2: Creating the ERC20 Contract

Create a new Solidity file (`HederaToken.sol` ) inside the `src` directory:

{% code title="src/HederaToken.sol" %}
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract HederaToken is ERC20, Ownable {
    constructor(address initialOwner)
        ERC20("HederaToken", "HEDT")
        Ownable(initialOwner)
    {
        _mint(msg.sender, 1000 * 10 ** decimals());
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
}
```
{% endcode %}

The contract uses the OpenZeppelin ERC20 and Ownable implementations.

* The token is named "HederaToken" with the symbol "HEDT"
* The `constructor` mints an initial supply of 1,000 tokens to the deployer of the contract
* An `onlyOwner` `mint` function is included to allow the contract owner to mint more tokens in the future.

Now, compile the contract:

```bash
forge build
```

This command compiles your contracts and places the artifacts(including the [ABI](https://docs.hedera.com/hedera/core-concepts/smart-contracts/compiling-smart-contracts) and bytecode) into the `out` directory. We are now ready to deploy the smart contract.

***

## Step 3: Create a Deployment Script

Using a script is the standard and most reliable way to handle deployments in Foundry. Create a new file named `HederaToken.s.sol` inside the `script` directory.

{% code title="script/HederaToken.s.sol" %}
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import {Script, console} from "forge-std/Script.sol";
import {HederaToken} from "../src/HederaToken.sol";

contract HederaTokenScript is Script {
    function run() external returns (address) {
        // Load the private key from the .env file
        uint256 deployerPrivateKey = vm.envUint("OPERATOR_KEY");
        
        // Start broadcasting transactions with the loaded private key
        vm.startBroadcast(deployerPrivateKey);

        // Get the deployer's address to use as the initial owner
        address deployerAddress = vm.addr(deployerPrivateKey);

        // Deploy the contract
        HederaToken hederaToken = new HederaToken(deployerAddress);

        // Stop broadcasting
        vm.stopBroadcast();

        console.log("HederaToken deployed to:", address(hederaToken));

        return address(hederaToken);
    }
}
```
{% endcode %}

***

## Step 4: Deploy Your ERC20 Smart Contract

Now, execute the script to deploy your contract. Foundry will automatically load the variables from your `.env` file.

```bash
forge script script/HederaToken.s.sol:HederaTokenScript --rpc-url testnet --broadcast
```

After a few moments, you will see the address of your newly deployed contract:

```
[⠒] Compiling...
[⠒] Sending transaction...
[⠒] Waiting for receipt...
== Logs ==
  HederaToken deployed to: 0x047f8c7569b9beecab790902ba29daad143041d7
```

{% hint style="success" %}
Copy the deployed contract address—you'll need this in subsequent steps.
{% endhint %}

***

## Step 5: Interacting with the Contract

Now that the contract is deployed, you can interact with it using `cast`, Foundry's command-line tool for making RPC calls.

To use `cast` and other command-line tools, you need to load the variables from your `.env` file into your current terminal session.

**Load Environment Variables**

Run the following command to load the `OPERATOR_KEY` and `RPC_URL` into your shell:

```bash
source .env
```

Now your shell knows the value of `$OPERATOR_KEY` and `$RPC_URL`.

**Set Up Shell Variables**

Next, set up variables for your contract address and public address to make the next commands easier to read. Please export these variables in your shell.

```bash
# Replace with the contract address from the previous step
export CONTRACT_ADDRESS=<your-contract-address>

# Derive your public address from the private key
export MY_ADDRESS=$(cast wallet address $OPERATOR_KEY)
```

**Check Your Balance**

Let's call the `balanceOf` function to check the token balance of your account.

```bash
cast call $CONTRACT_ADDRESS "balanceOf(address)" $MY_ADDRESS --rpc-url $RPC_URL
```

The output will be the balance in its raw form (with 18 decimals):

```
0x00000000000000000000000000000000000000000000003635c9adc5dea00000
```

You can use the following to convert the hexadecimal to a decimal number so it's human readable.

```bash
cast --to-dec 0x00000000000000000000000000000000000000000000003635c9adc5dea00000
```

You should see the value `1000000000000000000000`.

**Transfer Tokens**

Next, let's transfer 100 tokens to a new account. For this example, we'll generate a new random private key.

```bash
# Generate a new random private key and get its address
export RECIPIENT_ADDRESS=$(cast wallet address $(openssl rand -hex 32))
echo "Recipient Address: $RECIPIENT_ADDRESS"
```

Now, send 100 tokens to this new address. Note that `100e18` is a convenient way to write `100 * 10^18`.

```bash
cast send $CONTRACT_ADDRESS "transfer(address,uint256)" $RECIPIENT_ADDRESS 100e18 \
    --private-key $OPERATOR_KEY \
    --rpc-url $RPC_URL
```

After the transaction confirms, check the recipient's balance:

```bash
cast call $CONTRACT_ADDRESS "balanceOf(address)" $RECIPIENT_ADDRESS --rpc-url testnet
```

The output will show the 100 tokens you sent:

```
0x0000000000000000000000000000000000000000000000056bc75e2d63100000
```

***

## Step 6: Verifying the Contract on Hashscan

Verifying your smart contract makes its source code publicly available on Hashscan. The constructor for this contract takes one argument (`initialOwner`), which we must provide for successful verification.

Run the following command, using the variables you set earlier.

```bash
forge verify-contract $CONTRACT_ADDRESS src/HederaToken.sol:HederaToken \
    --chain-id 296 \
    --verifier sourcify \
    --verifier-url "https://server-verify.hashscan.io/" \
    --constructor-args $(cast abi-encode "constructor(address)" $MY_ADDRESS)
```

After running the command, you should see a success message.

```
Submitting verification for [HederaToken] "0x047F8c7569B9beECaB790902BA29DaAD143041d7". 
Contract successfully verified
```

**Congratulations! 🎉 You have successfully deployed, interacted with, and verified an ERC20 smart contract on the Hedera Testnet using Foundry.  Feel free to reach out in** [**Discord**](https://hedera.com/discord)**!**

***

## Next Steps

* Check out [OpenZeppelin ERC-20 Documentation](https://docs.openzeppelin.com/contracts/5.x/erc20)
* See the full code in the [Hedera-Code-Snippets Repository](https://github.com/hedera-dev/hedera-code-snippets/tree/main/foundry-erc20)
