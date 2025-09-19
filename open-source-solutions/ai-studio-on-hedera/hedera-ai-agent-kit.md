---
description: >-
  Features and Functionality in the Hedera Agent Kit SDK at
  https://github.com/hashgraph/hedera-agent-kit
---

# Hedera AI Agent Kit

## Overview

Build LLM-powered applications that interact with the Hedera Network. Create conversational agents that can understand user requests in natural language and execute Hedera transactions, or build backend systems that leverage AI for on-chain operations.

The Hedera Agent Kit provides:

* **Conversational AI**: LangChain-based agents that understand natural language
* **Adaptors for Framework Tools**:  Pre-built tools covering Hedera services (and third party plugins), automatically adapted into popular frameworks like LangChain, Vercel ai-sdk, and MCP
* **Flexible Transaction Handling**: Direct execution or provide transaction bytes for user signing
* **Autonomous and Human-in-the-Loop** mode for executing transactions on Hedera
* **A Plugin Architecture -** For using both Hedera network capabilities and services, as well as third-party features and functionality

***

## Quick Start - Create a Hedera Agent

See the npm package for the Hedera Agent Kit can be found at: [https://www.npmjs.com/package/hedera-agent-kit](https://www.npmjs.com/package/hedera-agent-kit)

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

3.  Install ONE of these AI provider packages:

    ```bash
    # Option 1: OpenAI (requires API key)
    npm install @langchain/openai

    # Option 2: Anthropic Claude (requires API key)
    npm install @langchain/anthropic

    # Option 3: Groq (free tier available)
    npm install @langchain/groq

    # Option 4: Ollama (100% free, runs locally)
    npm install @langchain/ollama
    ```
4. Add Environment Variables

Create a .env file in your directory

```bash
touch .env
```

If you don't already have a Hedera account, create a testnet account at [https://portal.hedera.com/dashboard](https://portal.hedera.com/dashboard)

Add the following to the .env file:

{% code overflow="wrap" %}
```
# Required: Hedera credentials (get free testnet account at https://portal.hedera.com/dashboard)
HEDERA_ACCOUNT_ID="0.0.xxxxx"
HEDERA_PRIVATE_KEY="0x..." # ECDSA encoded private key

# Optional: Add the API key for your chosen AI provider
OPENAI_API_KEY="sk-proj-..."      # For OpenAI (https://platform.openai.com/api-keys)
ANTHROPIC_API_KEY="sk-ant-..."    # For Claude (https://console.anthropic.com)
GROQ_API_KEY="gsk_..."            # For Groq free tier (https://console.groq.com/keys)
# Ollama doesn't need an API key (runs locally)
```
{% endcode %}

5. Once you have your project set up, create an index.js file:

```bash
touch index.js
```

{% code title="index.js" %}
```javascript
const dotenv = require('dotenv');
dotenv.config();

const { ChatPromptTemplate } = require('@langchain/core/prompts');
const { AgentExecutor, createToolCallingAgent } = require('langchain/agents');
const { Client, PrivateKey } = require('@hashgraph/sdk');
const { HederaLangchainToolkit, coreQueriesPlugin } = require('hedera-agent-kit');

// Choose your AI provider (install the one you want to use)
function createLLM() {
  // Option 1: OpenAI (requires OPENAI_API_KEY in .env)
  if (process.env.OPENAI_API_KEY) {
    const { ChatOpenAI } = require('@langchain/openai');
    return new ChatOpenAI({ model: 'gpt-4o-mini' });
  }
  
  // Option 2: Anthropic Claude (requires ANTHROPIC_API_KEY in .env)
  if (process.env.ANTHROPIC_API_KEY) {
    const { ChatAnthropic } = require('@langchain/anthropic');
    return new ChatAnthropic({ model: 'claude-3-haiku-20240307' });
  }
  
  // Option 3: Groq (requires GROQ_API_KEY in .env)
  if (process.env.GROQ_API_KEY) {
    const { ChatGroq } = require('@langchain/groq');
    return new ChatGroq({ model: 'llama3-8b-8192' });
  }
  
  // Option 4: Ollama (free, local - requires Ollama installed and running)
  try {
    const { ChatOllama } = require('@langchain/ollama');
    return new ChatOllama({ 
      model: 'llama3.2',
      baseUrl: 'http://localhost:11434'
    });
  } catch (e) {
    console.error('No AI provider configured. Please either:');
    console.error('1. Set OPENAI_API_KEY, ANTHROPIC_API_KEY, or GROQ_API_KEY in .env');
    console.error('2. Install and run Ollama locally (https://ollama.com)');
    process.exit(1);
  }
}

async function main() {
  // Initialize AI model
  const llm = createLLM();

  // Hedera client setup (Testnet by default)
  const client = Client.forTestnet().setOperator(
    process.env.HEDERA_ACCOUNT_ID,
    PrivateKey.fromStringECDSA(process.env.HEDERA_PRIVATE_KEY),
  );

  const hederaAgentToolkit = new HederaLangchainToolkit({
    client,
    configuration: {
      plugins: [coreQueriesPlugin] // all our core plugins here https://github.com/hedera-dev/hedera-agent-kit/tree/main/typescript/src/plugins
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

6. Run Your "Hello Hedera Agent Kit" Example

From the root directory, run your example agent, and prompt it to give your hbar balance:

```bash
node index.js
```

***

## Examples

See and try out the [**example NextJS Application** ](https://github.com/hedera-dev/template-hedera-agent-kit-nextjs)built using the latest version of the AI Agent Kit to see

[**Clone and try out**](https://github.com/hedera-dev/hedera-agent-kit?tab=readme-ov-file#-clone--test-the-sdk-examples) different examples in the toolkit:

* The [**example tool calling agent**](https://github.com/hedera-dev/hedera-agent-kit?tab=readme-ov-file#2--configure-add-environment-variables-1) can carry out simple tasks with Hedera tools in 'autonomous mode'
* The [**structured chat agent**](https://github.com/hedera-dev/hedera-agent-kit?tab=readme-ov-file#4--option-b-run-the-structured-chat-agent) can string together and complete more complex tasks, autonomously on Hedera
* The [**human in the loop agent**](https://github.com/hedera-dev/hedera-agent-kit?tab=readme-ov-file#5---option-c-try-the-human-in-the-loop-chat-agent) shows you how you can create a more controlled workflow
* [**Try out the MCP server**](https://github.com/hedera-dev/hedera-agent-kit?tab=readme-ov-file#6---option-d-try-out-the-mcp-server) to enable interaction with Hedera in your favorite application such as Claude Desktop or an IDE like Cursor.&#x20;

## About the Agent Kit

### Agent Execution Modes

This tool has two execution modes with AI agents; autonomous excution and return bytes. If you set:

* `mode: AgentMode.RETURN_BYTE` the transaction will be executed, and the bytes to execute the Hedera transaction will be returned.
* `mode: AgentMode.AUTONOMOUS` the transaction will be executed autonomously, using the accountID set (the operator account can be set in the client with `.setOperator(process.env.ACCOUNT_ID!`)

## Agent Kit Plugins

The Hedera Agent Kit provides a basic set of tools in the form of Plugins, which group together sets of functionality and can easily be included in your instance of hederaAgentToolkit

Need additional capabilities with the agent kit, that isn't currently included? Please [open an issue](https://github.com/hedera-dev/hedera-agent-kit/issues/new?template=toolkit_feature_request.md\&title=%5BFEATURE%5D%20-%20).

**Available Plugins**

* **Core Account Plugin**: Tools for Hedera Account Service operations
* **Core Consensus Plugin**: Tools for Hedera Consensus Service (HCS) operations
* **Core HTS Plugin**: Tools for Hedera Token Service operations
* **Core Queries Plugin**: Tools for querying Hedera network data

See the available plugins, the included tools, examples, and instructions on how to use a in the Github docs: [PLUGINS.md](https://github.com/hashgraph/hedera-agent-kit/blob/main/docs/HEDERAPLUGINS.md)

## Requests and Contributions

**To request additional functionality,** please [**open an issue**](https://github.com/hedera-dev/hedera-agent-kit/issues/new?template=toolkit_feature_request.yml\&labels=feature-request)**.**\
**To contribute** to the Hedera Agent Kit see the [**Contributing Guidelines**](https://github.com/hedera-dev/hedera-agent-kit/blob/main/CONTRIBUTING.md) \
**To create your own plugin,** see the instructions in [PLUGINS.md](https://github.com/hashgraph/hedera-agent-kit/blob/main/docs/PLUGINS.md)\
**To officially register your plugin**, [follow the instructions here](https://github.com/hashgraph/hedera-agent-kit/blob/main/docs/PLUGINS.md#publish-and-register-your-plugin)



## Resources

* **GitHub**: [https://github.com/hashgraph/hedera-agent-kit](https://github.com/hashgraph/hedera-agent-kit)
* **npm**: [hedera-agent-kit](https://www.npmjs.com/package/hedera-agent-kit)
* **Issues**: [https://github.com/hedera-dev/hedera-agent-kit/issues](https://github.com/hedera-dev/hedera-agent-kit/issues)
