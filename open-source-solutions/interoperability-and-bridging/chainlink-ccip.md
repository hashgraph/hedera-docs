# Chainlink CCIP

### Chainlink CCIP on Hedera

The **Chainlink Cross-Chain Interoperability Protocol (CCIP)** is the standard for blockchain interoperability.\
CCIP enables developers to build **secure cross-chain applications** that can transfer tokens, send messages, and initiate actions across blockchains.

Through the **Cross-Chain Token (CCT)** standard, CCIP allows token developers to integrate new and existing tokens with CCIP in a **self-serve** manner within minutes—without requiring vendor lock-in, hard-coded functions, or external dependencies that limit future flexibility.

CCTs support:

* **Self-serve deployments** with full control and ownership
* **Zero-slippage transfers** across supported chains
* **Enhanced programmability** via configurable rate limits
* **Smart Execution**, ensuring reliable cross-chain transaction delivery

CCIP is powered by **Chainlink Decentralized Oracle Networks (DONs)**—a proven infrastructure that has secured **tens of billions of dollars** and enabled **over $21 trillion** in on-chain transaction value.

***

#### Overview of CCIP and HTS Compatibility

On Hedera, CCIP extends interoperability between **Hedera’s Hashgraph network** and **EVM-compatible blockchains** such as Ethereum.\
It integrates seamlessly with both the **Hedera Token Service (HTS)** and standard **EVM tokens (ERC-20 and ERC-721)**, allowing developers to bridge data, tokens, and logic across ecosystems.

Through CCIP, developers can:

* Send and receive arbitrary messages across chains
* Execute programmable cross-chain logic using Chainlink’s oracle network
* Experiment with **LINK**, **Wrapped HBAR (WHBAR)**, or **ETH** as fee tokens
* Prepare for future **Cross-Chain Token (CCT)** transfers once fully enabled on Hedera

> ⚠️ **Note:** Cross-Chain Token (CCT) transfers on Hedera are still in progress on testnet.\
> The current demos focus on message passing between Hedera Testnet and Ethereum Sepolia.

***

#### Why CCIP Matters

CCIP provides a **unified framework** for cross-chain connectivity—replacing the need for custom bridges with a decentralized standard backed by Chainlink’s proven security model.

By integrating CCIP, Hedera developers can create applications that benefit from:

* **Secure message delivery** via decentralized oracle networks
* **Universal token compatibility** through the CCT standard
* **Reduced integration overhead** through SDK tooling and no-code deployment options
* **Future-proof design** with no vendor lock-in

This aligns with Hedera’s mission to enable high-throughput, low-fee interoperability across distributed ledger technologies.

***

#### Key CCIP Developer Tools

