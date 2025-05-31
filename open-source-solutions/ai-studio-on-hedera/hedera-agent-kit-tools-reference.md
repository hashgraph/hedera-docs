# Hedera Agent Kit Tools Reference

This document provides a comprehensive reference for all 67 pre-built tools available in the Hedera Agent Kit. These tools are organized by service type and can be used both by the conversational agent and programmatically.

## Account Tools

### hedera-account-create
**Description:** Creates a new Hedera account with configurable properties.

**Key Parameters:**
- `key` (optional): Public key string (hex) or private key string for the new account
- `alias` (optional): Account alias (e.g., EVM address or serialized PublicKey string)
- `initialBalance` (optional): Initial balance in HBAR (defaults to 0)
- `memo` (optional): Memo for the account
- `autoRenewPeriod` (optional): Auto-renewal period in seconds
- `maxAutomaticTokenAssociations` (optional): Max automatic token associations
- `stakedAccountId` (optional): Account ID to stake to
- `stakedNodeId` (optional): Node ID to stake to

**Example Usage:**
```typescript
await agent.invoke('hedera-account-create', {
  key: '0x02a1b2c3...',
  initialBalance: 10,
  memo: 'My new account',
  maxAutomaticTokenAssociations: 10
});
```

### hedera-account-delete
**Description:** Deletes a Hedera account and transfers its balance to another account.

**Key Parameters:**
- `accountId`: The account ID to delete (e.g., "0.0.xxxx")
- `transferAccountId`: The account ID to receive the deleted account's balance

**Example Usage:**
```typescript
await agent.invoke('hedera-account-delete', {
  accountId: '0.0.12345',
  transferAccountId: '0.0.98765'
});
```

### hedera-account-get-balance
**Description:** Retrieves the HBAR balance and token balances for a Hedera account.

**Key Parameters:**
- `accountId`: The account ID to query (e.g., "0.0.xxxx")

**Example Usage:**
```typescript
const balance = await agent.invoke('hedera-account-get-balance', {
  accountId: '0.0.12345'
});
```

### hedera-account-get-info
**Description:** Retrieves detailed information about a Hedera account.

**Key Parameters:**
- `accountId`: The account ID to query (e.g., "0.0.xxxx")

**Example Usage:**
```typescript
const info = await agent.invoke('hedera-account-get-info', {
  accountId: '0.0.12345'
});
```

### hedera-account-get-nfts
**Description:** Retrieves all NFTs owned by a specific Hedera account.

**Key Parameters:**
- `accountId`: The account ID to query (e.g., "0.0.xxxx")
- `limit` (optional): Maximum number of NFTs to return
- `order` (optional): Sort order ('asc' or 'desc')

**Example Usage:**
```typescript
const nfts = await agent.invoke('hedera-account-get-nfts', {
  accountId: '0.0.12345',
  limit: 100
});
```

### hedera-account-get-tokens
**Description:** Retrieves all tokens associated with a Hedera account.

**Key Parameters:**
- `accountId`: The account ID to query (e.g., "0.0.xxxx")
- `limit` (optional): Maximum number of tokens to return

**Example Usage:**
```typescript
const tokens = await agent.invoke('hedera-account-get-tokens', {
  accountId: '0.0.12345'
});
```

### hedera-account-get-public-key
**Description:** Retrieves the public key associated with a Hedera account.

**Key Parameters:**
- `accountId`: The account ID to query (e.g., "0.0.xxxx")

**Example Usage:**
```typescript
const publicKey = await agent.invoke('hedera-account-get-public-key', {
  accountId: '0.0.12345'
});
```

### hedera-account-transfer-hbar
**Description:** Transfers HBAR between Hedera accounts.

**Key Parameters:**
- `toAccountId`: The recipient account ID (e.g., "0.0.xxxx")
- `amount`: Amount of HBAR to transfer
- `memo` (optional): Transaction memo

**Example Usage:**
```typescript
await agent.invoke('hedera-account-transfer-hbar', {
  toAccountId: '0.0.98765',
  amount: 5,
  memo: 'Payment for services'
});
```

### hedera-account-update
**Description:** Updates properties of a Hedera account.

**Key Parameters:**
- `accountId`: The account ID to update (e.g., "0.0.xxxx")
- `key` (optional): New key for the account
- `memo` (optional): New memo for the account
- `autoRenewPeriod` (optional): New auto-renewal period in seconds
- `expirationTime` (optional): New expiration time

