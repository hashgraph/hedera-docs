---
title: Hardhat keystore
---

Before we make any changes to our Hardhat configuration file, let's set some configuration variables we will be referring to within the file later.

```bash
# If you have already set this before, please use the --force flag
npx hardhat keystore set HEDERA_RPC_URL
```

For `HEDERA_RPC_URL`, we'll have `https://testnet.hashio.io/api`

```bash
# If you have already set this before, please use the --force flag
npx hardhat keystore set HEDERA_PRIVATE_KEY
```

For `HEDERA_PRIVATE_KEY`, enter the **HEX Encoded Private Key for your ECDSA account** from the [Hedera Portal.](https://portal.hedera.com/)
