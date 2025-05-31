# Hedera Agent Kit

Build LLM-powered applications that interact with the Hedera Network. Create conversational agents that can understand user requests in natural language and execute Hedera transactions, or build backend systems that leverage AI for on-chain operations.

## Overview

The Hedera Agent Kit provides:

- **Conversational AI**: LangChain-based agents that understand natural language
- **Comprehensive Tools**: 67 pre-built tools covering all Hedera services
- **Flexible Transaction Handling**: Direct execution or provide transaction bytes for user signing
- **Service Builders**: Fluent APIs for programmatic Hedera operations
- **Plugin System**: Extend functionality with custom tools
- **TypeScript First**: Fully typed with comprehensive interfaces

## Installation

```bash
npm install @hashgraphonline/hedera-agent-kit @hashgraph/sdk @langchain/openai @langchain/core zod
```

For WalletConnect integration:

```bash
npm install @hashgraphonline/hashinal-wc
```

## Quick Start

### Basic Conversational Agent

```typescript
import {
  HederaConversationalAgent,
  ServerSigner,
} from '@hashgraphonline/hedera-agent-kit';
import * as dotenv from 'dotenv';

dotenv.config();

async function main() {
  const signer = new ServerSigner(
    process.env.HEDERA_ACCOUNT_ID!,
    process.env.HEDERA_PRIVATE_KEY!,
    'testnet'
  );

  const agent = new HederaConversationalAgent(signer, {
    openAIApiKey: process.env.OPENAI_API_KEY,
    operationalMode: 'directExecution',
  });

  await agent.initialize();

  const chatHistory = [];
  const response = await agent.processMessage(
    "What's my HBAR balance?",
    chatHistory
  );

  console.log('Agent:', response.output);
}

main().catch(console.error);
```

### User Transaction Signing

```typescript
const agent = new HederaConversationalAgent(agentSigner, {
  operationalMode: 'provideBytes',
  userAccountId: userAccountId,
  scheduleUserTransactionsInBytesMode: true,
});

const response = await agent.processMessage(
  'Transfer 5 HBAR from my account to 0.0.12345',
  chatHistory
);

// Response includes these fields (from actual AgentResponse interface):
// - output: string - The main response text
// - message?: string - Additional message content
// - transactionBytes?: string - Transaction bytes for user signing
// - scheduleId?: string - Schedule ID if transaction was scheduled
// - notes?: string[] - IMPORTANT: Agent's inferences and assumptions
// - error?: string - Error message if something went wrong

if (response.transactionBytes) {
  // Sign with user's key (example from langchain-demo.ts)
  const userSigner = new ServerSigner(userAccountId, userPrivateKey, network);
  const txBytes = Buffer.from(response.transactionBytes, 'base64');
  const transaction = Transaction.fromBytes(txBytes);

  const frozenTx = transaction.isFrozen()
    ? transaction
    : await transaction.freezeWith(userSigner.getClient());

  const signedTx = await frozenTx.sign(userSigner.getOperatorPrivateKey());
  const txResponse = await signedTx.execute(userSigner.getClient());
  const receipt = await txResponse.getReceipt(userSigner.getClient());
}
```

## Developer Pathways

Choose your approach based on your use case:

### 1. Conversational AI Applications

Use `HederaConversationalAgent` for natural language interfaces:

```typescript
const agent = new HederaConversationalAgent(signer, {
  openAIApiKey: process.env.OPENAI_API_KEY,
  operationalMode: 'directExecution',
});

const response = await agent.processMessage(
  'Create a token called MyToken',
  []
);
```

### 2. Programmatic Control

Use `HederaAgentKit` and service builders directly:

```typescript
const kit = new HederaAgentKit(signer);
await kit
  .hts()
  .createFungibleToken({
    name: 'MyToken',
    symbol: 'MTK',
    initialSupply: 1000,
  })
  .execute();
```

### 3. Custom Tool Development

Extend the kit with your own tools:

```typescript
class CustomTool extends BaseHederaTransactionTool {
  // Your tool implementation
}
```

## Architecture Overview

```
┌─────────────────────────────────────────────────────┐
│                  Your Application                    │
└─────────────────┬───────────────────────────────────┘
                  │
        ┌─────────┴─────────┬──────────────────┐
        ▼                   ▼                  ▼
┌───────────────┐  ┌─────────────────┐  ┌─────────────┐
│ Conversational│  │  Direct Builder │  │   Custom    │
│     Agent     │  │      Usage      │  │    Tools    │
└───────┬───────┘  └────────┬────────┘  └──────┬──────┘
        │                    │                   │
        └────────────────────┴───────────────────┘
                             │
                    ┌────────▼────────┐
                    │ Service Builders│
                    │  (Core Logic)   │
                    └────────┬────────┘
                             │
                    ┌────────▼────────┐
                    │   Hedera SDK    │
                    └─────────────────┘
```

