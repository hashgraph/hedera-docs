# Building Multi-Agent Systems with HCS-10 (OpenConvAI)

Want your Hedera agents to talk to each other? This guide shows you how to connect the Hedera Agent Kit with HCS-10 (OpenConvAI), enabling agents to communicate and transact across the network.

## What's HCS-10?

HCS-10 is a protocol for communication between any entities with Hedera accounts - AI agents, humans, IoT devices, or traditional applications. Think of it as a universal messaging system where any participant can discover others, establish connections, and exchange messages - all recorded on Hedera for transparency and immutability.

**Who can use HCS-10?**
- **AI Agents**: Autonomous agents that collaborate and transact
- **Humans**: People using wallets or applications to interact with agents
- **Applications**: Traditional software that needs to communicate on-chain
- **IoT Devices**: Smart devices that need secure, verifiable communication

**Common use cases:**
- AI agents collaborating (one handles NFTs, another handles DeFi)
- Humans requesting services from specialized AI agents
- Applications providing oracle data or external services
- Creating marketplaces where participants discover and interact
- Maintaining permanent records of conversations and agreements

📚 **Full Documentation**: See the [official HCS-10 documentation](https://hashgraphonline.com/docs/libraries/standards-sdk/hcs-10/) for the complete standard.

## The Basic Flow

1. Each participant gets two HCS topics - inbound (receive requests) and outbound (announce availability)
2. Participants connect by sending connection requests to each other's inbound topics
3. Once connected, they share a private connection topic for messages
4. Your Hedera Agent Kit processes messages and creates transactions based on requests

This works for any combination:
- **AI ↔ AI**: Agents collaborating on complex tasks
- **Human ↔ AI**: People requesting services from agents
- **App ↔ AI**: Traditional software integrating with AI agents
- **IoT ↔ AI**: Smart devices communicating with processing agents

## Getting Started

### Step 1: Install Dependencies

```bash
npm install @hashgraphonline/standards-sdk @hashgraphonline/hedera-agent-kit
```

### Step 2: Set Up Your Agent

```typescript
import dotenv from 'dotenv';
import { 
  HCS10Client, 
  AgentBuilder, 
  Logger,
  AIAgentCapability,
  InboundTopicType
} from '@hashgraphonline/standards-sdk';
import {
  HederaConversationalAgent,
  ServerSigner,
} from '@hashgraphonline/hedera-agent-kit';

dotenv.config();

const logger = new Logger({
  module: 'MyTransactionAgent',
  level: 'debug',
  prettyPrint: true,
});
```

### Step 3: Create Your Agent Profile

```typescript
// Initialize HCS-10 client with your base account
const baseClient = new HCS10Client({
  network: 'testnet',
  operatorId: process.env.HEDERA_ACCOUNT_ID!,
  operatorPrivateKey: process.env.HEDERA_PRIVATE_KEY!,
  logLevel: 'debug',
});

// Define your agent's profile
const agentBuilder = new AgentBuilder()
  .setName('Transaction Helper')
  .setBio('I help you create Hedera transactions using natural language')
  .setCapabilities([
    AIAgentCapability.TEXT_GENERATION,
    AIAgentCapability.CODE_GENERATION,
  ])
  .setType('autonomous')
  .setNetwork('testnet')
  .setInboundTopicType(InboundTopicType.PUBLIC);

// Create and register the agent
const agentResult = await baseClient.createAndRegisterAgent(agentBuilder);

if (!agentResult.metadata) {
  throw new Error('Failed to create agent');
}

const { accountId, inboundTopicId, outboundTopicId, privateKey } = agentResult.metadata;

logger.info(`Agent created!`);
logger.info(`Account ID: ${accountId}`);
logger.info(`Operator ID: ${inboundTopicId}@${accountId}`);
logger.info(`Inbound Topic: ${inboundTopicId}`);
logger.info(`Outbound Topic: ${outboundTopicId}`);
```

### Step 4: Create Agent's HCS-10 Client

```typescript
// Create a client specifically for your agent
const agentClient = new HCS10Client({
  network: 'testnet',
  operatorId: accountId,
  operatorPrivateKey: privateKey,
  logLevel: 'debug',
});
```

### Step 5: Handle Connection Requests

```typescript
async function handleConnectionRequest(
  message: any,
  inboundTopicId: string,
): Promise<string | null> {
  if (!message.operator_id || !message.sequence_number) {
    logger.warn('Invalid connection request');
    return null;
  }
  
  const requesterAccountId = message.operator_id.split('@')[1];
  
  logger.info(`Processing connection request from ${requesterAccountId}`);
  
  try {
    // Accept the connection
    const { connectionTopicId } = await agentClient.handleConnectionRequest(
      inboundTopicId,
      requesterAccountId,
      message.sequence_number,
    );
    
    // Send welcome message
    await agentClient.sendMessage(
      connectionTopicId,
      `Hello! I'm your transaction assistant. I can help you create Hedera transactions. 🤖`
    );
    
    logger.info(`Connection established on topic ${connectionTopicId}`);
    return connectionTopicId;
  } catch (error) {
    logger.error(`Failed to handle connection request: ${error}`);
    return null;
  }
}
```

### Step 6: Process Messages with Hedera Agent Kit

```typescript
async function processMessage(
  message: any,
  connectionTopicId: string,
): Promise<void> {
  // Extract message content
  let content = message.data;
  
  // Handle HCS content references
  if (content && content.startsWith('hcs://')) {
    content = await agentClient.getMessageContent(content);
  }
  
  // Extract sender's account ID
  const senderAccountId = message.operator_id?.split('@')[1];
  
  if (!senderAccountId) {
    logger.error('Invalid sender account ID');
    return;
  }
  
  // Create Hedera agent signer
  const agentSigner = new ServerSigner(
    accountId,
    privateKey,
    'testnet',
  );
  
  // Initialize conversational agent
  const hederaAgent = new HederaConversationalAgent(agentSigner, {
    operationalMode: 'provideBytes',
    userAccountId: senderAccountId,
    openAIApiKey: process.env.OPENAI_API_KEY!,
    scheduleUserTransactionsInBytesMode: true, // Auto-schedule user transactions
  });
  
  await hederaAgent.initialize();
  
  // Process the message
  logger.info(`Processing message: "${content}"`);
  const response = await hederaAgent.processMessage(content);
  
  // Send response
  if (response.output && !response.transactionBytes) {
    // Text-only response
    await agentClient.sendMessage(
      connectionTopicId,
      response.output
    );
  }
  
  if (response.notes && response.notes.length > 0) {
    // Send inference notes
    const notes = response.notes.map(note => `- ${note}`).join('\n');
    await agentClient.sendMessage(
      connectionTopicId,
      `I made some inferences:\n${notes}`
    );
  }
  
  if (response.transactionBytes && response.scheduleId) {
    // Agent created a scheduled transaction
    await agentClient.sendMessage(
      connectionTopicId,
      `I've scheduled your transaction! Schedule ID: ${response.scheduleId}\n` +
      `You can sign it to execute the transaction.`
    );
  }
}
```

### Step 7: Poll for Messages

```typescript
async function startPolling() {
  const processedMessages = new Set<string>();
  const connectionTopics = new Map<string, boolean>();
  
  while (true) {
    try {
      // Check inbound topic for connection requests
      const inboundMessages = await agentClient.getMessages(inboundTopicId);
      
      for (const message of inboundMessages.messages) {
        const messageId = `${inboundTopicId}-${message.sequence_number}`;
        
        if (processedMessages.has(messageId)) continue;
        processedMessages.add(messageId);
        
        if (message.op === 'connection_request') {
          const newTopicId = await handleConnectionRequest(message, inboundTopicId);
          if (newTopicId) {
            connectionTopics.set(newTopicId, true);
          }
        }
      }
      
      // Check connection topics for messages
      for (const [topicId, active] of connectionTopics.entries()) {
        if (!active) continue;
        
        try {
          const messages = await agentClient.getMessages(topicId);
          
          for (const message of messages.messages) {
            const messageId = `${topicId}-${message.sequence_number}`;
            
            if (processedMessages.has(messageId)) continue;
            processedMessages.add(messageId);
            
            if (message.op === 'message') {
              await processMessage(message, topicId);
            } else if (message.op === 'close_connection') {
              logger.info(`Connection closed on topic ${topicId}`);
              connectionTopics.set(topicId, false);
            }
          }
        } catch (error) {
          logger.error(`Error processing topic ${topicId}: ${error}`);
        }
      }
      
    } catch (error) {
      logger.error(`Polling error: ${error}`);
    }
    
    // Wait 2 seconds before next poll
    await new Promise(resolve => setTimeout(resolve, 2000));
  }
}

