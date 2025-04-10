---
description: create a token
---

# Token Properties

Token properties on Hedera define the characteristics, governance, and lifecycle of fungible and non-fungible tokens. These properties are set during token creation and, depending on configuration, can be updated to meet evolving requirements. By specifying token properties, developers gain control over supply, permissions, and other critical aspects of token behavior.

<table><thead><tr><th width="164">Property</th><th>Description</th></tr></thead><tbody><tr><td><strong>Name</strong></td><td>Set the publicly visible name of the token. The token name is specified as a string of UTF-8 characters in Unicode. UTF-8 encoding of this Unicode cannot contain the 0 byte (<code>NUL</code>). The token name is not unique. Maximum of 100 characters.</td></tr><tr><td><strong>Token Type</strong></td><td>The type of token to create. Either fungible (<code>FUNGIBLE_COMMON</code>) or non-fungible(<code>NON_FUNGIBLE_UNIQUE</code>). </td></tr><tr><td><strong>Symbol</strong></td><td>The publicly visible token symbol. Set the publicly visible name of the token. The token symbol is specified as a string of UTF-8 characters in Unicode. UTF-8 encoding of this Unicode cannot contain the 0 byte (<code>NUL</code>). The token symbol is not unique. Maximum of 100 characters.</td></tr><tr><td><strong>Decimal</strong></td><td>The number of decimal places a token is divisible by. This field can never be changed.</td></tr><tr><td><strong>Initial Supply</strong></td><td>Specifies the initial supply of fungible tokens to be put in circulation. The initial supply is sent to the Treasury Account. The maximum supply of tokens is <code>9,223,372,036,854,775,807</code>(<code>2^63-1</code>) tokens and is in the lowest denomination possible. For creating an NFT, you must set the initial supply to 0.</td></tr><tr><td><strong>Treasury Account</strong></td><td>The account which will act as a treasury for the token. This account will receive the specified initial supply and any additional tokens that are minted. If tokens are burned, the supply will decreased from the treasury account.</td></tr><tr><td><strong>Fee Schedule Key</strong></td><td>The key which can change the token's <a href="../../../sdks-and-apis/sdks/token-service/custom-token-fees.md">custom fee</a> schedule. It must sign a TokenFeeScheduleUpdate transaction. A custom fee schedule token without a fee schedule key is immutable.</td></tr><tr><td><strong>Custom Fees</strong></td><td><a href="../../../sdks-and-apis/sdks/token-service/custom-token-fees.md">Custom fees</a> to charge during a token transfer transaction that transfers units of this token. Custom fees can either be <a href="../../../sdks-and-apis/sdks/token-service/custom-token-fees.md#fixed-fee">fixed</a>, <a href="../../../sdks-and-apis/sdks/token-service/custom-token-fees.md#fractional-fee">fractional</a>, or <a href="../../../sdks-and-apis/sdks/token-service/custom-token-fees.md#royalty-fee">royalty</a> fees. You can set up to a maximum of 10 custom fees.</td></tr><tr><td><strong>Max Supply</strong></td><td>For tokens of type <code>FUNGIBLE_COMMON</code> - the maximum number of tokens that can be in circulation.<br>For tokens of type <code>NON_FUNGIBLE_UNIQUE</code> - the maximum number of NFTs (serial numbers) that can be minted. This field can never be changed.<br>You must set the token supply type to FINITE if you set this field.</td></tr><tr><td><strong>Supply Type</strong></td><td>Specifies the token supply type. Defaults to INFINITE.</td></tr><tr><td><strong>Freeze Default</strong></td><td>The default Freeze status (frozen or unfrozen) of Hedera accounts relative to this token. If true, an account must be unfrozen before it can receive the token.</td></tr><tr><td><strong>Expiration Time</strong></td><td>The epoch second at which the token should expire; if an auto-renew account and period are specified, this is coerced to the current epoch second plus the autoRenewPeriod. The default expiration time is 7,890,000 seconds (90 days).</td></tr><tr><td><strong>Auto Renew Account</strong></td><td>An account which will be automatically charged to renew the token's expiration, at autoRenewPeriod interval. This key is required to sign the transaction if present. Currently, rent is not enforced for tokens so auto-renew payments will not be made.</td></tr><tr><td><strong>Auto Renew Period</strong></td><td>The interval at which the auto-renew account will be charged to extend the token's expiry. The default auto-renew period is 7,890,000 seconds. Currently, rent is not enforced for tokens so auto-renew payments will not be made.<br><br><strong>NOTE:</strong> The minimum period of time is approximately 30 days (2592000 seconds) and the maximum period of time is approximately 92 days (8000001 seconds). Any other value outside of this range will return the following error: AUTORENEW_DURATION_NOT_IN_RANGE.</td></tr><tr><td><strong>Memo</strong></td><td>A short publicly visible memo about the token.</td></tr><tr><td><strong>Metadata</strong></td><td>The metadata of the token. The admin key or the metadata key can be used to update this property.</td></tr></tbody></table>