## Core Components

### HederaConversationalAgent

For AI-powered applications with natural language interfaces.

### HederaAgentKit

The core engine that manages builders and tools.

### Service Builders

The foundation - fluent APIs that simplify Hedera SDK complexity:

- **AccountBuilder**: Account operations and HBAR transfers
- **HtsBuilder**: Token operations (most feature-rich)
- **HcsBuilder**: Consensus service operations
- **ScsBuilder**: Smart contract interactions
- **FileBuilder**: File storage operations
- **QueryBuilder**: Read-only queries

### Signers

- **ServerSigner**: Backend applications with keys
- **WalletConnect**: Use `@hashgraphonline/hashinal-wc` for browser wallets

## Available Tools

The kit includes 67 pre-built LangChain tools:

### Account Management (19 tools)

- Account creation, updates, deletion
- HBAR transfers and allowances
- Balance queries
- Scheduled transaction signing

### Token Service - HTS (26 tools)

- Token creation (fungible & NFT)
- Minting, burning, transfers
- Associations and dissociations
- Freezing, pausing, KYC operations
- Airdrops

### Consensus Service - HCS (7 tools)

- Topic creation and management
- Message submission
- Topic queries

### Smart Contracts - SCS (7 tools)

- Contract deployment
- Function execution
- Contract queries and updates

### File Service (5 tools)

- File creation and updates
- Content management

### Network & Queries (8 tools)

- Network information
- Transaction queries
- HBAR price data
- Block information

## Service Builders

Direct programmatic access to Hedera services:

```typescript
// Transfer HBAR using AccountBuilder
const result = await kit
  .accounts()
  .transferHbar({
    transfers: [
      { accountId: '0.0.RECIPIENT', amount: new Hbar(1) },
      { accountId: signer.getAccountId().toString(), amount: new Hbar(-1) },
    ],
    memo: 'Payment',
  })
  .execute();

// Create a token using HtsBuilder
const token = await kit
  .hts()
  .createFungibleToken({
    name: 'My Token',
    symbol: 'MTK',
    decimals: 2,
    initialSupply: 1000,
  })
  .execute();
```

## Plugin System

Extend functionality with custom plugins:

```typescript
import { IPlugin } from '@hashgraphonline/standards-agent-kit';

class MyPlugin implements IPlugin {
  id = 'my-plugin';
  version = '1.0.0';

  getTools(context) {
    return [
      new DynamicStructuredTool({
        name: 'my-custom-tool',
        description: 'Does something custom',
        schema: z.object({
          param: z.string(),
        }),
        func: async (input) => {
          // Implementation
          return 'Result';
        },
      }),
    ];
  }
}

// Use with agent
const agent = new HederaConversationalAgent(signer, {
  pluginConfig: {
    plugins: [new MyPlugin()],
  },
});
```

## Operational Modes

### Direct Execution

Agent signs and submits transactions using its configured signer:

```typescript
operationalMode: 'directExecution';
```

### Provide Bytes

Agent returns transaction bytes for user signing:

```typescript
operationalMode: 'provideBytes';
```

With automatic scheduling for user transactions:

```typescript
scheduleUserTransactionsInBytesMode: true;
```

## Examples

Full working examples are available in the repository:

- `examples/langchain-demo.ts` - Interactive chat demo
- `examples/hello-world-plugin.ts` - Plugin creation
- `examples/custom-mirror-node.ts` - Mirror node configuration

## Documentation

- [User Prompts Guide](./hedera-agent-kit-user-prompts.md) - Handling messages and responses
- [Query Guide](./hedera-agent-kit-queries.md) - Reading data from Hedera
- [Service Builders Guide](./hedera-agent-kit-builders.md) - Creating transactions
- [Plugin Development Guide](./hedera-agent-kit-plugins.md) - Extending functionality
- [Tools Reference](./hedera-agent-kit-tools-reference.md) - All available tools
- [OpenConvAI Integration](./hedera-agent-kit-openconvai.md) - Multi-agent communication

## Resources

- **GitHub**: [github.com/hashgraph-online/hedera-agent-kit](https://github.com/hashgraph-online/hedera-agent-kit)
- **NPM**: [@hashgraphonline/hedera-agent-kit](https://www.npmjs.com/package/@hashgraphonline/hedera-agent-kit)
- **Issues**: [GitHub Issues](https://github.com/hashgraph-online/hedera-agent-kit/issues)

## License

Apache 2.0
