# Hybrid (HTS + EVM ) Tokenization

## **Hybrid Tokenization: Combining HTS and Smart Contracts**

Hedera's system contracts allow EVM-based smart contracts to interact directly with HTS tokens. This integration enables smart contracts to manage HTS tokens as if they were standard ERC tokens, facilitating complex interactions and programmability. For example, the Hedera Account Service (HAS) system contract introduces an account proxy to interact with other contracts, enabling functionalities such as HBAR allowances and authorization checks directly within smart contracts. ​

By combining these features, Hedera provides a robust platform for developers to leverage both native token services and EVM-based smart contracts, ensuring scalability, security, and interoperability within the blockchain ecosystem.

<figure><img src="../../.gitbook/assets/hybrid-tokenization-mindmap.png" alt=""><figcaption></figcaption></figure>

### Smart Contract-Based Token Management

Smart contracts provide programmable, self-executing contracts to create, manage, and enforce conditions for tokens. Tokenized assets managed by smart contracts could represent various types of assets, such as cryptocurrencies, non-fungible tokens, and real-world assets (RWAs). Secure transfer and complex interactions across decentralized apps (dApps) are facilitated by tokens, beyond mere transactions.

Ethereum’s ERC-20 (fungible tokens) and ERC-721 (non-fungible tokens) standards offer universal interfaces, ensuring compatibility across exchanges, wallets, and dApps. Developers find it convenient to implement by adhering to these standards, while predictable platform behavior is guaranteed.

Hedera extends this compatibility further by allowing HTS-native tokens to act as ERC-20 or ERC-721. This makes it possible to make minimal, if any, adjustments while deploying EVM smart contracts on Hedera while still tapping HTS's native efficiencies, such as low-cost transactions and compliant-by-default.

***

## How HTS and the EVM Work Together

### **Token Creation & Management with HTS**

Hedera offers the Hedera API (HAPI), granting comprehensive access to services like account management, token transactions, and consensus. Developers can utilize Hedera SDKs to perform actions such as token transfers, contract calls, and consensus messaging. HTS is used for native token issuance, transfers, and compliance controls, ensuring fast and efficient transactions.&#x20;

* Mint, burn, and transfer tokens with low fees.
* Use built-in compliance tools (KYC, Freeze, Pause, Wipe).
* Enable atomic swaps between HTS tokens and HBAR.

### **Advanced Logic & Automation with Smart Contracts**

Solidity smart contracts add programmability to token operations, allowing developers to:

* Define automated rules for token transfers, staking, or rewards.
* Integrate with DeFi applications using lending, swaps, and pooling logic.
* Enforce complex business logic for RWAs, gaming economies, and NFT royalties.

HTS provides efficiency, while smart contracts enable custom behavior.

***

## **System Contracts for Direct HTS Token Interactions**

Hedera's system contracts allow EVM-based smart contracts to interact directly with HTS tokens. This integration enables smart contracts to manage HTS tokens as if they were standard ERC tokens, facilitating complex interactions and programmability. For example, the Hedera Account Service (HAS) system contract introduces an account proxy to interact with other contracts, enabling functionalities such as HBAR allowances and authorization checks directly within smart contracts. By leveraging system contracts, developers can:

* Hold and manage HTS tokens within smart contracts, just like ERC-20 and ERC-721 tokens.
* Transfer HTS tokens using EVM-based logic, enabling seamless token operations.
* Access Hedera accounts within smart contracts, unlocking new dApp functionalities.

This native integration eliminates the need for custom bridges or complex workarounds, making HTS token management within smart contracts more efficient and developer-friendly.

<table><thead><tr><th width="256.88189697265625">System Contract</th><th width="136.23529052734375">Contract Address</th><th>Source</th></tr></thead><tbody><tr><td><strong>Hedera Account Service (HAS)</strong></td><td><code>0x16a</code></td><td><a href="https://github.com/hashgraph/hedera-smart-contracts/tree/main/contracts/system-contracts/hedera-account-service">https://github.com/hashgraph/hedera-smart-contracts/tree/main/contracts/system-contracts/hedera-account-service</a></td></tr><tr><td><strong>Hedera Schedule Service (HSS)</strong></td><td><code>0x16b</code></td><td><a href="https://github.com/hashgraph/hedera-smart-contracts/tree/main/contracts/system-contracts/hedera-schedule-service">https://github.com/hashgraph/hedera-smart-contracts/tree/main/contracts/system-contracts/hedera-schedule-service</a></td></tr><tr><td><strong>Hedera Token Service (HTS)</strong></td><td><code>0x167</code></td><td><a href="https://github.com/hashgraph/hedera-smart-contracts/tree/main/contracts/system-contracts/hedera-token-service">https://github.com/hashgraph/hedera-smart-contracts/tree/main/contracts/system-contracts/hedera-token-service</a></td></tr><tr><td><strong>Exchange Rate</strong></td><td><code>0x168</code></td><td><a href="https://github.com/hashgraph/hedera-smart-contracts/tree/main/contracts/system-contracts/exchange-rate">https://github.com/hashgraph/hedera-smart-contracts/tree/main/contracts/system-contracts/exchange-rate</a></td></tr><tr><td><strong>Pseudo Random Number Generator (PRNG)</strong></td><td><code>0x169</code></td><td><a href="https://github.com/hashgraph/hedera-smart-contracts/tree/main/contracts/system-contracts/pseudo-random-number-generator">https://github.com/hashgraph/hedera-smart-contracts/tree/main/contracts/system-contracts/pseudo-random-number-generator</a></td></tr></tbody></table>

***

## **HTS vs. Smart Contract Performance Features**

By combining these features, Hedera provides a robust platform for developers to leverage both native token services and EVM-based smart contracts, ensuring scalability, security, and interoperability within the blockchain ecosystem.​

<table><thead><tr><th width="178.572265625">Feature</th><th>HTS-Native Tokens</th><th>Smart Contract Tokens</th><th>Hybrid Approach</th></tr></thead><tbody><tr><td><strong>Transaction Speed</strong></td><td>10,000+ TPS</td><td>~350 TPS (gas-limited)</td><td>HTS speed with smart contract flexibility</td></tr><tr><td><strong>Cost Efficiency</strong></td><td>Fixed, low-cost fees</td><td>Higher gas costs</td><td>HTS transactions remain low-cost</td></tr><tr><td><strong>Custom Logic</strong></td><td>❌ Limited to built-in controls</td><td>✅ Fully programmable</td><td>✅ Smart contracts enhance HTS functionality</td></tr><tr><td><strong>Compliance Features</strong></td><td>✅ KYC, Freeze, Pause, Wipe</td><td>❌ Must be custom-coded</td><td>✅ Hybrid approach supports compliance via smart contracts</td></tr><tr><td><strong>EVM Compatibility</strong></td><td>✅ Via Facade Contracts</td><td>✅ Standard ERC-20/ERC-721</td><td>✅ HTS tokens accessible via smart contracts</td></tr></tbody></table>

For high-frequency transactions, HTS-native tokens provide superior performance and lower costs. For custom business logic, smart contract tokens offer greater flexibility. Hybrid tokenization lets developers leverage both.
