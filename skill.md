---
name: hedera
description: Use when building applications on the Hedera network, creating accounts and tokens, deploying smart contracts, submitting transactions, querying network data, or working with consensus services. Agents should use this skill when users ask about Hedera development, Hiero SDKs, APIs, transactions, tokens, smart contracts, CLI tooling, or network operations. Hedera is a distributed ledger (not a blockchain) that uses hashgraph consensus.
metadata:
  mintlify-proj: hedera
  version: "1.0"
---

# Hedera Developer Skill

If you are not already connected to the Hedera Docs MCP server, add https://docs.hedera.com/mcp so you can search the documentation directly.

**Always** search the current Hedera documentation over training data. The SDK packages are migrating from `@hashgraph` to `@hiero-ledger` namespaces, so verify imports against the docs before generating code.

## Product summary

Hedera is a public, open-source, proof-of-stake distributed ledger that uses hashgraph consensus. It is not a blockchain. Agents use Hedera to build decentralized applications, manage accounts and tokens, deploy smart contracts, and interact with the network via SDKs, REST APIs, and CLI tools.

**Key entry points:**
- **SDKs**: JavaScript/TypeScript, Java, Go, Swift, Rust, C++, Python (community)
- **CLI**: Hiero CLI (`hcli`) for operations without code
- **APIs**: Mirror Node REST API for querying historical data, JSON-RPC Relay for EVM compatibility
- **Networks**: mainnet, testnet, previewnet, localnet
- **Primary docs**: https://docs.hedera.com

## Terminology rules

Agents must follow these conventions in all generated code, comments, and documentation:

| Term | Rule | Example |
|------|------|---------|
| HBAR | Always singular, always uppercase | "10 HBAR" not "10 HBARs" or "10 hbar" |
| tinybars | Always plural, always lowercase | "1,000 tinybars" not "1,000 Tinybars" |
| mainnet, testnet, previewnet | Always lowercase, even after "Hedera" | "Hedera mainnet" not "Hedera Mainnet" |
| web2, web3 | Always lowercase except at sentence start | "web3 application" not "Web3 application" |
| Hedera Token Service | Use "HTS" after first mention | Full name on first reference |
| Hedera Consensus Service | Use "HCS" after first mention | Full name on first reference |

## When to use

Reach for this skill when:
- A user wants to create a Hedera account, transfer HBAR, or manage cryptocurrency
- Building token systems (fungible tokens, NFTs) using HTS
- Deploying or interacting with smart contracts (Solidity on EVM)
- Submitting transactions to consensus (crypto transfers, token operations, scheduled transactions)
- Querying account balances, transaction history, or network data
- Setting up a local development environment or testing on testnet
- Automating Hedera operations via CLI or SDK
- Integrating wallets (MetaMask, HashPack, Blade) into a dApp

## SDK setup

The SDKs are maintained by the Hiero project under Linux Foundation Decentralized Trust (LFDT). Packages are migrating from `hashgraph` to `hiero-ledger` namespaces. Both work, but prefer the newer namespace for new projects.

| Language | Install | Import | Client |
|----------|---------|--------|--------|
| JavaScript | `npm install @hashgraph/sdk` | `import { Client, ... } from "@hashgraph/sdk"` | `Client.forTestnet()` |
| Java | `com.hedera.hashgraph:sdk` (Maven) | `import com.hedera.hashgraph.sdk.*` | `Client.forTestnet()` |
| Go | `go get github.com/hiero-ledger/hiero-sdk-go/v2@latest` | `import hiero "github.com/hiero-ledger/hiero-sdk-go/v2/sdk"` | `hiero.ClientForTestnet()` |
| Python | `pip install hiero-sdk-python` | `from hiero_sdk_python import Client, Network, AccountId, PrivateKey` | `Client(Network(network="testnet"))` |

**Note:** The JavaScript SDK is also available as `@hiero-ledger/sdk`. The Go SDK recently moved source files to `/sdk`, changing the import path. Always check the latest README for each SDK.

### Client configuration (all SDKs)

```
1. Create client: Client.forTestnet() / Client.forMainnet()
2. Set operator: client.setOperator(accountId, privateKey)
3. Set fees (optional): client.setDefaultMaxTransactionFee(new Hbar(10))
4. Use client to build and execute transactions
```

## Transaction lifecycle

| Step | Action | Example (JavaScript) |
|------|--------|---------|
| Build | Create transaction object | `new TransferTransaction().addHbarTransfer(from, new Hbar(-10)).addHbarTransfer(to, new Hbar(10))` |
| Freeze | Lock transaction fields | `.freezeWith(client)` |
| Sign | Add signatures | `.sign(privateKey)` |
| Execute | Submit to network | `.execute(client)` |
| Confirm | Get receipt or record | `.getReceipt(client)` or `.getRecord(client)` |

