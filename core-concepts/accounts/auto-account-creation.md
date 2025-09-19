# Auto Account Creation

Auto account creation is a unique flow in which applications, like wallets and exchanges, can create free user "accounts" instantly, even without an internet connection. Applications can make these by generating an **account alias.** The alias account ID format used to specify the account alias in Hedera transactions comprises the shard ID, realm ID, and account alias <mark style="color:purple;">`<shardNum>.<realmNum>.<alias>`</mark>. This is an alternative account identifier compared to the standard account number format <mark style="color:purple;">`<shardId>.<realmId>.<accountNum>`</mark><mark style="color:blue;">.</mark>

The account alias can be either one of the supported types:

<details>

<summary><strong>Public Key</strong></summary>

The public key alias can be an ED25519 or ECDSA secp256k1 public key type.\
\
**Example**\
\
ECDSA secp256k1 Public Key:\
`02d588ec1000770949ab77516c77ee729774de1c8fe058cab6d64f1b12ffc8ff07`\
\
DER Encoded ECDSA secp256k1 Public Key Alias:\
`302d300706052b8104000a03220002d588ec1000770949ab77516c77ee729774de1c8fe058cab6d64f1b12ffc8ff07`\
\
ECDSA secp256k1 Public Key Alias Account ID:\
`0.0.302d300706052b8104000a03220002d588ec1000770949ab77516c77ee729774de1c8fe058cab6d64f1b12ffc8ff07`\
\
\
\
EDDSA ED25519 Public Key:\
`1a5a62bb9f35990d3fea1a5bb7ef6f1df0a297697adef1e04510c9d4ecc5db3f`\
\
DER Encoded EDDSA ED25519 Public Key Alias:\
`302a300506032b65700321001a5a62bb9f35990d3fea1a5bb7ef6f1df0a297697adef1e04510c9d4ecc5db3f`\
\
EDDSA ED25519 Public Key Alias Account ID:\
`0.0.302a300506032b65700321001a5a62bb9f35990d3fea1a5bb7ef6f1df0a297697adef1e04510c9d4ecc5db3f`

</details>

<details>

<summary><strong>EVM Address</strong></summary>

