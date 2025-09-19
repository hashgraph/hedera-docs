# Create an account

### **Create an account using the account create API**

A transaction that creates a Hedera account. A Hedera account is required to interact with any of the Hedera network services as you need an account to pay for all associated transaction/query fees. You can visit the [Hedera Developer Portal](https://portal.hedera.com/register) to create a previewnet or testnet account. You can also use third-party wallets to generate free [mainnet accounts](../../../networks/mainnet/mainnet-access.md). To process an account create transaction, you will need an existing account to pay for the transaction fee. To obtain the new account ID, request the [receipt](../transactions/get-a-transaction-receipt.md) of the transaction.

{% hint style="info" %}
When creating a **new account** using the<mark style="color:purple;">`AccountCreateTransaction()`</mark>API you will need an existing account to pay for the associated transaction fee.
{% endhint %}

**Account Properties**

{% content-ref url="../../../core-concepts/accounts/account-properties.md" %}
[account-properties.md](../../../core-concepts/accounts/account-properties.md)
{% endcontent-ref %}

**Transaction Fees**

* The sender pays for the token association fee and the rent for the first auto-renewal period.
* Please see the transaction and query [fees](../../../networks/mainnet/fees/#transaction-and-query-fees) table for the base transaction fee.
* Please use the [Hedera fee estimator](https://hedera.com/fees) to estimate your transaction fee cost.

**Transaction Signing Requirements**

* The account paying for the transaction fee is required to sign the transaction.

#### Maximum Auto-Associations and Fees

Accounts have a property, `maxAutoAssociations`, and the property's value determines the maximum number of automatic token associations allowed.

<table><thead><tr><th width="162" align="center">Property Value</th><th>Description</th></tr></thead><tbody><tr><td align="center"><code>0</code></td><td>Automatic <strong>token</strong> associations or <strong>token airdrops</strong> are not allowed, and the account must be manually associated with a token. This also applies if the value is less than or equal to <code>usedAutoAssociations</code>.</td></tr><tr><td align="center"><code>-1</code></td><td>Unlimited automatic token associations are allowed, and this is the default for accounts created via <a href="../../../core-concepts/accounts/auto-account-creation.md">auto account creation</a> and for accounts that began as hollow accounts and are now complete. Accounts with <code>-1</code> can receive new tokens without manually associating them. The sender still pays the <code>maxAutoAssociations</code> fee and initial rent for each association.</td></tr><tr><td align="center"><code>> 0</code></td><td>If the value is a positive number (number greater than 0), the number of automatic token associations an account can have is limited to that number.</td></tr></tbody></table>

{% hint style="info" %}
The sender pays the `maxAutoAssociations` fee and the rent for the first auto-renewal period for the association. This is in addition to the typical transfer fees. This ensures the receiver can receive tokens without association and makes it a smoother transfer process.
{% endhint %}

**Reference**: [HIP-904](https://hips.hedera.com/hip/hip-904)

#### Methods

<table><thead><tr><th width="508">Method</th><th width="125.33333333333331">Type</th><th>Requirement</th></tr></thead><tbody><tr><td><code>setKey(&#x3C;key>)</code></td><td>Key</td><td>Required</td></tr><tr><td><code>setAlias(&#x3C;alias>)</code></td><td>EvmAddress</td><td>Optional</td></tr><tr><td><code>setInitialBalance(&#x3C;initialBalance>)</code></td><td>HBar</td><td>Optional</td></tr><tr><td><code>setReceiverSignatureRequired(&#x3C;booleanValue>)</code></td><td>boolean</td><td>Optional</td></tr><tr><td><code>setMaxAutomaticTokenAssociations(&#x3C;amount>)</code></td><td>int</td><td>Optional</td></tr><tr><td><code>setStakedAccountId(&#x3C;stakedAccountId>)</code></td><td>AccountId</td><td>Optional</td></tr><tr><td><code>setStakedNodeId(&#x3C;stakedNodeId>)</code></td><td>long</td><td>Optional</td></tr><tr><td><code>setDeclineStakingReward(&#x3C;declineStakingReward>)</code></td><td>boolean</td><td>Optional</td></tr><tr><td><code>setAccountMemo(&#x3C;memo>)</code></td><td>String</td><td>Optional</td></tr><tr><td><code>setAutoRenewPeriod(&#x3C;autoRenewPeriod>)</code></td><td>Duration</td><td>Disabled</td></tr></tbody></table>

{% hint style="warning" %}
**Account Alias**

If an alias is set during account creation, it becomes [immutable](../../../support-and-community/glossary.md#immutability), meaning it cannot be changed. If you plan to update or rotate keys in the future, do not set the alias at the time of initial account creation. The alias can be set after finalizing all key updates.
{% endhint %}

{% tabs %}
{% tab title="Java" %}
```java
//Create the transaction
AccountCreateTransaction transaction = new AccountCreateTransaction()
    .setKeyWithAlias(ecdsaPublicKey)
    // DO NOT set an alias with your key if you plan to update/rotate keys in the future, Use .setKeyWithoutAlias instead 
    // .setKeyWithoutAlias(ecdsaPublicKey)
    .setInitialBalance(new Hbar(1));

//Submit the transaction to a Hedera network
TransactionResponse txResponse = transaction.execute(client);

//Request the receipt of the transaction
TransactionReceipt receipt = txResponse.getReceipt(client);

//Get the account ID
AccountId newAccountId = receipt.accountId;

System.out.println("The new account ID is " +newAccountId);

//Version 2.0.0
```
{% endtab %}

{% tab title="JavaScript" %}
```javascript
//Create new ECDSA key
const ecdsaPublicKey = PrivateKey.generateECDSA().publicKey

//Create the transaction
const transaction = new AccountCreateTransaction()
    .setKeyWithAlias(ecdsaPublicKey)
    // DO NOT set an alias with your key if you plan to update/rotate keys in the future, Use .setKeyWithoutAlias instead 
    // .setKeyWithoutAlias(ecdsaPublicKey)
    .setInitialBalance(new Hbar(1));

//Sign the transaction with the client operator private key and submit to a Hedera network
const txResponse = await transaction.execute(client);

//Request the receipt of the transaction
const receipt = await txResponse.getReceipt(client);

//Get the account ID
const newAccountId = receipt.accountId;

console.log("The new account ID is " +newAccountId);

//v2.0.5
```
{% endtab %}

{% tab title="Go" %}
```go
//Create the transaction
transaction := hedera.NewAccountCreateTransaction().
        SetKeyWithAlias(ecdsaPublicKey).
        //do not set if you need to rotate keys in the future
        // SetKeyWithoutAlias(ecdsaPublicKey).
        SetInitialBalance(hedera.NewHbar(1))

//Sign the transaction with the client operator private key and submit to a Hedera network
txResponse, err := AccountCreateTransaction.Execute(client)
if err != nil {
    panic(err)
}

//Request the receipt of the transaction
receipt, err := txResponse.GetReceipt(client)
if err != nil {
    panic(err)
}

//Get the account ID
newAccountId := *receipt.AccountID

fmt.Printf("The new account ID is %v\n", newAccountId)

//Version 2.0.0
```
{% endtab %}

{% tab title="Rust" %}
```rust
// Create new ECDSA key
let ecdsa_public_key = PrivateKey::generate_ecdsa().public_key();

// Create the transaction
let transaction = AccountCreateTransaction::new()
    .key_with_alias(ecdsa_public_key)
    // DO NOT set an alias with your key if you plan to update/rotate keys in the future, Use .key_without_alias instead 
    // .key_without_alias(ecdsa_public_key)
    .initial_balance(Hbar::from(1));

// Sign the transaction with the client operator private key and submit to a Hedera network
let tx_response = transaction
    .execute(&client)
    .await?;

// Request the receipt of the transaction
let receipt = tx_response.get_receipt(&client).await?;

// Get the account ID
let new_account_id = receipt.account_id.unwrap();

println!("The new account ID is {}", new_account_id);

// v0.34.0
```
{% endtab %}
{% endtabs %}

#### Get transaction values

| Method                           | Type      | Description                                               |
| -------------------------------- | --------- | --------------------------------------------------------- |
| `getKey()`                       | Key       | Returns the public key on the account                     |
| `getInitialBalance()`            | Hbar      | Returns the initial balance of the account                |
| `getAutoRenewPeriod()`           | Duration  | Returns the auto renew period on the account              |
| `getDeclineStakingReward()`      | boolean   | Returns whether or not the account declined rewards       |
| `getStakedNodeId()`              | long      | Returns the node ID                                       |
| `getStakedAccountId()`           | AccountId | Returns the node account ID                               |
| `getReceiverSignatureRequired()` | boolean   | Returns whether the receiver signature is required or not |

{% tabs %}
{% tab title="Java" %}
```java
//Create an account with 1 hbar
AccountCreateTransaction transaction = new AccountCreateTransaction()
    // The only _required_ property here is `key`
    .setKeyWithAlias(newPublicKey)
    // DO NOT set an alias with your key if you plan to update/rotate keys in the future, Use .setKeyWithoutAlias instead 
    // .setKeyWithoutAlias(newPublicKey)
    .setInitialBalance(new Hbar(1));

//Return the key on the account
Key accountKey = transaction.getKey();
```
{% endtab %}

{% tab title="JavaScript" %}
```javascript
//Create an account with 1 HBAR 
const transaction = new AccountCreateTransaction()
    // The only _required_ property here is `key`
    .setKeyWithAlias(newPublicKey)
    // Do NOT set an alias if you need to rotate keys in the future. Use .setKeyWithoutAlias instead
    // .setKeyWithoutAlias(newPublicKey)
    .setInitialBalance(new Hbar(1));

//Return the key on the account
const accountKey = transaction.getKey();
```
{% endtab %}

{% tab title="Go" %}
```go
//Create an account with 1 hbar
AccountCreateTransaction := hedera.NewAccountCreateTransaction().
    SetKeyWithAlias(newPublicKey).
    // DO NOT set an alias with your key if you plan to update/rotate keys in the future, Use .SetKeyWithoutAlias instead 
    // SetKeyWithoutAlias(newPublicKey).
    SetInitialBalance(hedera.NewHbar(1))

//Return the key on the account
accountKey, err := AccountCreateTransaction.GetKey()
```
{% endtab %}
{% endtabs %}