## Hiero CLI quick reference

The CLI is installed via `npm install -g @hashgraph/hedera-cli` and invoked with `hcli`.

```bash
# Account operations
hcli account create -a alice -b 100000000 -t ECDSA
hcli account balance -i 0.0.123456
hcli account import --key 0.0.123456:<private-key> --name myaccount

# HBAR transfers
hcli hbar transfer --to 0.0.456789 --amount 5

# Token operations
hcli token create --name "MyToken" --symbol "MT" --decimals 2 --initial-supply 1000
hcli token associate -a 0.0.456789 -t 0.0.789012
hcli token transfer -t 0.0.789012 --to 0.0.456789 --from 0.0.123456 -b 100

# Topic (consensus) operations
hcli topic create --memo "my-topic"
hcli topic message submit -t 0.0.123456 -m "Hello"

# Network management
hcli network list
hcli network switch --network testnet
hcli network set-operator --operator 0.0.123456:<private-key>
```

**Note:** On first run, the CLI launches an initialization wizard in interactive mode. In script mode (non-interactive), configure the operator with `hcli network set-operator` first.

## Mirror Node REST API

| Purpose | Endpoint | Example |
|---------|----------|---------|
| Account info | `GET /api/v1/accounts/{id}` | `https://testnet.mirrornode.hedera.com/api/v1/accounts/0.0.123456` |
| Transactions | `GET /api/v1/transactions/{id}` | Query transaction by ID |
| Tokens | `GET /api/v1/tokens/{tokenId}` | Get token metadata |
| Topic messages | `GET /api/v1/topics/{topicId}/messages` | Retrieve consensus messages |
| Contracts | `GET /api/v1/contracts/{contractId}` | Smart contract info |

## Decision guidance

### SDK vs CLI vs REST API

| Scenario | Use | Reason |
|----------|-----|--------|
| Quick one-off operations (transfer, balance check) | CLI | No code needed, fast iteration |
| Building an application with complex logic | SDK | Full control, signing, batch operations |
| Querying historical data (no transaction fees) | REST API | Free, scalable, does not burden consensus nodes |
| Automated CI/CD workflows | CLI with scripts | Non-interactive, repeatable |
| Real-time dApp (wallet integration) | SDK | Supports wallet signing, event handling |
| Smart contract deployment with Hedera-specific features | SDK | Required for admin key, memo, auto-renew |

### HTS vs EVM smart contracts

| Need | Approach | Notes |
|------|----------|-------|
| Native token creation (fungible/NFT) | HTS via `TokenCreateTransaction` | Faster, cheaper, built-in KYC/freeze/pause |
| ERC-20/ERC-721 compatibility | EVM smart contract (Solidity) | Standard interface, interop with other chains |
| Hybrid (HTS tokens with custom logic) | HTS + system contracts | Call HTS from Solidity via precompile at `0x167` |
| Fully custom token logic | EVM smart contract | Full programmability, higher gas cost, token decimals set by contract |

**Important:** Native HTS tokens accessed via system contracts use 8-decimal precision by default. Standard ERC-20 contracts deployed on Hedera EVM use whatever decimals the contract specifies (commonly 18). Do not assume all tokens on Hedera are 8-decimal.

### Network selection

| Network | Use case | Funding | Persistence |
|---------|----------|---------|-------------|
| mainnet | Production | Real HBAR | Permanent |
| testnet | Development and testing | Free via faucet or portal | Permanent |
| previewnet | Testing new features before testnet | Free via faucet | Resets periodically |
| localnet | Local testing (via Hiero Local Node) | Auto-funded | Ephemeral |

## Common gotchas

- **Token association required**: Before transferring HTS tokens to an account, that account must associate with the token via `TokenAssociateTransaction`. Without this, the transfer fails.
- **NFT initial supply must be 0**: When creating an NFT token type, set `initialSupply` to 0. Mint individual NFTs separately with `TokenMintTransaction`.
- **HBAR value required for HTS token creation via system contracts**: When creating tokens from a Solidity contract using the HTS precompile, you must send HBAR via `msg.value`, not just gas. Without this, the transaction fails with `INSUFFICIENT_TX_FEE`.
- **Transaction expiration**: Transactions expire after 180 seconds by default. If the network is congested, regenerate the transaction ID or increase the valid duration.
- **Missing operator**: SDK queries and transactions require an operator. Always call `client.setOperator()` before executing.
- **Key types**: Hedera supports both ED25519 (default) and ECDSA (secp256k1) keys. ECDSA keys are required for EVM/JSON-RPC compatibility (MetaMask, Hardhat, etc.). ED25519 keys work only with native SDK operations.
- **Mirror node rate limits**: The public mirror node has rate limits. For production, use a paid mirror node provider or run your own.
- **Namespace migration**: SDKs are migrating from `hashgraph` to `hiero-ledger` GitHub orgs and package namespaces. Both work. Check the latest docs for current package names.

