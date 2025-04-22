# Create a topic

A transaction that creates a new topic recognized by the Hedera network. The newly generated topic can be referenced by its `topicId`. The `topicId` is used to identify a unique topic to submit messages to. You can obtain the new topic ID by requesting the receipt of the transaction. All messages within a topic are sequenced with respect to one another and are provided a unique sequence number.

{% hint style="info" %}
#### Note

With the Consensus Node Release [v0.60](../../../networks/release-notes/services.md#release-v0.60), you can set an auto renew account ID without the requirement of setting an admin key on the topic.
{% endhint %}

#### Private topic

You can also create a private topic where only authorized parties can submit messages to that topic. To create a private topic you would need to set the `submitKey` property of the transaction. The `submitKey` value is then shared with the authorized parties and is required to successfully submit messages to the private topic.

#### Topic Properties

| Field                  | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| ---------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Admin Key**          | Access control for updateTopic/deleteTopic. If no adminKey is specified, anyone can increase the topic's expirationTime with updateTopic, but they cannot use deleteTopic. However, if an adminKey is specified, both updateTopic and deleteTopic can be used.                                                                                                                                                                                                                                                                                                                                       |
| **Submit Key**         | Access control for submitMessage. No access control will be performed specified, allowing all message submissions.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| **Topic Memo**         | Store the new topic with a short publicly visible memo. (100 bytes)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| **Auto Renew Account** | <p>At the topic's expirationTime, the optional account can be used to extend the lifetime up to a maximum of the autoRenewPeriod or duration/amount that all funds on the account can extend (whichever is the smaller). <br><br>Currently, rent is not enforced for topics so no auto-renew payments will be made.<br><br><strong>Note:</strong> If the developer does not explicitly set <code>autoRenewAccount</code>, the SDK will automatically default to using the transaction fee payer account ID for the auto renew account. This is beneficial in the event an admin key is not set. </p> |
| **Auto Renew Period**  | <p>The initial lifetime of the topic and the amount of time to attempt to extend the topic's lifetime by automatically at the topic's expirationTime. Currently, rent is not enforced for topics so auto-renew payments will not be made.<br><br><strong>NOTE:</strong> The minimum period of time is approximately 30 days (2592000 seconds) and the maximum period of time is approximately 92 days (8000001 seconds). Any other value outside of this range will return the following error: <code>AUTORENEW_DURATION_NOT_IN_RANGE</code>.</p>                                                    |
| **Fee Schedule Key**   | (Optional) A key that controls updates and deletions of topic fees. **Must be set at creation; cannot be added later via `updateTopic`**.                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| **Fee Exempt Keys**    | (Optional) A list of keys that, if used to sign a message submission, allow the sender to bypass fees. **Can be updated later via `updateTopic`**.                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| **Custom Fees**        | <p>(Optional) A fee structure applied to message submissions for revenue generation. <strong>Can be updated later via <code>updateTopic</code>, but must be signed by the Fee Schedule Key</strong>.<br>Defines a fixed fee required for each message submission to the topic. This fee can be set in HBAR or HTS fungible tokens and applies when messages are submitted.</p>                                                                                                                                                                                                                       |

**Transaction Signing Requirements:**

* If an **Admin Key** is specified, the Admin Key must sign the transaction.
* If no **Admin Key** is specified, the topic is immutable.
* If an **Auto Renew Account** is specified, that account must also sign this transaction.
* If a **Fee Schedule Key** is specified, the Fee Schedule Key must sign the transaction.
* If a Fee Exempt Key List is specified, it contains a list of public keys that are exempt from paying fees when submitting messages to the topic. These keys do not need to sign the transaction.

**Transaction Fees**

* Each **transaction** incurs a **standard Hedera network fee** based on network resource usage.
* If a **custom fee** is set for a topic, users submitting messages must pay this fee in **HBAR or HTS tokens**.
* The **Fee Schedule Key** allows authorized users to update fee structures. If set, it must sign transactions modifying fees.
* Fee exemptions can be granted using the **Fee Exempt Key List**.
* Use the [Hedera Fee Estimator](https://hedera.com/fees) to estimate standard network fees.

#### Methods

<table><thead><tr><th width="338">Method</th><th width="172.33333333333331">Type</th><th>Requirements</th></tr></thead><tbody><tr><td><code>setAdminKey(&#x3C;adminKey>)</code></td><td>Key</td><td>Optional</td></tr><tr><td><code>setSubmitKey(&#x3C;submitKey>)</code></td><td>Key</td><td>Optional</td></tr><tr><td><code>setTopicMemo(&#x3C;memo>)</code></td><td>String</td><td>Optional</td></tr><tr><td><code>setAutoRenewAccountId(&#x3C;accountId>)</code></td><td>AccountId</td><td>Optional</td></tr><tr><td><code>setAutoRenewPeriod(&#x3C;autoRenewPeriod>)</code></td><td>Duration</td><td>Optional</td></tr><tr><td><code>setFeeScheduleKey()</code></td><td>Key</td><td>Optional</td></tr><tr><td><code>setFeeExemptKeys()</code></td><td>List</td><td>Optional</td></tr><tr><td><code>setCustomFees()</code></td><td>List</td><td>Optional</td></tr></tbody></table>

{% tabs %}
{% tab title="Java" %}
```java
//Create the transaction
TopicCreateTransaction transaction = new TopicCreateTransaction()
    .setFeeScheduleKey(feeScheduleKey)
    .setFeeExemptKeys(feeExemptKeys)
    .setCustomFees(customFees);

//Sign with the client operator private key and submit the transaction to a Hedera network
TransactionResponse txResponse = transaction.execute(client);

//Request the receipt of the transaction
TransactionReceipt receipt = txResponse.getReceipt(client);

//Get the topic ID
TopicId newTopicId = receipt.topicId;

System.out.println("The new topic ID is " + newTopicId);

//v2.0.0
```
{% endtab %}

{% tab title="JavaScript" %}
<pre class="language-javascript"><code class="lang-javascript">//Create the transaction
const transaction = new TopicCreateTransaction()
<strong>    .setFeeScheduleKey(feeScheduleKey)
</strong>    .setFeeExemptKeys(feeExemptKeys)
    .setCustomFees(customFees);

//Sign with the client operator private key and submit the transaction to a Hedera network
const txResponse = await transaction.execute(client);

//Request the receipt of the transaction
const receipt = await txResponse.getReceipt(client);

//Get the topic ID
const newTopicId = receipt.topicId;

console.log("The new topic ID is " + newTopicId);

//v2.0.0
</code></pre>
{% endtab %}

{% tab title="Go" %}
<pre class="language-go"><code class="lang-go">//Create the transaction
transaction := hedera.NewTopicCreateTransaction().
<strong>    .setFeeScheduleKey(feeScheduleKey).
</strong>    .setFeeExemptKeys(feeExemptKeys).
    .setCustomFees(customFees)

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

//Get the topic ID
newTopicID := *transactionReceipt.TopicID

fmt.Printf("The new topic ID is %v\n", newTopicID)

//v2.0.0
</code></pre>
{% endtab %}
{% endtabs %}

## Get transaction values

<table><thead><tr><th width="340.3333333333333">Method</th><th width="192">Type</th><th>Requirements</th></tr></thead><tbody><tr><td><code>getAdminKey(&#x3C;adminKey>)</code></td><td>Key</td><td>Optional</td></tr><tr><td><code>getSubmitKey(&#x3C;submitKey>)</code></td><td>Key</td><td>Optional</td></tr><tr><td><code>getTopicMemo(&#x3C;memo>)</code></td><td>String</td><td>Optional</td></tr><tr><td><code>getAutoRenewAccountId()</code></td><td>AccountId</td><td>Required</td></tr><tr><td><code>getAutoRenewPeriod()</code></td><td>Duration</td><td>Required</td></tr><tr><td><code>getFeeScheduleKey()</code></td><td>Key</td><td>Optional</td></tr><tr><td><code>getFeeExemptKeys()</code></td><td>List</td><td>Optional</td></tr><tr><td><code>getCustomFees()</code></td><td>List</td><td>Optional</td></tr></tbody></table>

{% tabs %}
{% tab title="Java" %}
```java
//Create the transaction
TopicCreateTransaction transaction = new TopicCreateTransaction()
    .setFeeScheduleKey(feeScheduleKey);
    
//Get the fee schedule key from the transaction    
Key getFeeScheduleKey = transaction.getFeeScheduleKey();

//V2.0.0
```
{% endtab %}

{% tab title="JavaScript" %}
```javascript
const transaction = new TopicCreateTransaction()
    .setFeeScheduleKey(feeScheduleKey);
    
//Get the fee schedule key from the transaction    
const feeScheduleKey = transaction.getFeeScheduleKey();

//V2.0.0
```
{% endtab %}

{% tab title="Go" %}
```java
transaction := hedera.NewTopicCreateTransaction().
    SetFeeScheduleKey(feeScheduleKey)

getFeeScheduleKey := transaction.GetFeeScheduleKey()


//V2.0.0
```
{% endtab %}
{% endtabs %}
