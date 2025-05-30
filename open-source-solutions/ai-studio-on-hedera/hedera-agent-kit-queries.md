# Hedera Agent Kit Query Guide

Queries are fundamentally different from transactions. While transactions change the state of the Hedera network, queries simply read data. This guide covers how to retrieve information from Hedera using the Agent Kit.

## Queries vs Transactions

### Transactions (State-Changing)

- **Cost HBAR**: Require payment to execute
- **Create receipts**: Generate transaction records
- **Change state**: Modify accounts, tokens, topics, etc.
- **Need signing**: Require cryptographic signatures
- **Examples**: Transfer HBAR, create token, submit message

### Queries (Read-Only)

- **Free or cheap**: Most mirror node queries are free
- **No receipts**: Just return data
- **Read state**: Retrieve existing information
- **No signing**: Public data access
- **Examples**: Check balance, get token info, read messages

## The Query Builder

The Query Builder provides a unified interface for all Hedera queries:

```typescript
const queryBuilder = kit.query();
```

## Account Queries

Get information about Hedera accounts:

```typescript
// Get full account information
const accountInfo = await queryBuilder.getAccountInfo('0.0.12345');
console.log({
  balance: accountInfo.balance,
  autoRenewPeriod: accountInfo.auto_renew_period,
  memo: accountInfo.memo,
  key: accountInfo.key,
  stakedNodeId: accountInfo.staked_node_id,
});

// Get just the HBAR balance
const balance = await queryBuilder.getAccountBalance('0.0.12345');
console.log(`Balance: ${balance} HBAR`);

// Get account's tokens
const tokens = await queryBuilder.getAccountTokens('0.0.12345');
tokens?.forEach((token) => {
  console.log(`Token ${token.token_id}: ${token.balance}`);
});

// Get account's NFTs
const nfts = await queryBuilder.getAccountNfts('0.0.12345');
nfts?.forEach((nft) => {
  console.log(`NFT: ${nft.token_id} serial ${nft.serial_number}`);
});
```

## Token Queries

Retrieve information about tokens and NFTs:

```typescript
// Get token information
const tokenInfo = await queryBuilder.getTokenInfo('0.0.456789');
console.log({
  name: tokenInfo.name,
  symbol: tokenInfo.symbol,
  decimals: tokenInfo.decimals,
  totalSupply: tokenInfo.total_supply,
  treasuryAccount: tokenInfo.treasury_account_id,
});

// Validate NFT ownership
const ownership = await queryBuilder.validateNftOwnership(
  '0.0.12345', // account ID
  '0.0.456789', // token ID
  1 // serial number
);
if (ownership) {
  console.log('Account owns this NFT');
}

// Get specific NFT info
const nftInfo = await queryBuilder.getNftInfo('0.0.456789', 1);
console.log({
  metadata: nftInfo.metadata,
  owner: nftInfo.account_id,
  spender: nftInfo.spender,
});

// Get all NFTs for a collection
const allNfts = await queryBuilder.getNftsByToken('0.0.456789', {
  limit: 100,
  order: 'asc',
});
```

## Topic Queries

Read messages from HCS topics:

```typescript
// Get topic information
const topicInfo = await queryBuilder.getTopicInfo('0.0.789012');
console.log({
  memo: topicInfo.memo,
  runningHash: topicInfo.running_hash,
  sequenceNumber: topicInfo.sequence_number,
});

// Get all messages from a topic
const messages = await queryBuilder.getTopicMessages('0.0.789012');
messages.forEach((msg) => {
  console.log({
    sequenceNumber: msg.sequence_number,
    contents: Buffer.from(msg.message, 'base64').toString(),
    consensusTimestamp: msg.consensus_timestamp,
  });
});

// Get filtered messages
const recentMessages = await queryBuilder.getTopicMessagesByFilter(
  '0.0.789012',
  {
    limit: 10,
    order: 'desc',
    startTime: new Date(Date.now() - 3600000).toISOString(), // Last hour
  }
);
```

## Transaction Queries

Look up past transactions:

```typescript
// Get transaction by ID
const tx = await queryBuilder.getTransaction('0.0.12345@1234567890.123456789');
console.log({
  result: tx.result,
  consensus_timestamp: tx.consensus_timestamp,
  transfers: tx.transfers,
});

// Get scheduled transaction status
const scheduleStatus = await queryBuilder.getScheduledTransactionStatus(
  '0.0.999888'
);
console.log({
  executed: scheduleStatus.executed,
  deleted: scheduleStatus.deleted,
  executedDate: scheduleStatus.executedDate,
});

// Get transaction by timestamp
const txByTime = await queryBuilder.getTransactionByTimestamp(
  '1234567890.123456789'
);
```

