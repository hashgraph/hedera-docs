# Get NFT info

A query that returns information about a non-fungible token (NFT). You request the info for an NFT by specifying the NFT ID.

**Token Allowances**

Only when a spender is set on an explicit NFT ID of a token, we return the spender ID in the `TokenNftInfoQuery` for the respective NFT. If  `approveTokenNftAllowanceAllSerials` is used to approve all NFTs for a given token class and no NFT ID is specified, we will not return a spender ID for all the serial numbers of that token.

**Query Fees**

* Please see the transaction and query [fees](../../../networks/mainnet/fees/#transaction-and-query-fees) table for base transaction fee
* Please use the [Hedera fee estimator](https://hedera.com/fees) to estimate your query fee cost

{% hint style="warning" %}
Requesting NFT info by Token ID or Account ID is deprecated.
{% endhint %}

The request returns the following information:

<table><thead><tr><th width="201.48828125">Item</th><th>Description</th></tr></thead><tbody><tr><td><strong>NFT ID</strong></td><td>The unique ID of a non-fungible token composed of the token ID and serial number in the format: <code>&#x3C;shardNum>.&#x3C;realmNum>.&#x3C;tokenNum>/&#x3C;serialNum></code>  (e.g., <code>0.0.1234/1</code>).</td></tr><tr><td><strong>Account ID</strong></td><td>The account ID of the current owner of the NFT</td></tr><tr><td><strong>Creation Time</strong></td><td>The effective consensus timestamp at which the NFT was minted</td></tr><tr><td><strong>Metadata</strong></td><td>Represents the unique metadata of the NFT</td></tr><tr><td><strong>Ledger ID</strong></td><td>The ID of the network (mainnet, testnet, previewnet). Reference <a href="https://hips.hedera.com/hip/hip-198">HIP-198</a>.</td></tr><tr><td><strong>Spender ID</strong></td><td>The spender account ID for the NFT. This is only returned if the NFT ID was specifically approved.</td></tr></tbody></table>

### Methods

<table><thead><tr><th width="235">Method</th><th width="75">Type</th><th width="308">Description</th><th>Requirement</th></tr></thead><tbody><tr><td><code>setNftId(&#x3C;nftId>)</code></td><td><a href="nft-id.md">NftId</a></td><td>Applicable only to tokens of type <code>NON_FUNGIBLE_UNIQUE</code>. Gets info on a NFT for a given TokenID (of type <code>NON_FUNGIBLE_UNIQUE</code>) and serial number.</td><td>Optional</td></tr></tbody></table>

{% tabs %}
{% tab title="Java" %}
```java
//Returns the info for the specified NFT ID
List<TokenNftInfo> nftInfos = new TokenNftInfoQuery()
     .setNftId(nftId)
     .execute(client);

//v2.0.14
```
{% endtab %}

{% tab title="JavaScript" %}
```javascript
//Returns the info for the specified NFT ID
const nftInfos = await new TokenNftInfoQuery()
     .setNftId(nftId)
     .execute(client);

//v2.0.28
```
{% endtab %}

{% tab title="Go" %}
```go
//Returns the info for the specified NFT ID
nftInfo, err := NewTokenNftInfoQuery().
   SetNftID(nftID).
	 Execute(client)

//v2.1.16
```
{% endtab %}

{% tab title="Rust" %}
```rust
// Returns the info for the specified NFT ID
let nft_infos = TokenNftInfoQuery::new()
    .nft_id(nft_id)
    .execute(&client).await?;

// v0.34.0
```
{% endtab %}
{% endtabs %}
