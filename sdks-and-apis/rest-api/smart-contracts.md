# Smart Contracts

## Overview

The **Smart Contracts endpoints** in the Hedera Mirror Node REST API allows developers to query **smart contract metadata, execution results, state changes, and logs**. These endpoints are essential for tracking contract interactions, retrieving transaction results, and debugging contract executions on the Hedera network.

## Endpoints

The following endpoints are available for the Smart Contracts object:

| **Endpoint**                                | **Description**                                                  |
| ------------------------------------------- | ---------------------------------------------------------------- |
| `GET /api/v1/contracts`                     | Retrieves a list of smart contract entities on the network.      |
| `GET /api/v1/contracts/{id}`                | Fetches details of a specific contract by ID.                    |
| `GET /api/v1/contracts/{id}/results`        | Retrieves execution results for a specific contract.             |
| `GET /api/v1/contracts/{id}/state`          | Fetches the latest state of a contract.                          |
| `GET /api/v1/contracts/results`             | Lists execution results for all contracts.                       |
| `GET /api/v1/contracts/results/{timestamp}` | Retrieves execution results for a contract at a given timestamp. |
| `GET /api/v1/contracts/logs`                | Lists logs emitted from contracts.                               |
| `GET /api/v1/contracts/logs/{id}`           | Fetches logs for a specific contract.                            |
| `POST /api/v1/contracts/call`               | Invokes a smart contract method.                                 |

## Smart Contracts

{% swagger src="https://raw.githubusercontent.com/hashgraph/hedera-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml" path="/api/v1/contracts" method="get" %}
[https://raw.githubusercontent.com/hashgraph/hedera-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml](https://raw.githubusercontent.com/hashgraph/hedera-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml)
{% endswagger %}

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

{% swagger src="https://raw.githubusercontent.com/hashgraph/hedera-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml" path="/api/v1/contracts/{contractIdOrAddress}" method="get" %}
[https://raw.githubusercontent.com/hashgraph/hedera-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml](https://raw.githubusercontent.com/hashgraph/hedera-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml)
{% endswagger %}

{% swagger src="https://raw.githubusercontent.com/hashgraph/hedera-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml" path="/api/v1/contracts/{contractIdOrAddress}/results" method="get" %}
[https://raw.githubusercontent.com/hashgraph/hedera-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml](https://raw.githubusercontent.com/hashgraph/hedera-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml)
{% endswagger %}

{% swagger src="https://raw.githubusercontent.com/hashgraph/hedera-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml" path="/api/v1/contracts/{contractIdOrAddress}/state" method="get" %}
[https://raw.githubusercontent.com/hashgraph/hedera-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml](https://raw.githubusercontent.com/hashgraph/hedera-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml)
{% endswagger %}

{% swagger src="https://raw.githubusercontent.com/hashgraph/hedera-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml" path="/api/v1/contracts/{contractIdOrAddress}/results/{timestamp}" method="get" %}
[https://raw.githubusercontent.com/hashgraph/hedera-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml](https://raw.githubusercontent.com/hashgraph/hedera-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml)
{% endswagger %}

{% swagger src="https://raw.githubusercontent.com/hashgraph/hedera-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml" path="/api/v1/contracts/results" method="get" %}
[https://raw.githubusercontent.com/hashgraph/hedera-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml](https://raw.githubusercontent.com/hashgraph/hedera-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml)
{% endswagger %}

{% swagger src="https://raw.githubusercontent.com/hashgraph/hedera-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml" path="/api/v1/contracts/results/{transactionIdOrHash}" method="get" %}
[https://raw.githubusercontent.com/hashgraph/hedera-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml](https://raw.githubusercontent.com/hashgraph/hedera-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml)
{% endswagger %}

{% swagger src="https://raw.githubusercontent.com/hashgraph/hedera-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml" path="/api/v1/contracts/results/{transactionIdOrHash}/actions" method="get" %}
[https://raw.githubusercontent.com/hashgraph/hedera-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml](https://raw.githubusercontent.com/hashgraph/hedera-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml)
{% endswagger %}

{% swagger src="https://raw.githubusercontent.com/hashgraph/hedera-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml" path="/api/v1/contracts/results/{transactionIdOrHash}/opcodes" method="get" %}
[https://raw.githubusercontent.com/hashgraph/hedera-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml](https://raw.githubusercontent.com/hashgraph/hedera-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml)
{% endswagger %}

{% swagger src="https://raw.githubusercontent.com/hashgraph/hedera-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml" path="/api/v1/contracts/{contractIdOrAddress}/results/logs" method="get" %}
[https://raw.githubusercontent.com/hashgraph/hedera-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml](https://raw.githubusercontent.com/hashgraph/hedera-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml)
{% endswagger %}

{% swagger src="https://raw.githubusercontent.com/hashgraph/hedera-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml" path="/api/v1/contracts/results/logs" method="get" %}
[https://raw.githubusercontent.com/hashgraph/hedera-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml](https://raw.githubusercontent.com/hashgraph/hedera-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml)
{% endswagger %}

{% swagger src="https://raw.githubusercontent.com/hashgraph/hedera-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml" path="/api/v1/contracts/call" method="post" %}
[https://raw.githubusercontent.com/hashgraph/hedera-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml](https://raw.githubusercontent.com/hashgraph/hedera-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml)
{% endswagger %}
