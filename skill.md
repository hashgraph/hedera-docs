---
name: hedera
description: Use when building applications on the Hedera network, creating accounts and tokens, deploying smart contracts, submitting transactions, querying network data, or working with consensus services. Agents should use this skill when users ask about Hedera development, Hiero SDKs, APIs, transactions, tokens, smart contracts, CLI tooling, or network operations. Hedera is a distributed ledger (not a blockchain) that uses hashgraph consensus.
metadata:
  mintlify-proj: hedera
  version: "1.0"
---

# Hedera Developer Skill

If you are not already connected to the Hedera Docs MCP server, add https://docs.hedera.com/mcp so you can search the documentation directly.

**Always** search the current Hedera documentation over training data. The JavaScript SDK now publishes as `@hiero-ledger/sdk` (not `@hashgraph/sdk`), so verify imports against the docs before generating code.

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
- Integrating wallets (MetaMask, HashPack) into a dApp

## SDK setup

The SDKs are maintained by the Hiero project under Linux Foundation Decentralized Trust (LFDT). Some packages have moved from `hashgraph` to `hiero-ledger` namespaces. Use the package names in this table for new projects.

| Language | Install | Import | Client |
|----------|---------|--------|--------|
| JavaScript | `npm install @hiero-ledger/sdk` | `import { Client, ... } from "@hiero-ledger/sdk"` | `Client.forTestnet()` |
| Java | `com.hedera.hashgraph:sdk` (Maven) | `import com.hedera.hashgraph.sdk.*` | `Client.forTestnet()` |
| Go | `go get github.com/hiero-ledger/hiero-sdk-go/v2@latest` | `import hiero "github.com/hiero-ledger/hiero-sdk-go/v2/sdk"` | `hiero.ClientForTestnet()` |
| Python | `pip install hiero-sdk-python` | `from hiero_sdk_python import Client, Network, AccountId, PrivateKey` | `Client(Network(network="testnet"))` |

**Note:** `@hashgraph/sdk` is the previous name of the JavaScript SDK. Releases v2.70.0 through v2.81.0 were published under both names; from v2.82.0 onward they publish only as `@hiero-ledger/sdk`. Existing projects that use `@hashgraph/sdk` still install. The Java SDK still publishes as `com.hedera.hashgraph:sdk` (v2.78.0 on Maven Central). Its migration guide describes a move to the `org.hiero` group ID and the `org.hiero.sdk` package, but no `org.hiero` SDK artifact is published yet, so keep using `com.hedera.hashgraph:sdk`. The Go SDK is imported from `github.com/hiero-ledger/hiero-sdk-go/v2/sdk`. Check each SDK's README for the current package name.

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

The CLI is installed with `npm install -g @hiero-ledger/hiero-cli` (or on macOS, `brew install hiero-ledger/tools/hiero-cli`) and invoked as `hcli`. Amounts are in HBAR, or in token display units with decimals applied, unless you append a lowercase `t` for tinybars or raw base units: `-b 1` is 1 HBAR, `-b 100t` is 100 tinybars.

```bash
# Account operations (key type defaults to ecdsa)
hcli account create -n alice -b 1 -t ecdsa
hcli account balance -a 0.0.123456
hcli account import --key 0.0.123456:<private-key> --name myaccount

# HBAR transfers (--from defaults to the operator)
hcli hbar transfer --to 0.0.456789 --amount 5

# Token operations (--treasury defaults to the operator; --decimals defaults to 0)
hcli token create-ft --token-name "MyToken" --symbol "MT" --decimals 2 --initial-supply 1000
hcli token associate -T 0.0.789012 -a <account>
hcli token transfer-ft -T 0.0.789012 --to 0.0.456789 --from <account> -a 100

# Topic (consensus) operations
hcli topic create --memo "my-topic"
hcli topic submit-message -t 0.0.123456 -m "Hello"

# Network management
hcli network list
hcli network use -g testnet
hcli network set-operator --operator 0.0.123456:<private-key>
```

For `token associate -a` and `token transfer-ft --from`, pass an account the CLI can sign for: an `accountId:privateKey` pair, a key reference, or the name of an account created or imported in the CLI. In `token create-ft`, `--name` sets the CLI's local name for the token, and `--token-name` sets the on-chain token name. NFTs use `token create-nft`, `token mint-nft`, and `token transfer-nft`. Run `hcli <plugin> <command> --help` for every option.

**Note:** If no operator is configured, the CLI launches an initialization wizard in its default `human` output mode. With `--format json` it exits with an error instead, so in scripts configure the operator with `hcli network set-operator` first.

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