The EVM address alias is created by using the rightmost 20 bytes of the 32 byte `Keccak-256` hash of an `ECDSA secp256k1` public key. This calculation is in the manner described by the [Ethereum Yellow Paper](https://ethereum.github.io/yellowpaper/paper.pdf). The EVM address is not equivalent to the ECDSA public key.\
\
The acceptable format for Hedera transactions is the EVM Address Alias Account ID. The acceptable format for Ethereum public addresses to denote an account address is the hex encoded public address.\
\
**Example**\
\
EVM Address: `b794f5ea0ba39494ce839613fffba74279579268`\
\
HEX Encoded EVM Address: `0xb794f5ea0ba39494ce839613fffba74279579268`\
\
EVM Address Alias Account ID: `0.0.b794f5ea0ba39494ce839613fffba74279579268`

</details>

The <mark style="color:purple;">`<shardNum>.<realmNum>.<alias>`</mark> format is only acceptable when specified in the `TransferTransaction`, `AccountInfoQuery`, and `AccountBalanceQuery` transaction types. If this format is used to specify an account in any other transaction type, the transaction will not succeed.

Reference Hedera Improvement Proposal: [HIP-583](https://hips.hedera.com/hip/hip-583)

## **Auto Account Creation Flow**

### **1. Create an account alias**

Create an account alias and convert it to the alias account ID format. The alias account ID format requires appending the shard number and realm numbers to the account alias. This form of account is purely a local account, i.e., not registered with the Hedera network.

### **2. Deposit tokens to the account alias account ID**

Once the alias Account ID exists, create a **TransferTransaction** that sends HBAR or HTS tokens to that alias. Sending tokens triggers auto account creation on the network, and the first token transferred is automatically associated with the new account.

When the transfer executes, the network:

* Creates a **child** account-creation transaction just before the transfer
* Assigns a new account number and stores the alias on the account
* Sets the memo to indicate an auto-created account
* Sets the account key if the alias is a public key, or leaves the account **hollow** if the alias is an EVM address

The **parent** transaction is the token transfer. The **child** is the account creation. They share a transaction ID; the child uses the same ID with a nonce increment. To fetch the new account ID, query the child record or request the parent record with child records included.

The **payer** of the transfer covers both the token transfer fee and the account creation fee.

{% hint style="info" %}
#### **Note**

The account-creation child transaction is timestamped just before the transfer (a minimal offset).\
Parent and child share the same Transaction ID; the child uses the same ID with a nonce increment.\
Fees for both the account creation and the transfer are charged **in tinybars** to the payer of the parent transfer.\
To retrieve the new Account ID, either request the parent record with child records included or query the child record directly by incrementing the nonce.
{% endhint %}

### **3. Get the new account number**

You can obtain the new account number in any of the following ways:

* Request the parent transaction record or receipt and set the child transaction record boolean flag equal to true.
* Request the transaction receipt or record of the account create transaction by using the transaction ID of the parent transfer transaction and incrementing the nonce value from 0 to 1.
* Specify the account alias account ID in an `AccountInfoQuery` transaction request. The response will return the account's account number account ID.
* Inspect the parent transfer transaction record transfer list for the account with a transfer equal to the token transfer value.

## Auto Account Creation with an EVM Address&#x20;

When the alias is an EVM address, the network creates a **hollow account**. A hollow account has an account number and alias but no key. It can receive tokens, but it cannot send tokens or modify account properties until it is a complete account.

### Complete a Hollow Account

To complete a hollow account, submit a Hedera transaction that:

1. Make the hollow account the **fee payer** for a Hedera transaction, and
2. Sign that transaction with the **ECDSA private key** that matches the EVM address.

If either condition is missing, the transaction is rejected. After completion, the account behaves like a regular Hedera account.

#### **Using HAPI (SDKs)**

* Build a transaction (for example, a small [`TransferTransaction`](../../sdks-and-apis/sdks/accounts-and-hbar/transfer-cryptocurrency.md)).
* Set the transaction’s payer to the hollow account in your SDK.
* Sign with the corresponding ECDSA key and execute.

#### **Using EVM Wallets via JSON-RPC**

* Send the first transaction from the new account in the wallet.
* EVM wallets will set the new account as the transaction fee payer when users sign transactions to complete the account. No further action is required as the RPC will set the users account ID as the fee payer.

## **Automatic Token Associations for Completed Accounts**

Once a hollow account has been converted into a complete account by acting as the payer for a transaction and signing with its ECDSA private key, it inherits the default automatic association settings. Specifically, the account’s `maxAutoAssociations` property defaults to `–1`, enabling unlimited automatic token associations. This means that any subsequent HTS tokens transferred to the completed account will be automatically associated, and the recipient does not need to manually associate with each token. This behavior is part of frictionless airdrops ([HIP‑904](https://hips.hedera.com/hip/hip-904)) and differs from earlier network versions where auto‑association for new tokens was not available.

## Examples

<details>

<summary><strong>Auto-create an account using a public key alias</strong></summary>

:black\_circle: [Java](https://github.com/hiero-ledger/hiero-sdk-java/blob/main/examples/src/main/java/com/hedera/hashgraph/sdk/examples/AccountAliasExample.java)\
:black\_circle: [JavaScript](https://github.com/hiero-ledger/hiero-sdk-js/blob/main/examples/account-alias.js)\
:black\_circle: [Go](https://github.com/hiero-ledger/hiero-sdk-go/blob/main/examples/alias_id_example/main.go)

</details>

<details>

<summary><strong>Auto-create an account using an EVM address (public address) alias</strong></summary>

:black\_circle: [Java](https://github.com/hiero-ledger/hiero-sdk-java/blob/main/examples/src/main/java/com/hedera/hashgraph/sdk/examples/AutoCreateAccountTransferTransactionExample.java)\
:black\_circle: [JavaScript](https://github.com/hiero-ledger/hiero-sdk-js/blob/main/examples/transfer-using-evm-address.js)\
:black\_circle: [Go](https://github.com/hiero-ledger/hiero-sdk-go/blob/main/examples/account_create_token_transfer/main.go)

</details>
