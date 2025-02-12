# Schedule Transactions

## Overview

The **Scheduled Transactions endpoints** in the Hedera Mirror Node REST API allows developers to query **scheduled transactions** on the Hedera network. These endpoints are essential for tracking transaction scheduling, execution status, and metadata related to scheduled transactions.

## Endpoints

The following endpoints are available for the Scheduled Transactions object:

| **Endpoint**                 | **Description**                                            |
| ---------------------------- | ---------------------------------------------------------- |
| `GET /api/v1/schedules`      | Retrieves a list of scheduled transactions on the network. |
| `GET /api/v1/schedules/{id}` | Fetches details of a specific scheduled transaction by ID. |

## Schedule Transactions

{% swagger src="https://raw.githubusercontent.com/hashgraph/hedera-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml" path="/api/v1/schedules" method="get" %}
[https://raw.githubusercontent.com/hashgraph/hedera-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml](https://raw.githubusercontent.com/hashgraph/hedera-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml)
{% endswagger %}

#### Response Details <a href="#response-details-1" id="response-details-1"></a>

| Response Item                      | Description                                                                    |
| ---------------------------------- | ------------------------------------------------------------------------------ |
| **schedules**                      | List of schedules                                                              |
| **admin\_key**                     | The admin key on the schedule                                                  |
| **admin\_key\_type**               | The type of key                                                                |
| **admin\_key\_key**                | The admin public key                                                           |
| **consensus\_timestamp**           | The consensus timestamp of when the schedule was created                       |
| **creator\_account\_id**           | The account ID of the creator of the schedule                                  |
| **executed\_timestamp**            | The timestamp at which the transaction that was scheduled was executed at      |
| **memo**                           | A string of characters associated with the memo if set                         |
| **payer\_account\_id**             | The account ID of the account paying for the execution of the transaction      |
| **schedule\_id**                   | The ID of the schedule entity                                                  |
| **signatures**                     | The list of keys that signed the transaction                                   |
| **signatures.public\_key\_prefix** | The signatures public key prefix                                               |
| **signatures.signature**           | The signature of the key that signed the schedule transaction                  |
| **signatures.type**                | The type of signature (ED5519 or ECDSA)                                        |
| **transaction\_body**              | The transaction body of the transaction that was scheduled                     |
| **wait\_for\_expiry**              | Whether or not the schedule transaction specified a specific time to expire by |
| **links.next**                     | Hyperlink to the next page of results                                          |

{% swagger src="https://raw.githubusercontent.com/hashgraph/hedera-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml" path="/api/v1/schedules/{scheduleId}" method="get" %}
[https://raw.githubusercontent.com/hashgraph/hedera-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml](https://raw.githubusercontent.com/hashgraph/hedera-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml)
{% endswagger %}

#### Response Details <a href="#response-details-1" id="response-details-1"></a>

| Response Item                       | Description                                                                    |
| ----------------------------------- | ------------------------------------------------------------------------------ |
| **adminKey**                        | The admin key on the schedule                                                  |
| **adminKey.\_type**                 | The type of key                                                                |
| **adminKey.key**                    | The admin public key                                                           |
| **consensus\_timestamp**            | The consensus timestamp of when the schedule was created                       |
| **creator\_account\_id**            | The account ID of the creator of the schedule                                  |
| **executed\_timestamp**             | The timestamp at which the transaction that was scheduled was executed at      |
| **memo**                            | A string of characters associated with the memo if set                         |
| **payer\_account\_id**              | The account ID of the account paying for the execution of the transaction      |
| **schedule\_id**                    | The ID of the schedule entity                                                  |
| **signatures**                      | The list of keys that signed the transaction                                   |
| **signatures.consensus\_timestamp** | The consensus timestamp at which the signature was added                       |
| **signatures.public\_key\_prefix**  | The signatures public key prefix                                               |
| **signatures.signature**            | The signature of the key that signed the schedule transaction                  |
| **signatures.type**                 | The type of signature (ED5519 or ECDSA)                                        |
| **transaction\_body**               | The transaction body of the transaction that was scheduled                     |
| **wait\_for\_expiry**               | Whether or not the schedule transaction specified a specific time to expire by |
