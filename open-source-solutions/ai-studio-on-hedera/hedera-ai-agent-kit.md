---
description: Features and Functionality in the Hedera Agent Kit SDK
---

# Hedera AI Agent Kit

Build LLM-powered applications that interact with the Hedera Network. Create conversational agents that can understand user requests in natural language and execute Hedera transactions, or build backend systems that leverage AI for on-chain operations.

## Overview

The Hedera Agent Kit provides:

* **Conversational AI**: LangChain-based agents that understand natural language
* **Comprehensive LangChain Tools**:  Pre-built tools covering Hedera services
* **Flexible Transaction Handling**: Direct execution or provide transaction bytes for user signing
* **Autonomous and Human-in-the-Loop** mode for executing transactions on Hedera

## Quick Start

1. Create your project directory

```bash
mkdir hello-hedera-agent-kit
cd hello-hedera-agent-kit
```

2. Install the agent kit, and init the project

```bash
npm install hedera-agent-kit @langchain/openai @langchain/core langchain @hashgraph/sdk dotenv
npm init -y
```

3. Add Environment Variables

If you don't already have a Hedera account, create a testnet account at [https://portal.hedera.com/dashboard](https://portal.hedera.com/dashboard)



4. Create a .env file in your directory

```bash
touch .env
```

Set up the following variables:

```
ACCOUNT_ID="0.0.xxxxx" # your operator account ID from https://portal.hedera.com/dashboard
PRIVATE_KEY="0x..." # ECDSA encoded private key
OPENAI_API_KEY="sk-proj-..." # Create an OpenAPI Key at https://platform.openai.com/api-keys
```

### Basic Conversational Agent

Once you have your project set up, create an index.js file:

```bash
touch index.js
```

{% code title="index.js" %}
```typescript
import dotenv from 'dotenv';
dotenv.config();

import { ChatOpenAI } from '@langchain/openai';
import { ChatPromptTemplate } from '@langchain/core/prompts';
import { AgentExecutor, createToolCallingAgent } from 'langchain/agents';
import { Client, PrivateKey } from '@hashgraph/sdk';
import { HederaLangchainToolkit } from 'hedera-agent-kit';


async function main() {
  // Initialise OpenAI LLM
  const llm = new ChatOpenAI({
    model: 'gpt-4o-mini',
  });

  // Hedera client setup (Testnet by default)
  const client = Client.forTestnet().setOperator(
    process.env.ACCOUNT_ID,
    PrivateKey.fromStringDer(process.env.PRIVATE_KEY),
  ); // get these from https://portal.hedera.com

  const hederaAgentToolkit = new HederaLangchainToolkit({
    client,
    configuration: {
      tools: [] // use an empty array if you want to load all tools
    },
  });
  
  // Load the structured chat prompt template
  const prompt = ChatPromptTemplate.fromMessages([
    ['system', 'You are a helpful assistant'],
    ['placeholder', '{chat_history}'],
    ['human', '{input}'],
    ['placeholder', '{agent_scratchpad}'],
  ]);

  // Fetch tools from toolkit
  const tools = hederaAgentToolkit.getTools();

  // Create the underlying agent
  const agent = createToolCallingAgent({
    llm,
    tools,
    prompt,
  });
  
  // Wrap everything in an executor that will maintain memory
  const agentExecutor = new AgentExecutor({
    agent,
    tools,
  });
  
  const response = await agentExecutor.invoke({ input: "what's my balance?" });
  console.log(response);
}

main().catch(console.error);
```
{% endcode %}

### Examples

