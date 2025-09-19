---
title: Hardhat 2 → 3
---

<details>

<summary><strong>🚧</strong> <strong>What's new: Hardhat 2 → 3</strong> </summary>

Key differences in Hardhat 3:

* **compile → build**\
  `npx hardhat compile` is now `npx hardhat build`. This is the big one. The v3 migration guide explicitly shows using the `build` task.
* **project init switch**\
  v2 commonly used `npx hardhat` or `npx hardhat init` to bootstrap. In v3 it’s `npx hardhat --init`.

- **keystore helper commands are new**\
  v3’s recommended flow includes a keystore plugin with commands like `npx hardhat keystore set HEDERA_RPC_URL` and `npx hardhat keystore set HEDERA_PRIVATE_KEY`. These weren’t standard in v2.
- **Foundry-compatiable Solidity tests**\
  In addition to offering Javascript/Typescript integration tests, Hardhat v3 also integrates Foundry-compatible Solidity tests that allows developers to write unit tests directly in Solidity

* **Enhanced Network Management**\
  v3 allows tasks to create and manage multiple network connections simultaneously which is a significant improvement over the single, fixed connection available in version 2. This provides greater flexibility for scripts and tests that interact with multiple networks.

_📚 Learn more from the official_ [_Hardhat documentation_](https://hardhat.org/docs/getting-started)_._

</details>
