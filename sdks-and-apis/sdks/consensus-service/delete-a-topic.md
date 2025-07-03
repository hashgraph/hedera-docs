# Delete a topic

A transaction that deletes a topic from the Hedera network. Once a topic is deleted, the topic cannot be recovered to receive messages and all submitMessage calls will fail. Older messages can still be accessed, even after the topic is deleted, via the mirror node.

**Transaction Signing Requirements**

* If the adminKey was set upon the creation of the topic, the adminKey is required to sign to successfully delete the topic.
* If no adminKey was set upon the creating of the topic, you cannot delete the topic and will receive an UNAUTHORIZED error.

#### Methods

<table><thead><tr><th width="264">Method</th><th>Type</th><th>Description</th><th>Requirement</th></tr></thead><tbody><tr><td><code>setTopicId(&#x3C;topicId>)</code></td><td>TopicId</td><td>The ID of the topic to delete</td><td>Required</td></tr></tbody></table>

{% tabs %}
{% tab title="Java" %}
```java
//Create the transaction
TopicDeleteTransaction transaction = new TopicDeleteTransaction()
    .setTopicId(newTopicId);
        
//Sign the transaction with the admin key, sign with the client operator and submit the transaction to a Hedera network, get the transaction ID
TransactionResponse txResponse = transaction.freezeWith(client).sign(adminKey).execute(client);

//Request the receipt of the transaction
TransactionReceipt receipt = txResponse.getReceipt(client);

//Get the transaction consensus status
Status transactionStatus = receipt.status;

System.out.println("The transaction consensus status is " +transactionStatus);

//V2.0.0
```
{% endtab %}

{% tab title="JavaScript" %}
```javascript
//Create the transaction
const transaction = await new TopicDeleteTransaction()
    .setTopicId(newTopicId)
    .freezeWith(client);
        
//Sign the transaction with the admin key
const signTx = await transaction.sign(adminKey);
    
//Sign with the client operator private key and submit to a Hedera network
const txResponse = await signTx.execute(client);

//Request the receipt of the transaction
const receipt = await txResponse.getReceipt(client);

//Get the transaction consensus status
const transactionStatus = receipt.status;

console.log("The transaction consensus status is " +transactionStatus);

//v2.0.5
```
{% endtab %}

{% tab title="Go" %}
```java
//Create the transaction and freeze the transaction to prepare for signing
transaction := hedera.NewTopicDeleteTransaction().
		SetTopicID(topicID).
		FreezeWith(client)
		

//Sign the transaction with the admin key, sign with the client operator and submit the transaction to a Hedera network, get the transaction ID
txResponse, err := transaction.Sign(adminKey).Execute(client)
if err != nil {
		panic(err)
}

//Request the receipt of the transaction
receipt, err = txResponse.GetReceipt(client)
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
// Create the transaction to delete the topic
let transaction = TopicDeleteTransaction::new()
    .topic_id(topic_id);

// Sign the transaction with the admin key
let tx_response = transaction
    .freeze_with(&client)?
    .sign(admin_key)
    .execute(&client).await?;

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

| Method                  | Type    | Description                   | Requirement |
| ----------------------- | ------- | ----------------------------- | ----------- |
| `getTopicId(<topicId>)` | TopicId | The ID of the topic to delete | Required    |

{% tabs %}
{% tab title="Java" %}
```java
//Create the transaction
TopicDeleteTransaction transaction = new TopicDeleteTransaction()
    .setTopicId(newTopicId);

//Get topic ID
TopicId getTopicId = transaction.getTopicId(); 

//v2.0.0
```
{% endtab %}

{% tab title="JavaScript" %}
```java
//Create the transaction
const transaction = new TopicDeleteTransaction()
    .setTopicId(newTopicId);

//Get topic ID
const getTopicId = transaction.getTopicId();

//v2.0.0
```
{% endtab %}

{% tab title="Go" %}
```java
//Create the transaction
transaction := hedera.NewTopicDeleteTransaction().
		SetTopicID(topicID)

//Get topic ID
getTopicId := transaction.GetTopicID()

//v2.0.0
```
{% endtab %}
{% endtabs %}
