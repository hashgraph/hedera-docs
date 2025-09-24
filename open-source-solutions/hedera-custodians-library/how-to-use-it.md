# How to Use the Hedera Custodians Library

To install the Hedera Custodians Integration package from NPM, run the following command in your terminal:

```sh
npm install @hashgraph/hedera-custodians-integration
```

This command will install the Hedera Custodians Library along with all its necessary dependencies. Ensure you are in your project’s root directory or the appropriate subdirectory where you wish to add the library.

***

## Creating a Service

To create a custodial wallet service:

1. Choose the appropriate configuration (`FireblocksConfig` or `DFNSConfig`).
2. Instantiate the configuration with the required parameters.
3. Create a `CustodialWalletService` instance using the configuration.

```typescript
import { CustodialWalletService, FireblocksConfig } from '@hashgraph/hedera-custodians-integration';

const config = new FireblocksConfig(
  FIREBLOCKS_API_KEY,
  FIREBLOCKS_API_SECRET_KEY,
  FIREBLOCKS_BASE_URL,
  FIREBLOCKS_VAULT_ACCOUNT_ID,
  FIREBLOCKS_ASSET_ID
);

const service = new CustodialWalletService(config);
```

{% hint style="info" %}
#### **Using Fireblocks**

For Fireblocks integrations, the recommended approach is the [**Fireblocks Hedera SDK Client and Signer**](https://github.com/fireblocks/hbar-fireblocks-sdk)**,** which implements [**HIP-338: Signature and Wallet Providers**](https://hips.hedera.com/hip/hip-338)**.** It includes complete examples, such as handling multiple nodes with `maxNumberOfPayloadsPerTransaction` and multi-signer flows.

You can still use this library’s `FireblocksConfig` with `CustodialWalletService` if you need a factory/strategy abstraction, but the official client/signer is the recommended route for new builds.
{% endhint %}

***

## Signing Transactions

To sign a transaction:

1. Create a `SignatureRequest` with the transaction bytes.
2. Use the signTransaction method of the `CustodialWalletService`.

```typescript
import { SignatureRequest } from '@hashgraph/hedera-custodians-integration';

const transactionBytes = new Uint8Array([/* your transaction bytes */]);
const request = new SignatureRequest(transactionBytes);

const signature = await service.signTransaction(request);
```

***

## Managing Multiple Wallets

To manage multiple wallets:

1. Create separate configurations for each wallet.
2. Instantiate a `CustodialWalletService` for each configuration.

```typescript
const fireblocksConfig = new FireblocksConfig(/* Fireblocks parameters */);
const dfnsConfig = new DFNSConfig(/* DFNS parameters */);

const fireblocksService = new CustodialWalletService(fireblocksConfig);
const dfnsService = new CustodialWalletService(dfnsConfig);
```

***

## Additional Resources

* [**Hedera Custodians Library Repository**](https://github.com/hashgraph/hedera-custodians-library)
* [**Fireblocks Hedera SDK Client and Signer Repository**](https://github.com/fireblocks/hbar-fireblocks-sdk)
