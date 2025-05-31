# Handling User Prompts with Hedera Agent Kit

When building applications with `HederaConversationalAgent`, establishing a proper flow for handling user prompts and agent responses is crucial. This guide explains how to process user inputs, manage conversation history, and handle the various response types from the agent.

## Processing User Prompts

To send a user's message to the agent and receive a response:

```typescript
// Initialize the agent as shown in the Quick Start example
const conversationalAgent = new HederaConversationalAgent(agentSigner, {
  operationalMode: 'provideBytes',
  userAccountId: userAccountId,
  openAIApiKey: openaiApiKey,
});
await conversationalAgent.initialize();

// Create a chat history array to maintain conversation context
const chatHistory: Array<{ type: 'human' | 'ai'; content: string }> = [];

// Process a user message
async function handleUserMessage(userInput: string) {
  // Add the user's message to chat history
  chatHistory.push({ type: 'human', content: userInput });

  // Process the message using the agent
  const agentResponse = await conversationalAgent.processMessage(
    userInput,
    chatHistory
  );

  // Add the agent's response to chat history
  chatHistory.push({ type: 'ai', content: agentResponse.output });

  // Return the full response to handle any transaction data
  return agentResponse;
}
```

## Understanding Agent Responses

The `processMessage` method returns an `AgentResponse` object with these key properties:

```typescript
interface AgentResponse {
  output: string;              // The text response to show to the user
  message?: string;            // Additional message content
  transactionBytes?: string;   // Base64-encoded transaction bytes (when in 'provideBytes' mode)
  scheduleId?: string;         // The schedule ID when a transaction was scheduled
  notes?: string[];            // Important: Inferences the agent made (see section below)
  error?: string;              // Error message if something went wrong
}
```

## Handling Different Response Types

Depending on your operational mode, you'll need to handle different response types:

### 1. Text-only Responses

Simple informational responses require no special handling:

```typescript
const response = await handleUserMessage("What's my HBAR balance?");
console.log(response.output); // Display to the user
```

### 2. Transaction Bytes (provideBytes mode)

When the agent generates transaction bytes, you'll need to present them to the user for signing:

```typescript
const response = await handleUserMessage('Transfer 10 HBAR to 0.0.12345');

if (response.transactionBytes) {
  // Option 1: Using Hashinal WalletConnect SDK
  import { HashinalsWalletConnectSDK } from '@hashgraphonline/hashinal-wc';
  import { Transaction } from '@hashgraph/sdk';
  
  const sdk = HashinalsWalletConnectSDK.getInstance();
  await sdk.init(projectId, metadata);
  await sdk.connect();
  
  // Sign and submit the transaction
  const txBytes = Buffer.from(response.transactionBytes, 'base64');
  const transaction = Transaction.fromBytes(txBytes);
  const receipt = await sdk.executeTransaction(transaction);
  console.log('Transaction executed:', receipt);

  // Option 2: If you have the user's key in your app
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

### 3. Schedule IDs (scheduled transactions)

When the agent creates a scheduled transaction:

```typescript
const response = await handleUserMessage(
  'Schedule a transfer of 5 HBAR from my account to 0.0.12345'
);

if (response.scheduleId) {
  const scheduleIdStr = response.scheduleId.toString();
  console.log(`Transaction scheduled with ID: ${scheduleIdStr}`);

  // Ask the user if they want to sign the scheduled transaction
  const userWantsToSign = await askUserForConfirmation();

  if (userWantsToSign) {
    // Ask the agent to prepare the ScheduleSign transaction
    const signResponse = await handleUserMessage(
      `Sign the scheduled transaction with ID ${scheduleIdStr}`
    );

    // Handle the resulting transaction bytes as shown above
    if (signResponse.transactionBytes) {
      // Present to wallet or sign with user key
    }
  }
}
```

### 4. Handling Inference Notes

The `notes` field is crucial for transparency - it shows what assumptions the agent made when your request was ambiguous or incomplete:

```typescript
const response = await handleUserMessage('Create a token called YES');

if (response.notes && response.notes.length > 0) {
  console.log("I've made some inferences based on your prompt. If this isn't what you expected, please try a more refined prompt.");
  response.notes.forEach(note => console.log(note));
}

