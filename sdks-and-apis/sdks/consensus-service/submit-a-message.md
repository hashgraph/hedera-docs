# Submit a message

A transaction that submits a topic message to the Hedera network. To access the messages submitted to a topic ID, subscribe to the topic via a mirror node. The mirror node will publish the ordered messages to subscribers. Once the transaction is successfully executed, the receipt of the transaction will include the topic's updated sequence number and topic running hash.

## **Max Chunks**

The **max chunks** setting defines the maximum number of chunks into which a given message can be split. The default value is **20 chunks**, meaning a message can consist of up to 20 chunks by default. This value can be modified using the `setMaxChunks` method.

#### **Max Chunk Size**

{% hint style="info" %}
🚨 **NOTE:** Max size of an HCS message: 1024 bytes (1 kb).
{% endhint %}

The **max chunk size** refers to the maximum size (in bytes) of each individual chunk of a message. By default, the max chunk size is **1024 bytes (1 KB)**. This value can be modified using the `setChunkSize` method.

## **Custom Fee Payment**

If a topic has custom fees enabled, users submitting messages must pay the required fee in **HBAR or HTS fungible tokens**. If `setCustomFees` is not specified in the transaction, the user would need to pay any fee associated with that topic ID. The transaction will only fail if the user does not have sufficient assets to cover the fee.

**Recommendation:** To avoid unexpected fees, it is strongly recommended to use `setCustomFees` when submitting a message. This ensures that only the intended fee structure is applied, providing a safeguard against unintended charges.

```java
TopicMessageSubmitTransaction()
   .setTopicId(<TOPIC_ID>)
   .setMessage(<MESSAGE>)
   .setCustomFees(<MAX_CUSTOM_FEES>) // Ensure this covers the required amount
   .execute(client);
```

## **Transaction Signing Requirements**

* Anyone can submit a message to a public topic.
* The `submitKey` is required to sign the transaction for a private topic.

## **Transaction Fees**