## Network Queries

Get network-wide information:

```typescript
// Get current HBAR price
const hbarPrice = await queryBuilder.getHbarPrice(new Date());
console.log(`HBAR price: $${hbarPrice}`);

// Get recent blocks
const blocks = await queryBuilder.getBlocks({
  limit: 10,
  order: 'desc',
});

// Get network information
const networkInfo = await queryBuilder.getNetworkInfo();
console.log({
  network: networkInfo.network,
  version: networkInfo.version,
});

// Get network fees
const fees = await queryBuilder.getNetworkFees();
console.log(`Current fee schedule:`, fees);

// Get network supply
const supply = await queryBuilder.getNetworkSupply();
console.log(`Total HBAR supply: ${supply.total_supply}`);
```

## Smart Contract Queries

Query smart contracts without executing transactions:

```typescript
// Read contract view/pure functions
const result = await queryBuilder.readSmartContract(
  '0.0.123456', // contract ID
  '0x70a08231', // function selector for balanceOf(address)
  '0.0.12345', // payer account
  {
    gas: 30000,
    estimate: false,
  }
);

// Get contract info
const contractInfo = await queryBuilder.getContract('0.0.123456');
console.log({
  bytecode: contractInfo.bytecode,
  memo: contractInfo.memo,
  auto_renew_period: contractInfo.auto_renew_period,
});

// Get contract execution results
const contractResults = await queryBuilder.getContractResults({
  limit: 10,
  order: 'desc',
});
```

## Airdrop Queries

Check pending airdrops:

```typescript
// Get airdrops sent by an account
const sentAirdrops = await queryBuilder.getOutstandingTokenAirdrops(
  '0.0.12345'
);
sentAirdrops?.forEach((airdrop) => {
  console.log(
    `Sent ${airdrop.amount} of ${airdrop.token_id} to ${airdrop.receiver_id}`
  );
});

// Get airdrops waiting to be claimed
const pendingAirdrops = await queryBuilder.getPendingTokenAirdrops('0.0.12345');
pendingAirdrops?.forEach((airdrop) => {
  console.log(
    `Can claim ${airdrop.amount} of ${airdrop.token_id} from ${airdrop.sender_id}`
  );
});
```

## Using Queries in Conversational Agents

The conversational agent can answer questions using queries:

```typescript
const agent = new HederaConversationalAgent(signer, config);

// User asks questions - no transactions needed
const response1 = await agent.processMessage("What's my HBAR balance?", []);
const response2 = await agent.processMessage('Show me my NFTs', []);
const response3 = await agent.processMessage(
  "What's the current HBAR price?",
  []
);
const response4 = await agent.processMessage(
  'Get messages from topic 0.0.789012',
  []
);
```

## Query Tools Implementation

Query tools extend `BaseHederaQueryTool` and implement the `executeQuery` method:

```typescript
import { BaseHederaQueryTool } from '../common/base-hedera-query-tool';

export class HederaGetHbarPriceTool extends BaseHederaQueryTool<
  typeof GetHbarPriceZodSchema
> {
  name = 'hedera-get-hbar-price';
  description = 'Retrieves the HBAR price in USD for a specific date';
  specificInputSchema = z.object({
    date: z
      .string()
      .optional()
      .describe('Date in ISO format. Defaults to current date.'),
  });
  namespace = 'network';

  protected async executeQuery(args: z.infer<typeof GetHbarPriceZodSchema>) {
    const date = args.date ? new Date(args.date) : new Date();
    const price = await this.hederaKit.query().getHbarPrice(date);

    if (price === null) {
      return {
        success: false,
        error: `Could not retrieve HBAR price for date ${date.toISOString()}`,
      };
    }

    return {
      success: true,
      date: date.toISOString(),
      priceUsd: price,
      currency: 'USD',
    };
  }
}
```

## Best Practices

1. **Use queries liberally** - They're free or cheap
2. **Cache results** - Mirror node data has a slight delay
3. **Handle nulls** - Not all data may be available
4. **Paginate large results** - Use limit and order parameters

## Query vs Transaction Decision Tree

```
Need information? → Use Query Builder
Need to change something? → Use Service Builders

Examples:
- "What's my balance?" → Query
- "Transfer 10 HBAR" → Transaction
- "Show token info" → Query
- "Create a token" → Transaction
- "Read topic messages" → Query
- "Submit topic message" → Transaction
```

## Summary

Queries are essential for building interactive Hedera applications. They provide read access to all on-chain data without costing HBAR or requiring signatures. The Query Builder makes it easy to access this data with a consistent, type-safe interface that handles all the complexity of mirror node APIs.
