# Smart Contract Verification API

## Overview

The Sourcify API enables programmatic access to smart contract verification services, allowing developers to verify contract source code, check verification status, and retrieve verified contract files. This decentralized verification service is essential for developers and auditors who need to ensure smart contract transparency and verify that deployed bytecode matches the provided source code across multiple blockchain networks.

### Key Features

* **Contract Verification**: Submit smart contract source code and metadata for verification against deployed bytecode on various blockchain networks.
* **Multiple Verification Methods**: Support for direct file upload, Etherscan-verified contract import, and solc-json compilation artifact verification.
* **Verification Status Checking**: Query the verification status of contracts by address and chain ID, with support for both full and partial matches.
* **File Retrieval**: Access verified contract source code, metadata, and compilation artifacts for any verified contract.
* **Multi-Chain Support**: Compatible with Ethereum mainnet, testnets, and other EVM-compatible networks including Hedera.
* **Repository Access**: Browse and download verified contract files with organized file tree structures.

{% hint style="success" %}
📣 For interactive API exploration and testing, visit [https://server-verify.hashscan.io/api-docs/](https://server-verify.hashscan.io/api-docs/)
{% endhint %}

## Base URL

```
https://server-verify.hashscan.io
```

## Endpoints

#### Stateless Verification

<table><thead><tr><th width="118.704833984375">Method</th><th>Endpoint</th><th>Description</th></tr></thead><tbody><tr><td>POST</td><td><code>/verify</code></td><td>verify contracts by uploading source files and metadata</td></tr><tr><td>POST</td><td><code>/verify/etherscan</code></td><td>verify contracts already verified on etherscan</td></tr><tr><td>POST</td><td><code>/verify/solc-json</code></td><td>verify contracts using solc-json compilation artifacts</td></tr></tbody></table>

#### Repository Access

<table><thead><tr><th width="106.517333984375">Method</th><th>Endpoint</th><th>Description</th></tr></thead><tbody><tr><td>GET</td><td><code>/check-all-by-addresses</code></td><td>check verification status (full or partial match) for multiple contracts</td></tr><tr><td>GET</td><td><code>/check-by-addresses</code></td><td>check verification status (full match only) for multiple contracts</td></tr><tr><td>GET</td><td><code>/files/any/{chain}/{address}</code></td><td>retrieve all files for a contract (full and partial match)</td></tr><tr><td>GET</td><td><code>/files/{chain}/{address}</code></td><td>retrieve all files for a contract (full match only)</td></tr><tr><td>GET</td><td><code>/files/contracts/{chain}</code></td><td>get all verified contract addresses on a specific chain</td></tr><tr><td>GET</td><td><code>/files/tree/any/{chain}/{address}</code></td><td>get file tree structure (full and partial match)</td></tr><tr><td>GET</td><td><code>/files/tree/{chain}/{address}</code></td><td>get file tree structure (full match only)</td></tr><tr><td>GET</td><td><code>/repository/contracts/{match_type}/{chain}/{address}/{filePath}</code></td><td>download specific files from verified contracts</td></tr></tbody></table>

#### Session Management

<table><thead><tr><th width="109.390625">Method</th><th>Endpoint</th><th>Description</th></tr></thead><tbody><tr><td>GET</td><td><code>/session/data</code></td><td>retrieve current session verification data</td></tr><tr><td>POST</td><td><code>/session/clear</code></td><td>clear session data</td></tr><tr><td>POST</td><td><code>/session/input-files</code></td><td>add files to verification session</td></tr><tr><td>POST</td><td><code>/session/input-contract</code></td><td>import deployed contract from ipfs</td></tr><tr><td>POST</td><td><code>/session/verify-checked</code></td><td>verify contracts in current session</td></tr><tr><td>POST</td><td><code>/session/input-solc-json</code></td><td>add solc-json to session for verification</td></tr><tr><td>POST</td><td><code>/session/verify/etherscan</code></td><td>verify etherscan contracts in session</td></tr></tbody></table>

#### Administration

<table><thead><tr><th width="109.19094848632812">Method</th><th>Endpoint</th><th>Description</th></tr></thead><tbody><tr><td>POST</td><td><code>/change-log-level</code></td><td>modify application logging level (requires authentication)</td></tr></tbody></table>



{% openapi-operation spec="sourcify-api" path="/verify" method="post" %}
[OpenAPI sourcify-api](https://server-verify.hashscan.io/api-docs/swagger.json)
{% endopenapi-operation %}



{% openapi-operation spec="sourcify-api" path="/verify/etherscan" method="post" %}
[OpenAPI sourcify-api](https://server-verify.hashscan.io/api-docs/swagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="sourcify-api" path="/verify/solc-json" method="post" %}
[OpenAPI sourcify-api](https://server-verify.hashscan.io/api-docs/swagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="sourcify-api" path="/check-all-by-addresses" method="get" %}
[OpenAPI sourcify-api](https://server-verify.hashscan.io/api-docs/swagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="sourcify-api" path="/check-by-addresses" method="get" %}
[OpenAPI sourcify-api](https://server-verify.hashscan.io/api-docs/swagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="sourcify-api" path="/files/any/{chain}/{address}" method="get" %}
[OpenAPI sourcify-api](https://server-verify.hashscan.io/api-docs/swagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="sourcify-api" path="/files/{chain}/{address}" method="get" %}
[OpenAPI sourcify-api](https://server-verify.hashscan.io/api-docs/swagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="sourcify-api" path="/repository/contracts/{full_match | partial_match}/{chain}/{address}/{filePath}" method="get" %}
[OpenAPI sourcify-api](https://server-verify.hashscan.io/api-docs/swagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="sourcify-api" path="/files/contracts/{chain}" method="get" %}
[OpenAPI sourcify-api](https://server-verify.hashscan.io/api-docs/swagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="sourcify-api" path="/files/tree/any/{chain}/{address}" method="get" %}
[OpenAPI sourcify-api](https://server-verify.hashscan.io/api-docs/swagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="sourcify-api" path="/files/tree/{chain}/{address}" method="get" %}
[OpenAPI sourcify-api](https://server-verify.hashscan.io/api-docs/swagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="sourcify-api" path="/session/data" method="get" %}
[OpenAPI sourcify-api](https://server-verify.hashscan.io/api-docs/swagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="sourcify-api" path="/session/clear" method="post" %}
[OpenAPI sourcify-api](https://server-verify.hashscan.io/api-docs/swagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="sourcify-api" path="/session/input-files" method="post" %}
[OpenAPI sourcify-api](https://server-verify.hashscan.io/api-docs/swagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="sourcify-api" path="/session/input-contract" method="post" %}
[OpenAPI sourcify-api](https://server-verify.hashscan.io/api-docs/swagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="sourcify-api" path="/session/verify-checked" method="post" %}
[OpenAPI sourcify-api](https://server-verify.hashscan.io/api-docs/swagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="sourcify-api" path="/session/input-solc-json" method="post" %}
[OpenAPI sourcify-api](https://server-verify.hashscan.io/api-docs/swagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="sourcify-api" path="/session/verify/etherscan" method="post" %}
[OpenAPI sourcify-api](https://server-verify.hashscan.io/api-docs/swagger.json)
{% endopenapi-operation %}

{% openapi-operation spec="sourcify-api" path="/change-log-level" method="post" %}
[OpenAPI sourcify-api](https://server-verify.hashscan.io/api-docs/swagger.json)
{% endopenapi-operation %}