// Example notes from actual agent responses:
// - "The number of decimal places for your token was automatically set to '0'."
// - "Your token's supply type was set to 'FINITE' by default."
// - "A maximum supply of '1,000,000,000,000,000' for the token was set by default."
// - "We've generated a token symbol 'YES' for you, based on the token name 'YES'."
```

**Why notes matter:**
- **Parameter Defaults**: Shows what default values were applied (decimals, supply limits, etc.)
- **Auto-generation**: Reveals what the agent created automatically (symbols, names)
- **Configuration Choices**: Explains decisions made about token/transaction parameters  
- **Transparency**: Helps users understand exactly what will be created
- **Refinement**: Users can provide more specific details if defaults aren't desired

**Best practice**: Always display notes to users so they can verify the agent's parameter choices before proceeding with transactions.

## Working with Chat History

The chat history is crucial for giving the agent context of the conversation. Best practices:

### 1. Format
Each entry should have a `type` ('human' or 'ai') and `content` (string):

```typescript
interface ChatMessage {
  type: 'human' | 'ai' | 'system';
  content: string;
}
```

### 2. Memory Management
Limit history length to avoid token limits:

```typescript
// Trim history if it gets too long
if (chatHistory.length > 20) {
  // Keep the most recent 15 messages
  chatHistory.splice(0, chatHistory.length - 15);
}
```

### 3. Preserving Context
For better results, include important context:

```typescript
// Special initialization message to set context
chatHistory.push({
  type: 'system',
  content: 'The user's account ID is 0.0.12345. They are interested in NFTs.'
});
```

## Complete Prompt Handling Flow

Here's a complete example bringing all the concepts together:

```typescript
async function handleHederaConversation() {
  // Initialize agent
  const agent = new HederaConversationalAgent(agentSigner, {
    operationalMode: 'provideBytes',
    userAccountId: userAccountId,
    openAIApiKey: openaiApiKey,
  });
  await agent.initialize();

  const chatHistory = [];

  // Initialize with context
  chatHistory.push({
    type: 'system',
    content: `User account: ${userAccountId}. Network: ${network}.`,
  });

  // Simulated chat loop
  while (true) {
    const userInput = await getUserInput(); // Your UI input function
    if (userInput.toLowerCase() === 'exit') break;

    chatHistory.push({ type: 'human', content: userInput });

    const response = await agent.processMessage(userInput, chatHistory);
    displayToUser(response.output);
    chatHistory.push({ type: 'ai', content: response.output });

    // Handle special responses
    if (response.transactionBytes) {
      const shouldSign = await askUserToSign();
      if (shouldSign) {
        await signAndSubmitTransaction(response.transactionBytes);
      }
    }

    if (response.scheduleId) {
      displayToUser(
        `Transaction scheduled! ID: ${response.scheduleId.toString()}`
      );
      // Handle schedule signing if needed
    }

    // Display inference notes if any
    if (response.notes && response.notes.length > 0) {
      displayToUser("⚠️  Agent inferences (please verify):");
      response.notes.forEach(note => displayToUser(`- ${note}`));
      displayToUser("If these assumptions are incorrect, please provide more specific details.");
    }

    // Trim history if needed
    if (chatHistory.length > 20) chatHistory.splice(0, chatHistory.length - 15);
  }
}
```

## Real-World Example: Scheduled Transaction Handling

Here's a complete example of handling scheduled transactions, including checking their status and approving them:

```typescript
import { HashinalsWalletConnectSDK } from '@hashgraphonline/hashinal-wc';
import { ScheduleSignTransaction } from '@hashgraph/sdk';
import { HederaMirrorNode, TransactionParser } from '@hashgraphonline/standards-sdk';

