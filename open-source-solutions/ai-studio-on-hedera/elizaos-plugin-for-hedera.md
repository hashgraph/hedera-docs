---
description: >-
  A plugin built for the ElizaOS framework to enable developers creating ElizaOS
  Agents to seamlessly integrate Hedera Network Functionality
---

# ElizaOS Plugin for Hedera

## Overview

ElizaOS is an open‑source agent runtime for building autonomous, tool‑using AI agents that can plan and take actions. ElizaOS is an easy to use framework created to make it easy to build web3-native agents.&#x20;

The [**Hedera Plugin for Eliza**](https://github.com/elizaos-plugins/plugin-hedera) integrates Hedera functionality into ElizaOS, making it easy to interact with the network directly from the ElizaOS platform. With this plugin, users can execute a variety of blockchain operations, including:

* **HBAR and HTS Token Management**: Check balances and execute transfers with ease.​
* **Token Operations**: Create, mint, and manage tokens efficiently.​
* **Consensus Service Interaction**: Engage with Hedera Consensus Service (HCS) topics for streamlined consensus mechanisms.​
* **Token Distribution**: Airdrop tokens and manage associations seamlessly.

This plugin provides an efficient way to work with Hedera Services and transactions, while staying within the ElizaOS environment. It connects ElizaOS directly to Hedera via the Hedera Agent Kit, exposing safe, typed tools for transfers, tokens, and mirror node queries.

***

## ElizaOS + the Hedera Agent Kit

At its core, the plugin is powered by the [hedera-agent-kit,](https://github.com/hashgraph/hedera-agent-kit/) which streamlines network interactions and automates common tasks. It supports:

* Real-time HBAR balance updates for the connected wallet.
* Automated on-chain queries without requiring manual actions.
*   Context-aware responses, allowing users to ask questions like:

    User: _What’s my HBAR balance?_\
    Response: _Your current HBAR balance is 999.81 HBAR._

This ensures a smooth and intuitive user experience, reducing friction when working with the Hedera network.

Building on Hedera means users have all the avantages of the Hedera network:

* Fast finality and low, predictable fees—ideal for iterative agent behavior.
* Native tokenization (HTS) with rich controls and compliance features.
* Ordered, verifiable messaging via Hedera Consensus Service (HCS).
* Carbon‑negative network with high throughput and stable costs.

***

## Try It Out

This plugin simplifies Hedera blockchain development and interaction within ElizaOS. \
\
ElizaOS provides the runtime for AI agents (planning, memory, tools, messaging), while the Hedera Agent Kit plugin provides strongly‑typed, batteries‑included functions for common Hedera actions (HBAR transfers, HTS token ops, HCS messages, queries). This plugin bridges the two, so an Eliza agent can call Hedera actions safely via tools agent-kit defined tools.

### How It Works

* At startup the plugin registers the Hedera Agent Kit toolkit with ElizaOS.
* It validates your Hedera credentials, creates a Hedera client (testnet by default), and registers a set of blockchain tools (actions) with the agent runtime.
* Agent prompts/plans then invokes these tools to perform on‑chain operations and returns results back into the conversation.

\
For full documentation and setup instructions, visit the [**GitHub Repository**](https://github.com/elizaos-plugins/plugin-hedera).

{% @github-files/github-code-block url="https://github.com/hedera-dev/hedera-plugin-eliza" %}
