# Network

## Overview

The **Network Object** in the Hedera Mirror Node REST API allows developers to query **network-related information**, such as network supply, fees, exchange rates, and node details. These object are essential for monitoring network status, estimating transaction costs, and retrieving staking information.

## Endpoints

The following endpoints are available for the Network object:

<table><thead><tr><th width="392">Endpoint</th><th>Description</th></tr></thead><tbody><tr><td><code>GET /api/v1/network/supply</code></td><td>Retrieves the current total supply of HBAR.</td></tr><tr><td><code>GET /api/v1/network/fees</code></td><td>Fetches the latest transaction fee schedules.</td></tr><tr><td><code>GET /api/v1/network/exchangerate</code></td><td>Retrieves exchange rates to estimate transaction costs.</td></tr><tr><td><code>GET /api/v1/network/nodes</code></td><td>Lists the network address book nodes.</td></tr><tr><td><code>GET /api/v1/network/stake</code></td><td>Fetches staking-related information.</td></tr></tbody></table>

## Network

{% swagger src="https://raw.githubusercontent.com/hiero-ledger/hiero-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml" path="/api/v1/network/supply" method="get" %}
[https://raw.githubusercontent.com/hiero-ledger/hiero-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml](https://raw.githubusercontent.com/hiero-ledger/hiero-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml)
{% endswagger %}

{% swagger src="https://raw.githubusercontent.com/hiero-ledger/hiero-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml" path="/api/v1/network/fees" method="get" %}
[https://raw.githubusercontent.com/hiero-ledger/hiero-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml](https://raw.githubusercontent.com/hiero-ledger/hiero-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml)
{% endswagger %}



{% swagger src="https://raw.githubusercontent.com/hiero-ledger/hiero-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml" path="/api/v1/network/exchangerate" method="get" %}
[https://raw.githubusercontent.com/hiero-ledger/hiero-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml](https://raw.githubusercontent.com/hiero-ledger/hiero-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml)
{% endswagger %}

{% swagger src="https://raw.githubusercontent.com/hiero-ledger/hiero-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml" path="/api/v1/network/nodes" method="get" %}
[https://raw.githubusercontent.com/hiero-ledger/hiero-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml](https://raw.githubusercontent.com/hiero-ledger/hiero-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml)
{% endswagger %}

{% swagger src="https://raw.githubusercontent.com/hiero-ledger/hiero-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml" path="/api/v1/network/stake" method="get" %}
[https://raw.githubusercontent.com/hiero-ledger/hiero-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml](https://raw.githubusercontent.com/hiero-ledger/hiero-mirror-node/main/hedera-mirror-rest/api/v1/openapi.yml)
{% endswagger %}