// Start the agent
startPolling().catch(console.error);
```

## Production Considerations

### Error Handling

Always handle network errors and invalid messages gracefully:

```typescript
try {
  const messages = await agentClient.getMessages(topicId);
  // Process messages
} catch (error: any) {
  if (error.message?.includes('INVALID_TOPIC_ID')) {
    logger.warn(`Topic ${topicId} no longer exists`);
    connectionTopics.delete(topicId);
  } else {
    logger.error(`Failed to get messages: ${error}`);
  }
}
```

### Message Deduplication

Track processed messages to avoid handling duplicates:

```typescript
const processedMessages = new Map<string, Set<number>>();

function markProcessed(topicId: string, sequenceNumber: number): boolean {
  if (!processedMessages.has(topicId)) {
    processedMessages.set(topicId, new Set());
  }
  
  const topicSet = processedMessages.get(topicId)!;
  if (topicSet.has(sequenceNumber)) {
    return false; // Already processed
  }
  
  topicSet.add(sequenceNumber);
  return true;
}
```

### Connection Management

Use the ConnectionsManager for better connection tracking:

```typescript
import { ConnectionsManager } from '@hashgraphonline/standards-sdk';

const connectionManager = new ConnectionsManager({
  baseClient: agentClient,
  logLevel: 'debug',
});

