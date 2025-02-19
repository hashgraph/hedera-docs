# Tokens

## Overview

The **Tokens endpoints** in the Hedera Mirror Node REST API allow developers to retrieve token details, token balances, NFT metadata, and transaction history. These endpoints are essential for tracking tokenized assets and interactions on the Hedera network.

## Endpoints

The following endpoints are available for the Tokens object:

| **Endpoint**                                | **Description**                                      |
| ------------------------------------------- | ---------------------------------------------------- |
| `GET /api/v1/tokens`                        | Retrieves a list of all tokens on the network.       |
| `GET /api/v1/tokens/balances`               | Lists token balances across accounts.                |
| `GET /api/v1/tokens/{id}`                   | Fetches details of a specific token by ID.           |
| `GET /api/v1/tokens/nfts`                   | Retrieves a list of all NFTs on the network.         |
| `GET /api/v1/tokens/nfts/{id}`              | Fetches metadata and details for a specific NFT.     |
| `GET /api/v1/tokens/nfts/{id}/transactions` | Retrieves the transaction history of a specific NFT. |
| `GET /api/v1/network/supply`                | Fetches the current total supply of HBAR.            |

## Tokens

{% swagger src="https://raw.githubusercontent.com/hashgraph/hedera-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml" path="/api/v1/tokens" method="get" %}
[https://raw.githubusercontent.com/hashgraph/hedera-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml](https://raw.githubusercontent.com/hashgraph/hedera-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml)
{% endswagger %}

#### Response Details

| Response Item  | Description                                  |
| -------------- | -------------------------------------------- |
| **token\_Id**  | The ID of the token in x.y.z format          |
| **symbol**     | The symbol of the token                      |
| **admin\_key** | The admin key for the token                  |
| **type**       | The type of token (fungible or non-fungible) |

#### Additional Examples

| Example Request                                                                              | Description                                      |
| -------------------------------------------------------------------------------------------- | ------------------------------------------------ |
| `/api/v1/tokens?publickey=3c3d546321ff6f63d70 1d2ec5c277095874e19f4a235bee1e6bb19258bf362be` | All tokens with matching admin key               |
| `/api/v1/tokens?account.id=0.0.8`                                                            | All tokens for matching account                  |
| `/api/v1/tokens?token.id=gt:0.0.1001`                                                        | All tokens in range                              |
| `/api/v1/tokens?order=desc`                                                                  | All tokens in descending order of `token.id`     |
| `/api/v1/tokens?limit=x`                                                                     | All tokens taking the first `x` number of tokens |

{% swagger src="https://raw.githubusercontent.com/hashgraph/hedera-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml" path="/api/v1/tokens/{tokenId}/balances" method="get" %}
[https://raw.githubusercontent.com/hashgraph/hedera-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml](https://raw.githubusercontent.com/hashgraph/hedera-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml)
{% endswagger %}

#### Response Details

| Response Item | Description                                                   |
| ------------- | ------------------------------------------------------------- |
| **timestamp** | The timestamp of the recorded balances in seconds.nanoseconds |
| **balances**  | The balance of the tokens in those accounts                   |
| **account**   | The ID of the account that has the token balance              |
| **balance**   | The balance of the token associated with the account          |

#### Additional Examples

| Example Request                                                     | Description                                      |
| ------------------------------------------------------------------- | ------------------------------------------------ |
| `/api/v1/tokens/<token_id>/balances?order=asc`                      | The balance of the token in ascending order      |
| `/api/v1/tokens/<token_id>/balances?account.id=0.0.1000`            | The balance of the token for account ID 0.0.1000 |
| `/api/v1/tokens/<token_id>/balances?account.balance=gt:1000`        | The balance for the token greater than 1000      |
| `/api/v1/tokens/<token_id>/balances?timestamp=1566562500.040961001` | The token balances for the specified timestamp   |

{% swagger src="https://raw.githubusercontent.com/hashgraph/hedera-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml" path="/api/v1/tokens/{tokenId}" method="get" %}
[https://raw.githubusercontent.com/hashgraph/hedera-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml](https://raw.githubusercontent.com/hashgraph/hedera-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml)
{% endswagger %}

#### Response Details

| Response Item             | Description                                                              |
| ------------------------- | ------------------------------------------------------------------------ |
| **admin\_key**            | The token's admin key, if specified                                      |
| **auto\_renew\_account**  | The auto renew account ID                                                |
| **auto\_renew\_period**   | The period at which the auto renew account will be charged a renewal fee |
| **created\_timestamp**    | The timestamp of when the token was created                              |
| **decimals**              | The number of decimal places a token is divisible by                     |
| **expiry\_timestamp**     | The epoch second at which the token should expire                        |
| **freeze\_default**       | Whether or not accounts created                                          |
| **fee\_schedule\_key**    | The fee schedule key, if any                                             |
| **freeze\_key**           | The freeze key for the token, if specified                               |
| **initial\_suppl**y       | The initial supply of the token                                          |
| **kyc\_key**              | The KYC key for the token, if specified                                  |
| **modified\_timestamp**   | The last time the token properties were modified                         |
| **name**                  | The name of the token                                                    |
| **supply\_key**           | The supply key for the token, if specified                               |
| **symbol**                | The token symbol                                                         |
| **token\_id**             | The token ID                                                             |
| **total\_supply**         | The total supply of the token                                            |
| **treasury\_account\_id** | The treasury account of the token                                        |
| **type**                  | whether a token is a fungible or non-fungible token                      |
| **wipe\_key**             | The wipe key for the token, if specified                                 |
| **custom\_fees**          | The custom fee schedule for the token, if any                            |
| **pause\_key**            | The pause key for a token, if specified                                  |
| **pause\_status**         | Whether or not the token is paused                                       |

{% swagger src="https://raw.githubusercontent.com/hashgraph/hedera-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml" path="/api/v1/tokens/{tokenId}/nfts" method="get" %}
[https://raw.githubusercontent.com/hashgraph/hedera-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml](https://raw.githubusercontent.com/hashgraph/hedera-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml)
{% endswagger %}

#### Response Details

| Response Item           | Description                                           |
| ----------------------- | ----------------------------------------------------- |
| **account\_id**         | The account ID of the account associated with the NFT |
| **created\_timestamp**  | The timestamp of when the NFT was created             |
| **deleted**             | Whether the token was deleted or not                  |
| **metadata**            | The meta data of the NFT                              |
| **modified\_timestamp** | The last time the token properties were modified      |
| **serial\_number**      | The serial number of the NFT                          |
| **token\_id**           | The token ID of the NFT                               |

{% swagger src="https://raw.githubusercontent.com/hashgraph/hedera-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml" path="/api/v1/tokens/{tokenId}/nfts/{serialNumber}" method="get" %}
[https://raw.githubusercontent.com/hashgraph/hedera-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml](https://raw.githubusercontent.com/hashgraph/hedera-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml)
{% endswagger %}

#### Response Details

| Response Item           | Description                                           |
| ----------------------- | ----------------------------------------------------- |
| **account\_id**         | The account ID of the account associated with the NFT |
| **created\_timestamp**  | The timestamp of when the NFT was created             |
| **deleted**             | Whether the token was deleted or not                  |
| **metadata**            | The meta data of the NFT                              |
| **modified\_timestamp** | The last time the token properties were modified      |
| **serial\_number**      | The serial number of the NFT                          |
| **token\_id**           | The token ID of the NFT                               |

{% swagger src="https://raw.githubusercontent.com/hashgraph/hedera-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml" path="/api/v1/tokens/{tokenId}/nfts/{serialNumber}/transactions" method="get" %}
[https://raw.githubusercontent.com/hashgraph/hedera-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml](https://raw.githubusercontent.com/hashgraph/hedera-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml)
{% endswagger %}

#### Response Details

| Response Item             | Description                       |
| ------------------------- | --------------------------------- |
| **created\_timestamp**    | The timestamp of the transaction  |
| **id**                    | The timestamp of the transaction  |
| **receiver\_account\_id** | The account that received the NFT |
| **sender\_account\_id**   | The account that sent the NFT     |
| **type**                  | The type of transaction           |
| **token\_id**             | The token ID of the NFT           |

{% swagger src="https://raw.githubusercontent.com/hashgraph/hedera-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml" path="/api/v1/network/supply" method="get" %}
[https://raw.githubusercontent.com/hashgraph/hedera-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml](https://raw.githubusercontent.com/hashgraph/hedera-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml)
{% endswagger %}
