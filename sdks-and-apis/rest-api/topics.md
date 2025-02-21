# Topics

## Overview

The **Topics endpoints** in the Hedera Mirror Node REST API allows developers to query **topics and messages**. These endpoints are crucial for retrieving topic details, message history, and tracking consensus events on the network.

## Endpoints

The following endpoints are available for the Topics object:

| **Endpoint**                                            | **Description**                                                |
| ------------------------------------------------------- | -------------------------------------------------------------- |
| `GET /api/v1/topics/{id}/messages`                      | Retrieves messages for a specific topic by ID.                 |
| `GET /api/v1/topics/{id}/messages/{sequence_number}`    | Fetches a specific message from a topic using sequence number. |
| `GET /api/v1/topics/{id}/messages/{consensusTimestamp}` | Retrieves a topic message by consensus timestamp.              |

## Topics

{% swagger src="https://raw.githubusercontent.com/hiero-ledger/hiero-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml" path="/api/v1/topics/{topicId}/messages" method="get" %}
[https://raw.githubusercontent.com/hiero-ledger/hiero-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml](https://raw.githubusercontent.com/hiero-ledger/hiero-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml)
{% endswagger %}

#### Response Details

| Response Item            | Description                                                                          |
| ------------------------ | ------------------------------------------------------------------------------------ |
| **consensus\_timestamp** | The consensus timestamp of the message in seconds.nanoseconds                        |
| **topic\_id**            | The ID of the topic the message was submitted to                                     |
| **payer\_account\_id**   | The account ID that paid for the transaction to submit the message                   |
| **message**              | The content of the message                                                           |
| **running\_hash**        | The new running hash of the topic that received the message                          |
| **sequence\_number**     | The sequence number of the message relative to all other messages for the same topic |

{% swagger src="https://raw.githubusercontent.com/hiero-ledger/hiero-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml" path="/api/v1/topics/{topicId}/messages/{sequenceNumber}" method="get" %}
[https://raw.githubusercontent.com/hiero-ledger/hiero-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml](https://raw.githubusercontent.com/hiero-ledger/hiero-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml)
{% endswagger %}

{% swagger src="https://raw.githubusercontent.com/hiero-ledger/hiero-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml" path="/api/v1/topics/messages/{timestamp}" method="get" %}
[https://raw.githubusercontent.com/hiero-ledger/hiero-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml](https://raw.githubusercontent.com/hiero-ledger/hiero-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml)
{% endswagger %}
