---
description: >-
  The Hedera Mainnet is currently comprised of permissioned consensus nodes
  operated by the Hedera Council.
---

# Node Deployment Requirements

This guide outlines the technical requirements, system setup, and network configuration for [_Hedera Council_](https://hedera.com/council) members to deploy and operate their permissioned consensus node on the Hedera Mainnet. All requirements aim to ensure consistency and performance across the network.

{% hint style="danger" %}
<mark style="color:blue;">**Note:**</mark> This documentation applies only to permissioned consensus nodes operated by Hedera Council Members. It does not cover Hedera’s transition to a permissionless network.
{% endhint %}

## Minimum Node Platform Requirements

The overall performance of the Hedera Mainnet is currently constrained by the lowest-performing node in the network. To maintain consistent performance across all Council nodes, a set of minimum hardware, connectivity, and hosting requirements has been established for this initial permissioned phase.

{% hint style="info" %}
<mark style="color:red;">**Action:**</mark> To ensure compliance with these requirements, submit your proposed node hardware, connectivity, and hosting specifications to Hedera for review **before making any purchases via** :e-mail: <mark style="color:blue;">**devops@hashgraph.com.**</mark>
{% endhint %}

### CPU

* **Architecture**: X86/X64 (Intel Xeon or AMD EPYC)
* **Cores**: 24 cores / 48 threads
* **Benchmarks:**
  * **Geekbench 6 single-core:**
    * Minimum: ≥ 1000
    * Recommended: ≥ 1500
  * **Passmark single-thread:**
    * Minimum: ≥ 2300 (required for Mainnet)
    * Recommended: ≥ 2800

***

### **Memory**

* **Minimum:** 256GB DDR4 ECC Registered DIMM (PC4-21300 2666MHz)
* **Recommended:** 320 GB+ DDR4 ECC (PC4-25600 3200MHz)

***

### **Storage**

**General Guidelines:**\
It is recommended to configure a **240 GB SSD in RAID 1** for the root volume (`/`) and mount additional volumes for usable storage during installation. If RAID is not available, assign all storage to root.

<details>

<summary><strong>Minimum Requirements/Recommendations ⬇</strong></summary>

* **Minimum:** 5TB NVMe SSD (usable)
* **Recommended:**
  * OS: 2 × 240GB SSD (RAID 1)
  * Data: 2 × NVMe drives (7.5TB RAID 0) or 4× in RAID 10 array

**Performance:** \
If mounted to root volume, the root volume must meet these requirements. If provisioned via RAID, the RAID array should meet these requirements:

* Sequential Write: 2,000–3,000 MB/s
* Sequential Read: 3,000–6,200 MB/s
* Random Read (sync): 250k–1M IOPS
* Random Write (sync): 100k–170k IOPS
* Avg. Latency: ≤ 200µs

> 📁 <mark style="color:blue;">**Note**</mark>: Nodes must pass the Hedera performance test suite at installation time.

</details>

***

### **Network Connectivity**

* Sustained bandwidth: ≥ 1Gbps (via 1/10Gb Ethernet)

***

### Node Operating System & Tools

#### Supported OS

* Supported Linux Distributions (64-bit, LTS only):
  * Ubuntu 22.04 LTS
  * Red Hat Enterprise Linux (RHEL) 8 and 9
  * Oracle Linux 8 and 9
* Supported kernel versions:
  * 6.2.0
  * 6.1.2&#x20;
  * 6.0.16
  * 5.15.86

<details>

<summary>🧩 <strong>Node Software ⬇</strong></summary>

The following software components must be installed and configured on your node host to ensure proper participation in the Hedera Mainnet. All installations must follow the minimum version requirements and path conventions.

**🐳 Docker & Containerization:**

<table><thead><tr><th width="203.68359375">Component</th><th width="214.16796875">Version</th><th>Notes</th></tr></thead><tbody><tr><td><strong>Docker Engine</strong></td><td><code>20.10.6</code></td><td>Must be deployed with <strong>root privileges</strong>.</td></tr><tr><td><strong>Docker Compose</strong></td><td><code>1.29.2</code></td><td>Required for managing multi-container deployments.</td></tr><tr><td><strong>Privileged Containers</strong></td><td>Optional</td><td>If <strong>disabled</strong>, host machine <strong>must run</strong> the Havege Daemon.</td></tr><tr><td><strong>Havege Daemon</strong></td><td><code>1.9.14</code></td><td>Needed only if privileged containers are disabled.</td></tr><tr><td><strong>IPTables Support</strong></td><td>Linux kernel <code>3.10+</code></td><td>Required for Docker networking.</td></tr></tbody></table>

> :information\_source: <mark style="color:orange;">**Information**</mark>: Havege Daemon enhances the system’s entropy pool and is only necessary if container privilege escalation is disabled in your environment.

**🔐 System Utilities:**

<table><thead><tr><th width="182.73828125">Component</th><th width="189.078125">Required Version</th><th>Purpose</th></tr></thead><tbody><tr><td><strong>HashDeep</strong></td><td><code>4.4</code></td><td>Used for update integrity verification.</td></tr><tr><td><strong>Bindplane Collector</strong></td><td><code>4+</code></td><td>Required for node software log monitoring</td></tr><tr><td><strong>JQ CLI</strong></td><td><code>1.5+</code></td><td>JSON parser utility used in scripts and CLI workflows.</td></tr><tr><td><strong>GNU CoreUtils</strong></td><td><code>8.00+</code></td><td>Provides essential Unix command-line tools.</td></tr><tr><td><strong>cURL CLI</strong></td><td><code>7.58.0+</code></td><td>Used for API communication and health checks.</td></tr><tr><td><strong>InCron Daemon</strong></td><td><code>0.5.12+</code></td><td>Enables file-system-triggered automation (e.g., network upgrades).</td></tr><tr><td><strong>Rsync CLI</strong></td><td><code>3.0.0+</code></td><td>Required for network-wide upgrade file synchronization.</td></tr></tbody></table>

> 📁 <mark style="color:blue;">Note:</mark> Ensure all command-line tools are installed in your system's global $PATH and are accessible to the node admin user.

**⚙️ Node Management Tools:**

<table><thead><tr><th width="195.47265625">Component</th><th width="154.7265625">Version</th><th>Configuration Requirements</th></tr></thead><tbody><tr><td><strong>Node Mgmt Tools</strong></td><td><code>0.1.0+</code></td><td>Must be installed at <code>/opt/hgcapp/node-mgmt-tools</code></td></tr><tr><td></td><td></td><td>Path must be writable and executable by <code>hgcadmin</code> user</td></tr></tbody></table>

> 📁 <mark style="color:blue;">Note</mark>: The Node Mgmt Tools bundle includes essential scripts for update operations, log rotation, and status health checks.

</details>

***

### **System User Accounts**

#### _**Node Software Account (Mandatory):**_

<table><thead><tr><th width="299.6484375">Attribute</th><th>Value</th></tr></thead><tbody><tr><td><strong>Username</strong></td><td><code>hedera</code></td></tr><tr><td><strong>Unix</strong> <strong>UID</strong></td><td>2000</td></tr><tr><td><strong>Group Specification</strong></td><td><code>hedera</code> (GID 2000)</td></tr><tr><td><strong>Secondary Group</strong></td><td><code>admin</code> or <code>wheel</code></td></tr><tr><td><strong>Permissions</strong></td><td>Full access to the entire <code>/opt/hgcapp</code>folder</td></tr></tbody></table>

***

### Proxy Server Requirements

A proxy is required to expose the node’s public APIs.

#### Minimum Proxy Specifications:

* **CPU**: 2-core X86/X64
* **Memory**: 4GB RAM
* **Storage**: 100GB SSD
* **Network**: 200Mbps sustained, static IP

**Software:**

* **Docker container** (provided by Hedera) with pre-configured HAProxy

***

### Network Configuration

<details>

<summary>🌐 <strong>Node Connectivity ⬇</strong></summary>

#### ✅ Network Bandwidth

* **Minimum:** `1 Gbps` sustained internet connection _(not burstable)._
* **Recommended:** Unmetered bandwidth to ensure uninterrupted sync and consensus participation.

#### 🔐 Network Isolation & IP Requirements

* Deployed within a **dedicated, isolated DMZ** (Demilitarized Zone) network
* Configured with a **firewall** to allow connectivity only with Hedera consensus nodes
* Node must have a **static IP address**

> 📁 <mark style="color:blue;">**Note**</mark>**:** Fully Qualified Domain Names (FQDNs) are **not** supported.

#### 📡 Port Configuration

The following ports must be configured for **public internet access** unless otherwise stated:

<table><thead><tr><th width="136.35546875">Port</th><th width="115.03515625">Protocol</th><th width="171.6953125">Direction</th><th>Description</th></tr></thead><tbody><tr><td><code>50111</code></td><td>TCP</td><td>Ingress</td><td>gRPC (public) API access</td></tr><tr><td><code>50211</code></td><td>TCP</td><td>Ingress</td><td>Gossip protocol</td></tr><tr><td><code>50212</code></td><td>TCP</td><td>Ingress</td><td>TLS-encrypted Gossip protocol</td></tr><tr><td><code>80</code></td><td>TCP</td><td>Egress only</td><td>OS package repository connectivity</td></tr><tr><td><code>443</code></td><td>TCP</td><td>Egress only</td><td>Secure package &#x26; system update access</td></tr><tr><td><code>123</code></td><td>UDP</td><td>Ingress/Egress</td><td>Time sync via NTP pool</td></tr></tbody></table>

</details>

<details>

<summary>🛡️ <strong>Proxy Connectivity ⬇</strong></summary>

**✅ Internet Bandwidth**

* **Required:** 200 Mbps sustained connection

**📡 Port Configuration**

<table><thead><tr><th width="132.375">Port</th><th width="129.4921875">Protocol</th><th width="170.046875">Direction</th><th>Purpose</th></tr></thead><tbody><tr><td><code>50211</code></td><td>TCP</td><td>Ingress/Egress</td><td>Gossip protocol</td></tr><tr><td><code>50212</code></td><td>TCP</td><td>Ingress/Egress</td><td>TLS-encrypted gossip</td></tr><tr><td><code>80</code></td><td>TCP</td><td>Egress only</td><td>OS package repository</td></tr><tr><td><code>443</code></td><td>TCP</td><td>Egress only</td><td>Secure updates</td></tr></tbody></table>

</details>

<details>

<summary>🔀 Interface Bonding (Optional) <strong>⬇</strong></summary>

If you plan to use **interface bonding (NIC bonding)** to increase reliability or performance, note the following:

**✅ Supported Configurations**

Only **Layer 2** bonding is supported:

* **Mode 1 (Active-Backup):**
  * Uses one active NIC at a time
  * Automatically switches to backup if the active NIC fails
* **Mode 4 (LACP – 802.3ad Active/Active):**
  * Uses Link Aggregation Control Protocol
  * Requires switch support
  * Provides load balancing and redundancy

**❌ Not Supported**

* **Layer 3 Policy-Based Routing (PBR)** with dual-pathways is **not supported**, due to the use of **mutual TLS** in the Hedera network.

> ⚠️ Mutual TLS depends on consistent IP-level paths; Layer 3 routing can disrupt this, leading to connection failures.

</details>

***

### Hosting Requirements

To ensure high availability, security, and operational consistency, all nodes must be hosted in accordance with the following standards:

**✅ Hosting Facility Standards**

* Must use a **Tier 1 Data Center** with high availability and redundancy.
* The facility should be compliant with industry security standards:
  * **SSAE 16 / SSAE 18**
  * **SOC 2 Type 2**

**🔒 Security & Compliance**

* Facilities must implement industry-standard physical and logical security controls.
* Regular audits and certifications (must be available on request).

**⚠️ Redundancy Across Council**

* **Hedera aim to avoid using the same hosting providers** across multiple Council Members to minimize systemic risk and improve geographic and provider diversity.

***

## Contacts

For questions or approval of infrastructure plans, contact:

* 📧 devops@hashgraph.com

***

## Next Steps

For detailed guidance on deploying and onboarding your Hedera Mainnet node, please see the [Node Deployment Steps](../node-deployment-process.md).
