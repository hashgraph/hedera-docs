# Delete a schedule transaction

A `ScheduleDeleteTransaction` is a consensus node transaction that removes a scheduled transaction from the network. A scheduled transaction can only be deleted if an admin key was set during its creation. If no admin key was set, any attempt to delete it will result in a `SCHEDULE_IS_IMMUTABLE` response from the network. Once successfully deleted, the scheduled transaction will be marked as deleted, and the consensus timestamp of the deletion will be recorded.

**Transaction Signing Requirements**

* The signature of the admin key

**Transaction Properties**

| Field           | Description                        |
| --------------- | ---------------------------------- |
| **Schedule ID** | The ID of the schedule transaction |

## Methods

<table><thead><tr><th width="331.3333333333333">Method</th><th width="145">Type</th><th>Requirement</th></tr></thead><tbody><tr><td><code>setScheduleId(&#x3C;scheduleId>)</code></td><td>ScheduleId</td><td>Required</td></tr></tbody></table>

{% tabs %}
{% tab title="Java" %}
```java
//Create the transaction and sign with the admin key
ScheduleDeleteTransaction transaction = new ScheduleDeleteTransaction()
     .setScheduleId(scheduleId)
     .freezeWith(client)
     .sign(adminKey);

//Sign with the operator key and submit to a Hedera network
TransactionResponse txResponse = transaction.execute(client);

//Get the transaction receipt
TransactionReceipt receipt = txResponse.getReceipt(client);

//Get the transaction status
Status transactionStatus = receipt.status;
System.out.println("The transaction consensus status is " +transactionStatus);
```
{% endtab %}

{% tab title="JavaScript" %}
```javascript
//Create the transaction and sign with the admin key
const transaction = await new ScheduleDeleteTransaction()
     .setScheduleId(scheduleId)
     .freezeWith(client)
     .sign(adminKey);

//Sign with the operator key and submit to a Hedera network
const txResponse = await transaction.execute(client);

//Get the transaction receipt
const receipt = await txResponse.getReceipt(client);

//Get the transaction status
const transactionStatus = receipt.status;
console.log("The transaction consensus status is " +transactionStatus);
```
{% endtab %}

{% tab title="Go" %}
```go
//Create the transaction and freeze the unsigned transaction
transaction, err := hedera.NewScheduleDeleteTransaction()
            SetScheduleID(scheduleId).
            FreezeWith(client)

if err != nil {
    panic(err)
}

//Sign with the admin key, sign with the client operator private key and submit the transaction to a Hedera network
txResponse, err := transaction.Sign(adminKey).Execute(client)

if err != nil {
    panic(err)
}

//Request the receipt of the transaction
receipt, err := txResponse.GetReceipt(client)

if err != nil {
    panic(err)
}

//Get the transaction consensus status
status:= *receipt.Status

fmt.Printf("The transaction consensus status is %v\n", status)
```
{% endtab %}

{% tab title="Rust" %}
```rust
// Create the transaction and sign with the admin key
let transaction = ScheduleDeleteTransaction::new()
    .schedule_id(schedule_id)
    .freeze_with(&client)?
    .sign(admin_key);

// Sign with the operator key and submit to a Hedera network
let tx_response = transaction.execute(&client).await?;

// Get the transaction receipt
let receipt = tx_response.get_receipt(&client).await?;

// Get the transaction status
let status = receipt.status;
println!("The transaction consensus status is {:?}", status);

// v0.34.0
```
{% endtab %}
{% endtabs %}