**Example Usage:**
```typescript
await agent.invoke('hedera-account-update', {
  accountId: '0.0.12345',
  memo: 'Updated account memo',
  autoRenewPeriod: 7776000
});
```

### hedera-account-approve-hbar-allowance
**Description:** Approves HBAR spending allowance for another account.

**Key Parameters:**
- `ownerAccountId`: Account granting the allowance (e.g., "0.0.xxxx")
- `spenderAccountId`: Account receiving the allowance
- `amount`: HBAR amount to approve

**Example Usage:**
```typescript
await agent.invoke('hedera-account-approve-hbar-allowance', {
  ownerAccountId: '0.0.12345',
  spenderAccountId: '0.0.98765',
  amount: 100
});
```

### hedera-account-approve-fungible-token-allowance
**Description:** Approves fungible token spending allowance for another account.

**Key Parameters:**
- `tokenId`: Token ID (e.g., "0.0.xxxx")
- `ownerAccountId`: Account granting the allowance
- `spenderAccountId`: Account receiving the allowance
- `amount`: Token amount to approve

**Example Usage:**
```typescript
await agent.invoke('hedera-account-approve-fungible-token-allowance', {
  tokenId: '0.0.11111',
  ownerAccountId: '0.0.12345',
  spenderAccountId: '0.0.98765',
  amount: 1000
});
```

### hedera-account-approve-token-nft-allowance
**Description:** Approves NFT spending allowance for another account.

**Key Parameters:**
- `tokenId`: NFT token ID (e.g., "0.0.xxxx")
- `ownerAccountId`: Account granting the allowance
- `spenderAccountId`: Account receiving the allowance
- `serialNumbers` (optional): Specific NFT serial numbers to approve
- `approvedForAll` (optional): Approve all NFTs of this token

**Example Usage:**
```typescript
await agent.invoke('hedera-account-approve-token-nft-allowance', {
  tokenId: '0.0.11111',
  ownerAccountId: '0.0.12345',
  spenderAccountId: '0.0.98765',
  serialNumbers: [1, 2, 3]
});
```

### Additional Account Tools
- `hedera-account-revoke-hbar-allowance`: Revokes HBAR spending allowance
- `hedera-account-revoke-fungible-token-allowance`: Revokes fungible token allowance
- `hedera-account-delete-nft-allowance-all-serials`: Deletes all NFT allowances
- `hedera-account-delete-nft-spender-allowance`: Deletes specific NFT spender allowance
- `hedera-account-get-outstanding-airdrops`: Gets outstanding airdrops for an account
- `hedera-account-get-pending-airdrops`: Gets pending airdrops for an account
- `hedera-account-sign-and-execute-scheduled-transaction`: Signs and executes scheduled transactions

## Hedera Token Service (HTS) Tools

### hedera-hts-create-fungible-token
**Description:** Creates a new fungible token on Hedera.

**Key Parameters:**
- `tokenName`: The publicly visible name of the token
- `tokenSymbol` (optional): The publicly visible symbol of the token
- `treasuryAccountId` (optional): Treasury account ID
- `initialSupply`: Initial supply in the smallest denomination
- `decimals` (optional): Number of decimal places (defaults to 0)
- `adminKey` (optional): Admin key for the token
- `supplyKey` (optional): Supply key for minting/burning
- `customFees` (optional): Array of custom fee objects
- `freezeDefault` (optional): Default freeze status for accounts

**Example Usage:**
```typescript
await agent.invoke('hedera-hts-create-fungible-token', {
  tokenName: 'My Token',
  tokenSymbol: 'MTK',
  initialSupply: 1000000,
  decimals: 2,
  treasuryAccountId: '0.0.12345'
});
```

### hedera-hts-create-nft
**Description:** Creates a new non-fungible token (NFT) collection on Hedera.

**Key Parameters:**
- `tokenName`: The publicly visible name of the NFT collection
- `tokenSymbol`: The publicly visible symbol of the NFT collection
- `treasuryAccountId` (optional): Treasury account ID
- `adminKey` (optional): Admin key for the NFT
- `supplyKey` (optional): Supply key for minting NFTs
- `customFees` (optional): Array of custom fee objects
- `maxSupply` (optional): Maximum number of NFTs that can be minted

