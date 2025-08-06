# Node Deployment Process

This document outlines the step-by-step process for Hedera Council members to deploy a permissioned consensus node on the Hedera mainnet.

## Prerequisite

Before proceeding, ensure you have reviewed the [Node Requirements](node-requirements/) to confirm your hardware, network, and software setup complies with Hedera standards.

***

## Deployment Steps

### 1. 🧑‍💼 Project Kickoff & Coordination

* Initial contact with Council Member and node hosting entity
* Identify key individuals and technical project managers
* Establish regular deployment team meeting cadence
* Discuss deployment options and convey technical requirements

***

### 2. 🧱 Infrastructure Preparation

* **Platform acquisition**
  * Hardware or virtual instance
  * Hosting facility selection
  * Network connectivity established
* **Operating system configuration**
  * Hardened OS image
  * Required packages and dependencies

***

### 3. 🔐 Account & Network Provisioning

* Provision Hedera-specific system accounts (e.g., fee account, node account)
* Provision network access
  * Set firewall rules and access control lists (ACLs)
  * Ensure compliance with Node Connectivity and Proxy Connectivity specs
* Convey credentials securely to Hedera
  * Include any VPN or special instructions for permissioned access

***

### 4. 📞 Support Planning

* Define escalation paths and support contacts between Hedera and the hosting team
* Confirm shared availability and incident response expectations

***

### 5. 🧪 Configuration Review & Deployment

* **Hedera reviews:**
  * Platform setup
  * Network and firewall configuration
* **Node software deployment:**
  * Install Hedera consensus node software
  * Install required libraries and dependencies
  * Add configuration for connecting to the Hedera **performance testnet**

***

### 6. 🧭 Test & Validation Phase

* Hedera conducts:
  * Functional testing
  * Stability and performance tests of all network services
* Review test results jointly
* Determine readiness for mainnet onboarding

***

### 7. 🔐 Key Management & Final Steps

* Review Council Member key management documentation
  * Fee account, staking proxy account, etc.
* Update private keys using provided secure tooling

***

### 8. 🌐 Mainnet Onboarding

* Schedule connection to Hedera mainnet
* Node goes **live** on the Hedera mainnet

***