async function handleScheduledTransaction(scheduleId: string, network: 'mainnet' | 'testnet') {
  // Initialize WalletConnect SDK
  const sdk = HashinalsWalletConnectSDK.getInstance();
  await sdk.init(projectId, metadata);
  await sdk.connect();
  
  // Create mirror node instance
  const mirrorNode = new HederaMirrorNode(network);
  
  // Fetch schedule information
  const scheduleInfo = await mirrorNode.getScheduleInfo(scheduleId);
  
  if (!scheduleInfo) {
    throw new Error('Schedule not found');
  }
  
  // Check if already executed
  if (scheduleInfo.executed_timestamp) {
    console.log('Transaction already executed at:', scheduleInfo.executed_timestamp);
    return { status: 'executed', timestamp: scheduleInfo.executed_timestamp };
  }
  
  // Parse transaction details
  const transactionDetails = TransactionParser.parseScheduleResponse({
    transaction_body: scheduleInfo.transaction_body,
    memo: scheduleInfo.memo,
  });
  
  console.log('Transaction Details:', {
    type: transactionDetails.humanReadableType,
    transfers: transactionDetails.transfers,
    memo: transactionDetails.memo,
    expirationTime: scheduleInfo.expiration_time
  });
  
  // Create and execute the ScheduleSign transaction
  const scheduleSignTx = new ScheduleSignTransaction()
    .setScheduleId(scheduleId);
  
  try {
    // For scheduled transactions, disable signer since it's already configured
    const receipt = await sdk.executeTransaction(scheduleSignTx, false);
    console.log('Schedule signed successfully:', receipt);
    return { status: 'signed', receipt };
  } catch (error) {
    console.error('Failed to sign schedule:', error);
    throw error;
  }
}

// Usage with HederaConversationalAgent
async function exampleScheduledTransactionFlow() {
  const agent = new HederaConversationalAgent(agentSigner, {
    operationalMode: 'provideBytes',
    userAccountId: userAccountId,
    scheduleUserTransactionsInBytesMode: true, // Auto-schedule user transactions
  });
  
  // User requests a scheduled transaction
  const response = await agent.processMessage(
    'Schedule a transfer of 10 HBAR from my account to 0.0.12345 for tomorrow'
  );
  
  if (response.scheduleId) {
    console.log('Transaction scheduled with ID:', response.scheduleId.toString());
    
    // Handle the scheduled transaction approval
    const result = await handleScheduledTransaction(
      response.scheduleId.toString(),
      'testnet'
    );
    
    console.log('Schedule handling result:', result);
  }
}
```

## Polling for Schedule Status

Monitor the status of scheduled transactions:

```typescript
async function pollScheduleStatus(scheduleId: string, network: 'mainnet' | 'testnet') {
  const mirrorNode = new HederaMirrorNode(network);
  
  const checkStatus = async () => {
    const scheduleInfo = await mirrorNode.getScheduleInfo(scheduleId);
    
    if (scheduleInfo?.executed_timestamp) {
      console.log('Schedule executed!');
      clearInterval(intervalId);
      
      // Get the executed transaction details
      const executedTx = await mirrorNode.getTransactionByTimestamp(
        scheduleInfo.executed_timestamp
      );
      console.log('Executed transaction:', executedTx);
    } else if (scheduleInfo?.deleted_timestamp) {
      console.log('Schedule was deleted');
      clearInterval(intervalId);
    } else {
      console.log('Schedule still pending...');
    }
  };
  
  // Check immediately and then every 5 seconds
  await checkStatus();
  const intervalId = setInterval(checkStatus, 5000);
  
  // Return cleanup function
  return () => clearInterval(intervalId);
}
```

## Error Handling

Always handle errors gracefully:

```typescript
try {
  const response = await agent.processMessage(userInput, chatHistory);
  
  if (response.error) {
    console.error('Agent error:', response.error);
    displayToUser(`Sorry, I encountered an error: ${response.error}`);
    return;
  }
  
  // Handle successful response
} catch (error) {
  console.error('Processing error:', error);
  displayToUser('Sorry, something went wrong. Please try again.');
}
```

## Tips for Better Conversations

1. **Be Specific**: Include account IDs, token IDs, and amounts explicitly
2. **Provide Context**: Tell the agent about your intent
3. **Handle Ambiguity**: Check inference notes and confirm when needed
4. **Maintain History**: Keep relevant context in the chat history
5. **Validate Input**: Check user input before sending to the agent

## Next Steps

- Learn about [Available Tools](./hedera-agent-kit-tools-reference.md) for all capabilities
- Explore [Service Builders](./hedera-agent-kit-builders.md) for programmatic control
- Check out [Query Operations](./hedera-agent-kit-queries.md) for reading data
- Build [Multi-Agent Systems](./hedera-agent-kit-openconvai.md) with OpenConvAI