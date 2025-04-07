# Tokenization on Hedera

## Overview

Tokens on Hedera represent digital assets that users can create, manage, and transfer through the Hedera Token Service (HTS). HTS supports both fungible tokens (e.g., stablecoins, loyalty points) and non-fungible tokens (NFTs) for collectibles, real-world assets (RWAs), and more. Built on Hedera’s high-performance hashgraph, tokens benefit from low, predictable fees, built-in compliance features, and cross-chain interoperability, making them ideal for enterprise and web3 applications.

## Tokenization Models

Hedera supports three tokenization approaches, allowing developers to choose the best fit for their use case:

<table data-view="cards"><thead><tr><th align="center"></th><th data-hidden data-card-cover data-type="files"></th><th data-hidden data-card-target data-type="content-ref"></th></tr></thead><tbody><tr><td align="center"><a href="hedera-token-service-hts-native-tokenization/"><strong>HTS Native</strong></a></td><td><a href="../../.gitbook/assets/token-service-icon.png">token-service-icon.png</a></td><td><a href="hedera-token-service-hts-native-tokenization/">hedera-token-service-hts-native-tokenization</a></td></tr><tr><td align="center"><a href="tokenization-on-hedera.md#id-2.-erc-evm-tokenization-evm-compatible-standards"><strong>ERC/EVM</strong></a></td><td><a href="../../.gitbook/assets/erc-evm-tokenization-icon.png">erc-evm-tokenization-icon.png</a></td><td><a href="erc-evm-compatible-tokenization.md">erc-evm-compatible-tokenization.md</a></td></tr><tr><td align="center"><a href="tokenization-on-hedera.md#id-3.-hybrid-tokenization-combining-hts-with-evm-smart-contracts"><strong>Hybrid (HTS + EVM)</strong></a></td><td><a href="../../.gitbook/assets/evm tools.png">evm tools.png</a></td><td><a href="hybrid-hts-+-evm-tokenization.md">hybrid-hts-+-evm-tokenization.md</a></td></tr></tbody></table>

### Tokenization Quick Reference Summary

<table><thead><tr><th width="168">Feature</th><th align="center">HTS Native Tokenization</th><th align="center">ERC/EVM Tokenization</th><th align="center">Hybrid Tokenization</th></tr></thead><tbody><tr><td><strong>Smart Contracts Required</strong></td><td align="center">No</td><td align="center">Yes</td><td align="center">Optional (HTS + EVM)</td></tr><tr><td><strong>Cost Efficiency</strong></td><td align="center">Low fees, fixed-cost transactions</td><td align="center">Higher gas fees</td><td align="center">Lower fees than full EVM, utilizes HTS efficiencies</td></tr><tr><td><strong>Compliance &#x26; Security</strong></td><td align="center">Built-in compliance tools (KYC, freeze, pause)</td><td align="center">No built-in compliance, requires smart contract logic</td><td align="center">HTS tokens act as ERC-20/ERC-721 (via HIP-218 &#x26; HIP-376)</td></tr><tr><td><strong>Flexibility</strong></td><td align="center">Limited customization</td><td align="center">Highly customizable with Solidity</td><td align="center">Combines benefits of both models</td></tr><tr><td><strong>Use Cases</strong></td><td align="center">Enterprise solutions, regulated assets, fast transactions</td><td align="center">DeFi, dApps, token standards (ERC-20, ERC-721, ERC-3643)</td><td align="center">Interoperability, scalable token solutions, cost-effective DeFi</td></tr></tbody></table>

***

### 1. Hedera Token Service (HTS) - Native Tokenization

HTS provides a high-performance, native tokenization framework that operates directly on Hedera’s core consensus layer. Unlike smart contract-based tokenization, HTS offers faster transactions and reduced costs by eliminating the need for Solidity smart contracts.

<figure><img src="../../.gitbook/assets/hts-native-tokenization-mindmap.png" alt=""><figcaption><p><strong>Native Tokenization Key Features</strong></p></figcaption></figure>

**Best for: Stablecoins, loyalty programs, micropayments, and enterprise solutions.**

