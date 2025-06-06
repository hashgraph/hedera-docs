# Hedera Token Service (HTS) Native Tokenization

## Overview

The Hedera Token Service (HTS) provides native support for fungible and non-fungible tokens (NFTs), allowing developers to create and manage tokens without deploying smart contracts. This simplifies tokenization, reduces development complexity, and enhances security. The native tokenization model is optimized for high-speed transactions, supporting up to 10,000 transactions per second (TPS) for token transfers, making it ideal for enterprise-scale applications that require rapid and secure token operations. HTS also provides additional features such as: &#x20;

* **Built-in compliance controls** – KYC, pause, freeze, and account association
* **Atomic swaps** – Transfer multiple tokens and HBAR in a single transaction
* **Customizable fees** – Supports automatic royalties and revenue sharing
* **Direct API & SDK access** - No Solidity smart contracts required

<figure><img src="../../../.gitbook/assets/key-advantages-of-hts-mindmap.png" alt=""><figcaption></figcaption></figure>

HTS is accessible through Hedera’s native API (HAPI), which provides comprehensive token management capabilities, including account operations, token transactions, and consensus messaging. Developers can interact with HTS via the Hedera SDKs, enabling seamless token transfers, contract calls, and consensus integrations.

***

## **Built-in Compliance & Security Controls**

HTS ensures secure and compliant tokenization with built-in tools that eliminate the need for Solidity-based enforcement. Token issuers can configure their tokens using the following security features

<table><thead><tr><th width="199">Feature</th><th>Function</th><th>Benefit</th></tr></thead><tbody><tr><td><strong>KYC Enforcement</strong></td><td>Restricts transfers to verified accounts</td><td>Ensures regulatory compliance and security</td></tr><tr><td><strong>Freeze/Pause Functions</strong></td><td>Suspends transactions when needed</td><td>Protects against fraud and suspicious activity</td></tr><tr><td><strong>Custom Fees</strong></td><td>Supports royalties &#x26; structured payments</td><td>Automates revenue collection and token monetization</td></tr><tr><td><strong>Supply Control</strong></td><td>Enables or disables minting or burning</td><td>Maintains controlled token supply</td></tr><tr><td><strong>Account Association</strong></td><td>Prevents spam token transfers</td><td>Enhances security and prevents unwanted token drops</td></tr></tbody></table>

These optional compliance and control mechanisms make HTS flexible to meet regulatory requirements while maintaining token security and flexibility.

***

## Token Management

Managing token operations on Hedera involves defining roles and performing key actions to control and manage the token lifecycle. Below are the primary roles and token management operations supported by HTS.

### Role-Based Access Control

HTS utilizes role-based access control (RBAC) to securely manage token lifecycle operations. Token issuers can assign distinct roles to delegate responsibilities, enhance security, and ensure compliance.

<table><thead><tr><th width="179">Role</th><th>Description</th></tr></thead><tbody><tr><td><strong>Admin Key</strong></td><td>Grants full control over token configuration, including updating properties. Used for governance and administrative tasks, such as freezing or pausing.</td></tr><tr><td><strong>Supply Key</strong></td><td>Allows minting and burning of tokens to adjust the total supply. Ensures control over token issuance and circulation.</td></tr><tr><td><strong>Freeze Key</strong></td><td>Enables freezing or unfreezing token transfers for specific accounts. Used to enforce restrictions during investigations or compliance checks.</td></tr><tr><td><strong>KYC Key</strong></td><td>Enforces KYC compliance, allowing only approved accounts to transact with tokens. Ensures regulatory compliance for sensitive use cases.</td></tr><tr><td><strong>Wipe Key</strong></td><td>Allows removal of tokens from specific accounts. Used for refunding or correcting token allocations.</td></tr><tr><td><strong>Pause Key</strong></td><td>Allows pausing or unpausing token transactions. Pausing a token prevents the token from participating in all transactions.</td></tr><tr><td><strong>Fee Schedule Key</strong></td><td>Allows adjustments to the token’s custom fee schedule, providing flexibility in managing transaction costs.</td></tr><tr><td><strong>Metadata Key</strong></td><td>The key which can update the metadata of an NFT. This key is used to sign and authorize the transaction to update the metadata of NFTs. This value can be null.</td></tr></tbody></table>

### **Token Operations**

HTS supports various token operations to ensure secure and flexible management of tokenized assets.

<table><thead><tr><th width="177">Operation</th><th>Description</th></tr></thead><tbody><tr><td><strong>Mint</strong></td><td>Increase the total supply of a token by creating new units.</td></tr><tr><td><strong>Burn</strong></td><td>Decrease the total supply of a token by destroying specific units.</td></tr><tr><td><strong>Associate</strong></td><td>Enables an account to hold and transact the token.</td></tr><tr><td><strong>Dissociate</strong></td><td>Remove a token association from an account to prevent further transactions.</td></tr><tr><td><strong>Freeze/Unfreeze</strong></td><td>Temporarily restrict or allow token transfers for specific accounts.</td></tr><tr><td><strong>Wipe</strong></td><td>Remove tokens from an account’s balance, effectively burning them.</td></tr><tr><td><strong>Enable KYC</strong></td><td>Restricts token holding or transfers to accounts meeting compliance requirements.</td></tr></tbody></table>

***

## **Use Cases for HTS**

HTS powers a wide range of applications across finance, gaming, enterprise, and digital assets. It enables high-speed, low-cost transfers for stablecoins, CBDCs (central bank digital currency), and remittances, making digital payments faster and more efficient. Its NFT marketplace solutions support efficient and affordable minting and trading of non-fungible tokens (NFTs). For enterprises and banking, HTS facilitates tokenized securities, corporate treasury operations, and interbank settlements. In gaming and the metaverse, it powers instant asset ownership transfers for in-game items, digital collectibles, and virtual economies.

<figure><img src="../../../.gitbook/assets/hts-use-cases-icons.png" alt=""><figcaption></figcaption></figure>
