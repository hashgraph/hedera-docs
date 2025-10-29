# Create a Batch Transaction

A transaction that allows multiple transactions to be executed atomically in a single network transaction. Batch transactions ensure that all operations either succeed together or fail together, providing ACID properties (atomicity, consistency, isolation, and durability). This feature enables complex transaction flows without requiring smart contracts, simplifying development and offering better user experiences.

When creating a **new batch transaction** using the `BatchTransaction()` API you will need an existing account to pay for the associated transaction fee for both the batch transaction itself and each inner transaction.

{% content-ref url="../../../core-concepts/transactions-and-queries/transaction-properties.md" %}
[transaction-properties.md](../../../core-concepts/transactions-and-queries/transaction-properties.md)
{% endcontent-ref %}

#### Transaction Integrity

* Each inner transaction within a batch is treated as a self-contained transaction.
* If an inner transaction fails, preceding transactions that succeeded will still incur fees, even though their effects are not committed.
* Inner transactions are individually signed regular transactions.

#### Transaction Fees

* The cost to run a batch transaction includes fees for the outer batch transaction and also fees for each inner transaction.
* Outer and inner transactions are charged separately and may have different payers.
* Inner transactions that are processed will be charged the regular fees for their transaction type, even if the batch fails.
* Batch transaction fees are charged regardless of whether the transaction succeeds or fails.

#### Transaction Signing Requirements

* The account paying for the batch transaction fee is required to sign the batch transaction.
* Each inner transaction must be signed by its required signatories.
* The batch transaction must be signed by all `batchKey` keys specified in the included transactions.

#### Limits on Batch Size

* The maximum number of transactions in a batch is limited to 50 transactions.
* The maximum size of the batch transaction must not exceed 6KB, including all inner transactions.
* All inner transactions must execute within the standard transaction valid duration (typically 3 minutes).

## Methods

<table data-full-width="false"><thead><tr><th width="352.8515625">Method</th><th width="193.554931640625" valign="middle">Type</th><th width="179.08642578125" valign="top">Requirement</th></tr></thead><tbody><tr><td><code>setInnerTransactions(&#x3C;transactions>)</code></td><td valign="middle">List&#x3C;Transaction></td><td valign="top">Optional</td></tr><tr><td><code>addInnterTransaction(&#x3C;transaction>)</code></td><td valign="middle">Transaction</td><td valign="top">Optional</td></tr><tr><td><code>setBatchKey(&#x3C;key>)</code></td><td valign="middle">Key</td><td valign="top">Required</td></tr></tbody></table>

## BatchKey Mechanism

The `batchKey` that is set during the creation of an inner transaction is a required signature for the encompassing batch transaction. This key ensures only authorized users can submit the batch and keeps all transactions together. When you set a batchKey, the system automatically marks the transaction as part of a batch by setting `nodeAccountId` to `0.0.0`, which helps the network process it correctly.

{% tabs %}
{% tab title="Java" %}
```java
// Create and execute the batch transaction
BatchTransaction batchTx = new BatchTransaction()
    .addInnerTransaction(mintTx)       // Add first transaction
    .addInnerTransaction(transferTx)   // Add second transaction
    .freezeWith(client)
    .sign(batchKey);              // Sign with the batch key

TransactionResponse txResponse = batchTx.execute(client);

// Request the receipt of the transaction
TransactionReceipt receipt = txResponse.getReceipt(client);

// Get the inner transaction IDs
List<TransactionId> innerTxIds = batchTx.getInnerTransactionIds();

System.out.println("Batch transaction status: " + receipt.status);
for (TransactionId txId : innerTxIds) {
    System.out.println("Inner transaction ID: " + txId);
}
```
{% endtab %}

{% tab title="JavaScript" %}
```javascript
// Create and execute the batch transaction
const batchTx = await new BatchTransaction()
    .addInnerTransaction(mintTx)       // Add first transaction
    .addInnerTransaction(transferTx)   // Add second transaction
    .freezeWith(client)
    .sign(batchKey);              // Sign with the batch key

const txResponse = await batchTx.execute(client);

// Request the receipt of the transaction
const receipt = await txResponse.getReceipt(client);

// Get the inner transaction IDs
const innerTxIds = batchTx.getInnerTransactionIds();

console.log(`Batch transaction status: ${receipt.status}`);
innerTxIds.forEach(txId => {
    console.log(`Inner transaction ID: ${txId}`);
});
```
{% endtab %}

{% tab title="Go" %}
```go
// Create and execute the batch transaction
batchTx := hedera.NewBatchTransaction().
    AddInnerTransaction(mintTx).       // Add first transaction
    AddInnerTransaction(transferTx).   // Add second transaction
    FreezeWith(client)
batchTx.Sign(batchKey)            // Sign with the batch key

txResponse, err := batchTx.Execute(client)
if err != nil {
    panic(err)
}

// Request the receipt of the transaction
receipt, err := txResponse.GetReceipt(client)
if err != nil {
    panic(err)
}

// Get the inner transaction IDs
innerTxIds := batchTx.GetInnerTransactionIDs()

fmt.Printf("Batch transaction status: %v\n", receipt.Status)
for _, txId := range innerTxIds {
    fmt.Printf("Inner transaction ID: %v\n", txId)
}

```
{% endtab %}
{% endtabs %}

{% hint style="success" %}
#### Batchify Helper Method

The `batchify()` method is the recommended way to prepare transactions for inclusion in a batch. This helper method simplifies the process by handling multiple steps in a single call, reducing code complexity and potential errors.

```javascript
.batchify(client, batchPublicKey);
```
{% endhint %}

## Get transaction values

<table><thead><tr><th>Method</th><th width="227.31597900390625">Type</th><th>Description</th></tr></thead><tbody><tr><td><code>getInnerTransactions()</code></td><td>List&#x3C;Transaction></td><td>Returns the list of transactions in the batch</td></tr><tr><td><code>getInnerTransactionIds()</code></td><td>List&#x3C;TransactionId></td><td>Returns the generated IDs of the inner transactions</td></tr><tr><td><code>getBatchKey()</code></td><td>Key</td><td>Returns the batch key on an inner transaction</td></tr></tbody></table>

{% tabs %}
{% tab title="Java" %}
```java
// Create a batch transaction
BatchTransaction transaction = new BatchTransaction()
    .addInnerTransaction(mintTx)
    .addInnerTransaction(transferTx);

// Return the transactions in the batch
List<Transaction> transactions = transaction.getTransactions();

// Get the inner transaction IDs (only available after execution)
List<TransactionId> innerTxIds = transaction.getInnerTransactionIds();

```
{% endtab %}

{% tab title="JavaScript" %}
```go
// Create a batch transaction
const transaction = new BatchTransaction()
    .addTransaction(mintTx)
    .addTransaction(transferTx);

// Return the transactions in the batch
const transactions = transaction.getTransactions();

// Get the inner transaction IDs (only available after execution)
const innerTxIds = transaction.getInnerTransactionIds();

```
{% endtab %}

{% tab title="Go" %}
```go
// Create a batch transaction
transaction := hedera.NewBatchTransaction().
    AddTransaction(mintTx).
    AddTransaction(transferTx)

// Return the transactions in the batch
transactions := transaction.GetTransactions()

// Get the inner transaction IDs (only available after execution)
innerTxIds := transaction.GetInnerTransactionIDs()

```
{% endtab %}
{% endtabs %}