**Example Usage:**
```typescript
await agent.invoke('hedera-hts-create-nft', {
  tokenName: 'My NFT Collection',
  tokenSymbol: 'MNFT',
  treasuryAccountId: '0.0.12345',
  maxSupply: 10000
});
```

### hedera-hts-mint-fungible-token
**Description:** Mints additional supply of a fungible token.

**Key Parameters:**
- `tokenId`: The token ID to mint (e.g., "0.0.xxxx")
- `amount`: Amount to mint in smallest denomination
- `supplyKey` (optional): Supply key if different from operator

**Example Usage:**
```typescript
await agent.invoke('hedera-hts-mint-fungible-token', {
  tokenId: '0.0.11111',
  amount: 500000
});
```

### hedera-hts-mint-nft
**Description:** Mints new NFTs for a collection.

**Key Parameters:**
- `tokenId`: The NFT collection ID (e.g., "0.0.xxxx")
- `metadataArray`: Array of metadata strings for each NFT
- `supplyKey` (optional): Supply key if different from operator

**Example Usage:**
```typescript
await agent.invoke('hedera-hts-mint-nft', {
  tokenId: '0.0.11111',
  metadataArray: [
    'ipfs://QmHash1',
    'ipfs://QmHash2'
  ]
});
```

### hedera-hts-transfer-tokens
**Description:** Transfers fungible tokens between accounts.

**Key Parameters:**
- `tokenId`: The token ID to transfer (e.g., "0.0.xxxx")
- `fromAccountId`: Source account ID
- `toAccountId`: Destination account ID
- `amount`: Amount to transfer

**Example Usage:**
```typescript
await agent.invoke('hedera-hts-transfer-tokens', {
  tokenId: '0.0.11111',
  fromAccountId: '0.0.12345',
  toAccountId: '0.0.98765',
  amount: 100
});
```

### hedera-hts-transfer-nft
**Description:** Transfers an NFT between accounts.

**Key Parameters:**
- `tokenId`: The NFT token ID (e.g., "0.0.xxxx")
- `fromAccountId`: Source account ID
- `toAccountId`: Destination account ID
- `serialNumber`: NFT serial number to transfer

**Example Usage:**
```typescript
await agent.invoke('hedera-hts-transfer-nft', {
  tokenId: '0.0.11111',
  fromAccountId: '0.0.12345',
  toAccountId: '0.0.98765',
  serialNumber: 42
});
```

### hedera-hts-associate-tokens
**Description:** Associates tokens with an account so it can receive them.

**Key Parameters:**
- `accountId`: Account to associate tokens with
- `tokenIds`: Array of token IDs to associate

**Example Usage:**
```typescript
await agent.invoke('hedera-hts-associate-tokens', {
  accountId: '0.0.12345',
  tokenIds: ['0.0.11111', '0.0.22222']
});
```

### hedera-hts-dissociate-tokens
**Description:** Dissociates tokens from an account.

**Key Parameters:**
- `accountId`: Account to dissociate tokens from
- `tokenIds`: Array of token IDs to dissociate

**Example Usage:**
```typescript
await agent.invoke('hedera-hts-dissociate-tokens', {
  accountId: '0.0.12345',
  tokenIds: ['0.0.11111']
});
```

### hedera-hts-get-token-info
**Description:** Retrieves detailed information about a token.

**Key Parameters:**
- `tokenId`: The token ID to query (e.g., "0.0.xxxx")

**Example Usage:**
```typescript
const tokenInfo = await agent.invoke('hedera-hts-get-token-info', {
  tokenId: '0.0.11111'
});
```

### Additional HTS Tools
- `hedera-hts-burn-fungible-token`: Burns fungible tokens
- `hedera-hts-burn-nft`: Burns specific NFTs
- `hedera-hts-delete-token`: Deletes a token
- `hedera-hts-update-token`: Updates token properties
- `hedera-hts-freeze-token-account`: Freezes an account for a token
- `hedera-hts-unfreeze-token-account`: Unfreezes an account for a token
- `hedera-hts-grant-kyc-token`: Grants KYC to an account for a token
- `hedera-hts-revoke-kyc-token`: Revokes KYC from an account
- `hedera-hts-pause-token`: Pauses all token operations
- `hedera-hts-unpause-token`: Unpauses token operations
- `hedera-hts-wipe-token-account`: Wipes tokens from an account
- `hedera-hts-validate-nft-ownership`: Validates NFT ownership
- `hedera-hts-airdrop-token`: Airdrops tokens to accounts
- `hedera-hts-claim-airdrop`: Claims pending airdrops
- `hedera-hts-reject-tokens`: Rejects unwanted tokens
- `hedera-hts-token-fee-schedule-update`: Updates token custom fees

