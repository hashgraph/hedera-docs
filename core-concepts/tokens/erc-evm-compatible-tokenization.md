# ERC/EVM-Compatible Tokenization

Hedera provides full compatibility with ERC token standards through its EVM smart contract support, allowing developers to deploy and interact with ERC-20, ERC-721, and other EVM-based tokens. By integrating ERC standards with Hedera’s scalability, security, and low fees, developers can use familiar EVM tooling while benefiting from Hedera’s performance optimizations.

***

## **Why Choose ERC/EVM Tokenization on Hedera?**

* Deploy ERC-20, ERC-721, and other EVM-based contracts directly on Hedera's EVM implementation.
* Use EVM-native tools like Hardhat, Web3.js, ethers.js, and Remix to interact with smart contracts.
* Interact with smart contracts via JSON-RPC relay, maintaining a familiar EVM development workflow.
* Achieve greater scalability and efficiency, with predictable low-cost transactions and higher throughput than Ethereum.

This makes Hedera an ideal platform for EVM developers looking for high-performance alternatives without modifying their existing smart contracts.

***

## **ERC Token Standards on Hedera**

Hedera supports multiple ERC token standards, allowing developers to deploy smart contracts that interact seamlessly with EVM dApps and wallets.

<figure><img src="../../.gitbook/assets/erc-standards-hedera.png" alt=""><figcaption></figcaption></figure>

<table><thead><tr><th width="143.857666015625">Token Standard</th><th>Description</th><th>Use Cases</th></tr></thead><tbody><tr><td><a href="../smart-contracts/tokens-managed-by-smart-contracts/erc-20-fungible-tokens.md"><strong>ERC-20</strong></a></td><td>Fungible token standard</td><td>Cryptocurrencies, governance tokens</td></tr><tr><td><a href="../smart-contracts/tokens-managed-by-smart-contracts/erc-721-non-fungible-tokens-nfts.md"><strong>ERC-721</strong></a></td><td>Non-fungible token (NFT) standard</td><td>Digital art, collectibles, gaming assets</td></tr><tr><td><a href="../smart-contracts/tokens-managed-by-smart-contracts/erc-3643-real-world-assets-rwa.md"><strong>ERC-3643</strong></a></td><td>Regulated real-world asset (RWA) token standard</td><td>Securities, compliant digital assets</td></tr><tr><td><a href="../smart-contracts/tokens-managed-by-smart-contracts/erc-1363-payable-tokens.md"><strong>ERC-1363</strong></a></td><td>Payable tokens supporting direct contract payments</td><td>Subscription models, in-app purchases</td></tr></tbody></table>

These standards enable the deployment of any smart contract, including DeFi applications and tokenization contracts like ERC-20 and ERC-721 tokens. This compatibility alows EVM developers to leverage familiar workflows, tools and, frameworks on Hedera.

***

## Deploying and Interacting with ERC Tokens on Hedera

### **Using JSON-RPC for EVM Tooling**

Hedera provides a JSON-RPC relay, making it easy for developers to interact with smart contracts using EVM-native tools. These tools provide standard EVM developer workflows on Hedera's EVM environment. Developers can use the same JSON-RPC methods as Ethereum, ensuring compatibility with dApps, wallets, and DeFi protocols.

<table><thead><tr><th width="205.6319580078125">Tools</th><th>Description</th></tr></thead><tbody><tr><td><a href="https://hardhat.org/hardhat-runner/docs/getting-started#overview"><strong>Hardhat</strong></a></td><td>Deploy and test smart contracts.</td></tr><tr><td><a href="https://web3js.readthedocs.io/en/v1.10.0/"><strong>Web3.js</strong></a> <strong>/</strong> <a href="https://docs.ethers.org/v5/"><strong>ethers.js</strong></a></td><td>Query and interact with contracts.</td></tr><tr><td><a href="https://remix.ethereum.org/"><strong>Remix IDE</strong></a></td><td>Deploy smart contracts using a browser-based IDE.</td></tr></tbody></table>

<figure><img src="../../.gitbook/assets/SmartContractsAndHTS.drawio.png" alt=""><figcaption></figcaption></figure>

### **HTS Tokens as ERC-20/ERC-721 via Facade Contracts**

Hedera provides facade contracts (per HIP-218 and HIP-376) that allow HTS-native tokens to function as ERC-20 or ERC-721 tokens. With these contracts, developers can leverage Hedera’s efficiency while maintaining EVM compatibility.

​A facade contract on Hedera acts as a built-in adapter, allowing Hedera Token Service (HTS) tokens to function seamlessly as standard ERC-20 or ERC-721 tokens within EVM-compatible (EVM) environments. This integration enables developers to interact with HTS tokens using familiar Ethereum interfaces, such as `transfer()`, `approve()`, and `transferFrom()`, without requiring modifications to existing Ethereum wallets or decentralized applications (dApps).

