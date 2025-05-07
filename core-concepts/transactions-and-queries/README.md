---
description: An overview of Hedera API transactions and queries
---

# Transactions and Queries

## Transactions

Transactions are requests sent by a client to a node with the expectation that they are submitted to the network for processing into consensus order and subsequent application to state. Each transaction (e.g. `TokenCreateTransaction()`) has an associated transaction fee compensating the Hedera network for processing and subsequent maintenance in a consensus state.

**Transaction ID**

Each transaction has a unique transaction ID. The transaction ID is used for the following:

* Obtaining receipts, records
* Internally by the network for detecting when duplicate transactions are submitted

The transaction ID is composed by using the transaction's valid start time and the account ID of the account that is paying for the transaction. The transaction's valid start time is the time the transaction begins to be processed on the network. The transaction's valid start time can be set to a future date/time. A transaction ID looks something like `0.0.9401@1598924675.82525000`where `0.0.9401` is the transaction fee payer account ID and `1598924675.82525000` is the timestamp in `seconds.nanoseconds`.

Transactions have a valid duration of up to 180 seconds and begin at the transaction's valid start time. This means that the transaction has up to 180 seconds to be accepted by one of the nodes in the network. If the transaction is not accepted in this timeframe, the transaction will expire. The transaction will have to be created, signed, and submitted again.

A **transaction** generally includes the following:

* **Node Account**: the account ID of the node the transaction is being sent to (e.g. `0.0.3`)
* **Transaction ID**: the identifier for a transaction. It has two components:&#x20;
  * The account ID of the paying account
  * The transaction’s valid start time
* **Transaction Fee**: the maximum fee the transaction fee paying account is willing to pay for the transaction
* **Valid Duration**: the number of seconds that the client wishes the transaction to be deemed valid for, starting at the transaction's valid start time
* **Memo**: a string of text up to 100 bytes of data (optional)
* **Transaction**: type of request, for instance, an HBAR transfer or a smart contract call
* **Signatures**: at minimum, the paying account will sign the transaction as authorization. Other signatures may be present as well.

For a detailed breakdown of all transaction properties, please refer to the [Transaction Properties](transaction-properties.md) page.

The lifecycle of a transaction in the Hedera ecosystem begins when a client creates a transaction. Once the transaction is created it is cryptographically signed at a minimum by the account paying for the fees associated with the transaction. Additional signatures may be required depending on the properties set for the account, topic, or token. The client can stipulate the maximum fee it is willing to pay for the processing of the transaction and, for a smart contract operation, the maximum amount of gas. Once the required signatures are applied to the transaction the client then submits the transaction to any node on the Hedera network.