## Hedera Consensus Service (HCS) Tools

### hedera-hcs-create-topic
**Description:** Creates a new HCS topic for consensus messaging.

**Key Parameters:**
- `memo` (optional): Memo for the topic
- `adminKey` (optional): Admin key for topic management
- `submitKey` (optional): Key required to submit messages
- `autoRenewAccountId` (optional): Account for auto-renewal payments
- `autoRenewPeriod` (optional): Auto-renewal period in seconds

**Example Usage:**
```typescript
await agent.invoke('hedera-hcs-create-topic', {
  memo: 'My consensus topic',
  adminKey: '0x02a1b2c3...',
  autoRenewPeriod: 7776000
});
```

### hedera-hcs-submit-message
**Description:** Submits a message to an HCS topic.

**Key Parameters:**
- `topicId`: The topic ID (e.g., "0.0.xxxx")
- `message`: The message content (supports base64 for binary)
- `maxChunks` (optional): Maximum chunks for large messages
- `chunkSize` (optional): Size of each chunk in bytes
- `submitKey` (optional): Submit key if required

**Example Usage:**
```typescript
await agent.invoke('hedera-hcs-submit-message', {
  topicId: '0.0.33333',
  message: 'Hello Hedera Consensus Service!'
});
```

### hedera-hcs-get-topic-info
**Description:** Retrieves information about an HCS topic.

**Key Parameters:**
- `topicId`: The topic ID to query (e.g., "0.0.xxxx")

**Example Usage:**
```typescript
const topicInfo = await agent.invoke('hedera-hcs-get-topic-info', {
  topicId: '0.0.33333'
});
```

### hedera-hcs-get-topic-messages
**Description:** Retrieves messages from an HCS topic.

**Key Parameters:**
- `topicId`: The topic ID (e.g., "0.0.xxxx")
- `timestamp` (optional): Start timestamp for message retrieval
- `limit` (optional): Maximum number of messages to return
- `order` (optional): Sort order ('asc' or 'desc')

**Example Usage:**
```typescript
const messages = await agent.invoke('hedera-hcs-get-topic-messages', {
  topicId: '0.0.33333',
  limit: 50,
  order: 'desc'
});
```

### Additional HCS Tools
- `hedera-hcs-update-topic`: Updates topic properties
- `hedera-hcs-delete-topic`: Deletes an HCS topic
- `hedera-hcs-get-topic-fees`: Gets fees for topic operations

## Smart Contract Service (SCS) Tools

### hedera-scs-create-contract
**Description:** Deploys a new smart contract to Hedera.

**Key Parameters:**
- `bytecode`: Contract bytecode (hex string)
- `gas`: Gas limit for deployment
- `constructorParameters` (optional): Constructor parameters
- `adminKey` (optional): Admin key for the contract
- `memo` (optional): Contract memo
- `initialBalance` (optional): Initial HBAR balance

**Example Usage:**
```typescript
await agent.invoke('hedera-scs-create-contract', {
  bytecode: '0x608060405234801561001057600080fd5b5...',
  gas: 100000,
  initialBalance: 10
});
```

### hedera-scs-execute-contract
**Description:** Executes a function on a deployed smart contract.

**Key Parameters:**
- `contractId`: The contract ID (e.g., "0.0.xxxx")
- `functionName`: Name of the function to call
- `parameters`: Function parameters
- `gas`: Gas limit for execution
- `payableAmount` (optional): HBAR to send with the call

**Example Usage:**
```typescript
await agent.invoke('hedera-scs-execute-contract', {
  contractId: '0.0.44444',
  functionName: 'transfer',
  parameters: ['0x123...', 100],
  gas: 50000
});
```

### hedera-scs-get-contract
**Description:** Retrieves information about a smart contract.

**Key Parameters:**
- `contractId`: The contract ID to query (e.g., "0.0.xxxx")

**Example Usage:**
```typescript
const contractInfo = await agent.invoke('hedera-scs-get-contract', {
  contractId: '0.0.44444'
});
```