Under the hood, when an EVM-compatible tool interacts with an HTS token's facade contract, the call is delegated to Hedera's native token service. This design ensures that HTS tokens can be managed and transacted using standard Ethereum tooling, providing a seamless developer experience. ​

In summary, facade contracts provide a bridge between Hedera's native token services and the Ethereum ecosystem, enabling developers to leverage Hedera's performance benefits while maintaining compatibility with established Ethereum standards and tools.​

<table><thead><tr><th width="242.2333984375">Facade Contracts</th><th>Description</th></tr></thead><tbody><tr><td><strong>IHRC904AccountFacade.sol</strong></td><td><a href="https://github.com/hashgraph/hedera-smart-contracts/blob/main/contracts/system-contracts/hedera-account-service/IHRC904AccountFacade.sol">https://github.com/hashgraph/hedera-smart-contracts/blob/main/contracts/system-contracts/hedera-account-service/IHRC904AccountFacade.sol</a></td></tr><tr><td><strong>IHRC906AccountFacade.sol</strong></td><td><a href="https://github.com/hashgraph/hedera-smart-contracts/blob/main/contracts/system-contracts/hedera-account-service/IHRC906AccountFacade.sol">https://github.com/hashgraph/hedera-smart-contracts/blob/main/contracts/system-contracts/hedera-account-service/IHRC906AccountFacade.sol</a></td></tr><tr><td><strong>IHRC755ScheduleFacade.sol</strong></td><td><a href="https://github.com/hashgraph/hedera-smart-contracts/blob/main/contracts/system-contracts/hedera-schedule-service/IHRC755ScheduleFacade.sol">https://github.com/hashgraph/hedera-smart-contracts/blob/main/contracts/system-contracts/hedera-schedule-service/IHRC755ScheduleFacade.sol</a></td></tr><tr><td><strong>IHRC904TokenFacade.sol</strong></td><td><a href="https://github.com/hashgraph/hedera-smart-contracts/blob/main/contracts/system-contracts/hedera-token-service/IHRC904TokenFacade.sol">https://github.com/hashgraph/hedera-smart-contracts/blob/main/contracts/system-contracts/hedera-token-service/IHRC904TokenFacade.sol</a></td></tr></tbody></table>

{% hint style="info" %}
#### Token Associations

When transferring HTS tokens on Hedera, recipients must associate the token with their account before receiving it. [Learn more about token auto associations and fees](hedera-token-service-hts-native-tokenization/token-airdrops.md#auto-associations-and-fees).
{% endhint %}

### **Synthetic Events for Tokens Managed by Smart Contracts**

Smart contract tokens like ERC-20 and ERC-721 emit events, creating contract logs that developers can query or subscribe to. Hedera Token Service (HTS) tokens do not natively generate such event logs. As a solution to this limitation, Hedera Mirror Nodes generate synthetic event logs, enabling event-driven workflows to mimic the behavior of smart contract tokens for HTS transactions. Synthetic events are generated for transactions such as:

* `CryptoTransfer`
* `CryptoApproveAllowance`
* `CryptoDeleteAllowance`
* `TokenMint`
* `TokenWipe`
* `TokenBurn`

This feature enables developers to effectively monitor HTS token activities as if they were smart contract tokens. An example code implementation demonstrating using ethers.js to listen to synthetic events can be found [here](https://github.com/ed-marquez/hedera-example-hts-synthetic-events-sdk-ethers).

<figure><img src="../../.gitbook/assets/synthetic-events.png" alt=""><figcaption><p><strong>Synthetic Events Flow</strong></p></figcaption></figure>

## Video Resource

{% embed url="https://youtu.be/B23aVhaCARU?si=kOx79FdLexzdTcde" %}

<details>

<summary>📣 <strong>EVM Protocols Supporting Hedera ⬇</strong></summary>

<table><thead><tr><th width="221.88629150390625">Protocols</th><th>Description</th></tr></thead><tbody><tr><td><a href="../../open-source-solutions/oracle-networks/chainlink-oracles.md"><strong>Chainlink Oracles / CCIP*</strong></a></td><td>Decentralized data feeds, price oracles, and verifiable randomness (VRF). Ensures reliable, off-chain data for Hedera EVM smart contracts.</td></tr><tr><td><a href="../../open-source-solutions/interoperability-and-bridging/layerzero.md"><strong>LayerZero Interoperability</strong></a></td><td>Enables seamless cross-chain communication. Facilitates integration between Hedera and other EVM-compatible networks.</td></tr><tr><td><a href="https://www.openzeppelin.com/solidity-contracts"><strong>OpenZeppelin Libraries</strong></a></td><td>Standardized, audited smart contract frameworks.</td></tr><tr><td><a href="../../open-source-solutions/oracle-networks/"><strong>Supra / Pyth / ChainLink</strong></a></td><td>Oracles for EVM accessible data for prices of tokens, etc</td></tr></tbody></table>

</details>
