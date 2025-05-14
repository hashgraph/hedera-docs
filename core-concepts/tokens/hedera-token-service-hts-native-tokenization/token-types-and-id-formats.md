# Token Types and ID Formats

## Supported Token Types

The Hedera Token Service (HTS) supports multiple token types, enabling you to represent a wide range of digital assets—whether they’re identical units of value or unique items. This guide covers the supported token types and explains how tokens are identified on Hedera. The Hedera Token Service supports two primary token types:

### **Fungible Tokens**

Fungible tokens are identical, interchangeable, and share the same value and properties. They are best suited for assets where every unit is equal. This is particularly useful for representing divisible assets such as stablecoins, loyalty points, in-game currencies, or any currency-like asset with fractional ownership.

<figure><img src="../../../.gitbook/assets/fungible-tokens-type.png" alt=""><figcaption></figcaption></figure>

### **Non-Fungible Tokens**

Non-fungible tokens (NFTs) are unique and non-interchangeable, differentiated by a distinct serial number. They can represent various unique and indivisible assets that require individual distinction, such as digital art, music, collectibles, or identity and certifications.&#x20;

<figure><img src="../../../.gitbook/assets/non-fungible-tokens-type.png" alt=""><figcaption></figcaption></figure>

***

## Token ID and Format

The **Token ID** uniquely identifies a token entity on the Hedera network. It consists of the shard number, realm number, and a token number, formatted as:

📌 `<shardNum>.<realmNum>.<tokenNum>`

This Token ID is used in all transactions and queries involving the token.&#x20;

#### **Token ID Example**

📌 `0.0.100` → Identifies a **fungible token** with a token number `100`.

### Components of a Token ID

<table><thead><tr><th width="164">Component</th><th width="419">Description</th><th align="center">Default</th></tr></thead><tbody><tr><td><strong>Shard Number</strong> (<code>shardNum</code>)</td><td>Defines the shard (partition) where the token exists. Currently, Hedera operates in only one shard, so this value remains <code>0</code>. </td><td align="center"><code>0</code></td></tr><tr><td><strong>Realm Number</strong> (<code>realmNum</code>)</td><td>Identifies the realm within a shard. Today, Hedera has one realm, so this value is also <code>0</code>.</td><td align="center"><code>0</code></td></tr><tr><td><strong>Token Number</strong> (<code>tokenNum</code>)</td><td>A unique identifier assigned to each token when it is created.</td><td align="center"><p><strong>Varies</strong></p><p>(assigned at creation)</p></td></tr><tr><td><strong>Serial Number</strong> (<code>serialNum</code>)</td><td>A unique identifier for individual NFTs within a collection. Not applicable to fungible tokens.</td><td align="center"><p><strong>N/A</strong> </p><p>(NFTs only)</p></td></tr></tbody></table>

### Non-Fungible Token ID Format

For **non-fungible tokens (NFTs)**, an additional serial number is appended to the Token ID to distinguish each unique instance within a collection:

📌 `<shardNum>.<realmNum>.<tokenNum>/`_<mark style="color:green;background-color:green;">`<serialNum>`</mark>_

#### **NFT Token ID Example**

📌 `0.0.12345/1` → First NFT in collection `0.0.12345`

📌 `0.0.12345/2` → Second NFT in collection `0.0.12345`

<figure><picture><source srcset="../../../.gitbook/assets/token-id-structure-flow-v2-for-dark-mode (1) (1).png" media="(prefers-color-scheme: dark)"><img src="../../../.gitbook/assets/token-id-structure-flow-v2-for-light-mode.png" alt=""></picture><figcaption></figcaption></figure>



This consistent ID format ensures that tokens are efficiently tracked and managed across the Hedera network.
