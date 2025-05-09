# Blocks

## Overview

The **Block endpoints** in the Hedera Mirror Node REST API allows developers to query **block data** on the Hedera network. These endpoints are essential for retrieving block metadata, including hashes, timestamps, and transactions within blocks.

## Endpoints

The following Block endpoints are available:

| **Endpoint**                          | **Description**                                              |
| ------------------------------------- | ------------------------------------------------------------ |
| `GET /api/v1/blocks`                  | Retrieves a list of blocks on the network.                   |
| `GET /api/v1/blocks/{hash_or_number}` | Fetches details of a specific block by hash or block number. |

## Blocks

{% openapi-operation spec="mainnet" path="/api/v1/blocks" method="get" %}
[Broken link](broken-reference)
{% endopenapi-operation %}

{% openapi-operation spec="mainnet" path="/api/v1/blocks/{hashOrNumber}" method="get" %}
[Broken link](broken-reference)
{% endopenapi-operation %}