* Each transaction incurs a standard Hedera network fee based on network resource usage.
* If a custom fee is set for a topic, users submitting messages must pay this fee in HBAR or HTS tokens.
* The Fee Schedule Key allows authorized users to update fee structures. If set, it must sign transactions modifying fees.
* If the topic has custom fees, the sender must have sufficient balance to cover the fees unless they are exempt via the Fee Exempt Key List. It is recommended to use `setCustomFees` on the `TopicMessageSubmitTransaction` to ensure the expected fee structure is applied and avoid unexpected transaction failures due to insufficient funds.
* If you submit a message to a topic with a custom fee, the cost changes from the baseline $0.0001 USD to roughly $0.05 USD per `TopicMessageSubmitTransaction`.
* Use the [query fees table](https://docs.hedera.com/hedera/networks/mainnet/fees#consensus-service) for the base transaction fee and the [Hedera Fee Estimator](https://hedera.com/fees) to estimate standard network fees.

{% hint style="danger" %}
### **⚠️ Warning**

Messages submitted to topics that enforce a custom fee have a higher cost ($0.05–$0.06 per message) compared to topics without custom fees (≈$0.0001). Be sure to factor this into your budget when targeting custom-fee topics, as the added complexity and extra compute overhead for custom fees is reflected in the higher transaction cost. Because fees are calculated by kilobyte with up to a 20% buffer, a single `TopicMessageSubmitTransaction` charge may reach a maximum of $0.06.
{% endhint %}

## Methods

<table><thead><tr><th width="298">Method</th><th width="192.37890625">Type</th><th>Description</th><th>Requirement</th></tr></thead><tbody><tr><td><code>setTopicId(&#x3C;topicId>)</code></td><td>TopicId</td><td>The topic ID to submit the message to</td><td>Required</td></tr><tr><td><code>setMessage(&#x3C;message>)</code></td><td>String</td><td>The message in a String format</td><td>Optional</td></tr><tr><td><code>setMessage(&#x3C;message>)</code></td><td>byte [ ]</td><td>The message in a byte array format</td><td>Optional</td></tr><tr><td><code>setMessage(&#x3C;message>)</code></td><td>ByteString</td><td>The message in a ByteString format</td><td>Optional</td></tr><tr><td><code>setChunkSize()</code></td><td>int</td><td>The max size of individual chunk for a given message. Default: 1024 bytes</td><td>Optional</td></tr><tr><td><code>setMaxChunks()</code></td><td>int</td><td>The max number of chunks a given message can be split into. Default: 20</td><td>Optional</td></tr><tr><td><code>setCustomFeeLimits()</code></td><td>List&#x3C;CustomFeeLimit></td><td>The maximum custom fees the sender is willing to pay</td><td>Optional</td></tr><tr><td><code>addCustomFeeLimit()</code></td><td>CustomFeeLimit</td><td>Adds a custom fee limit</td><td>Optional</td></tr></tbody></table>

{% tabs %}
{% tab title="Java" %}
<pre class="language-java"><code class="lang-java">//Create the transaction
TopicMessageSubmitTransaction transaction = new TopicMessageSubmitTransaction()
    .setTopicId(newTopicId)
    .setMessage("hello, HCS! ")
    .setMaxCustomFees(maxCustomFees); // Set max custom fees if applicable

//Sign with the client operator key and submit transaction to a Hedera network, get transaction ID
TransactionResponse txResponse = transaction.execute(client);

//Request the receipt of the transaction
TransactionReceipt receipt = txResponse.getReceipt(client);

//Get the transaction consensus status
Status transactionStatus = receipt.status;

System.out.println("The transaction consensus status is " +transactionStatus);

<strong>//v2.0.0
</strong></code></pre>
{% endtab %}

{% tab title="JavaScript" %}
```javascript
// Create the transaction
const transaction = await new TopicMessageSubmitTransaction()
    .setTopicId(newTopicId)
    .setMessage("Hello, HCS!")
    .setMaxCustomFees(maxCustomFees); // Set max custom fees if applicable

// Execute transaction
const txResponse = await transaction.execute(client);

// Request the receipt
const receipt = await txResponse.getReceipt(client);

// Get the transaction consensus status
console.log("Transaction Status:", receipt.status);

//v2.0.0
```
{% endtab %}

{% tab title="Go" %}
```java
//Create the transaction
transaction := hedera.NewTopicSubmitTransaction().
        SetTopicID(topicID).
        SetMessage([]byte(content)).
        SetMaxCustomFees(maxCustomFees) // Set max custom fees if applicable

//Sign with the client operator private key and submit the transaction to a Hedera network
txResponse, err := transaction.Execute(client)
if err != nil {
        panic(err)
}

//Request the receipt of the transaction
transactionReceipt, err := txResponse.GetReceipt(client)
if err != nil {
        panic(err)
}

//Get the transaction consensus status
transactionStatus := receipt.Status

fmt.Printf("The transaction consensus status is %v\n", transactionStatus)

//v2.0.0
```
{% endtab %}

{% tab title="Rust" %}
```rust
// Create the transaction
let transaction = TopicMessageSubmitTransaction::new()
    .topic_id(topic_id)
    .message("Hello, HCS!")
    .max_custom_fees(max_custom_fees); // Set max custom fees if applicable

// Sign with the client operator key and submit to a Hedera network
let tx_response = transaction.execute(&client).await?;

// Request the receipt of the transaction
let receipt = tx_response.get_receipt(&client).await?;

// Get the transaction consensus status
let status = receipt.status;

println!("The transaction consensus status is {:?}", status);

// v0.34.0
```
{% endtab %}
{% endtabs %}

## Get transaction values

| Method                 | Type       | Description                                      |
| ---------------------- | ---------- | ------------------------------------------------ |
| `getTopicId()`         | TopicId    | The topic ID to submit the message to            |
| `getMessage()`         | ByteString | The message being submitted                      |
| `getCustomFeeLimits()` | Fee\[]     | Extract the custom fee limits of the transaction |

{% tabs %}
{% tab title="Java" %}
```java
//Create the transaction
TopicMessageSubmitTransaction transaction = new TopicMessageSubmitTransaction()
    .setTopicId(newTopicId)
    .setMessage("hello, HCS! ");

//Get the transaction message
ByteString getMessage = transaction.getMessage();
//v2.0.0
```
{% endtab %}

{% tab title="JavaScript" %}
```javascript
//Create the transaction
const transaction = await new TopicMessageSubmitTransaction()
    .setTopicId(newTopicId)
    .setMessage("hello, HCS! ");

//Get the transaction message
const getMessage = transaction.getMessage();

//v2.0.0
```
{% endtab %}

{% tab title="Go" %}
```go
//Create the transaction
transaction := hedera.NewTopicSubmitTransaction().
        SetTopicID(topicID).
        SetMessage([]byte(content))

//Get the transaction message
getMessage := transaction.GetMessage()
//v2.0.0
```
{% endtab %}
{% endtabs %}