* [**CCIP Official Documentation**](https://docs.chain.link/ccip) — Start integrating CCIP into your cross-chain application.
* [**CCIP Token Manager**](https://tokenmanager.chain.link/) — A web interface for deploying and managing Cross-Chain Tokens (CCTs) with no-code guided configuration.
* [**CCIP SDK (JavaScript)**](https://docs.chain.link/ccip/ccip-javascript-sdk) — A development kit for building JavaScript dApps that perform token transfers or cross-chain messaging.

***

#### Getting Started with CCIP on Hedera

You can explore CCIP on Hedera using the [**Hedera CCIP Demo Repository**](https://github.com/mgarbs/hedera-ccip-demos), which demonstrates **bi-directional cross-chain messaging** between the **Hedera Testnet** and **Ethereum Sepolia**.

These examples use the **Chainlink CCIP JavaScript SDK** and show how to configure networks, manage fee tokens, and send cross-chain messages.

**Setup**

1.  **Install dependencies**

    ```bash
    pnpm install
    ```
2.  **Configure your environment**

    ```bash
    cp .env.example .env
    ```

    Add your Hedera Testnet private key:

    ```
    PRIVATE_KEY=0x...
    ```
3.  **Run a demo**

    ```bash
    pnpm run demo:hedera-sepolia-link
    ```

***

#### Available Demos

<table><thead><tr><th width="182.1630859375">Direction</th><th width="152.56640625">Payment</th><th>Command</th><th>Description</th></tr></thead><tbody><tr><td>Read-only</td><td>—</td><td><code>pnpm run demo:readonly</code></td><td>Query CCIP configuration without executing transactions.</td></tr><tr><td>Hedera → Sepolia</td><td>LINK</td><td><code>pnpm run demo:hedera-sepolia-link</code></td><td>Send a message using LINK as the fee token.</td></tr><tr><td>Hedera → Sepolia</td><td>WHBAR</td><td><code>pnpm run demo:hedera-sepolia-whbar</code></td><td>Send a message using Wrapped HBAR for fees.</td></tr><tr><td>Sepolia → Hedera</td><td>ETH</td><td><code>pnpm run demo:sepolia-hedera</code></td><td>Send a message from Sepolia to Hedera using ETH for fees.</td></tr></tbody></table>

> 💡 **Tip:** Wrap HBAR before running WHBAR examples:
>
> ```bash
> pnpm run wrap-hbar
> ```

All demos operate on **testnet** and are designed for **educational purposes only**. They are **not audited** and should not be used in production.

***

#### Network Configuration

**Hedera Testnet**

<a href="https://chainlist.org/chain/296" class="button primary" data-icon="plus-large">ADD HEDERA TESTNET</a>

<table><thead><tr><th width="220">Name</th><th width="360">Value</th></tr></thead><tbody><tr><td><strong>Network Name</strong></td><td>Hedera Testnet</td></tr><tr><td><strong>RPC Endpoint</strong></td><td><code>https://testnet.hashio.io/api</code></td></tr><tr><td><strong>Chain ID</strong></td><td><code>296</code></td></tr><tr><td><strong>CCIP Router</strong></td><td><code>0x802C5F84eAD128Ff36fD6a3f8a418e339f467Ce4</code></td></tr><tr><td><strong>Chain Selector</strong></td><td><code>222782988166878823</code></td></tr></tbody></table>

***

**Ethereum Sepolia**

<a href="https://chainlist.org/chain/11155111" class="button primary" data-icon="plus-large">ADD ETHEREUM SEPOLIA</a>

<table><thead><tr><th width="156.6650390625">Name</th><th width="360">Value</th></tr></thead><tbody><tr><td><strong>Network Name</strong></td><td>Ethereum Sepolia</td></tr><tr><td><strong>Chain ID</strong></td><td><code>11155111</code></td></tr><tr><td><strong>CCIP Router</strong></td><td><code>0x0BF3dE8c5D3e8A2B34D2BEeB17ABfCeBaf363A59</code></td></tr><tr><td><strong>Chain Selector</strong></td><td><code>16015286601757825753</code></td></tr></tbody></table>

***

#### Token Addresses

<table><thead><tr><th width="160.10546875">Network</th><th width="113.70703125">Token</th><th>Address</th></tr></thead><tbody><tr><td><strong>Hedera Testnet</strong></td><td>LINK</td><td><code>0x90a386d59b9A6a4795a011e8f032Fc21ED6FEFb6</code></td></tr><tr><td></td><td>WHBAR</td><td><code>0xb1F616b8134F602c3Bb465fB5b5e6565cCAd37Ed</code></td></tr><tr><td><strong>Ethereum Sepolia</strong></td><td>LINK</td><td><code>0x779877A7B0D9E8603169DdbD7836e478b4624789</code></td></tr></tbody></table>

> ⚠️ **Note:** WHBAR uses **8 decimals**, while most EVM tokens use **18 decimals**.

***

#### Developer Considerations

**Decimal Precision**

HBAR’s smallest unit is the **tinybar (8 decimals)**. Because CCIP on EVM networks operates with 18-decimal precision, conversions between tinybars and wei-based values may be required. See EVM Differences and Compatibility.

**Cross-Chain Fees**

Ensure your wallet holds sufficient **LINK**, **WHBAR**, or **ETH** to cover CCIP fees.

**Message Timing**

Cross-chain message delivery on testnet may take several minutes while the Chainlink oracle network confirms execution.

***

#### Test Tokens and Faucets

| Network | Token | Faucet                                                               |
| ------- | ----- | -------------------------------------------------------------------- |
| Hedera  | HBAR  | [Hedera Faucet](https://portal.hedera.com/faucet)                    |
| Hedera  | LINK  | [Chainlink Hedera Faucet](https://faucets.chain.link/hedera-testnet) |
| Sepolia | ETH   | [Chainlink Sepolia Faucet](https://faucets.chain.link/sepolia)       |

***

#### Additional Resources

* [CCIP Official Documentation](https://docs.chain.link/ccip)
* [CCIP Token Manager](https://tokenmanager.chain.link/)
* [CCIP SDK (JavaScript)](https://docs.chain.link/ccip/ccip-javascript-sdk)
* [Hedera CCIP Demo Repository](https://github.com/mgarbs/hedera-ccip-demos)
* [HashScan Explorer](https://hashscan.io/testnet)
* [Chainlink Faucets](https://faucets.chain.link/)

***

#### Summary

Chainlink CCIP establishes a universal standard for **secure, decentralized cross-chain interoperability**. It brings Hedera into a broader multi-chain ecosystem—enabling applications that move assets, execute logic, and share state across blockchains through a common protocol.

On Hedera, CCIP provides a **modular and future-ready foundation** for interoperability, supporting HTS and EVM token compatibility under the **Cross-Chain Token (CCT)** standard. This capability complements other interoperability solutions like LayerZero and Hashport, positioning Hedera as a key network within the interoperable web3 ecosystem.
