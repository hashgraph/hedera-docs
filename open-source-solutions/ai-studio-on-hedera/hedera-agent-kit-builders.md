# Hedera Agent Kit Service Builders Guide

Service builders are the foundation of the Hedera Agent Kit. They provide a fluent, type-safe API for constructing Hedera transactions, and serve as the building blocks for creating LangChain tools. The kit includes 6 specialized builders plus a comprehensive query builder.

## Why Service Builders?

The Hedera SDK is powerful but verbose. Service builders solve three key problems:

1. **Simplified API**: Transform complex SDK calls into fluent, chainable methods
2. **Type Safety**: Full TypeScript support with comprehensive parameter validation
3. **Tool Foundation**: Provide the standardized interface that LangChain tools wrap

### The Architecture Flow

```
LangChain Tool → Service Builder → Hedera SDK → Hedera Network
     (thin wrapper)    (business logic)   (protocol)    (execution)
```

## Builder Philosophy

Each builder follows these principles:

- **Fluent Interface**: Chain method calls for readable code
- **Validation**: Parameter checking before transaction construction
- **Flexibility**: Support both direct execution and transaction byte generation
- **Extensibility**: Easy to wrap with tools or use programmatically

## Creating Tools from Builders

Here's how LangChain tools wrap builders (actual code from the kit):

```typescript
// From transfer-hbar-tool.ts
export class HederaTransferHbarTool extends BaseHederaTransactionTool {
  name = 'hedera-account-transfer-hbar';
  description = 'Transfers HBAR between accounts';

  // 1. Get the appropriate builder
  protected getServiceBuilder(): BaseServiceBuilder {
    return this.hederaKit.accounts();
  }

  // 2. Call the builder method
  protected async callBuilderMethod(
    builder: BaseServiceBuilder,
    specificArgs: z.infer<typeof TransferHbarZodSchemaCore>
  ): Promise<void> {
    await (builder as AccountBuilder).transferHbar(specificArgs);
  }
}
```

The tool is just a thin wrapper that:

1. Defines the schema for natural language parsing
2. Gets the appropriate builder
3. Calls the builder method

## Account Builder

Handles all account-related operations and HBAR transfers.

### Core Methods

```typescript
const accountBuilder = kit.accounts();

// Create account
await accountBuilder
  .createAccount({
    initialBalance: new Hbar(10),
    memo: 'New account',
  })
  .execute();

// Transfer HBAR
await accountBuilder
  .transferHbar({
    transfers: [
      { accountId: '0.0.123', amount: new Hbar(5) },
      { accountId: '0.0.456', amount: new Hbar(-5) },
    ],
  })
  .execute();
```

### Creating a Custom Transfer Tool

```typescript
class CustomTransferTool extends BaseHederaTransactionTool {
  name = 'custom-transfer';
  specificInputSchema = z.object({
    recipient: z.string(),
    amount: z.number(),
    reason: z.string(),
  });

  protected getServiceBuilder() {
    return this.hederaKit.accounts();
  }

  protected async callBuilderMethod(builder, args) {
    // Add custom logic
    const memo = `Transfer for: ${args.reason}`;

    // Use the builder
    await builder.transferHbar({
      transfers: [
        { accountId: args.recipient, amount: new Hbar(args.amount) },
        {
          accountId: this.hederaKit.operatorAccountId,
          amount: new Hbar(-args.amount),
        },
      ],
      memo,
    });
  }
}
```

## HTS Builder

Manages all token operations - the most feature-rich builder.

### Token Creation Pattern

```typescript
const htsBuilder = kit.hts();

// The builder handles all the complex SDK setup
const result = await htsBuilder
  .createFungibleToken({
    name: 'My Token',
    symbol: 'MTK',
    decimals: 2,
    initialSupply: 1000,
    treasuryAccountId: kit.operatorAccountId,
  })
  .execute();
```

### Why Builders Matter for Tokens

