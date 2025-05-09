# Accounts

## Overview

The **Account** endpoints in the Hedera Mirror Node REST API provides endpoints to retrieve account details, crypto allowances, token relationships, NFTs owned by accounts, and staking reward payouts. These endpoints are crucial for tracking account balances, permissions, and historical activity.

## Endpoints

The following endpoints are available for the Accounts object:

| Endpoint                                                            | Description                                                         |
| ------------------------------------------------------------------- | ------------------------------------------------------------------- |
| `GET /api/v1/accounts`                                              | Retrieves a list of accounts on the network.                        |
| `GET /api/v1/accounts/{idOrAliasOrEvmAddress}`                      | Fetches details of a specific account by ID, alias, or EVM address. |
| `GET /api/v1/accounts/{idOrAliasOrEvmAddress}/allowances/crypto`    | Retrieves hbar allowances granted by an account.                    |
| `GET /api/v1/accounts/{idOrAliasOrEvmAddress}/rewards`              | Gets past staking reward payouts for an account.                    |
| `GET /api/v1/accounts/{idOrAliasOrEvmAddress}/airdrops/outstanding` | Fetches the outstanding token airdrops for a given account.         |
| `GET /api/v1/accounts/{idOrAliasOrEvmAddress}/airdrops/pending`     | Fetech the pending token airdrops for a given account.              |
| `GET /api/v1/accounts/{idOrAliasOrEvmAddress}/allowances/tokens`    | Retrieves token allowances granted by an account.                   |
| `GET /api/v1/accounts/{idOrAliasOrEvmAddress}/allowances/nfts`      | Retrieves nft allowances granted by an account.                     |
| `GET /api/v1/accounts/{idOrAliasOrEvmAddress}/nfts`                 | Fetches the nfts for an account.                                    |

## Accounts <a href="#accounts" id="accounts"></a>

The **accounts** object represents the information associated with an account and returns a list of account information.‌

Account IDs take the following format: **0.0.\<account number>**.‌

Example: 0.0.1000‌

Account IDs can also take the account number as an input value. For example, for account ID 0.0.1000, the number 1000 can be specified in the request.



{% openapi-operation spec="mainnet" path="/api/v1/accounts" method="get" %}
[Broken link](broken-reference)
{% endopenapi-operation %}

#### Response Details <a href="#response-details" id="response-details"></a>

| Response Item                           | Description                                                                            |
| --------------------------------------- | -------------------------------------------------------------------------------------- |
| **account**                             | The ID of the account                                                                  |
| **alias**                               | RFC4648 no-padding base32 encoded account alias                                        |
| **auto\_renew\_period**                 | The period in which the account will auto renew                                        |
| **balance**                             | The timestamp and account balance of the account                                       |
| **created\_timestamp**                  | The timestamp for the creation of that account                                         |
| **decline\_reward**                     | Whether or not the account has opted to decline a staking reward                       |
| **deleted**                             | Whether the account was deleted or not                                                 |
| **ethereum\_nonce**                     | The ethereum transaction nonce associated with this account                            |
| **evm\_address**                        | A network entity encoded as an EVM encoded hex                                         |
| **expiry\_timestamp**                   | The expiry date for the entity as set by a create or update transaction                |
| **key**                                 | The public key associated with the account                                             |
| **links.next**                          | Hyperlink to the next page of results                                                  |
| **max\_automatic\_token\_associations** | The number of automatic token associations, if any                                     |
| **memo**                                | The account memo, if any                                                               |
| **nfts**                                | List of nfts informations belonging to this account                                    |
| **pending\_reward**                     | The account's pending staking reward that has not been transferred to the account      |
| **receiver\_sig\_required**             | Whether or not the account requires a signature to receive a transfer into the account |
| **rewards**                             | List of rewards which of the account                                                   |
| **staked\_account\_id**                 | The account ID the account is staked to, if set                                        |
| **staked\_node\_id**                    | The node ID the account is staked to, if set                                           |
| **stake\_period\_start**                | The start of the staking period                                                        |
| **tokens**                              | The tokens and their balances associated to the specified account                      |