See and try out the [**example NextJS Application** ](https://github.com/hedera-dev/template-hedera-agent-kit-nextjs)built using the latest version of the AI Agent Kit to see

[**Clone and try out**](https://github.com/hedera-dev/hedera-agent-kit?tab=readme-ov-file#-clone--test-the-sdk-examples) different examples in the toolkit:

* The [**example tool calling agent**](https://github.com/hedera-dev/hedera-agent-kit?tab=readme-ov-file#2--configure-add-environment-variables-1) can carry out simple tasks with hedera tools in 'autonomous mode'
* The [**structured chat agent**](https://github.com/hedera-dev/hedera-agent-kit?tab=readme-ov-file#4--option-b-run-the-structured-chat-agent) can string together and complete more complex tasks, autonomously on Hedera
* The [**human in the loop agent**](https://github.com/hedera-dev/hedera-agent-kit?tab=readme-ov-file#5---option-c-try-the-human-in-the-loop-chat-agent) shows you how you can create a more controlled workflow
* [**Try out the MCP server**](https://github.com/hedera-dev/hedera-agent-kit?tab=readme-ov-file#6---option-d-try-out-the-mcp-server) to enable interaction with Hedera in your favorite application such as Claude Desktop or an IDE like Cursor.&#x20;

## About the Agent Kit

### Agent Execution Modes

This tool has two execution modes with AI agents; autonomous excution and return bytes. If you set:

* `mode: AgentMode.RETURN_BYTE` the transaction will be executed, and the bytes to execute the Hedera transaction will be returned.
* `mode: AgentMode.AUTONOMOUS` the transaction will be executed autonomously, using the accountID set (the operator account can be set in the client with `.setOperator(process.env.ACCOUNT_ID!`)

## Agent Kit Tools

The Hedera Agent Kit provides a set of tools to execute transactions on the Hedera network, which we will be expanding in the future.

**Available Tools**

* Transfer HBAR
* Create a Topic
* Submit a message to a Topic
* Create a Fungible Token
* Create a Non-Fungible Token
* Mint Fungible and Non-Fungible Tokens
* Create and Transfer ERC20 and ERC721 Tokens
* Airdrop Fungible Tokens

See the available tools and implementation details in the Github docs: [TOOLS.md](https://github.com/hedera-dev/hedera-agent-kit/blob/main/docs/TOOLS.md)

#### Hedera Mirror Node Query Tools

The Hedera network is made up of two types of nodes: consensus nodes and mirror nodes. Mirror nodes are free to query, and maintain a copy of the state of the network for users to query.

The Hedera Agent Kit provides a set of tools to execute and query these nodes:

* Get Account Query
* Get HBAR Balance Query
* Get Account Token Balances Query
* Get Topic Messages Query

If you need additional functionality outside of these Hedera tools, please [open an issue](https://github.com/hedera-dev/hedera-agent-kit/issues/new?template=toolkit_feature_request.md\&title=%5BFEATURE%5D%20-%20).

## Requests and Contributions

To request more functionality in the toolkit for:

* [Token Service](https://docs.hedera.com/hedera/sdks-and-apis/sdks/token-service)
* [Consensus Service](https://docs.hedera.com/hedera/sdks-and-apis/sdks/consensus-service)
* [Smart Contract Servce](https://docs.hedera.com/hedera/tutorials/smart-contracts)

**To request additional functionality,** please [**open an issue**](https://github.com/hedera-dev/hedera-agent-kit/issues/new?template=toolkit_feature_request.yml\&labels=feature-request)**.**\
**To contribute** to the Hedera Agent Kit see the [**Contributing Guidelines**](https://github.com/hedera-dev/hedera-agent-kit/blob/main/CONTRIBUTING.md)

## Examples

You can [**clone and try out** ](https://github.com/hedera-dev/hedera-agent-kit?tab=readme-ov-file#-clone--test-the-sdk-examples)different examples in the toolkit:

* The [**example tool calling agent**](https://github.com/hedera-dev/hedera-agent-kit?tab=readme-ov-file#2--configure-add-environment-variables-1) can carry out simple tasks with hedera tools in 'autonomous mode'
* The [**structured chat agent**](https://github.com/hedera-dev/hedera-agent-kit?tab=readme-ov-file#4--option-b-run-the-structured-chat-agent) can string together and complete more complex tasks, autonomously on Hedera
* The [**human in the loop agent**](https://github.com/hedera-dev/hedera-agent-kit?tab=readme-ov-file#5---option-c-try-the-human-in-the-loop-chat-agent) shows you how you can create a more controlled workflow
* [**Try out the MCP server**](https://github.com/hedera-dev/hedera-agent-kit?tab=readme-ov-file#6---option-d-try-out-the-mcp-server) to enable interaction with Hedera in your favorite application such as Claude Desktop or an IDE like Cursor.

## Resources

* **GitHub**: [github.com/hedera-dev/hedera-agent-kit](https://github.com/hedera-dev/hedera-agent-kit)&#x20;
* **NPM**: [hedera-agent-kit](https://www.npmjs.com/package/hedera-agent-kit)
* **Issues**: [https://github.com/hedera-dev/hedera-agent-kit/issues](https://github.com/hedera-dev/hedera-agent-kit/issues)