The SDK requires:

```typescript
// Raw SDK approach (complex)
const transaction = new TokenCreateTransaction()
  .setTokenName('My Token')
  .setTokenSymbol('MTK')
  .setDecimals(2)
  .setInitialSupply(1000)
  .setTreasuryAccountId(treasuryAccountId)
  .setAdminKey(adminKey)
  .setSupplyKey(supplyKey);
// ... many more settings
```

The builder simplifies this while maintaining flexibility.

## HCS Builder

Manages consensus service operations.

### Creating Topics and Messages

```typescript
const hcsBuilder = kit.hcs();

// Create topic
const topic = await hcsBuilder
  .createTopic({
    memo: 'Application events',
    submitKey: someKey,
  })
  .execute();

// Submit message
await hcsBuilder
  .submitMessage({
    topicId: topic.topicId,
    message: JSON.stringify({ event: 'user_login', timestamp: Date.now() }),
  })
  .execute();
```

## SCS Builder

Manages smart contract operations.

### Contract Deployment and Execution

```typescript
const scsBuilder = kit.scs();

// Deploy contract
const contract = await scsBuilder
  .createContract({
    bytecode: contractBytecode,
    gas: 100000,
    initialBalance: new Hbar(1),
  })
  .execute();

// Execute contract function
const result = await scsBuilder
  .executeContract({
    contractId: contract.contractId,
    functionName: 'transfer',
    functionParameters: new ContractFunctionParameters()
      .addAddress('0.0.123')
      .addUint256(100),
    gas: 75000,
  })
  .execute();
```

## File Builder

Manages file storage on Hedera.

### File Operations

```typescript
const fileBuilder = kit.file();

// Create file
const file = await fileBuilder
  .createFile({
    contents: Buffer.from('Hello Hedera'),
    memo: 'My file',
  })
  .execute();

// Append to file
await fileBuilder
  .appendFile({
    fileId: file.fileId,
    contents: Buffer.from(' - Additional content'),
  })
  .execute();
```

## Query Builder

The Query Builder is unique - it's read-only and doesn't create transactions. Instead, it queries data from the Hedera Mirror Node.

### Why a Query Builder?

Mirror Node APIs are complex with many parameters. The Query Builder:

- Provides a consistent interface for all queries
- Handles type conversions (AccountId objects to strings)
- Filters undefined parameters automatically
- Integrates with the configured mirror node

### Query Examples

```typescript
const queryBuilder = kit.query();

// Account queries
const accountInfo = await queryBuilder.getAccountInfo('0.0.123');
const balance = await queryBuilder.getAccountBalance('0.0.123');
const tokens = await queryBuilder.getAccountTokens('0.0.123');
const nfts = await queryBuilder.getAccountNfts('0.0.123');

// Token queries
const tokenInfo = await queryBuilder.getTokenInfo('0.0.456');
const ownership = await queryBuilder.validateNftOwnership(
  '0.0.123', // account
  '0.0.456', // token
  1 // serial
);

// Topic queries
const topicInfo = await queryBuilder.getTopicInfo('0.0.789');
const messages = await queryBuilder.getTopicMessages('0.0.789');

// Transaction queries
const tx = await queryBuilder.getTransaction('0.0.123@1234567890.123456789');
const scheduled = await queryBuilder.getScheduledTransactionStatus('0.0.999');

// Network queries
const hbarPrice = await queryBuilder.getHbarPrice(new Date());
const blocks = await queryBuilder.getBlocks({ limit: 10 });
const networkInfo = await queryBuilder.getNetworkInfo();
```

### Creating Query Tools

Query tools are simpler than transaction tools - they just wrap query builder methods:

```typescript
export class GetAccountBalanceTool extends DynamicStructuredTool {
  constructor(private queryBuilder: QueryBuilder) {
    super({
      name: 'get-account-balance',
      description: 'Get HBAR balance for an account',
      schema: z.object({
        accountId: z.string().describe('Account ID (e.g., 0.0.123)'),
      }),
      func: async ({ accountId }) => {
        const balance = await this.queryBuilder.getAccountBalance(accountId);
        return balance !== null
          ? `Balance: ${balance} HBAR`
          : 'Account not found';
      },
    });
  }
}
```

## Advanced Builder Patterns

### Transaction Notes System

Builders support a notes system for developer context:

```typescript
await accountBuilder
  .transferHbar({ transfers })
  .addNote('User requested transfer via chat')
  .addNote('Validated balance before transfer')
  .execute();
```

### Execution Modes

```typescript
// Direct execution
const result = await builder.method(params).execute();

// Get transaction bytes for user signing
const txBytes = await builder.method(params).getBytes();

// Schedule transaction
const scheduleId = await builder.method(params).schedule();
```

### Builder Composition

Create complex workflows by combining builders:

```typescript
async function createTokenAndDistribute(recipients: string[]) {
  // 1. Create token
  const token = await kit
    .hts()
    .createFungibleToken({
      name: 'Reward Token',
      symbol: 'RWT',
      initialSupply: recipients.length * 100,
    })
    .execute();

  // 2. Associate and transfer to each recipient
  for (const recipient of recipients) {
    // Associate
    await kit
      .hts()
      .associateToken({
        accountId: recipient,
        tokenIds: [token.tokenId],
      })
      .execute();

    // Transfer
    await kit
      .hts()
      .transferTokens({
        tokenId: token.tokenId,
        transfers: [
          { accountId: recipient, amount: 100 },
          { accountId: kit.operatorAccountId, amount: -100 },
        ],
      })
      .execute();
  }
}
```

## Creating Your Own Tools

The pattern for creating tools from builders:

1. **Extend BaseHederaTransactionTool**
2. **Define your schema** for natural language parsing
3. **Get the appropriate builder** in `getServiceBuilder()`
4. **Call builder methods** in `callBuilderMethod()`

Example custom tool:

```typescript
export class MultiRecipientTransferTool extends BaseHederaTransactionTool {
  name = 'multi-transfer';
  description = 'Transfer HBAR to multiple recipients equally';

  specificInputSchema = z.object({
    recipients: z.array(z.string()).describe('List of recipient account IDs'),
    totalAmount: z.number().describe('Total HBAR to distribute'),
    reason: z.string().optional(),
  });

  protected getServiceBuilder() {
    return this.hederaKit.accounts();
  }

  protected async callBuilderMethod(builder, args) {
    const amountPerRecipient = args.totalAmount / args.recipients.length;
    const operatorId = this.hederaKit.operatorAccountId.toString();

    const transfers = [
      // Debit from operator
      { accountId: operatorId, amount: new Hbar(-args.totalAmount) },
      // Credit to each recipient
      ...args.recipients.map((recipient) => ({
        accountId: recipient,
        amount: new Hbar(amountPerRecipient),
      })),
    ];

    await builder.transferHbar({
      transfers,
      memo: args.reason || 'Multi-recipient transfer',
    });
  }
}
```

## Best Practices

1. **Use Builders for Complex Logic**: Don't go directly to SDK unless necessary
2. **Leverage Type Safety**: Let TypeScript catch errors at compile time
3. **Add Notes**: Use the notes system for debugging and audit trails
4. **Handle Errors**: Builders provide consistent error handling
5. **Test Execution Modes**: Test both direct execution and byte generation

## Summary

Service builders are the bridge between the complex Hedera SDK and simple, usable tools. They:

- Simplify transaction construction
- Provide the foundation for LangChain tools
- Enable custom tool creation with minimal code
- Maintain flexibility for advanced use cases

The power of the Hedera Agent Kit comes from this layered approach: builders handle the complexity, tools provide the AI interface, and developers can work at whichever level makes sense for their use case.