{% embed url="https://docs.hedera.com/hedera/~/changes/2881/copy-of-tokens/hedera-token-service-hts-native-tokenization" %}
[Learn more](hedera-token-service-hts-native-tokenization/)
{% endembed %}

***

### 2. ERC/EVM Tokenization (EVM-Compatible Standards)

This model allows developers to deploy standard ERC-20, ERC-721, and ERC-1155 tokens using smart contracts within Hedera’s EVM implementation environment. This model is ideal for EVM-based projects migrating to Hedera or developers who prefer Solidity-based token logic.

<figure><img src="../../.gitbook/assets/evm-based-tokenization-mindmap.png" alt=""><figcaption><p><strong>ERC/EVM-Based Tokenization Key Features</strong></p></figcaption></figure>

**Best for DeFi protocols, NFT marketplaces, and EVM-native projects.**

{% embed url="https://docs.hedera.com/hedera/~/changes/2881/copy-of-tokens/erc-evm-tokenization-evm-compatible-standards/erc-evm-tokenization-evm-compatible-standards" %}
[Learn more](erc-evm-compatible-tokenization.md)
{% endembed %}

***

### 3. Hybrid Tokenization – Combining HTS with EVM Smart Contracts

The hybrid model combines the speed and cost efficiency of HTS with the programmability of EVM smart contracts. Developers can perform basic token operations (minting, transfers, burning) using HTS while leveraging smart contracts for complex logic, such as governance, interoperability, and multi-signature transactions.

<figure><img src="../../.gitbook/assets/hybrid-tokenization-mindmap (2).png" alt=""><figcaption></figcaption></figure>

**Best for DeFi, security tokens, and asset tokenization requiring smart contract logic.**

#### **Key Features**

* **HTS handles core operations** – Minting, burning, and transfers at low cost
* **Smart contracts add flexibility** – Custom governance, multi-signature approvals
* **Balances cost & programmability** – Reduces gas fees while maintaining EVM flexibility
* **Interoperability-ready** – Works with existing EVM infrastructure

{% embed url="https://docs.hedera.com/hedera/~/changes/2881/copy-of-tokens/hybrid-hts-+-evm-tokenization" %}
[Learn more](hybrid-hts-+-evm-tokenization.md)
{% endembed %}

***

## Tokenomics & Fee Structure

Hedera's tokenization framework prioritizes low costs, predictability, and flexibility, making it ideal for developers and businesses issuing and managing digital assets at scale. The **fixed fee** model ensures that transaction fees remain low, stable, and predictable, as they are denominated in USD and paid in HBAR. The transaction fees are not impacted by network demand and congestion like other chains. This eliminates volatility and makes transaction costs easy to estimate.

#### Built-In Custom Fees

The Hedera Token Service (HTS) extends beyond standard transaction fees by offering a custom fee schedule that enables automated fee distribution for token transactions, revenue sharing, and royalty payments, all without requiring smart contracts. These fees are enforced programmatically at the token level, ensuring predictability, efficiency, and scalability. By integrating fixed network fees with customizable fee structures, Hedera provides a developer-friendly, cost-effective solution for managing digital assets at scale.

{% embed url="https://docs.hedera.com/hedera/~/changes/2881/copy-of-tokens/hedera-token-service-hts-native-tokenization/custom-fee-schedule" %}
[Learm more](hedera-token-service-hts-native-tokenization/custom-fee-schedule.md)
{% endembed %}

{% embed url="https://www.youtube.com/watch?v=YnEQ6ZmBG7A" %}

***

## Additional Resources&#x20;

* [**HTS x EVM - Part 1: How to Mint NFTs \[Tutorial\]**](../../tutorials/smart-contracts/hts-x-evm-part-1-how-to-mint-nfts.md)
* [**HTS x EVM - Part 2: KYC & Update \[Tutorial\]**](../../tutorials/smart-contracts/hts-x-evm-part-2-kyc-and-update.md)
* [**HTS x EVM - Part 3: How to Pause, Freeze, Wipe, and Delete NFTs \[Tutorial\]**](../../tutorials/smart-contracts/hts-x-evm-part-3-how-to-pause-freeze-wipe-and-delete-nfts.md)
