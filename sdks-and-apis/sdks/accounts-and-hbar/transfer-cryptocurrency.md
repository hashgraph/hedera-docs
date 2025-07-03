# Transfer cryptocurrency

A transaction that transfers HBAR and tokens between Hedera accounts. You can enter multiple transfers in a single transaction. The net value of HBAR between the sending accounts and receiving accounts must equal zero.

For a CryptoTransferTransactionBody:

{% hint style="warning" %}
* Max of 10 balance adjustments in its HBAR transfer list.
* Max of 10 fungible token balance adjustments across all its token transfer list.
* Max of 10 NFT ownership changes across all its token transfer list.
* Max of 20 balance adjustments or NFT ownership changes implied by a transaction (including custom fees).
* If you are transferring a token with custom fees, only two levels of nesting fees are allowed.
* The sending account is responsible to pay for the custom token fees.
{% endhint %}

**Transaction Fees**

* Please see the transaction and query [fees](../../../networks/mainnet/fees/#transaction-and-query-fees) table for the base transaction fee
* Please use the [Hedera fee estimator](https://hedera.com/fees) to estimate your transaction fee cost

**Spender Account Allowances**

An account can have [another account](approve-an-allowance.md) spend tokens on its behalf. If the delegated spender account is transacting tokens from the owner account that authorized the allowance, the owner account needs to be specified in the transfer transaction by calling one of the following:

* `addApprovedHbarTransfer()`
* `addApprovedTokenTransfer()`
* `addApprovedNftTransfer()`
* `addApprovedTokenTransferWithDecimals()`

The debiting account is the owner's account when using this feature.

{% hint style="info" %}
**Note**: The allowance spender must pay the fee for the transaction.
{% endhint %}

**Transaction Signing Requirements**

* The accounts the tokens are being debited from are required to sign the transaction
  * If an authorized spender account is spending on behalf of the account that owns the tokens then the spending account is required to sign
* The transaction fee-paying account is required to sign the transaction

### Methods

<table><thead><tr><th width="279.3333333333333">Method</th><th width="222">Type</th><th>Description</th></tr></thead><tbody><tr><td><code>addHbarTransfer(&#x3C;accountId>, &#x3C;evmAddress>,  &#x3C;value>)</code></td><td><a href="../specialized-types.md#accountid">AccountId</a>, string, HBAR</td><td>The account involved in the transfer and the number of HBAR.<br><br>The sender and recipient values must net zero.</td></tr><tr><td><code>addTokenTransfer(&#x3C;tokenId>, &#x3C;accountId>, &#x3C;evmAddress>, &#x3C;value>)</code></td><td><a href="../token-service/token-id.md">TokenId</a>, <a href="../specialized-types.md#accountid">AccountId</a>, string, long</td><td>The ID of the token, the account ID involved in the transfer, and the number of tokens to transfer.<br><br>The sender and recipient values must net zero.</td></tr><tr><td><code>addNftTransfer(&#x3C;nftId>, &#x3C;sender>, &#x3C;receiver>)</code></td><td><a href="../token-service/nft-id.md">NftId</a>, <a href="../specialized-types.md">AcountId</a>, <a href="../specialized-types.md#accountid">AccountId</a></td><td>The NFT ID (token + serial number), the sending account, and receiving account.</td></tr><tr><td><code>addTokenTransferWithDecimals(&#x3C;tokenId>, &#x3C;accountId>, &#x3C;value>, &#x3C;int>)</code></td><td><a href="../token-service/token-id.md">TokenId</a>, AccountId, long, decimals</td><td>The ID of the token, the account ID involved in the transfer, the number of tokens to transfer, the decimals of the token.<br><br>The sender and recipient values must net zero.</td></tr><tr><td><code>addApprovedHbarTransfer(&#x3C;ownerAccountId>,&#x3C;amount>)</code></td><td><a href="../specialized-types.md#accountid">AccountId</a>, Hbar</td><td>The owner account ID the spender is authorized to transfer from and the amount.<br>Applicable to allowance transfers only.</td></tr><tr><td><code>addApprovedTokenTransfer(&#x3C;tokenId>, &#x3C;accountId>, &#x3C;value>)</code></td><td><a href="../token-service/token-id.md">TokenId</a>, <a href="../specialized-types.md#accountid">AccountId</a>, long</td><td>The owner account ID and token the spender is authorized to transfer from. The debiting account is the owner account.<br>Applicable to allowance transfers only.<br></td></tr><tr><td><code>addApprovedTokenTransferWithDecimals(&#x3C;tokenId>, &#x3C;accountId>, &#x3C;value>, &#x3C;decimals>)</code></td><td><a href="../token-service/token-id.md">TokenId</a>, <a href="../specialized-types.md#accountid">AccountId</a>, long, int</td><td>The owner account ID and token ID (with decimals) the spender is authorized to transfer from. The debit account is the account ID of the sender.<br>Applicable to allowance transfers only.<br></td></tr><tr><td><code>addApprovedNftTransfer(&#x3C;nftId>,&#x3C;sender>, &#x3C;receiver>)</code></td><td><a href="../token-service/nft-id.md">NftId</a>, <a href="../specialized-types.md">AcountId</a>, <a href="../specialized-types.md#accountid">AccountId</a></td><td>The NFT ID the spender is authorized to transfer. The sender is the owner account and receiver is the receiving account.<br>Applicable to allowance transfers only.</td></tr></tbody></table>

{% tabs %}
{% tab title="Java" %}
```java
// Create a transaction to transfer 1 HBAR 
TransferTransaction transaction = new TransferTransaction()
     .addHbarTransfer(OPERATOR_ID, new Hbar(-1))
     .addHbarTransfer(newAccountId, evmAddress, new Hbar(1));

//Submit the transaction to a Hedera network
TransactionResponse txResponse = transaction.execute(client);

//Request the receipt of the transaction
TransactionReceipt receipt = txResponse.getReceipt(client);

//Get the transaction consensus status
Status transactionStatus = receipt.status;

System.out.println("The transaction consensus status is " +transactionStatus);

//Version 2.0.0
```
{% endtab %}

{% tab title="JavaScript" %}
```javascript
// Create a transaction to transfer 1 HBAR
const transaction = new TransferTransaction()
    .addHbarTransfer(OPERATOR_ID, new Hbar(-1))
    .addHbarTransfer(newAccountId, evmAddress, new Hbar(1));
    
//Submit the transaction to a Hedera network
const txResponse = await transaction.execute(client);

//Request the receipt of the transaction
const receipt = await txResponse.getReceipt(client);

//Get the transaction consensus status
const transactionStatus = receipt.status;

console.log("The transaction consensus status is " +transactionStatus.toString());

//v2.0.0
```
{% endtab %}

{% tab title="Go" %}
```java
// Create a transaction to transfer 1 HBAR
transaction := hedera.NewTransferTransaction().
		AddHbarTransfer(client.GetOperatorAccountID(), hedera.NewHbar(-1)).
		AddHbarTransfer(hedera.AccountID{Account: 3}, hedera.NewHbar(1))

//Submit the transaction to a Hedera network
txResponse, err := transaction.Execute(client)

if err != nil {
    panic(err)
}

//Request the receipt of the transaction
receipt, err := txResponse.GetReceipt(client)

if err != nil {
    panic(err)
}

//Get the transaction consensus status
transactionStatus := receipt.Status

fmt.Printf("The transaction consensus status is %v\n", transactionReceipt.Status)

//Version 2.0.0
```
{% endtab %}

{% tab title="Rust" %}
```rust
// Create the transfer transaction
let transaction = TransferTransaction::new()
    .hbar_transfer(account_id, Hbar::from(-10))
    .hbar_transfer(recipient_id, Hbar::from(10));

// Freeze the transaction for signing, sign with the private key of the account that is sending hbars
let tx_response = transaction
    .freeze_with(&client)?
    .sign(account_key)
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

| Method                | Type                                 | Description                                              |
| --------------------- | ------------------------------------ | -------------------------------------------------------- |
| `getHbarTransfers()`  | Map\<AccountId, Hbar>                | Returns a list of the hbar transfers in this transaction |
| `getTokenTransfers()` | Map\<TokenId, Map\<AccountId, long>> | Returns the list of token transfers in the transaction   |

{% tabs %}
{% tab title="Java" %}
```java
// Create a transaction 
CryptoTransferTransaction transaction = new CryptoTransferTransaction()
    .addSender(OPERATOR_ID, new Hbar(1)
    .addRecipient(newAccountId, new Hbar(1));

//Get transfers
List<Transfer> transfers = transaction.getTransfers();

//v2.0.0
```
{% endtab %}

{% tab title="JavaScript" %}
```javascript
// Create a transaction 
const transaction = new CryptoTransferTransaction()
    .addSender(OPERATOR_ID, new Hbar(1))
    .addRecipient(newAccountId, new Hbar(1));

//Get transfers
const transfers = transaction.getTransfers();

//v2.0.0
```
{% endtab %}

{% tab title="Go" %}
```go
// Create a transaction 
transaction := hedera.NewTransferTransaction().
		AddHbarTransfer(client.GetOperatorAccountID(), hedera.NewHbar(-1)).
		AddHbarTransfer(hedera.AccountID{Account: 3}, hedera.NewHbar(1))
//Get transfers
transfers := transaction.GetTransfers()

//v2.0.0
```
{% endtab %}
{% endtabs %}