***

## Token Metadata Standard

Metadata enhances the utility and interoperability of tokens by providing additional context about their attributes. Token metadata provides valuable context for a token's characteristics, enhancing its usability, interoperability, and discoverability across different apps. This metadata is particularly important for NFTs (non-fungible tokens) but can also apply to fungible tokens in certain use cases.

#### Common Metadata Fields

* **Name**: The display name of the asset.
* **Description**: A detailed description of the asset.
* **Image URL**: A link to the asset's image or multimedia file.
* **Attributes**: Key-value pairs describing properties like rarity, edition, or category.
* **Royalties**: Details about royalty fees (e.g., a 5% royalty with a fallback fee).

#### Metadata Storage and Standards

Metadata is typically attached during the minting process as a base64-encoded JSON payload, allowing seamless integration with wallets, dApps, and marketplaces. Hedera follows established metadata standards to ensure consistency across platforms. [HIP-412](https://hips.hedera.com/hip/hip-412) defines a structured format for NFT metadata. See the example below.

<details>

<summary><strong>JSON Schema V2 Example (HIP-412)</strong></summary>

```json
{
  "format": "HIP412@2.0.0",
  "name": "Hello",
  "creator": "HGraph Punks",
  "description": "HGraph Punks are a collection of 8,192 randomly generated NFTs that exist on the Hedera network. HGraph Punks holders get access to The H digital bar experience, ability to vote on HGraph Punks decisions, exclusive community events and much more. For more information, visit www.hgraphpunks.com",
  "image": "ipfs://bafybeibrnfa3dc43ukx6ypt4vb3uanbgvqe5jci7ubcmpgvau5shbmzujm/373.png",
  "properties": {
    "edition": {
      "number": 28,
      "set": 1,
      "drop": 2,
      "pack": 14
    },
    "supply": "8192",
    "catalog": ["classic"],
    "extras": [],
    "compiler": "Turtle Moon Tools",
    "category": "HGraph Punks"
  },
  "royalties": {
    "numerator": 5,
    "denominator": 100,
    "fallbackFee": 100
  },
  "attributes": [
    {
      "trait_type": "background",
      "value": "punkyPurple"
    },
    {
      "trait_type": "skin",
      "value": "hederaBlue"
    },
    {
      "trait_type": "tattoos",
      "value": "none"
    },
    {
      "trait_type": "forehead-h",
      "value": "turquoise"
    },
    {
      "trait_type": "earrings",
      "value": "stud_deepTurquoise"
    },
    {
      "trait_type": "necklace",
      "value": "none"
    },
    {
      "trait_type": "eyes",
      "value": "classicEyes_lightBrown"
    },
    {
      "trait_type": "nose",
      "value": "nose3"
    },
    {
      "trait_type": "mouth",
      "value": "tongueOut"
    },
    {
      "trait_type": "hair",
      "value": "braids_pink"
    },
    {
      "trait_type": "extras",
      "value": "none"
    }
  ],
  "files": [
    {
      "uri": "ipfs://bafybeibrnfa3dc43ukx6ypt4vb3uanbgvqe5jci7ubcmpgvau5shbmzujm",
      "type": "image/png",
      "is_default_file": true
    }
  ],
  "localization": {
    "uri": "ipfs://QmWS1VAdMD353A6SDk9wNyvkT14kyCiZrNDYAad4w1tKqT/{locale}.json",
    "default": "en",
    "locales": ["es", "fr"]
  }
}

```

</details>

By adhering to these standards, developers ensure that tokens created on Hedera can be easily indexed, retrieved, and utilized across various dApps and ecosystems.

***

## Additional Resources

* [**How to Structure Token Metadata Using HIP-412 Standard**](https://docs.hedera.com/hedera/tutorials/token/structure-your-token-metadata-using-json-schema-v2)
