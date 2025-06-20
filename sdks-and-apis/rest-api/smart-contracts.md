# Smart Contracts

## Overview

The **Smart Contracts endpoints** in the Hedera Mirror Node REST API allows developers to query **smart contract metadata, execution results, state changes, and logs**. These endpoints are essential for tracking contract interactions, retrieving transaction results, and debugging contract executions on the Hedera network.

## Endpoints

The following endpoints are available for the Smart Contracts object:

| **Endpoint**                                                  | **Description**                                                     |
| ------------------------------------------------------------- | ------------------------------------------------------------------- |
| `GET /api/v1/contracts`                                       | Retrieves a list of smart contract entities on the network.         |
| `GET /api/v1/contracts/{contractIdOrAddress}`                 | Fetches details of a specific contract by ID.                       |
| `GET /api/v1/contracts/results/{transactionIdOrhash}`         | Retrieves execution results for a specific contract transaction ID. |
| `GET /api/v1/contracts/{contractIdOrAddress}/results`         | Retrieves execution results for a specific contract.                |
| `GET /api/v1/contracts/{id}/state`                            | Fetches the state of a contract.                                    |
| `GET /api/v1/contracts/results`                               | Lists execution results for all contracts.                          |
| `GET /api/v1/contracts/results/{transactionIdOrHash}/results` | Get contract actions by transaction ID or transaction hash.         |
| `GET /api/v1/contracts/results/{timestamp}`                   | Retrieves execution results for a contract at a given timestamp.    |
| `GET /api/v1/contracts/logs`                                  | Lists logs emitted from contracts.                                  |
| `GET /api/v1/contracts/{id}/results/logs`                     | Fetches logs for a specific contract.                               |
| `GET /api/v1/contracts/{id}/results/opcodes`                  | Get the opcode traces for historical transactions                   |
| `POST /api/v1/contracts/call`                                 | Invokes a smart contract method.                                    |

## Smart Contracts

{% openapi-operation spec="mainnet" path="/api/v1/contracts" method="get" %}
[OpenAPI mainnet](https://mainnet.mirrornode.hedera.com/api/v1/docs/openapi.yml)
{% endopenapi-operation %}

| Response Item                           | Description                                                                                            |
| --------------------------------------- | ------------------------------------------------------------------------------------------------------ |
| **admin\_key**                          | The admin key of the contract, if specified                                                            |
| **auto\_renew\_account**                | The account paying the auto renew fees, if set                                                         |
| **auto\_renew\_period**                 | The period at which the contract auto renews                                                           |
| **bytecode**                            | The bytecode of the contract                                                                           |
| **contract\_id**                        | The contract ID                                                                                        |
| **created\_timestamp**                  | The timestamp the contract was created at                                                              |
| **deleted**                             | Whether or not the contract is deleted                                                                 |
| **evm\_address**                        | The EVM address of the contract                                                                        |
| **expiration\_timestamp**               | The timestamp of when the contract is set to expire                                                    |
| **file\_id**                            | The ID of the file that stored the contract bytecode                                                   |
| **max\_automatic\_token\_associations** | The number of automatic token association slots                                                        |
| **memo**                                | The memo of the contract, if specified                                                                 |
| **obtainer\_id**                        | The ID of the account or contract that will receive any remaining balance when the contract is deleted |
| **permanent\_removal**                  | Set to `true` when the system expires a contract                                                       |
| **proxy\_account\_id**                  | The proxy account ID (disabled)                                                                        |
| **solidity\_address**                   | The solidity address                                                                                   |
| **timestamp**                           | The period for which the attributes are valid for                                                      |



{% openapi-operation spec="mainnet" path="/api/v1/contracts/{contractIdOrAddress}" method="get" %}
[OpenAPI mainnet](https://mainnet.mirrornode.hedera.com/api/v1/docs/openapi.yml)
{% endopenapi-operation %}

{% openapi-operation spec="mainnet" path="/api/v1/contracts/results" method="get" %}
[OpenAPI mainnet](https://mainnet.mirrornode.hedera.com/api/v1/docs/openapi.yml)
{% endopenapi-operation %}

{% openapi-operation spec="mainnet" path="/api/v1/contracts/results/{transactionIdOrHash}" method="get" %}
[OpenAPI mainnet](https://mainnet.mirrornode.hedera.com/api/v1/docs/openapi.yml)
{% endopenapi-operation %}

{% openapi-operation spec="mainnet" path="/api/v1/contracts/{contractIdOrAddress}/results" method="get" %}
[OpenAPI mainnet](https://mainnet.mirrornode.hedera.com/api/v1/docs/openapi.yml)
{% endopenapi-operation %}

{% openapi-operation spec="mainnet" path="/api/v1/contracts/{contractIdOrAddress}/state" method="get" %}
[OpenAPI mainnet](https://mainnet.mirrornode.hedera.com/api/v1/docs/openapi.yml)
{% endopenapi-operation %}

{% openapi-operation spec="mainnet" path="/api/v1/contracts/results/{transactionIdOrHash}/actions" method="get" %}
[OpenAPI mainnet](https://mainnet.mirrornode.hedera.com/api/v1/docs/openapi.yml)
{% endopenapi-operation %}

{% openapi-operation spec="mainnet" path="/api/v1/contracts/{contractIdOrAddress}/results/{timestamp}" method="get" %}
[OpenAPI mainnet](https://mainnet.mirrornode.hedera.com/api/v1/docs/openapi.yml)
{% endopenapi-operation %}

{% openapi-operation spec="mainnet" path="/api/v1/contracts/{contractIdOrAddress}/results/logs" method="get" %}
[OpenAPI mainnet](https://mainnet.mirrornode.hedera.com/api/v1/docs/openapi.yml)
{% endopenapi-operation %}

{% openapi-operation spec="mainnet" path="/api/v1/contracts/results/logs" method="get" %}
[OpenAPI mainnet](https://mainnet.mirrornode.hedera.com/api/v1/docs/openapi.yml)
{% endopenapi-operation %}

{% openapi-operation spec="mainnet" path="/api/v1/contracts/results/{transactionIdOrHash}/opcodes" method="get" %}
[OpenAPI mainnet](https://mainnet.mirrornode.hedera.com/api/v1/docs/openapi.yml)
{% endopenapi-operation %}

{% openapi-operation spec="mainnet" path="/api/v1/contracts/call" method="post" %}
[OpenAPI mainnet](https://mainnet.mirrornode.hedera.com/api/v1/docs/openapi.yml)
{% endopenapi-operation %}
