# Update a topic

A transaction that updates the properties of an existing topic. This includes the topic memo, admin key, submit key, auto-renew account, auto-renew period and fee-related fields.

#### Topic Properties

<table><thead><tr><th width="332">Field</th><th>Description</th></tr></thead><tbody><tr><td><strong>Topic ID</strong></td><td>Update the topic ID</td></tr><tr><td><strong>Admin Key</strong></td><td>Set a new admin key that authorizes update topic and delete topic transactions.</td></tr><tr><td><strong>Submit Key</strong></td><td>Set a new submit key for a topic that authorizes sending messages to this topic.</td></tr><tr><td><strong>Topic Memo</strong></td><td>Set a new short publicly visible memo on the new topic and is stored with the topic. (100 bytes)</td></tr><tr><td><strong>Auto Renew Account</strong></td><td>Set a new auto-renew account ID for this topic. Currently, rent is not enforced for topics so auto-renew payments will not be made.</td></tr><tr><td><strong>Auto Renew Period</strong></td><td>Set a new auto-renew period for this topic. Currently, rent is not enforced for topics so auto-renew payments will not be made.<br><br><strong>NOTE:</strong> The minimum period of time is approximately 30 days (2592000 seconds) and the maximum period of time is approximately 92 days (8000001 seconds). Any other value outside of this range will return the following error: AUTORENEW_DURATION_NOT_IN_RANGE.</td></tr><tr><td><strong>Fee Schedule Key</strong></td><td>(Optional) A key that controls updates and deletions of topic fees. <strong>Must be set at creation; cannot be added later via <code>updateTopic</code></strong>.</td></tr><tr><td><strong>Fee Exempt Keys</strong></td><td>(Optional) A list of keys that, if used to sign a message submission, allow the sender to bypass fees. <strong>Can be updated later via <code>updateTopic</code></strong>.</td></tr><tr><td><strong>Custom Fees</strong></td><td>(Optional) A fee structure applied to message submissions for revenue generation. <strong>Can be updated later via <code>updateTopic</code>, but must be signed by the Fee Schedule Key</strong>.<br>Defines a fixed fee required for each message submission to the topic. This fee can be set in HBAR or HTS fungible tokens and applies when messages are submitted.</td></tr></tbody></table>

**Transaction Signing Requirements**

* If an admin key is updated, the transaction must be signed by the pre-update admin key and post-update admin key.
* If the admin key was set during the creation of the topic, the admin key must sign the transaction to update any of the topic's properties.
* If no `adminKey` was defined during the creation of the topic, you can only extend the expirationTime.
* If a `TopicUpdateTransaction` updates the fee schedule, the Fee Schedule Key must sign the transaction. If the Fee Schedule Key is being updated, both the existing (old) and the new Fee Schedule Key must sign the transaction.

**Transaction Fees**