#### Optional Filtering <a href="#optional-filtering" id="optional-filtering"></a>

| Operator                               | Example                                                                                               | Description                                                                                                 |
| -------------------------------------- | ----------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------- |
| `lt` (less than)                       | `/api/v1/accounts?account.id=lt:0.0.1000`                                                             | Returns account IDs less then 1000                                                                          |
| `lte` (less than or equal to)          | `/api/v1/accounts?account.id=lte:0.0.1000`                                                            | Returns account IDs less than or equal to 1000                                                              |
| `gt` (greater than)                    | `/api/v1/accounts?account.id=gt:0.0.1000`                                                             | Returns account IDs greater than 1000                                                                       |
| `gte` (greater than or equal to)       | `/api/v1/accounts?account.id=gte:0.0.1000`                                                            | Returns account IDs greater than or equal to 1000                                                           |
| `order` (order `asc` or `desc` values) | <p><code>/api/v1/accounts?order=asc</code></p><p>​</p><p><code>/api/v1/accounts?order=desc</code></p> | <p>Returns account information in ascending order</p><p>Returns account information in descending order</p> |

#### Additional Examples <a href="#additional-examples" id="additional-examples"></a>

| Example Requests                                                                                       | Description                                                                                                     |
| ------------------------------------------------------------------------------------------------------ | --------------------------------------------------------------------------------------------------------------- |
| `/api/v1/accounts?account.id=0.0.1001`                                                                 | Returns the account information of account 1001                                                                 |
| `/api/v1/accounts?account.balance=gt:1000`                                                             | Returns all account information that have a balance greater than 1000 tinybars                                  |
| `/api/v1/accounts?account.publickey=2b60955bcbf0cf5e9ea880b52e5b63f664b08edf6ed 15e301049517438d61864` | Returns all account information for 2b60955bcbf0cf5e9ea880b52e5b63f664b08edf6ed15e301049517438d61864 public key |
| `/api/v1/accounts/2?transactionType=cryptotransfer`                                                    | Returns the crypto transfer transactions for account 2.                                                         |



{% openapi-operation spec="mainnet" path="/api/v1/accounts/{idOrAliasOrEvmAddress}" method="get" %}
[Broken link](broken-reference)
{% endopenapi-operation %}



{% openapi-operation spec="mainnet" path="/api/v1/accounts/{idOrAliasOrEvmAddress}/allowances/crypto" method="get" %}
[Broken link](broken-reference)
{% endopenapi-operation %}

{% openapi-operation spec="mainnet" path="/api/v1/accounts/{idOrAliasOrEvmAddress}/rewards" method="get" %}
[Broken link](broken-reference)
{% endopenapi-operation %}

{% openapi-operation spec="mainnet" path="/api/v1/accounts/{idOrAliasOrEvmAddress}/tokens" method="get" %}
[Broken link](broken-reference)
{% endopenapi-operation %}

{% openapi-operation spec="mainnet" path="/api/v1/accounts/{idOrAliasOrEvmAddress}/airdrops/outstanding" method="get" %}
[Broken link](broken-reference)
{% endopenapi-operation %}

{% openapi-operation spec="mainnet" path="/api/v1/accounts/{idOrAliasOrEvmAddress}/airdrops/pending" method="get" %}
[Broken link](broken-reference)
{% endopenapi-operation %}

{% openapi-operation spec="mainnet" path="/api/v1/accounts/{idOrAliasOrEvmAddress}/allowances/tokens" method="get" %}
[Broken link](broken-reference)
{% endopenapi-operation %}

{% openapi-operation spec="mainnet" path="/api/v1/accounts/{idOrAliasOrEvmAddress}/allowances/nfts" method="get" %}
[Broken link](broken-reference)
{% endopenapi-operation %}

{% openapi-operation spec="mainnet" path="/api/v1/accounts/{idOrAliasOrEvmAddress}/nfts" method="get" %}
[Broken link](broken-reference)
{% endopenapi-operation %}

