# Create a token

{% hint style="info" %}
Check out the "Getting Started with the Hedera Token Service" video tutorial in JavaScript [here](https://youtu.be/lp3mwdYEZEk).
{% endhint %}

Create a new fungible or non-fungible token (NFT) on the Hedera network. After you submit the transaction to the Hedera network, you can obtain the new token ID by requesting the receipt.

You can also create, access, or transfer HTS tokens using smart contracts - see [Hedera Service Solidity Libraries](https://docs.hedera.com/guides/docs/sdks/smart-contracts/hedera-service-solidity-libraries) and [Supported ERC Token Standards](https://docs.hedera.com/guides/core-concepts/smart-contracts/supported-erc-token-standards).

{% hint style="warning" %}
#### Token Keys

* If any of the token key types (KYC key, Wipe key, Metadata key, etc) are not set during the creation of the token, you will not be able to update the token and add them in the future
* If any of the token key types (KYC key, Wipe key, Metadata key, etc) are set during the creation of the token, you will not be able to remove them in the future
{% endhint %}

#### **NFTs**

For non-fungible tokens, the token ID represents an NFT class. Once the token is created, you must mint each NFT using the [token mint](mint-a-token.md) operation.

{% hint style="warning" %}
**Note**: The initial supply for an NFT is required to be set to 0.
{% endhint %}

#### **Token Properties**

{% content-ref url="../../../core-concepts/tokens/hedera-token-service-hts-native-tokenization/token-properties.md" %}
[token-properties.md](../../../core-concepts/tokens/hedera-token-service-hts-native-tokenization/token-properties.md)
{% endcontent-ref %}

**Transaction Signing Requirements**

* Treasury key is required to sign
* Admin key, if specified
* Transaction fee payer key

**Transaction Fees**

* For fungible tokens, a [`CryptoTransfer`](https://docs.hedera.com/hedera/mainnet/fees) fee is added to transfer the newly created token to the treasury account
* Please see the transaction and query [fees](../../../networks/mainnet/fees/#transaction-and-query-fees) table for the base transaction fee
* Please use the [Hedera fee estimator](https://hedera.com/fees) to estimate your transaction fee cost

## Methods

<table><thead><tr><th width="447.3333333333333">Method</th><th>Type</th><th>Requirement</th></tr></thead><tbody><tr><td><code>setTokenName(&#x3C;name>)</code></td><td>String</td><td>Required</td></tr><tr><td><code>setTokenType(&#x3C;tokenType>)</code></td><td><a href="token-types.md">TokenType</a></td><td>Optional</td></tr><tr><td><code>setTokenSymbol(&#x3C;symbol>)</code></td><td>String</td><td>Required</td></tr><tr><td><code>setDecimals(&#x3C;decimal>)</code></td><td>int</td><td>Optional</td></tr><tr><td><code>setInitialSupply(&#x3C;initialSupply>)</code></td><td>int</td><td>Optional</td></tr><tr><td><code>setTreasuryAccountId(&#x3C;treasury>)</code></td><td><a href="broken-reference">AccountId</a></td><td>Required</td></tr><tr><td><code>setAdminKey(&#x3C;key>)</code></td><td>Key</td><td>Optional</td></tr><tr><td><code>setKycKey(&#x3C;key>)</code></td><td>Key</td><td>Optional</td></tr><tr><td><code>setFreezeKey(&#x3C;key>)</code></td><td>Key</td><td>Optional</td></tr><tr><td><code>setWipeKey(&#x3C;key>)</code></td><td>Key</td><td>Optional</td></tr><tr><td><code>setSupplyKey(&#x3C;key>)</code></td><td>Key</td><td>Optional</td></tr><tr><td><code>setPauseKey(&#x3C;key>)</code></td><td>Key</td><td>Optional</td></tr><tr><td><code>setFreezeDefault(&#x3C;freeze></code>)</td><td>boolean</td><td>Optional</td></tr><tr><td><code>setExpirationTime(&#x3C;expirationTime>)</code></td><td>Instant</td><td>Optional</td></tr><tr><td><code>setFeeScheduleKey(&#x3C;key>)</code></td><td>Key</td><td>Optional</td></tr><tr><td><code>setCustomFees(&#x3C;customFees>)</code></td><td>List&#x3C;<a href="custom-token-fees.md#custom-fee">CustomFee</a>></td><td>Optional</td></tr><tr><td><code>setSupplyType(&#x3C;supplyType>)</code></td><td>TokenSupplyType</td><td>Optional</td></tr><tr><td><code>setMaxSupply(&#x3C;maxSupply>)</code></td><td>long</td><td>Optional</td></tr><tr><td><code>setTokenMemo(&#x3C;memo>)</code></td><td>String</td><td>Optional</td></tr><tr><td><code>setAutoRenewAccountId(&#x3C;account>)</code></td><td><a href="../accounts-and-hbar/get-account-info.md">AccountId</a></td><td>Optional</td></tr><tr><td><code>setAutoRenewPeriod(&#x3C;period>)</code></td><td>Duration</td><td>Optional</td></tr><tr><td><code>setMetadataKey(&#x3C;key>)</code></td><td>Key</td><td>Optional</td></tr><tr><td><code>setMetadata(&#x3C;bytes>)</code></td><td>bytes</td><td>Optional</td></tr></tbody></table>

{% hint style="info" %}
**Note**: Where the Admin, Pause, Freeze, and Wipe keys are left blank, the Supply key will be required as a minimum.
{% endhint %}

{% tabs %}
{% tab title="Java" %}
```java
//Create the transaction
TokenCreateTransaction transaction = new TokenCreateTransaction()
        .setTokenName("Your Token Name")
        .setTokenSymbol("F")
        .setTreasuryAccountId(treasuryAccountId)
        .setInitialSupply(5000)
        .setAdminKey(adminKey.getPublicKey())
        .setMetadataKey(metadataKey)
        .setMetadata(metadata)
        .setMaxTransactionFee(new Hbar(30)); //Change the default max transaction fee

//Build the unsigned transaction, sign with admin private key of the token, sign with the token treasury private key, submit the transaction to a Hedera network
TransactionResponse txResponse = transaction.freezeWith(client).sign(adminKey).sign(treasuryKey).execute(client);

//Request the receipt of the transaction
TransactionReceipt receipt = txResponse.getReceipt(client);

//Get the token ID from the receipt
TokenId tokenId = receipt.tokenId;

System.out.println("The new token ID is " + tokenId);

//v2.0.1
```
{% endtab %}

{% tab title="JavaScript" %}
```javascript
//Create the transaction and freeze for manual signing
const transaction = await new TokenCreateTransaction()
     .setTokenName("Your Token Name")
     .setTokenSymbol("F")
     .setTreasuryAccountId(treasuryAccountId)
     .setInitialSupply(5000)
     .setAdminKey(adminPublicKey)
     .setMetadataKey(metadataKey)
     .setMetadata(metadata)
     .setMaxTransactionFee(new Hbar(30)) //Change the default max transaction fee
     .freezeWith(client);

//Sign the transaction with the token adminKey and the token treasury account private key
const signTx =  await (await transaction.sign(adminKey)).sign(treasuryKey);

//Sign the transaction with the client operator private key and submit to a Hedera network
const txResponse = await signTx.execute(client);

//Get the receipt of the transaction
const receipt = await txResponse.getReceipt(client);

//Get the token ID from the receipt
const tokenId = receipt.tokenId;

console.log("The new token ID is " + tokenId);

//v2.0.5
```
{% endtab %}

{% tab title="Go" %}
```go
//Create the transaction and freeze the unsigned transaction
tokenCreateTransaction, err := hedera.NewTokenCreateTransaction().
      SetTokenName("Your Token Name").
        SetTokenSymbol("F").
        SetTreasuryAccountID(treasuryAccountId).
        SetInitialSupply(1000).
        SetAdminKey(adminKey).
        SetMetadataKey(metadataKey).
        SetMetadata(metadata)
        SetMaxTransactionFee(hedera.NewHbar(30)). //Change the default max transaction fee
        FreezeWith(client)

if err != nil {
    panic(err)
}

//Sign with the admin private key of the token, sign with the token treasury private key, sign with the client operator private key and submit the transaction to a Hedera network
txResponse, err := tokenCreateTransaction.Sign(adminKey).Sign(treasuryKey).Execute(client)

if err != nil {
    panic(err)
}

//Request the receipt of the transaction
receipt, err := txResponse.GetReceipt(client)
if err != nil {
    panic(err)
}

//Get the token ID from the receipt
tokenId := *receipt.TokenID

fmt.Printf("The new token ID is %v\n", tokenId)

//v2.1.0
```
{% endtab %}
{% endtabs %}