**Important:** HTS token decimals are set by the creator when the token is created (`setDecimals()` in the SDKs, `--decimals` in the CLI; both default to 0). Standard ERC-20 contracts use whatever decimals the contract specifies (commonly 18). Never assume a fixed decimal count for a token on Hedera; read it from the token. HBAR itself has 8 decimals (tinybars) natively and inside the EVM. EVM tooling that sends transactions through the JSON-RPC Relay uses 18 decimals (weibars), which the network converts to tinybars. See [HBAR decimals](https://docs.hedera.com/evm/differences/hbar-decimals).

### Network selection

| Network | Use case | Funding | Persistence |
|---------|----------|---------|-------------|
| mainnet | Production | Real HBAR | Permanent |
| testnet | Development and testing | Free via faucet or portal | Resets periodically (announced 2 to 4 weeks ahead) |
| previewnet | Testing new features before testnet | Free via faucet | Resets periodically |
| localnet | Local testing and CI (via Solo) | Auto-funded | Ephemeral |

## Common gotchas

- **Token association required**: Before transferring HTS tokens to an account, that account must associate with the token via `TokenAssociateTransaction`. Without this, the transfer fails.
- **NFT initial supply must be 0**: When creating an NFT token type, set `initialSupply` to 0. Mint individual NFTs separately with `TokenMintTransaction`.
- **HBAR value required for HTS token creation via system contracts**: When creating tokens from a Solidity contract using the HTS precompile, you must send HBAR via `msg.value`, not just gas. Without this, the transaction fails with `INSUFFICIENT_TX_FEE`.
- **Transaction expiration**: The SDKs default to a 120-second valid duration, and the network accepts 15 to 180 seconds (values outside that range fail with `INVALID_TRANSACTION_DURATION`). A transaction that does not reach consensus within its window fails with `TRANSACTION_EXPIRED`. Regenerate the transaction ID and resubmit, or set a longer valid duration, up to 180 seconds.
- **Missing operator**: SDK queries and transactions require an operator. Always call `client.setOperator()` before executing.
- **Key types**: For EVM-oriented applications, create accounts with an ECDSA (secp256k1) key. ECDSA is required for EVM wallets and JSON-RPC tooling (MetaMask, Hardhat, Foundry); ED25519 keys work only with native SDK operations. Generate keys with `PrivateKey.generateECDSA()` or `PrivateKey.generateED25519()`. Avoid `PrivateKey.generate()`: it is deprecated and returns an ED25519 key. The Hiero CLI defaults to ECDSA.
- **Mirror node rate limits**: The public mirror node has rate limits. For production, use a paid mirror node provider or run your own.
- **Namespace migration**: SDK repositories have moved to the `hiero-ledger` GitHub org. For JavaScript, generate `@hiero-ledger/sdk` imports, not `@hashgraph/sdk`. Java still uses `com.hedera.hashgraph:sdk`. Check the latest docs for current package names.
- **Local testing**: there are two supported paths, and Hiero Local Node is neither. Never generate Hiero Local Node instructions, and never present it as an option; it is deprecated and unsupported.
  - **Solo** for a full local network (consensus node, mirror node, relay, explorer). Use this when the reader needs real Hedera services.
  - **Fork testing** for EVM work against existing mainnet or testnet state, via Hardhat or Foundry forking. Use this when the reader needs to test against deployed contracts or Hedera System Contracts rather than a fresh network. See https://docs.hedera.com/evm/development/forking.
- **Solo local network ports**: On Solo 0.63 and later, `solo one-shot single deploy` exposes the JSON-RPC relay on `http://localhost:37546` (chain ID `298`), the mirror node REST API on `http://localhost:38081`, the consensus node gRPC on `localhost:35211` (node account ID `0.0.3`), and the explorer on `http://localhost:38080`. Solo 0.62 and earlier use the older ports, including `7546` for the relay. Generated accounts and keys are written to `~/.solo/one-shot-<deployment-name>/accounts.json`. These ports are defaults, not guarantees: Solo forwards to the next free port if one is taken. Confirm with `solo deployment config ports --deployment <deployment-name>`.

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
4. Verify setup by querying the operator's balance with `MirrorNodeAccountBalanceQuery` or the mirror node REST API. Do not use `AccountBalanceQuery`; it no longer works. See [Get account balance](https://docs.hedera.com/native/accounts/get-balance).

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
   For more control, use `ContractCreateTransaction` directly. `.setBytecode(bytecode)` works for small contracts, as long as the whole signed transaction fits within the 6,144-byte transaction size limit. For larger contracts, use `ContractCreateFlow` or upload the bytecode with `FileCreateTransaction` and pass `.setBytecodeFileId(fileId)`.
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
1. [Native SDKs](https://docs.hedera.com/native) - All supported languages and tools
2. [Build your Hedera client](https://docs.hedera.com/native/fundamentals/client) - Client setup for all languages
3. [Transactions](https://docs.hedera.com/native/transactions) - Transaction lifecycle, signing, batch transactions
4. [Hedera Token Service](https://docs.hedera.com/learn/core-concepts/tokens/hts-overview) - Token creation and management
5. [Smart contracts](https://docs.hedera.com/evm) - EVM deployment and Hedera-specific features
6. [Mirror Node REST API](https://docs.hedera.com/reference/rest-api) - Query endpoints and examples
7. [Hiero CLI](https://docs.hedera.com/solutions/tools/hiero-cli/overview) - Command-line tool reference

## Building AI agents on Hedera

For developers building AI agents and agentic payment flows **on** Hedera (as opposed to using this skill to build general Hedera apps), see the Solutions > AI section:

- [AI tooling overview](https://docs.hedera.com/solutions/ai) - Entry point for AI agent tooling on Hedera
- [Hedera Agent Kit](https://docs.hedera.com/solutions/ai/agent-kit) - Toolkit (JavaScript and Python) for giving AI agents on-chain Hedera capabilities
- [ElizaOS plugin](https://docs.hedera.com/solutions/ai/elizaos) - Hedera plugin for the ElizaOS agent framework
- [x402](https://docs.hedera.com/solutions/ai/x402) - HTTP 402 pay-per-request payments for agents and APIs
- [Hosted MCP server](https://docs.hedera.com/solutions/ai/hosted-mcp-server) - Managed MCP server for Hedera agent operations
- [Agent Lab](https://docs.hedera.com/solutions/ai/agent-lab) - Environment for prototyping and testing Hedera AI agents

---

> For the full documentation index, see: https://docs.hedera.com/llms.txt