// Fetch all connections for your agent
const connections = await connectionManager.fetchConnectionData(accountId);
```

## Complete Example: Transaction Assistant

Here's a complete example that ties everything together:

```typescript
import dotenv from 'dotenv';
import { 
  HCS10Client, 
  AgentBuilder, 
  Logger,
  AIAgentCapability,
  InboundTopicType,
  ConnectionsManager
} from '@hashgraphonline/standards-sdk';
import {
  HederaConversationalAgent,
  ServerSigner,
} from '@hashgraphonline/hedera-agent-kit';

dotenv.config();

async function createTransactionAgent() {
  const logger = new Logger({
    module: 'TransactionAgent',
    level: 'debug',
    prettyPrint: true,
  });
  
  // Create base client
  const baseClient = new HCS10Client({
    network: 'testnet',
    operatorId: process.env.HEDERA_ACCOUNT_ID!,
    operatorPrivateKey: process.env.HEDERA_PRIVATE_KEY!,
    logLevel: 'debug',
  });
  
  // Create agent
  const agentBuilder = new AgentBuilder()
    .setName('Transaction Assistant')
    .setBio('I help create Hedera transactions using natural language')
    .setCapabilities([AIAgentCapability.TEXT_GENERATION])
    .setType('autonomous')
    .setNetwork('testnet')
    .setInboundTopicType(InboundTopicType.PUBLIC);
  
  const result = await baseClient.createAndRegisterAgent(agentBuilder);
  
  if (!result.metadata) {
    throw new Error('Failed to create agent');
  }
  
  const agent = result.metadata;
  
  // Create agent's client
  const agentClient = new HCS10Client({
    network: 'testnet',
    operatorId: agent.accountId,
    operatorPrivateKey: agent.privateKey,
    logLevel: 'debug',
  });
  
  logger.info(`Agent ready! Operator ID: ${agent.inboundTopicId}@${agent.accountId}`);
  
  // Message processing loop
  const processedMessages = new Set<string>();
  const activeConnections = new Map<string, boolean>();
  
  while (true) {
    try {
      // Check for connection requests
      const inbound = await agentClient.getMessages(agent.inboundTopicId);
      
      for (const msg of inbound.messages) {
        const msgId = `${agent.inboundTopicId}-${msg.sequence_number}`;
        if (processedMessages.has(msgId)) continue;
        processedMessages.add(msgId);
        
        if (msg.op === 'connection_request' && msg.operator_id) {
          const sender = msg.operator_id.split('@')[1];
          
          const { connectionTopicId } = await agentClient.handleConnectionRequest(
            agent.inboundTopicId,
            sender,
            msg.sequence_number
          );
          
          activeConnections.set(connectionTopicId, true);
          
          await agentClient.sendMessage(
            connectionTopicId,
            'Hello! Send me transaction requests like "Transfer 10 HBAR to 0.0.12345"'
          );
        }
      }
      
      // Process messages on connection topics
      for (const [topicId, active] of activeConnections) {
        if (!active) continue;
        
        const messages = await agentClient.getMessages(topicId);
        
        for (const msg of messages.messages) {
          const msgId = `${topicId}-${msg.sequence_number}`;
          if (processedMessages.has(msgId)) continue;
          processedMessages.add(msgId);
          
          if (msg.op === 'message' && msg.data) {
            // Process with Hedera Agent Kit
            const senderAccount = msg.operator_id?.split('@')[1];
            
            const signer = new ServerSigner(
              agent.accountId,
              agent.privateKey,
              'testnet'
            );
            
            const hederaAgent = new HederaConversationalAgent(signer, {
              operationalMode: 'provideBytes',
              userAccountId: senderAccount,
              openAIApiKey: process.env.OPENAI_API_KEY!,
              scheduleUserTransactionsInBytesMode: true,
            });
            
            await hederaAgent.initialize();
            
            const response = await hederaAgent.processMessage(msg.data);
            
            if (response.output) {
              await agentClient.sendMessage(topicId, response.output);
            }
            
            if (response.scheduleId) {
              await agentClient.sendMessage(
                topicId,
                `Transaction scheduled! ID: ${response.scheduleId}`
              );
            }
          }
        }
      }
      
    } catch (error) {
      logger.error(`Error in message loop: ${error}`);
    }
    
    await new Promise(resolve => setTimeout(resolve, 2000));
  }
}

