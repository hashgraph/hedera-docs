# JSON-RPC Relay

The [Hiero JSON-RPC Relay](https://github.com/hiero-ledger/hiero-json-rpc-relay) is an open-source project implementing the EVM JSON-RPC standard. It allows developers to interact with Hedera nodes using familiar EVM tools, allowing developers and users to deploy, query, and execute contracts as they usually would. Check out the interactive[ OpenRPC Specification](https://playground.open-rpc.org/?schemaUrl=https://raw.githubusercontent.com/hashgraph/hedera-json-rpc-relay/main/docs/openrpc.json\&uiSchema%5BappBar%5D%5Bui:splitView%5D=false\&uiSchema%5BappBar%5D%5Bui:input%5D=false\&uiSchema%5BappBar%5D%5Bui:examplesDropdown%5D=false) and a simple [list of endpoints](https://github.com/hiero-ledger/hiero-json-rpc-relay/blob/main/docs/rpc-api.md).

## HBAR decimal places

The Hiero JSON RPC Relay **`msg.value`** uses `18 decimals` when it returns HBAR. As a result, the **`gasPrice`** value returns 18 decimal places since it is only utilized from the JSON RPC Relay. Refer to the [HBAR page](../../sdks-and-apis/sdks/hbars.md) for a list of Hiero APIs and the decimal places they return.

## JSON RPC Relay Options for the Hedera Network

When interacting with smart contracts on Hedera, developers have several options for setting up a JSON RPC Relay. Each choice comes with unique advantages and trade-offs based on your project's needs, scalability, and operational preferences.

1. [**Hiero Local Node**](https://github.com/hiero-ledger/hiero-local-node)**:** It provides a built-in JSON RPC Relay and simulates the Hedera network environment locally. This option is ideal for quick prototyping, debugging, and isolated testing without external dependencies. It's ideal if you want to run extensive and repeated tests without having to worry about running out of testnet HBAR.
2. [**Self-hosted JSON RPC Relay**](https://github.com/hiero-ledger/hiero-json-rpc-relay/tree/main)**:** Running your own JSON RPC Relay offers complete control over configurations and network selection (testnet, previewnet, mainnet). It is best suited for projects requiring flexibility, high reliability, and scalability, especially in production environments.
3. [**Third-party JSON RPC Relay Services**](json-rpc-relay.md#community-hosted-json-rpc-relays)**:** Several third-party providers offer managed JSON RPC Relay services with different levels of reliability, service-level agreements (SLAs), and fee structures. These services remove infrastructure maintenance overhead, allowing teams to focus more on development (_you can find the list of supported services_ [_below_](json-rpc-relay.md#community-hosted-json-rpc-relays)_)._

| Feature                       |    Hiero Local Node   | Self-hosted RPC Relay |             Third-party RPC Relay            |
| ----------------------------- | :-------------------: | :-------------------: | :------------------------------------------: |
| **Infrastructure Management** |        Minimal        |        Required       |                     None                     |
| **Reliability and Stability** |      High (local)     |          High         |                Variable by SLA               |
| **Scalability**               |       / (local)       |        Flexible       |             Variable by provider             |
| **Setup Complexity**          |     Low to Medium     |     Medium to High    |                      Low                     |
| **Ideal Use Case**            | Testing & Development |  Testing & Production | Builders who prefer convenience & Production |

{% hint style="success" %}
Read the [**JSON RPC Relay Comparison blog**](https://hedera.com/blog/selecting-a-json-rpc-relay-for-your-project) post to learn more about the different options!
{% endhint %}

## Community Hosted JSON-RPC Relays

Anyone in the community can set up their own JSON RPC relay that applications can use to deploy, query, and execute smart contracts. The list of community-hosted Hiero JSON RPC relays and endpoints for previewnet, testnet, and mainnet can be found in the table below, as well as their associated docs or websites.

#### JSON-RPC Relay Endpoints

<table><thead><tr><th width="133">Network</th><th width="95" align="center">Chain ID</th><th width="267" align="center">Hashio RPC URL</th><th align="center">thirdweb RPC URL</th></tr></thead><tbody><tr><td><strong>Mainnet</strong></td><td align="center"><code>295</code></td><td align="center"><a href="https://mainnet.hashio.io/api">https://mainnet.hashio.io/api</a> **</td><td align="center"><a href="https://295.rpc.thirdweb.com">https://295.rpc.thirdweb.com</a></td></tr><tr><td><strong>Testnet</strong></td><td align="center"><code>296</code></td><td align="center"><a href="https://testnet.hashio.io/api">https://testnet.hashio.io/api</a>**</td><td align="center"><a href="https://296.rpc.thirdweb.com">https://296.rpc.thirdweb.com</a></td></tr><tr><td><strong>Previewnet</strong></td><td align="center"><code>297</code></td><td align="center"><a href="https://previewnet.hashio.io/api">https://previewnet.hashio.io/api</a>**</td><td align="center"><a href="https://297.rpc.thirdweb.com">https://297.rpc.thirdweb.com</a></td></tr></tbody></table>

{% hint style="success" %}
#### 🚨 **PLEASE NOTE**

**Hashio** is for development and **testing purposes only**. Production use cases are strongly encouraged to use [commercial-grade JSON-RPC relays](https://docs.hedera.com/hedera/core-concepts/smart-contracts/deploying-smart-contracts/json-rpc-relay#community-hosted-json-rpc-relays) or host their own instance of the [Hiero JSON-RPC Relay](https://github.com/hiero-ledger/hiero-json-rpc-relay).
{% endhint %}

<table data-view="cards"><thead><tr><th align="center"></th><th data-hidden data-card-cover data-type="files"></th><th data-hidden data-card-target data-type="content-ref"></th></tr></thead><tbody><tr><td align="center"><strong>Arkhia</strong></td><td><a href="../../.gitbook/assets/arkhia-logo.png">arkhia-logo.png</a></td><td><a href="https://www.arkhia.io/features/#api-services">https://www.arkhia.io/features/#api-services</a></td></tr><tr><td align="center"><strong>Hashio</strong></td><td><a href="../../.gitbook/assets/hashio-new-hashgraph.png">hashio-new-hashgraph.png</a></td><td><a href="https://www.hashgraph.com/hashio/">https://www.hashgraph.com/hashio/</a></td></tr><tr><td align="center"><strong>Hgraph</strong></td><td><a href="../../.gitbook/assets/hgraph-logo-card-white.png">hgraph-logo-card-white.png</a></td><td><a href="https://docs.hgraph.com/category/json-rpc">https://docs.hgraph.com/category/json-rpc</a></td></tr><tr><td align="center"><strong>Linkpool</strong></td><td><a href="../../.gitbook/assets/linkpool-logo-card.png">linkpool-logo-card.png</a></td><td><a href="https://linkpool.com/">https://linkpool.com/</a></td></tr><tr><td align="center"><strong>Run Your Own Relay</strong></td><td><a href="../../.gitbook/assets/05-Hedera-Icon-Lockup-Dark.jpg">05-Hedera-Icon-Lockup-Dark.jpg</a></td><td><a href="https://github.com/hiero-ledger/hiero-json-rpc-relay?tab=readme-ov-file#hedera-json-rpc-relay">https://github.com/hiero-ledger/hiero-json-rpc-relay?tab=readme-ov-file#hedera-json-rpc-relay</a></td></tr><tr><td align="center"><strong>thirdweb</strong></td><td><a href="../../.gitbook/assets/thirdweb-logo.jpg">thirdweb-logo.jpg</a></td><td><a href="https://thirdweb.com/hedera">https://thirdweb.com/hedera</a></td></tr><tr><td align="center"><strong>Validation Cloud</strong></td><td><a href="../../.gitbook/assets/validation-cloud-black-logo-card.png">validation-cloud-black-logo-card.png</a></td><td><a href="https://docs.validationcloud.io/about/hedera/json-rpc-relay-api">https://docs.validationcloud.io/about/hedera/json-rpc-relay-api</a></td></tr><tr><td align="center"><strong>QuickNode</strong></td><td><a href="../../.gitbook/assets/quicknode-logo-card-black.png">quicknode-logo-card-black.png</a></td><td><a href="https://www.quicknode.com/docs/hedera">https://www.quicknode.com/docs/hedera</a></td></tr></tbody></table>

{% hint style="info" %}
#### **Note**

If you want to add your hosted JSON-RPC relay to this list, please open an issue in the [Hedera docs GitHub repository](https://github.com/hashgraph/hedera-docs). Please visit the community-hosted websites to review any limitations specific to their instance.
{% endhint %}

{% content-ref url="../../tutorials/more-tutorials/json-rpc-connections/" %}
[json-rpc-connections](../../tutorials/more-tutorials/json-rpc-connections/)
{% endcontent-ref %}

## FAQ

<details>

<summary><strong>Are there Community hosted relays?</strong></summary>

* [**Hashio**](https://www.hashgraph.com/hashio/)
* [**Arkhia**](https://www.arkhia.io/features/#api-services)
* [**Validation Cloud**](https://docs.validationcloud.io/about/hedera/json-rpc-relay-api)
* [**QuickNode**](https://www.quicknode.com/docs/hedera)
* [**Hgraph**](https://docs.hgraph.com/category/json-rpc)

</details>

<details>

<summary><strong>How do I connect to the Hedera Network over RPC?</strong></summary>

The configuration guide to connect to the Hedera Network over RPC can be found [here](../../tutorials/more-tutorials/json-rpc-connections/).

</details>

<details>

<summary><strong>Where can I find the Hiero JSON-RPC relay endpoints?</strong></summary>

The endpoints for previewnet, testnet, and mainnet can be found on [Hashio](https://www.hashgraph.com/hashio/), accessible through the [Hashgraph](https://www.hashgraph.com) website. Feel free to join the discussion on [Stack Overflow](https://stackoverflow.com/questions/76153239/how-can-i-connect-to-hedera-testnet-over-rpc/76153290#76153290) for more questions.

</details>

<details>

<summary><strong>How does Hedera handle decimals in HBAR and gas prices?</strong></summary>

The JSON-RPC Relay `msg.value` uses 18 decimals when it returns HBAR. The `gasPrice` value also returns 18 decimal places. _Check out the_ [_HBAR page_](../../sdks-and-apis/sdks/hbars.md) _for the full list of Hedera APIs and their decimal representation._

</details>

<details>

<summary><strong>How can I contribute or log errors?</strong></summary>

To contribute or log errors, please refer to the [Contributing Guide](../../support-and-community/contributing-guide/) and submit them as issues in the [GitHub repository](https://github.com/hiero-ledger/hiero-json-rpc-relay).

</details>