* Each **transaction** incurs a **standard Hedera network fee** based on network resource usage.
* If a **custom fee** is set for a topic, users submitting messages must pay this fee in **HBAR or HTS tokens**.
* The **Fee Schedule Key** allows authorized users to update fee structures. If set, it must sign transactions modifying fees.
* Fee exemptions can be granted using the **Fee Exempt Key List**.
* Use the [Hedera Fee Estimator](https://hedera.com/fees) to estimate standard network fees.

#### Methods

<table><thead><tr><th width="416.3333333333333">Method</th><th width="148">Type</th><th>Requirements</th></tr></thead><tbody><tr><td><code>setTopicId(&#x3C;topicId>)</code></td><td>TopicId</td><td>Required</td></tr><tr><td><code>setAdminKey(&#x3C;adminKey>)</code></td><td>Key</td><td>Optional</td></tr><tr><td><code>setSubmitKey(&#x3C;submitKey>)</code></td><td>Key</td><td>Optional</td></tr><tr><td><code>setExpirationTime(&#x3C;expirationTime>)</code></td><td>Instant</td><td>Optional</td></tr><tr><td><code>setTopicMemo(&#x3C;memo>)</code></td><td>String</td><td>Optional</td></tr><tr><td><code>setAutoRenewAccountId(&#x3C;accountId>)</code></td><td>AccountId</td><td>Optional</td></tr><tr><td><code>setAutoRenewPeriod(&#x3C;autoRenewPeriod>)</code></td><td>Duration</td><td>Optional</td></tr><tr><td><code>setFeeScheduleKey()</code></td><td>Key</td><td>Optional</td></tr><tr><td><code>setFeeExemptKeys()</code></td><td>List</td><td>Optional</td></tr><tr><td><code>setCustomFees()</code></td><td>List</td><td>Optional</td></tr><tr><td><code>clearAdminKey()</code></td><td></td><td>Optional</td></tr><tr><td><code>clearSubmitKey()</code></td><td></td><td>Optional</td></tr><tr><td><code>clearTopicMemo()</code></td><td></td><td>Optional</td></tr><tr><td><code>clearAutoRenewAccountId()</code></td><td></td><td>Optional</td></tr></tbody></table>

{% tabs %}
{% tab title="Java" %}
```java
// Update a topic to set new custom fees
TopicUpdateTransaction transaction = new TopicUpdateTransaction()
    .setTopicId(topicId)              // Set the topic ID to update
    .setCustomFees(newCustomFees)      // Set the new list of custom fees
    .freezeWith(client)                // Freeze the transaction

    // Sign with the Fee Schedule Key to authorize fee changes
    .sign(feeScheduleKey);

// Submit the transaction to the Hedera network
TransactionResponse txResponse = transaction.execute(client);

// Request the receipt of the transaction
TransactionReceipt receipt = txResponse.getReceipt(client);

// Get the transaction consensus status
Status transactionStatus = receipt.status;

System.out.println("The transaction consensus status is " + transactionStatus);

// v2.0.0
```
{% endtab %}

{% tab title="JavaScript" %}
```javascript
// Update a topic with new custom fees
const transaction = await new TopicUpdateTransaction()
    .setTopicId(topicId)
    .setCustomFees(newCustomFees)
    .freezeWith(client)
    .sign(feeScheduleKey);

// Sign with the Fee Schedule Key to authorize fee changes
const signTx = await transaction.sign(feeScheduleKey);

// Submit the transaction to the Hedera network
const txResponse = await signTx.execute(client);

// Request the receipt of the transaction
const receipt = await txResponse.getReceipt(client);

//Get the transaction consensus status
const transactionStatus = receipt.status;

console.log("The transaction consensus status is " +transactionStatus);


//v2.0.0
```
{% endtab %}

{% tab title="Go" %}
```java
//Create the transaction
transaction := hedera.NewTopicUpdateTransaction().
		SetTopicId(topicId).
		SetFeeScheduleKey(newFeeScheduleKey).
		SetFeeExemptKeys(newFeeExemptKeys).
		SetCustomFees(newCustomFees)

// Sign with the Fee Schedule Key to authorize fee changes
txResponse, err := transaction.Sign(feeScheduleKey).Execute(client)
if err != nil {
    panic(err)
}

// Request the receipt of the transaction
receipt, err := txResponse.GetReceipt(client)
if err != nil {
    panic(err)
}

// Get the transaction consensus status
transactionStatus := receipt.Status

fmt.Printf("Transaction Status: %v\n", transactionStatus)

//v2.0.0
```
{% endtab %}

{% tab title="Rust" %}
```rust
// Create the transaction to update the topic
let transaction = TopicUpdateTransaction::new()
    .topic_id(topic_id)
    .topic_memo("Updated topic memo")
    .admin_key(new_admin_key)
    .submit_key(new_submit_key)
    .auto_renew_period(Duration::hours(24 * 30)); // 30 days

// Sign the transaction with the admin key
let tx_response = transaction
    .freeze_with(&client)?
    .sign(admin_key)?
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

<table><thead><tr><th width="336">Method</th><th width="234.33333333333331">Type</th><th>Requirements</th></tr></thead><tbody><tr><td><code>getTopicId()</code></td><td>TopicId</td><td>Required</td></tr><tr><td><code>getAdminKey()</code></td><td>Key</td><td>Optional</td></tr><tr><td><code>getSubmitKey()</code></td><td>Key</td><td>Optional</td></tr><tr><td><code>getTopicMemo()</code></td><td>String</td><td>Optional</td></tr><tr><td><code>getAutoRenewAccountId()</code></td><td>AccountId</td><td>Required</td></tr><tr><td><code>getAutoRenewPeriod()</code></td><td>Duration</td><td>Required</td></tr><tr><td><code>getFeeScheduleKey()</code></td><td>Key</td><td>Optional</td></tr><tr><td><code>getFeeExemptKeys()</code></td><td>List</td><td>Optional</td></tr><tr><td><code>getCustomFees()</code></td><td>List</td><td>Optional</td></tr></tbody></table>

{% tabs %}
{% tab title="Java" %}
```java
 //Create a transaction to add a submit key
TopicUpdateTransaction transaction = new TopicUpdateTransaction()
    .setSubmitKey(submitKey);

//Get submit key
transaction.getSubmitKey()

//v2.0.0
```
{% endtab %}

{% tab title="JavaScript" %}
```javascript
 //Create a transaction to add a submit key
const transaction = new TopicUpdateTransaction()
    .setSubmitKey(submitKey);

//Get submit key
transaction.getSubmitKey()

//v2.0.0
```
{% endtab %}

{% tab title="Go" %}
```java
//Create the transaction
transaction := hedera.NewTopicUpdateTransaction()
    SetSubmitKey()

transaction := transaction.GetSubmitKey()

//v2.0.0
```
{% endtab %}
{% endtabs %}