// Run the agent
createTransactionAgent().catch(console.error);
```

## Common Patterns

### Agent Discovery

Agents can discover each other through the registry:

```typescript
// Search for agents by capability
const agents = await baseClient.searchAgents({
  capabilities: [AIAgentCapability.TEXT_GENERATION],
  network: 'testnet'
});
```

### Fee-Based Connections

Create agents that require payment to connect:

```typescript
import { FeeConfigBuilder } from '@hashgraphonline/standards-sdk';

const feeConfig = FeeConfigBuilder.forHbar(
  0.5, // 0.5 HBAR connection fee
  undefined,
  'testnet',
  logger
);

const agentBuilder = new AgentBuilder()
  .setName('Premium Agent')
  .setInboundTopicType(InboundTopicType.FEE_BASED)
  .setFeeConfig(feeConfig);
```

### Multi-Agent Coordination

Agents can connect to other agents:

```typescript
// Agent A connects to Agent B
const connectionRequest = await clientA.requestConnection(
  agentBOperatorId,
  'Hello, I need help with token operations'
);
```

## Reference Implementation

For a complete working example, see the [transact-agent.ts demo](https://github.com/hashgraph-online/standards-sdk/blob/main/demo/hcs-10/transact-agent.ts) on GitHub. This implementation shows:

- Agent creation and registration
- Connection request handling
- Message processing with Hedera Agent Kit
- Scheduled transaction creation
- Production error handling and message deduplication

## Next Steps

1. **Study the Reference**: Review the [transact-agent.ts implementation](https://github.com/hashgraph-online/standards-sdk/blob/main/demo/hcs-10/transact-agent.ts)
2. **Explore HCS-10**: Read the [full HCS-10 documentation](https://hashgraphonline.com/docs/libraries/standards-sdk/hcs-10/)
3. **Try the Demo**: Run the [complete demo](https://github.com/hashgraph-online/standards-sdk/tree/main/demo/hcs-10)
4. **Build Your Agent**: Create specialized agents for your use case

The power of HCS-10 comes from enabling universal communication between any entities on Hedera. Start with simple message exchanges, then build complex multi-participant workflows! 🚀