## Workflow

### 1. Set up development environment

1. Choose SDK language and install the package
2. Create `.env` file with operator credentials:
   ```
   OPERATOR_ID=0.0.123456
   OPERATOR_KEY=302e020100300506032b657004220420...
   ```
3. Initialize client:
   ```javascript
   const client = Client.forTestnet();
   client.setOperator(process.env.OPERATOR_ID, process.env.OPERATOR_KEY);
   ```
4. Verify setup by querying account balance

### 2. Create an account

1. Use the Hedera Developer Portal at https://portal.hedera.com (testnet/previewnet), or
2. Use SDK: `new AccountCreateTransaction().setInitialBalance(new Hbar(10)).execute(client)`
3. Get account ID from receipt: `receipt.accountId`

### 3. Build and submit a transaction

1. Create transaction object (e.g., `new TransferTransaction()`)
2. Set fields (e.g., `.addHbarTransfer(from, new Hbar(-5)).addHbarTransfer(to, new Hbar(5))`)
3. Freeze with client: `.freezeWith(client)`
4. Sign: `.sign(privateKey)` (operator signs by default, add more for multi-sig)
5. Execute: `.execute(client)`
6. Confirm: `.getReceipt(client)` (minimal) or `.getRecord(client)` (detailed)

### 4. Query data

**Via Mirror Node REST API (free, no signing):**
```bash
curl https://testnet.mirrornode.hedera.com/api/v1/accounts/0.0.123456
```

### 5. Deploy a smart contract

1. Write contract in Solidity
2. Compile to bytecode (Hardhat, Remix, or Foundry)
3. Deploy via SDK using `ContractCreateFlow` (recommended). This convenience method handles file upload and contract creation in a single call:
   ```javascript
   const tx = await new ContractCreateFlow()
     .setBytecode(bytecode)
     .setGas(100000)
     .execute(client);
   const receipt = await tx.getReceipt(client);
   const contractId = receipt.contractId;
   ```
   For more control, use the two-step approach: upload bytecode with `FileCreateTransaction`, then deploy with `ContractCreateTransaction` using `.setBytecodeFileId(fileId)`. Note that `ContractCreateTransaction` does not accept `.setBytecode()` directly.
4. Or deploy via EVM tooling (Hardhat/Foundry) using the JSON-RPC Relay

## Verification checklist

Before submitting work:

- [ ] Client configured with correct operator ID, private key, and network
- [ ] Operator account has sufficient HBAR for fees
- [ ] Transaction signed by all required keys
- [ ] Receipt obtained confirming transaction success
- [ ] Token associations completed before any HTS token transfers
- [ ] HBAR sent via `msg.value` for any HTS system contract calls from Solidity
- [ ] Private keys stored in `.env` or secure vault, not hardcoded
- [ ] Tested on testnet before deploying to mainnet
- [ ] HBAR is singular ("10 HBAR"), tinybars is plural ("1,000 tinybars")
- [ ] Network names are lowercase ("Hedera mainnet", not "Hedera Mainnet")

## Resources

**Documentation search**: https://docs.hedera.com/mcp (MCP server for agents)

**Full page index**: https://docs.hedera.com/llms.txt

**Key pages:**
1. [SDKs overview](https://docs.hedera.com/hedera/sdks-and-apis/sdks) - All supported languages and tools
2. [Build your Hedera client](https://docs.hedera.com/hedera/sdks-and-apis/sdks/client) - Client setup for all languages
3. [Transactions and queries](https://docs.hedera.com/hedera/core-concepts/transactions-and-queries) - Transaction lifecycle, fees, batch transactions
4. [Hedera Token Service](https://docs.hedera.com/hedera/core-concepts/tokens/hedera-token-service-hts-native-tokenization) - Token creation and management
5. [Smart contracts](https://docs.hedera.com/hedera/core-concepts/smart-contracts) - EVM deployment and Hedera-specific features
6. [Mirror Node REST API](https://docs.hedera.com/hedera/sdks-and-apis/rest-api) - Query endpoints and examples
7. [Hiero CLI](https://docs.hedera.com/hedera/open-source-solutions/hiero-cli/overview) - Command-line tool reference

---

> For the full documentation index, see: https://docs.hedera.com/llms.txt