The receiving node validates (for instance, confirms the paying account has sufficient balance to pay the fee) the transaction and, if validation is successful, submits the transaction to the Hedera network for consensus by adding the transaction to an event and gossiping that event to another node. Quickly, that event flows out to all the other nodes. The network receives this transaction exponentially fast via the [gossip about gossip protocol](../hashgraph-consensus-algorithms/gossip-about-gossip.md). The consensus timestamp for an event (and so the transactions within) is calculated by each node independently calculating the median of the times that the network nodes received that event. You may find more information on how the consensus timestamp is calculated [here](https://docs.hedera.com/docs/hashgraph-overview#section-fair-timestamps). The hashgraph algorithm delivers the finality of consensus. Once assigned a consensus timestamp the transaction is then applied to the consensus state in the order determined by each transaction’s consensus timestamp. At that point, the transaction fees are also processed. In this manner, every node in the network maintains a consensus state because they all apply the same transactions in the same order. Each node also creates and temporarily stores receipts/records in support of the client, subsequently querying for the status of a transaction.

## Transaction Types

### Standard Transactions

Standard transactions are individual operations submitted to the network, such as token transfers, account creation, or smart contract calls. Each transaction contains a specific operation type that determines its behavior and the changes it makes to the network state.

* **Standard Transaction ID Format**
  * The transaction ID uniquely identifies a transaction on the Hedera network. It consists of the payer’s account ID and the transaction’s valid start time, formatted as:\
    `accountID@validStartTime`\
    This ID is used for obtaining receipts and records and for detecting duplicate transactions within the network.

**Transaction ID Example**

`0.0.9401@1598924675.82525000` → A transaction paid for by account `0.0.9401` with a valid start time of `1598924675.82525000`.

### Batch Transactions

Batch transactions allow multiple operations (HAPI calls) to be executed atomically as a single network transaction, ensuring that all operations either succeed together or fail together (upholding ACID properties). Batch transactions consist of:

{% hint style="danger" %}
**Note**: Jumbo `EthereumTransaction` (released in [**v0.62**](https://docs.hedera.com/hedera/networks/release-notes/services#release-v0.62) for [**HIP-1086**](https://github.com/hiero-ledger/hiero-improvement-proposals/pull/1086)) _**will NOT be supported in batch transactions**_. Since this limitation is currently _**not supported**_ by the network, developers _must avoid including jumbo transactions in batches_ to prevent unexpected behaviors. \*_This limitation may be lifted in a future release._&#x20;
{% endhint %}

#### **Outer Batch Transaction ID**

* This is the container transaction that follows the standard transaction ID format (`accountID@validStartTime`).
* It uniquely identifies the entire batch and is used for deduplication of the batch as a whole.
* The fee for the batch is paid by the account that submits the outer transaction.

_**Example:**_ **`0.0.9401@1598924675.82525000`**

#### **Inner Transaction IDs**

* Each inner transaction has its own transaction ID, following the same format as standard transactions.
* These IDs are associated with the specific operations within the batch.
* Upon processing, each inner transaction record includes a `parentConsensusTimestamp` field, which links it to the consensus timestamp of the outer batch transaction. This linkage preserves the atomicity of the batch by ensuring all inner transactions are tied to the same consensus event.
* Methods such as `getInnerTransactionIds()` can be used to retrieve the inner transaction IDs after execution.

#### **Batch Key (HIP-551)**

To prevent tampering—such as reordering, removing, or adding transactions within the batch—a Batch Key is used.

* **Purpose:**
  * The Batch Key signals the trusted signer who is authorized to finalize the batch.
  * It ensures that the inner transactions are submitted as a complete, unaltered set.
* **Mechanism:**
  * Each inner transaction must include the Batch Key in its signature map.
  * During consensus, the network verifies that every inner transaction carries a valid and consistent Batch Key.
  * If any inner transaction is missing a valid Batch Key signature or if inconsistencies are detected, the entire batch is rejected.

{% hint style="info" %}
#### **Note:**

The outer batch transaction does not include the Batch Key; its role is solely to encapsulate the inner transactions and manage deduplication.
{% endhint %}

#### **Overall Batch Transaction Processing**

* The batch transaction is processed as a single atomic unit with a consolidated response and receipt.
* Despite the atomic processing, each inner transaction is recorded individually, allowing for detailed auditing and troubleshooting if necessary.
* The design of batch transactions minimizes network overhead and ensures that all related operations are executed in lockstep, thereby maintaining the integrity and consistency of the network state.

Reference: [HIP-551](https://hips.hedera.com/hip/hip-551)

### Nested Transactions

A **nested transaction** triggers subsequent transactions after executing a top-level transaction. The top-level transaction that a user submits is a **parent transaction**. For each subsequent transaction, the parent transaction triggers a **child transaction** as a result of the execution of the parent transaction. An example of a nested transaction is when a user submits the top-level transfer transaction to an account alias that triggers an account creation transaction behind the scenes. This parent/child transaction relationship is also observed with Hedera contracts interacting with HTS precompile. A parent transaction supports up to 999 child transactions since the platform reserves 1000 nanoseconds per user-submitted transaction.

**Transaction IDs**

Parent and child transactions share the payer account ID and transaction valid start timestamp. The child transaction IDs have an additional **nonce** value representing the order in which the child transactions were executed. The parent transaction has a nonce value of 0. The nonce value of child transactions increments by 1 for each child transaction executed due to the parent transaction.

Parent Transaction ID: <mark style="color:red;">payerAccountId</mark>@<mark style="color:blue;">transactionValidStart</mark>

Child Transaction ID: <mark style="color:red;">payerAccountId</mark>@<mark style="color:blue;">transactionValidStart</mark>/<mark style="color:green;">nonce</mark>

Example:

* Parent Transaction ID: <mark style="color:red;">0.0.2252</mark>@<mark style="color:blue;">1640119571.329880313</mark>
* Child 1 Transaction ID: <mark style="color:red;">0.0.2252</mark>@<mark style="color:blue;">1640119571.329880313</mark>/<mark style="color:green;">1</mark>
* Child 2 Transaction ID: <mark style="color:red;">0.0.2252</mark>@<mark style="color:blue;">1640119571.329880313</mark>/2

**Transaction Records**

Nested transaction records are returned by requesting the record for the parent transaction and setting the `setIncludeChildren(<value>)` to true. This returns records for all child transactions associated with the parent transaction. Child transaction records include the parent consensus timestamp and the child transaction ID.

The parent consensus timestamp field in a child transaction record is not populated when the child transaction was triggered **before** the parent transaction. An example of this case is creating an account using an account alias. The user submits the transfer transaction to create and fund the new account using the account alias. The transfer transaction (parent) triggers the account create transaction (child). However, the child transaction occurs before the parent transaction, so the new account is created before completing the transfer. The parent consensus timestamp is not populated in this case.

**Transaction Receipts**

Nested transaction receipts can be returned by requesting the parent transaction receipt and setting the boolean value equal to true to return all child transaction receipts.

**Child Transaction Fees**

The transaction fee for the child transaction is included in the record of the parent transaction. The transaction fee will return zero in the child transaction.

## Queries

**Queries** are processed only by the single node to which they are sent. Clients send queries to retrieve some aspect of the current consensus state, like an account balance. Certain queries are free, but generally, they are subject to fees. The full list of queries can be found [here](https://docs.hedera.com/hedera/sdks-and-apis/sdks/queries).

A query includes a header that includes a normal HBAR transfer transaction that will serve as how the client pays the node the appropriate fee. There is no way to give partial payment to a node for processing the query, meaning if a user overpaid for the query, the user will not receive a refund. The node processing the query will submit that payment transaction to the network for processing into a consensus statement to receive its fee.

A client can determine the appropriate fee for a query by asking a node for the cost, not the actual data. Such a `COST_ANSWER` query is free to the client.

For more information about query fees, please visit Hedera API fees [overview](https://www.hedera.com/fees).

{% hint style="info" %}
#### Recall

Hedera does not have **miners** or a special group of nodes responsible for adding transactions to the ledger like alternative distributed ledger solutions. Each node's influence on determining the consensus timestamp for an event is proportional to its stake in HBAR.
{% endhint %}

![](../../.gitbook/assets/transaction-flow.png)

Once a transaction has been submitted to the network, clients may seek confirmation that it was successfully processed. Multiple confirmation methods are available, varying in the level of information provided, the duration for which the confirmation is available, the degree of trust, and the corresponding cost.

![](../../.gitbook/assets/query-confirmation.png)

### Confirmations

* **Receipts:** Receipts provide minimal information - simply whether or not the transaction was successfully processed into a consensus state. Receipts are generated by default and are persisted for 3 minutes. Receipts are free.
* **Records:** Records provide greater detail about the transaction than do receipts — such as the consensus timestamp it received or the results of a smart contract function call. Records are generated by default but are persisted for 3 minutes.
* **State proofs (coming soon):** When querying for a record, a client can optionally indicate that it desires the network to return a state proof in addition to the record. A state-proof documents network consensus on the contents of that record in the consensus state — this collective assertion includes signatures of most of the network nodes. Because state proofs are cryptographically signed by a supermajority of the network, they are secure and potentially admissible in a court of law.

{% content-ref url="../../sdks-and-apis/rest-api/" %}
[rest-api](../../sdks-and-apis/rest-api/)
{% endcontent-ref %}

For a more detailed review of the confirmation methods, please check out this [blog post](https://www.hedera.com/blog/transaction-confirmation-methods-in-hedera).

## FAQ

<details>

<summary><strong>What are the transaction and query fees associated with using Hedera?</strong></summary>

You can refer to the fees page on Hedera's website for a detailed breakdown of transaction and query costs. If you're looking for an estimation tool, you can use the [Hedera fee estimator](https://hedera.com/fees).

</details>

<details>

<summary><strong>What are transactions?</strong></summary>

Transactions are requests sent by a client to a node with the expectation that they are submitted to the network for processing into consensus order and subsequent application to state. Each transaction has a unique transaction ID composed of the transaction's valid start time and the account ID of the account that is paying for the transaction. This ID is used for obtaining receipts, records, and state proofs and for detecting when duplicate transactions are submitted.

</details>

<details>

<summary><strong>What are queries?</strong></summary>

Queries are requests processed only by the single node to which they are sent. [Clients](../../support-and-community/glossary.md#client) send queries to retrieve some aspect of the current consensus state, like the balance of an account. Certain queries are free, but generally, queries are subject to fees.

</details>

<details>

<summary><strong>What is the difference between receipts and records?</strong></summary>

Receipts provide minimal information - whether or not the transaction was successfully processed into a consensus state. Records provide greater detail about the transaction than receipts, such as the consensus timestamp it received or the results of a smart contract function call.

</details>

<details>

<summary><strong>What is the batch transaction size limit?</strong></summary>

The batch transaction size limits are:

* **Number of transactions**: The maximum number of transactions in a batch is limited to 50 inner transactions.
* **Total size**: The maximum size of the batch transaction must not exceed 6KB, including all inner transactions.
* **Time constraint**: All inner transactions must execute within the standard transaction valid duration (typically 3 minutes).

These limits are designed to ensure that batch transactions can be processed efficiently by the network while still providing enough capacity for complex transaction flows. The 50-transaction limit and 6KB size limit help prevent network congestion, while the time constraint ensures that all operations complete within a reasonable timeframe.

</details>

<details>

<summary><strong>What are batch transactions and why should I use them?</strong></summary>

Batch transactions allow multiple operations to be executed atomically in a single network transaction. All operations either succeed together or fail together, providing ACID properties (Atomicity, Consistency, Isolation, and Durability).

You should use batch transactions when:

* You need to ensure multiple operations succeed or fail as a unit
* You want to reduce the complexity of managing multiple separate transactions
* You need to perform operations that logically belong together (like unfreezing an account, transferring tokens, and freezing it again)
* You want to reduce overall transaction fees compared to submitting multiple individual transactions

</details>

<details>

<summary><strong>How are fees handled in batch transactions?</strong></summary>

Batch transactions have a specific fee structure:

* The outer batch transaction has its own fee (node + network), paid by the batch transaction's payer
* Each inner transaction pays its own fee (node + network + service), paid by each inner transaction's payer
* Inner transactions are charged even if the batch fails
* The total cost will typically be less than submitting each transaction individually

This means different accounts can pay for different parts of the batch, allowing for flexible payment arrangements.

</details>

<details>

<summary><strong>What is a <code>BatchKey</code> and why is it required?</strong></summary>

A BatchKey is a key that must sign the outer batch transaction and is set on each inner transaction. It serves several critical purposes:

* **Security**: Ensures that batch transactions can only be submitted as a whole and prevents tampering with the batch
* **Authorization**: Signals the trusted entity who can finalize the batch
* **Integrity**: Guarantees that the inner transactions haven't been modified after being prepared for the batch

Every inner transaction must have a BatchKey set, and the outer batch transaction must be signed by all BatchKeys specified in the inner transactions.

</details>

<details>

<summary><strong>How do I properly prepare transactions for a batch?</strong></summary>

The **recommended way** to prepare transactions for a batch is to use the `batchify()` method:

```javascript
// JavaScript example
const tx = new TransferTransaction()
    .addHbarTransfer(sender, -10)
    .addHbarTransfer(recipient, 10)
    .batchify(client, batchPublicKey);
```

This method automatically:

1. Sets the batch key on the transaction
2. Sets the node account ID to 0.0.0 (required for inner transactions)
3. Freezes the transaction with the provided client
4. Signs the transaction with the client's operator key

The **manual approach** requires multiple steps:

```javascript
// Manual approach - requires multiple steps
const transferTx = new TransferTransaction()
    .addHbarTransfer(sender, -10)
    .addHbarTransfer(recipient, 10)
    .setBatchKey(batchPublicKey)  // Step 1: Set batch key
    .freezeWith(client)           // Step 2: Freeze with client (sets nodeAccountId to 0.0.0)
    .sign(operatorKey);           // Step 3: Sign with operator key
```

Learn more [here](../../sdks-and-apis/sdks/transactions/create-a-batch-transaction.md).

</details>

<details>

<summary><strong>What are the most common errors with batch transactions and how do I fix them?</strong></summary>

<table><thead><tr><th width="300.779541015625">Error</th><th width="58.1761474609375">Code</th><th width="155.0313720703125">Cause</th><th>Solution</th></tr></thead><tbody><tr><td><code>BATCH_LIST_EMPTY</code></td><td>388</td><td>Submitting a batch with no inner transactions</td><td>Add at least one inner transaction to the batch</td></tr><tr><td><code>BATCH_LIST_CONTAINS_DUPLICATES</code></td><td>389</td><td>The batch contains duplicate inner transactions</td><td>Ensure each inner transaction in the batch is unique</td></tr><tr><td><code>BATCH_TRANSACTION_IN_BLACKLIST</code></td><td>390</td><td>An inner transaction is of a type that's not allowed in batches</td><td>Only use allowed transaction types in batches</td></tr><tr><td><code>INNER_TRANSACTION_FAILED</code></td><td>391</td><td>One or more inner transactions failed during execution</td><td>Check the specific error for the inner transaction and fix the issue</td></tr><tr><td><code>BATCH_KEY_SET_ON_NON_INNER_TRANSACTION</code></td><td>393</td><td>BatchKey is set on the outer transaction</td><td>Only set BatchKey on inner transactions, not on the outer batch transaction</td></tr><tr><td><code>INVALID_BATCH_KEY</code></td><td>394</td><td>The BatchKey is missing or invalid</td><td>Ensure all inner transactions have a valid BatchKey set</td></tr><tr><td><code>INVALID_NODE_ACCOUNT_ID</code></td><td>341</td><td>Inner transaction has a nodeAccountID other than 0.0.0</td><td>Use the <code>batchify()</code> method which automatically sets nodeAccountID to 0.0.0</td></tr></tbody></table>

</details>