### Additional SCS Tools
- `hedera-scs-update-contract`: Updates contract properties
- `hedera-scs-delete-contract`: Deletes a smart contract
- `hedera-scs-get-contracts`: Gets multiple contracts

## File Service Tools

### hedera-file-create
**Description:** Creates a new file on the Hedera network.

**Key Parameters:**
- `contents`: File contents (string or base64)
- `keys` (optional): Array of keys for file access
- `memo` (optional): File memo
- `expirationTime` (optional): Expiration timestamp

**Example Usage:**
```typescript
await agent.invoke('hedera-file-create', {
  contents: 'Hello, Hedera File Service!',
  memo: 'My first file'
});
```

### hedera-file-append
**Description:** Appends content to an existing file.

**Key Parameters:**
- `fileId`: The file ID (e.g., "0.0.xxxx")
- `contents`: Content to append

**Example Usage:**
```typescript
await agent.invoke('hedera-file-append', {
  fileId: '0.0.55555',
  contents: '\nAppended content'
});
```

### hedera-file-get-contents
**Description:** Retrieves the contents of a file.

**Key Parameters:**
- `fileId`: The file ID to query (e.g., "0.0.xxxx")

**Example Usage:**
```typescript
const fileContents = await agent.invoke('hedera-file-get-contents', {
  fileId: '0.0.55555'
});
```

### Additional File Tools
- `hedera-file-update`: Updates file properties and contents
- `hedera-file-delete`: Deletes a file

## Network Tools

### hedera-network-get-info
**Description:** Retrieves information about the Hedera network.

**Key Parameters:** None required

**Example Usage:**
```typescript
const networkInfo = await agent.invoke('hedera-network-get-info', {});
```

### hedera-network-get-hbar-price
**Description:** Gets the current HBAR price in USD.

**Key Parameters:** None required

**Example Usage:**
```typescript
const hbarPrice = await agent.invoke('hedera-network-get-hbar-price', {});
```

### hedera-network-get-fees
**Description:** Retrieves network fee information.

**Key Parameters:**
- `transactionType` (optional): Specific transaction type to query

**Example Usage:**
```typescript
const fees = await agent.invoke('hedera-network-get-fees', {
  transactionType: 'CryptoTransfer'
});
```

### hedera-network-get-blocks
**Description:** Retrieves recent network blocks.

**Key Parameters:**
- `limit` (optional): Number of blocks to retrieve
- `order` (optional): Sort order ('asc' or 'desc')

**Example Usage:**
```typescript
const blocks = await agent.invoke('hedera-network-get-blocks', {
  limit: 10,
  order: 'desc'
});
```

## Transaction Tools

### hedera-transaction-get
**Description:** Retrieves information about a specific transaction.

**Key Parameters:**
- `transactionId`: The transaction ID to query

**Example Usage:**
```typescript
const txInfo = await agent.invoke('hedera-transaction-get', {
  transactionId: '0.0.12345@1234567890.000000000'
});
```

## Common Tool Features

All tools in the Hedera Agent Kit share common features:

1. **Automatic Transaction Signing**: Tools automatically handle transaction signing using the configured operator account.

2. **Builder Pattern**: Tools use a builder pattern internally for constructing complex transactions with proper validation.

3. **Error Handling**: Tools provide detailed error messages and handle common Hedera network errors gracefully.

4. **Type Safety**: All tools use Zod schemas for input validation and TypeScript types for compile-time safety.

5. **Flexible Input**: Many parameters accept multiple formats (e.g., numbers as strings or numbers, keys in various formats).

6. **Sensible Defaults**: Optional parameters have sensible defaults based on Hedera best practices.

## Tool Categories Summary

- **Account Tools (19)**: Comprehensive account management including creation, deletion, updates, allowances, and queries
- **HTS Tools (25)**: Full token lifecycle management for both fungible and non-fungible tokens
- **HCS Tools (7)**: Topic creation, message submission, and consensus data retrieval
- **SCS Tools (6)**: Smart contract deployment, execution, and management
- **File Tools (5)**: File creation, updates, and content management
- **Network Tools (4)**: Network information, pricing, and block data
- **Transaction Tools (1)**: Transaction information retrieval

Total: **67 tools** providing comprehensive coverage of Hedera network functionality.