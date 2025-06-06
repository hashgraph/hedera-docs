---
description: Join a Hedera Testnet
---

# Testnets

## Overview

Hedera test networks provide developers access to a free testing environment for Hedera network services. Testnets simulate the exact development environment as you would expect for mainnet. This includes transaction fees, throttles, available services, etc. To create a Hedera Testnet or Previewnet account, you can visit the [Hedera Developer Portal](https://portal.hedera.com/login).

Once your application has been built and tested in this test environment, you can expect to migrate your decentralized application (dApp) to mainnet without any changes.

<table><thead><tr><th width="324">Test Networks</th><th>Description</th></tr></thead><tbody><tr><td><strong>Testnet</strong></td><td>Testnet runs the same code as the Hedera Mainnet, designed to provide a pre-production environment for developers about to move to mainnet. You can find compatible SDKs <a href="../../sdks-and-apis/sdks/#hedera-supported-sdks">here</a>.</td></tr><tr><td><strong>Previewnet</strong></td><td><p>Code that is under development by the Hedera team and likely to be used in an upcoming release designed to give developers early exposure to features coming down the pipe. Updates to the network are made frequently. There is no guarantee an SDK will readily support the up-and-coming features.</p><p><strong>Note:</strong> Updates to this network are triggered by a new release and are frequent. These updates will not be reflected on the status page.</p></td></tr></tbody></table>

<table><thead><tr><th width="325">Network Service</th><th>Availability</th></tr></thead><tbody><tr><td><strong>Cryptocurrency</strong></td><td>Limited</td></tr><tr><td><strong>Consensus Service</strong></td><td>Limited</td></tr><tr><td><strong>File Service</strong></td><td>Limited</td></tr><tr><td><strong>Smart Contract Service</strong></td><td>Limited</td></tr><tr><td><strong>Token Service</strong></td><td>Limited</td></tr></tbody></table>

## Test Network Resets

The mirror node and consensus node test network are scheduled to be reset _periodically_. Scheduled resets are communicated to the ecosystem with anticipation so developers can plan ahead. During a reset:

### What Gets Reset

* All account balances and transaction history
* Smart contract state and deployed contracts
* Consensus node ledger state
* Topic and token configurations

### What Remains

* Your account's public/private key pairs
* Access to the [Hedera Developer Portal](https://portal.hedera.com/register)&#x20;
* SDK configurations and application code

## Scheduled Reset Process

Resets follow a structured communication and execution process:

### Pre-Reset (2-4 weeks before)

* Subscribe to notifications on the [Hedera Status Page](https://status.hedera.com/)
* Community notification through official channels
* Developer preparation period begins

### During Reset

* Network temporarily unavailable
* Consensus nodes cleared and reinitialized
* Mirror node data archived

### Post-Reset (within 24 hours)

* Network restored with fresh state
* New account IDs available via Developer Portal
* Mirror node historical data accessible for 2 weeks

### Preparing for Resets

To minimize disruption during scheduled resets:

* Export any test data you need to preserve before the reset
* Schedule development activities around announced reset dates
* Obtain new testnet account IDs from the [Hedera Developer Portal](https://portal.hedera.com/register) after each reset
* _Mirror Node operators_ can reference the instructions [here](https://github.com/hiero-ledger/hiero-mirror-node/blob/main/docs/database/README.md) to set up your mirror node
  * GCP GCS and AWS S3 buckets: `hedera-testnet-streams-2023-01`

{% hint style="info" %}
**❓ If you have any questions or concerns, please connect with us via** [**Discord**](https://hedera.com/discord)**.**&#x20;
{% endhint %}

### **Reset History**

<table><thead><tr><th width="172.6319580078125">Date</th><th width="164.25177001953125">Status</th></tr></thead><tbody><tr><td><strong>February 1, 2024</strong></td><td>Completed</td></tr><tr><td><strong>April 25, 2024</strong> </td><td>Skipped</td></tr><tr><td><strong>July 25, 2024</strong></td><td>Skipped</td></tr><tr><td><strong>Oct 31, 2024</strong></td><td>Skipped</td></tr></tbody></table>

_📊 **Historical data**: Previous resets occurred on **January 26, 2023** and July 27, 2023._

## Test Network Throttles

{% hint style="warning" %}
## **Limited Support**

Transactions are currently throttled for testnets. You will receive a **`BUSY`** response if the number of transactions submitted to the network exceeds the threshold value.
{% endhint %}

<table><thead><tr><th width="322">Network Request Type</th><th>Throttle (tps)</th></tr></thead><tbody><tr><td><strong>Cryptocurrency Transactions</strong></td><td><p><code>AccountCreateTransaction</code>: 2 tps<br><code>TransferTransaction</code> (inc. tokens): 10,000 tps</p><p><code>Other</code>: 10,000 tps</p></td></tr><tr><td><strong>Consensus Transactions</strong></td><td><p><code>TopicCreateTransaction</code>: 5 tps</p><p><code>Other</code>: 10,000 tps</p></td></tr><tr><td><strong>Token Transactions</strong></td><td><p><code>TokenMintTransaction</code>:</p><ul><li>125 TPS for fungible mint</li><li>50 TPS for NFT mint</li></ul><p><code>TokenAssociateTransaction</code>: 100 tps<br><code>TransferTransaction</code> (inc. tokens): 10,000 tps</p><p><code>Other</code>: 3,000 tps</p></td></tr><tr><td><strong>Schedule Transactions</strong></td><td><code>ScheduleSignTransaction</code>: 100 tps<br><code>ScheduleCreateTransaction</code>: 100 tps</td></tr><tr><td><strong>File Transactions</strong></td><td>10 tps</td></tr><tr><td><strong>Smart Contract Transactions</strong></td><td><code>ContractExecuteTransaction</code>: 350 tps<br><code>ContractCreateTransaction</code>: 350 tps</td></tr><tr><td><strong>Queries (per node)</strong></td><td><p><code>AccountBalanceQuery</code>: 1000 tps</p><p></p><p><code>ContractGetInfo</code>: 700 tps<br><code>ContractGetBytecode</code>: 700 tps<br><code>ContractCallLocal</code>: 700 tps<br><br><code>FileGetInfo</code>: 700 tps<br><code>FileGetContents</code>: 700 tps<br><br><code>Other</code>: 10,000 tps</p></td></tr><tr><td><strong>Receipts</strong></td><td>unlimited (no throttle)</td></tr></tbody></table>
