---
description: Consensus Node release information
---

# Consensus Node

Visit the [Hedera status page](https://status.hedera.com/) for the latest versions supported on each network.
## Release v0.62

{% hint style="info" %}
**MAINNET UPDATE SCHEDULED: JUNE 11, 2025**
{% endhint %}

{% hint style="info" %}
**TESTNET UPDATE SCHEDULED: MAY 22, 2025**
{% endhint %}

### [Build 0.62.2](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.62.2)

<details>

<summary><strong>What's Changed</strong></summary>

* fix: (cherry-pick) Change default `decline_reward` to true for nodes created during genesis by [@Neeharika-Sompalli](https://github.com/Neeharika-Sompalli) in [#19087](https://github.com/hiero-ledger/hiero-consensus-node/pull/19087)
* chore: Disable Batch Transactions by [@Neeharika-Sompalli](https://github.com/Neeharika-Sompalli) in [#19115](https://github.com/hiero-ledger/hiero-consensus-node/pull/19115)
* chore: Config changes for batch transactions by [@Neeharika-Sompalli](https://github.com/Neeharika-Sompalli) in [#19130](https://github.com/hiero-ledger/hiero-consensus-node/pull/19130)
* fix: (cherry-pick) Flaky Jumbo transactions tests by [@derektriley](https://github.com/derektriley) in [#19140](https://github.com/hiero-ledger/hiero-consensus-node/pull/19140)
* chore: increase transactionMaxBytes by [@lpetrovic05](https://github.com/lpetrovic05) in [#19104](https://github.com/hiero-ledger/hiero-consensus-node/pull/19104)
* fix: 19107 Corrected classId of `BenchmarkMerkleInternal` to prevent `classId` conflict. by [@imalygin](https://github.com/imalygin) in [#19108](https://github.com/hiero-ledger/hiero-consensus-node/pull/19108)
* chore: Fix the ConsensusSubmitMessage fee scaling for topic with customFees by [@Neeharika-Sompalli](https://github.com/Neeharika-Sompalli) in [#19144](https://github.com/hiero-ledger/hiero-consensus-node/pull/19144)

**Full Changelog**: [v0.62.1...v0.62.2](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.62.1...v0.62.2)

</details>

### [**Build 0.62.1**](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.62.1)

<details>

<summary><strong>What's Changed</strong></summary>

* feat: Limit the callData field instead of ethereumData (cherry-pick) by [@vtronkov](https://github.com/vtronkov) in [#18968](https://github.com/hiero-ledger/hiero-consensus-node/pull/18968)
* chore: (cherry-pick) Write marker files for sidecars ([#18916](https://github.com/hiero-ledger/hiero-consensus-node/pull/18916)) by [@Neeharika-Sompalli](https://github.com/Neeharika-Sompalli) in [#18992](https://github.com/hiero-ledger/hiero-consensus-node/pull/18992)
* feat: enable the jumbo transaction feature flag (cherry-pick) by [@vtronkov](https://github.com/vtronkov) in [#19012](https://github.com/hiero-ledger/hiero-consensus-node/pull/19012)
* fix: (cherry-pick) Update Roster Schema isUpgrade check ([#19006](https://github.com/hiero-ledger/hiero-consensus-node/pull/19006)) by [@derektriley](https://github.com/derektriley) in [#19057](https://github.com/hiero-ledger/hiero-consensus-node/pull/19057)
* feat: Implement fee changes for HIP-991 ([#18991](https://github.com/hiero-ledger/hiero-consensus-node/pull/18991)) by [@Neeharika-Sompalli](https://github.com/Neeharika-Sompalli) in [#19050](https://github.com/hiero-ledger/hiero-consensus-node/pull/19050)
* feat: Cherry-pick: Implement feature flag for gRPC web proxy endpoint ([#19051](https://github.com/hiero-ledger/hiero-consensus-node/pull/19051)) by [@mhess-swl](https://github.com/mhess-swl) in [#19073](https://github.com/hiero-ledger/hiero-consensus-node/pull/19073)

**Full Changelog**: [v0.62.0...v0.62.1](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.62.0...v0.62.1)

</details>

### [**Build 0.62.0**](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.62.0)

<details>
<summary><strong>What's Changed</strong></summary>

* * feat: Limit the callData field instead of ethereumData (cherry-pick) by @vtronkov in https://github.com/hiero-ledger/hiero-consensus-node/pull/18968
* * chore: (cherry-pick) Write marker files for sidecars (#18916) by @Neeharika-Sompalli in https://github.com/hiero-ledger/hiero-consensus-node/pull/18992
* * feat: enable the jumbo transaction feature flag (cherry-pick) by @vtronkov in https://github.com/hiero-ledger/hiero-consensus-node/pull/19012
* * fix: (cherry-pick) Update Roster Schema isUpgrade check (#19006) by @derektriley in https://github.com/hiero-ledger/hiero-consensus-node/pull/19057
* * feat: Implement fee changes for  HIP-991 (#18991) by @Neeharika-Sompalli in https://github.com/hiero-ledger/hiero-consensus-node/pull/19050
* * feat: Cherry-pick: Implement feature flag for gRPC web proxy endpoint (#19051) by @mhess-swl in https://github.com/hiero-ledger/hiero-consensus-node/pull/19073
* **Full Changelog**: https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.62.0...v0.62.1

**Full Changelog**: [v0.62.0...v0.62.1](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.62.0...v0.62.1)

</details>

### [Build v0.62.0](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.62.0)

<details>
<summary><strong>What's Changed</strong></summary>

* ### Features
* * remove code deposit gas charge waiver (#18797)
* * decouple backend throttle config from front end and add support for burst (#18743)
* * Update consensus to use nGen for determining when to recalculate metadata (#18882)
* * add cGen (#18867)
* * HIP-1046 Extend node address book with gRPC web proxy endpoint (#18766)
* * EventCreator uses nGen instead of generation (#18737)
* * Otter test logging improvements (#18850)
* * Add new v0.62 module and HederaEVM class (#18535)
* * Modifications to `EventHeader` for Block Stream (#18548)
* * Add otter test module (#18646)
* * handle `ResendBlock` block node responses (#18747)
* * Handle `BlockAcknowledgements` received from Block Nodes (#18536)
* * 18593: Need a mechanism to repair key to path mapping from data files at startup (#18625)
* * Jumbo bytes throttle (#18389)
* * Use existing key to create an account (#18611)
* * Remove use of generation from sync (#18590)
* * move parent event descriptors (#18524)
* * Long Term Schedule Transaction Support For DAB transactions (#18539)
* * Implement Non-deterministic Generation (#18506)
* * Stream to Block Node's immediately without waiting `BlockProof`s (#18450)
* * Enhance yahcli rekey with ECDSA support (#18515)
* * Implement daily node rewards (#18441)
* * add HAPI verb to override the hederaFunctionality (#18481)
* * Increase the buffer size of ethereumCall gRPC endpoint (#18321)
* * Add ingest workflow jumbo checks (#18312)
* * try using non-zero realm/shard (#18092)
* ### Bug Fixes
* * 18903: Tighten HDHM repair checks (#18906)
* * detach FCQueue copy when serializing (#18863)
* * Fix failing test in crypto-base (#18888)
* * fix copy paste error in TipsetEventCreatorTests (#18876)
* * disable GasCalculationIntegrityTest test suite (#18868)
* * 18844: HDHM repair mechanism should not be enabled for snapshots (#18859)
* * 18856: ReconnectHashLeafFlusher uses a wrong config (#18857)
* * NPE in HalfDiskHashMap (#18854)
* * Remove unused injections and fix tests (#18651)
* * Fix `transactionFee` in batch transactions (#18835)
* * Correctly populate sysfiles with node info (#18834)
* * Revalidate collector token association on transfer (#18674)
* * Fix the NPE in DefaultIssDetector.handleCatastrophic (#18830)
* * flaky `completedHollowAccountOperationsFuzzing` test (#18816)
* * Fix flakiness in HIP-1064 tests (#18822)
* * 18813: VirtualMapLargeReconnectTest.multipleAbortedReconnectsCanSucceed is unstable (#18814)
* * Use getIfUsable() in ApproveAllowanceValidator (#18580)
* * add auto-renew check for negative values  (#18765)
* * 18795: HDHM repair mechanism can be improved to clean stale buckets (#18796)
* * Only allow creation of accounts that match the configured shard/realm (#18806)
* * Move sort before `filterLikelyDuplicates` (#18802)
* * adding validation for deleted token on unpause (#18671)
* * Update flow-pull-request-formatting.yaml (#18790)
* * 18658: ReconnectNodeRemover.setPathInformation() may cause OOM (#18708)
* * Remove mono logic returning the wrong response code (#18698)
* * 1280 hip 1056 block item with failed contract create result contains a contract (#18728)
* * Improved error handling for airdrops with multiple senders (#18604)
* * Use getIfUsable() when validate custom fees (#18576)
* * Fix TokenCreateTransaction TCK issues (#18577)
* * Add guard around LATEST_XTS_PASS_TAG (#18687)
* * Also archive config.txt as part of network archiving process (#18427)
* * Add back sorting of sync events (#18657)
* * memory leak in HalfDiskHashMap.endWriting() (#18659)
* * Call `endRound` after dispatch (#18620)
* * Only "go back" in cons time for post-restart system work (#18654)
* * **18561** Threads outlive the SequentialTaskScheduler created during test (#18391)
* * airdrop TCK issues fixes (#18582)
* * 18571: Current path range should be respected when path to hash and path to KV indices are restored (#18592)
* * contract get bytecode query to return the redirect code for hts token addresses (#18464) (#18563)
* * Fix flaky PcesFile tests (#18474)
* * Utilize more than one thread for SSL accept handling (#18557)
* * Ensure `BlockStreamManager#endRound()` is called after dispatching system txns (#18554)
* * **17180** EventCreator ignores HealthMonitor update when squelching enabled  (#18387)
* * Import sentinel key from hapi utils (#18512)
* * compile fix (#18510)
* * Should reject a FILE_UPDATE to 0.0.123 with an invalid throttle definition (#18417)
* * 18410: Bucket integrity check in HDHM.ReadUpdateBucketTask can be improved  (#18411)
* * HIP-1028 cleanup and versioning for GetTokenKey (#18304)
* * update reference to `unhex` method (#18470)

**Full Changelog**: [v0.62.0...v0.62.0](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.62.0...v0.62.0)

</details>

## Release v0.61

{% hint style="info" %}
**MAINNET UPDATE SCHEDULED: MAY 21, 2025**
{% endhint %}

{% hint style="info" %}
**TESTNET UPDATE SCHEDULED: MAY 14, 2025**
{% endhint %}

### [Build 0.61.6](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.61.6)

<details>

<summary><strong>What's Changed</strong></summary>

* chore: Config changes for batch transactions by [@Neeharika-Sompalli](https://github.com/Neeharika-Sompalli) in [#19127](https://github.com/hiero-ledger/hiero-consensus-node/pull/19127)

**Full Changelog**: [v0.61.5...v0.61.6](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.61.5...v0.61.6)

</details>

### [Build 0.61.5](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.61.5)

<details>

<summary><strong>What's Changed</strong></summary>

* chore: Disable Batch Transactions by [@Neeharika-Sompalli](https://github.com/Neeharika-Sompalli) in [#19114](https://github.com/hiero-ledger/hiero-consensus-node/pull/19114)

**Full Changelog**: [v0.61.4...v0.61.5](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.61.4...v0.61.5)

</details>

### [Build 0.61.4](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.61.4)

<details>

<summary><strong>What's Changed</strong></summary>

* fix: 0.61 cherry-pick: Correctly populate sysfiles with node info by [@mhess-swl](https://github.com/mhess-swl) in [#18884](https://github.com/hiero-ledger/hiero-consensus-node/pull/18884)
* fix: 18771: Backport fixes for 18593, 18795, 18844, and 18903 to release 0.61 by [@artemananiev](https://github.com/artemananiev) in [#18799](https://github.com/hiero-ledger/hiero-consensus-node/pull/18799)
* chore: (0.61) add fee refund mechanism, use for successful EthereumTransaction by [@tinker-michaelj](https://github.com/tinker-michaelj) in [#18913](https://github.com/hiero-ledger/hiero-consensus-node/pull/18913)

**Full Changelog**: [v0.61.3...v0.61.4](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.61.3...v0.61.4)

</details>

### [Build 0.61.3](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.61.3)

<details>

<summary><strong>What's Changed</strong></summary>

* chore: (cherry-pick) Update flow-pull-request-formatting.yaml by [@derektriley](https://github.com/derektriley) in [#18792](https://github.com/hiero-ledger/hiero-consensus-node/pull/18792)
* chore: (cherry-pick) adjust path to protobufs in 'Update Hedera Protobufs' step by [@derektriley](https://github.com/derektriley) in [#18787](https://github.com/hiero-ledger/hiero-consensus-node/pull/18787)
* chore: (cherry-pick) remove github-committers team from codeowners by [@derektriley](https://github.com/derektriley) in [#18808](https://github.com/hiero-ledger/hiero-consensus-node/pull/18808)
* chore: (cherry-pick) Update CODEOWNERS for tools-and-libs rename by [@derektriley](https://github.com/derektriley) in [#18788](https://github.com/hiero-ledger/hiero-consensus-node/pull/18788)
* chore: (cherry-pick) update codeowners with new team names by [@derektriley](https://github.com/derektriley) in [#18807](https://github.com/hiero-ledger/hiero-consensus-node/pull/18807)
* fix: Cherry-pick `transactionFee` fix for atomic batch transactions by [@Neeharika-Sompalli](https://github.com/Neeharika-Sompalli) in [#18853](https://github.com/hiero-ledger/hiero-consensus-node/pull/18853)

**Full Changelog**: [v0.61.2...v0.61.3](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.61.2...v0.61.3)

</details>

### [Build 0.61.2](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.61.2)

<details>

<summary><strong>What's Changed</strong></summary>

* chore: (cherry-pick) Delay initializing snark keys ([#18699](https://github.com/hiero-ledger/hiero-consensus-node/pull/18699)) by [@Neeharika-Sompalli](https://github.com/Neeharika-Sompalli) in [#18701](https://github.com/hiero-ledger/hiero-consensus-node/pull/18701)
* fix: (cherry-pick) Utilize more than one thread for SSL accept handling ([#18557](https://github.com/hiero-ledger/hiero-consensus-node/pull/18557)) by [@abies](https://github.com/abies) in [#18586](https://github.com/hiero-ledger/hiero-consensus-node/pull/18586)
* fix: 18720: Backport the fix for 18571 to release 0.61 by [@artemananiev](https://github.com/artemananiev) in [#18736](https://github.com/hiero-ledger/hiero-consensus-node/pull/18736)
* feat: (cherry-pick) try using non-zero realm/shard by [@derektriley](https://github.com/derektriley) in [#18732](https://github.com/hiero-ledger/hiero-consensus-node/pull/18732)

**Full Changelog**: [v0.61.1...v0.61.2](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.61.1...v0.61.2)

</details>

### [Build 0.61.1](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.61.1)

<details>

<summary><strong>What's Changed</strong></summary>

### What's Changed

* chore: Remove the entityCounts migration code in 0.61 ([#18500](https://github.com/hiero-ledger/hiero-consensus-node/pull/18500)) by [@Neeharika-Sompalli](https://github.com/Neeharika-Sompalli) in [#18511](https://github.com/hiero-ledger/hiero-consensus-node/pull/18511)
* refactor: cherry-pick "Use a list of signed bytes for transactions in AtomicBatchTransaction" by [@ibankov](https://github.com/ibankov) in [#18522](https://github.com/hiero-ledger/hiero-consensus-node/pull/18522)
* fix: State changes out of order in HAPI Tests (Restart) by [@derektriley](https://github.com/derektriley) in [#18564](https://github.com/hiero-ledger/hiero-consensus-node/pull/18564)
* fix: 18410: Bucket integrity check in HDHM.ReadUpdateBucketTask can be improved - rel/0.61 by [@imalygin](https://github.com/imalygin) in [#18505](https://github.com/hiero-ledger/hiero-consensus-node/pull/18505)
* fix: Ensure `BlockStreamManager#endRound()` is called after dispatching by [@tinker-michaelj](https://github.com/tinker-michaelj) in [#18562](https://github.com/hiero-ledger/hiero-consensus-node/pull/18562)
* feat: Cherry-pick Daily Node Rewards by [@Neeharika-Sompalli](https://github.com/Neeharika-Sompalli) in [#18570](https://github.com/hiero-ledger/hiero-consensus-node/pull/18570)
* fix: Call `BlockRecordManager.endRound` after system dispatch by [@Neeharika-Sompalli](https://github.com/Neeharika-Sompalli) in [#18621](https://github.com/hiero-ledger/hiero-consensus-node/pull/18621)
* fix: Only "go back" in cons time for post-restart system work by [@tinker-michaelj](https://github.com/tinker-michaelj) in [#18660](https://github.com/hiero-ledger/hiero-consensus-node/pull/18660)
* chore: cherry-pick fix NPE when using records by [@Neeharika-Sompalli](https://github.com/Neeharika-Sompalli) in [#18679](https://github.com/hiero-ledger/hiero-consensus-node/pull/18679)
* chore: Cherry-pick Add metrics for active node percentage by [@Neeharika-Sompalli](https://github.com/Neeharika-Sompalli) in [#18680](https://github.com/hiero-ledger/hiero-consensus-node/pull/18680)

**Full Changelog**: [v0.61.0...v0.61.1](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.61.0...v0.61.1)

</details>

### [Build 0.61.0](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.61.0)

<details>

<summary><strong>What's Changed</strong></summary>

#### Features

* Dynamic peers for the sync network ([#18051](https://github.com/hiero-ledger/hiero-consensus-node/pull/18051))
* Add JumboTransactionsConfig ([#18277](https://github.com/hiero-ledger/hiero-consensus-node/pull/18277))
* implement exponential backoff for connections to Block Nodes ([#18055](https://github.com/hiero-ledger/hiero-consensus-node/pull/18055))
* HIP-1028 Fungible and NFT Token Info versioning ([#18013](https://github.com/hiero-ledger/hiero-consensus-node/pull/18013))
* add SCHEDULE\_EXPIRY\_NOT\_CONFIGURABLE validation ([#18239](https://github.com/hiero-ledger/hiero-consensus-node/pull/18239))
* Add messages for skip and resend block to block service ([#18133](https://github.com/hiero-ledger/hiero-consensus-node/pull/18133))
* Create a HAPI test to validate birth round migration ([#18005](https://github.com/hiero-ledger/hiero-consensus-node/pull/18005))
* Close blocks during fatal ISS ([#17942](https://github.com/hiero-ledger/hiero-consensus-node/pull/17942))
* HIP-1028 apply versioning to Update Token and Update Token Keys System Contracts ([#17994](https://github.com/hiero-ledger/hiero-consensus-node/pull/17994))
* Add feature flag for CRS ([#18073](https://github.com/hiero-ledger/hiero-consensus-node/pull/18073))
* change version to 0.61 ([#18088](https://github.com/hiero-ledger/hiero-consensus-node/pull/18088))
* Support non-zero realms for contracts service ([#18010](https://github.com/hiero-ledger/hiero-consensus-node/pull/18010))
* HIP-551 atomic batch transactions ([#17333](https://github.com/hiero-ledger/hiero-consensus-node/pull/17333))

#### Bug Fixes

* Detect ISSes when states are not produced for every round ([#18399](https://github.com/hiero-ledger/hiero-consensus-node/pull/18399))
* remove @OrderedInIsolation from contract bdd tests ([#18400](https://github.com/hiero-ledger/hiero-consensus-node/pull/18400))
* HIP-632 fix alias length check ([#18385](https://github.com/hiero-ledger/hiero-consensus-node/pull/18385))
* Extended suite failure during insertRemoveAndModifyOneMillion ([#18407](https://github.com/hiero-ledger/hiero-consensus-node/pull/18407))
* **18393** metrics not updated in PlatformWiring ([#18394](https://github.com/hiero-ledger/hiero-consensus-node/pull/18394))
* Fix candidate roster adoption logic (v61) ([#18372](https://github.com/hiero-ledger/hiero-consensus-node/pull/18372))

</details>

## Release v0.60

{% hint style="success" %}
**MAINNET UPDATE SCHEDULED: APRIL 16, 2025**
{% endhint %}

{% hint style="success" %}
**TESTNET UPDATE SCHEDULED: April 9, 2025**
{% endhint %}

### Release Highlights

This release focuses on significant performance improvements, enhanced developer tooling, and improved error handling.

#### Hiero Improvement Proposals (HIPs)

[HIP-1021](https://hips.hedera.com/hip/hip-1021): Improve Assignment of Auto-Renew Account ID for Topics

* Full implementation of improved auto-renew account ID assignment for topics, enabling setting `autoRenewAccountId` during topic creation without an admin key.&#x20;
* Developers benefit from simplified topic management and reduced risk of unexpected expirations.

### [Build 0.60.1](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.60.1)

<details>

<summary><strong>What's Changed</strong></summary>

* fix: Update MTT Version by [@timo0](https://github.com/timo0) in [#18423](https://github.com/hiero-ledger/hiero-consensus-node/pull/18423)
* fix: 18424 Fixed initialization of MigrationTestingToolState by [@imalygin](https://github.com/imalygin) in [#18432](https://github.com/hiero-ledger/hiero-consensus-node/pull/18432)
* fix: 18722: Backport the fix for 18571 to release 0.60 by [@artemananiev](https://github.com/artemananiev) in [#18723](https://github.com/hiero-ledger/hiero-consensus-node/pull/18723)

**Full Changelog**: [v0.60.0...v0.60.1](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.60.0...v0.60.1)

</details>

### [Build 0.60.0](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.60.0)

<details>

<summary><strong>What's Changed</strong></summary>

* feat: add feature flag for disabling precompile contracts by [@lukelee-sl](https://github.com/lukelee-sl) in [#17548](https://github.com/hiero-ledger/hiero-consensus-node/pull/17548)
* fix: Fail cleanly on negative gas limit by [@kimbor](https://github.com/kimbor) in [#17486](https://github.com/hiero-ledger/hiero-consensus-node/pull/17486)
* test: fix `MerkleRehashTests.failedRehash()` unit test by [@OlegMazurov](https://github.com/OlegMazurov) in [#17575](https://github.com/hiero-ledger/hiero-consensus-node/pull/17575)
* feat: Use `decrementCounter` on `ENTITY_COUNTS` when `remove()` is called by [@Neeharika-Sompalli](https://github.com/Neeharika-Sompalli) in [#17513](https://github.com/hiero-ledger/hiero-consensus-node/pull/17513)
* feat: Implement ECDSA key support for yahcli accounts create by [@mhess-swl](https://github.com/mhess-swl) in [#17293](https://github.com/hiero-ledger/hiero-consensus-node/pull/17293)
* feat: update `onSealConsensusRound()` to return a boolean by [@mhess-swl](https://github.com/mhess-swl) in [#17529](https://github.com/hiero-ledger/hiero-consensus-node/pull/17529)
* fix: Reference correct `main` obj in test by [@mhess-swl](https://github.com/mhess-swl) in [#17581](https://github.com/hiero-ledger/hiero-consensus-node/pull/17581)
* ci: Fix Check Integration Job State step to detect properly by [@rbarker-dev](https://github.com/rbarker-dev) in [#17583](https://github.com/hiero-ledger/hiero-consensus-node/pull/17583)
* feat: add synthetic node creates to record stream at genesis by [@MiroslavGatsanoga](https://github.com/MiroslavGatsanoga) in [#17461](https://github.com/hiero-ledger/hiero-consensus-node/pull/17461)
* fix(17537): Fix Test Flake startAtFirstFileDiscontinuityInMiddleTest by [@mxtartaglia-sl](https://github.com/mxtartaglia-sl) in [#17580](https://github.com/hiero-ledger/hiero-consensus-node/pull/17580)

**Full Changelog**: [v0.59.5...v0.60.0](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.59.5...v0.60.0)

</details>

### Performance Results

<figure><img src="../../.gitbook/assets/‎0.60_Performance Measurement Results_Extract.‎001.png" alt=""><figcaption></figcaption></figure>

## Release v0.59

{% hint style="success" %}
**MAINNET UPDATE SCHEDULED: MARCH 26, 2025**
{% endhint %}

{% hint style="success" %}
**TESTNET UPDATE SCHEDULED: MARCH 18, 2025**
{% endhint %}

### Release Highlights

#### HIPs:

#### [HIP-991](https://hips.hedera.com/hip/hip-991): Topic Fees

* Description: ​HIP-991 introduces an optional fee system for submitting messages to topics on the Hedera network, aiming to enhance economic scalability and simplify operations for topic operators.
* Benefits: Empowers topic operators with greater control over their topics, offering mechanisms to monetize and manage access. Key features include:
  * Optional Submission Fees: Topic operators can set optional fees for message submissions, payable in HBAR or Hedera Token Service (HTS) fungible tokens.​
  * Fee Schedule Key: A new 'Fee Schedule Key' allows operators to manage and update fee structures. This key must be set during topic creation.​
  * Custom Fee Distribution: Collected fees can be distributed to multiple accounts, supporting both HBAR and HTS tokens.​
  * Fee Exemptions: Operators can specify a list of keys that are exempt from fees, allowing certain users to submit messages without incurring charges.​

#### [HIP-755](https://hips.hedera.com/hip/hip-755): Schedule Service System Contract signSchedule(address, bytes)

* Description: This HIP introduces a Schedule Service System Contract to enhance the Hedera Smart Contract Service (HSCS) by enabling smart contracts to interact with scheduled transactions. This release includes signSchedule(address, bytes).
* Benefits: HIP-755 introduces a Schedule Service System Contract to enhance the Hedera Smart Contract Service by enabling smart contracts to interact with scheduled transactions. signSchedule(address, bytes) method, allows smart contracts to pass along the signature from an EOA needed for a scheduled transaction.

#### [HIP-756](https://hips.hedera.com/hip/hip-756): Scheduled Token Create/Update Transactions via Smart Contract

* Description: Enables scheduling token create and update operations through smart contracts, with implementation of the scheduleNative system contract function.
* Benefits: Expands smart contract functionality by allowing developers to schedule token operations directly from smart contracts, providing more flexibility in DApp development.

### [Build 0.59.5](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.59.5)

<details>

<summary><strong>What's Changed</strong></summary>

* fix: Fix candidate roster adoption logic (v59) by [@poulok](https://github.com/poulok) in [#18359](https://github.com/hiero-ledger/hiero-consensus-node/pull/18359)

**Full Changelog**: [v0.59.4...v0.59.5](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.59.4...v0.59.5)

</details>

### [Build 0.59.4](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.59.4)

<details>

<summary><strong>What's Changed</strong></summary>

* fix: 18267: Backport the fix for 18235 to 0.59 by [@artemananiev](https://github.com/artemananiev) in [#18303](https://github.com/hiero-ledger/hiero-consensus-node/pull/18303)
* fix: 18268: Bucket integrity check in HDHM.ReadUpdateBucketTask can be improved by [@artemananiev](https://github.com/artemananiev) in [#18272](https://github.com/hiero-ledger/hiero-consensus-node/pull/18272)

**Full Changelog**: [v0.59.3...v0.59.4](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.59.3...v0.59.4)

</details>

### [Build 0.59.3](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.59.3)

<details>

<summary><strong>What's Changed</strong></summary>

* chore: Prohibit all airdrop royalty fees by [@tinker-michaelj](https://github.com/tinker-michaelj) in [#18261](https://github.com/hiero-ledger/hiero-consensus-node/pull/18261)

**Full Changelog**: [v0.59.2...v0.59.3](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.59.2...v0.59.3)

</details>

### [Build 0.59.2](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.59.2)

<details>

<summary><strong>What's Changed</strong></summary>

* chore: (0.59) Cherry-pick misc fixes by [@tinker-michaelj](https://github.com/tinker-michaelj) in [#18128](https://github.com/hiero-ledger/hiero-consensus-node/pull/18128)

**Full Changelog**: [v0.59.1...v0.59.2](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.59.1...v0.59.2)

</details>

### [Build v0.59.1](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.59.1)

<details>
<summary><strong>What's Changed</strong></summary>

* * chore: (0.59) Support `stake.{min,max}Stake` config by @tinker-michaelj in https://github.com/hiero-ledger/hiero-consensus-node/pull/17805
* * chore: cherry pick codeowners and ci runner fixes for hiero-ledger by @rbarker-dev in https://github.com/hiero-ledger/hiero-consensus-node/pull/17899
* * fix(cherrypick): Update io.netty:netty-bom to io.netty:netty-bom:4.1.118.Final by @rbarker-dev in https://github.com/hiero-ledger/hiero-consensus-node/pull/17893
* * fix: 17841: Backport the fix for 17803 to release 0.59 by @artemananiev in https://github.com/hiero-ledger/hiero-consensus-node/pull/17845
* * chore: cherry pick StateNetworkInfo atomic map swap (#17869) by @derektriley in https://github.com/hiero-ledger/hiero-consensus-node/pull/18025
* **Full Changelog**: https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.59.0...v0.59.1

**Full Changelog**: [v0.59.0...v0.59.1](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.59.0...v0.59.1)

</details>

### [Build 0.59.0](https://github.com/hashgraph/hedera-services/releases/tag/v0.59.0)

<details>

<summary><strong>What's Changed</strong></summary>

* refactor: 16436 Removed `MerkleRoot` interface. by [@imalygin](https://github.com/imalygin) in [#17130](https://github.com/hashgraph/hedera-services/pull/17130)
* fix: move and change value of Dockerfile environment variable by [@matteriben](https://github.com/matteriben) in [#16239](https://github.com/hashgraph/hedera-services/pull/16239)
* build: Roll hiero gradle conventions to version 0.1.4 by [@andrewb1269hg](https://github.com/andrewb1269hg) in [#17149](https://github.com/hashgraph/hedera-services/pull/17149)
* build(deps): bump actions/setup-java from 4.5.0 to 4.6.0 by [@dependabot](https://github.com/dependabot) in [#17113](https://github.com/hashgraph/hedera-services/pull/17113)
* build(deps): bump gradle/actions from 4.2.1 to 4.2.2 by [@dependabot](https://github.com/dependabot) in [#17111](https://github.com/hashgraph/hedera-services/pull/17111)
* chore: Update hedera-services to rename develop as main by [@rbarker-dev](https://github.com/rbarker-dev) in [#17091](https://github.com/hashgraph/hedera-services/pull/17091)
* chore: Update workrflow names to point to main instead of develop by [@rbarker-dev](https://github.com/rbarker-dev) in [#17158](https://github.com/hashgraph/hedera-services/pull/17158)
* ci: Update Check Integration/XTS Job State to include GH\_TOKEN by [@rbarker-dev](https://github.com/rbarker-dev) in [#17160](https://github.com/hashgraph/hedera-services/pull/17160)
* ci: add id\_token write permission to node-flow-deploy-release-artifact.yaml by [@rbarker-dev](https://github.com/rbarker-dev) in [#17161](https://github.com/hashgraph/hedera-services/pull/17161)
* feat: Support overwrites for interface bindings and endpoints by [@timo0](https://github.com/timo0) in [#17117](https://github.com/hashgraph/hedera-services/pull/17117)
* chore: Refactor hapi tests to use `hapiTest(...)` instead of `defaultHapiSpec(...)` (Part 3) by [@mhess-swl](https://github.com/mhess-swl) in [#16698](https://github.com/hashgraph/hedera-services/pull/16698)
* feat: consolidate hbar transfer list when decoding cryptoTransfer function by [@lukelee-sl](https://github.com/lukelee-sl) in [#17165](https://github.com/hashgraph/hedera-services/pull/17165)

**Full Changelog**: [v0.58.9...v0.59.0](https://github.com/hashgraph/hedera-services/compare/v0.58.9...v0.59.0)

</details>

<figure><img src="../../.gitbook/assets/‎0.59_Performance Measurement Results_Extract.‎001.png" alt=""><figcaption></figcaption></figure>

## Release v0.58

{% hint style="success" %}
**MAINNET UPDATE SCHEDULED: MARCH 12, 2025**
{% endhint %}

{% hint style="success" %}
**TESTNET UPDATE SCHEDULED: FEBRUARY 11, 2025**
{% endhint %}

### Release Highlights

This release introduces several new features, improvements, and bug fixes, including:

#### HIPs

* **HIP-423 Long-Term Scheduled Transactions**:\
  Update to ScheduleSign throttles changed: The ScheduleSign transaction is now throttled like other transactions and can now be managed by the default throttling mechanism on the network. ([#16958](https://github.com/hashgraph/hedera-services/issues/16958), [#16959](https://github.com/hashgraph/hedera-services/issues/16959)) This completes HIP-423.
* **HIP-755 authorizeSchedule(address)**\
  Adds functionality to the Hedera Schedule Service System contract so that a smart contract can sign a referenced scheduled transaction using its contract key, enabling automated execution of scheduled transactions directly from smart contracts. ([#16983](https://github.com/hiero-ledger/hiero-consensus-node/pull/16983)), the remaining outstanding features to complete HIP-755 will be provisioned in release .59.

#### Other Notable Changes

* Enabled mirror node to simulate contract calls:\
  The standalone transaction executor now supports custom Operations. Developers can use this feature to create and execute custom operations that are not part of the standard Hedera API. ([#17354](https://github.com/hashgraph/hedera-services/issues/17354))
* **Enhancing Dynamic Address Book v2** NodeCreate and NodeDelete transaction signature requirements changed:
  * The NodeCreate transaction now requires the admin key and one of the treasury account key, system admin key, or address book admin key to sign.
    * The NodeDelete transaction is now a non-privileged transaction and requires one of the admin key, treasury account key, system admin key, or address book admin key to sign. ([#16900](https://github.com/hashgraph/hedera-services/issues/16900), [#17021](https://github.com/hashgraph/hedera-services/issues/17021), [#16990](https://github.com/hashgraph/hedera-services/issues/16990), [#17029](https://github.com/hashgraph/hedera-services/issues/17029))
* **Ensuring state changes are now in block streams**:\
  Refactored out-of-band state modifications: All out-of-band state modifications have been refactored to be done in Schemas. ([#16843](https://github.com/hashgraph/hedera-services/issues/16843))
* Increased CryptoGetAccountBalance throttle: The throttle for the CryptoGetAccountBalance query has been increased to the number of network nodes times 1,000,000 plus a buffer. This change addresses an issue where the throttle was too low, leading to throttling errors. ([#16850](https://github.com/hashgraph/hedera-services/issues/16850), [#16857](https://github.com/hashgraph/hedera-services/issues/16857))

### [Build 0.58.13](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.58.13)

<details>

<summary><strong>What's Changed</strong></summary>

* Fail NFT airdrops that would trigger royalty fee payments.

**Full Changelog**: [v0.58.11...v0.58.13](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.58.11...v0.58.13)

</details>

### [Build 0.58.11](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.58.11)

<details>

<summary><strong>What's Changed</strong></summary>

* Add safety checks before Besu secp256k1 native library invocations (c.f. here.
* Ignore approval flag when de-duplicating account ids in a `TokenTransferList`.

**Full Changelog**: [v0.58.10...v0.58.11](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.58.10...v0.58.11)

</details>

### [Build 0.58.10](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.58.10)

<details>

<summary><strong>What's Changed</strong></summary>

**Full Changelog**: [v0.58.9...v0.58.10](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.58.9...v0.58.10)

</details>

### [Build 0.58.9](https://github.com/hashgraph/hedera-services/releases/tag/v0.58.9)

<details>

<summary><strong>What's Changed</strong></summary>

* chore: Use weights from reclamped stakes in current address book by [@tinker-michaelj](https://github.com/tinker-michaelj) in [#17777](https://github.com/hashgraph/hedera-services/pull/17777)

**Full Changelog**: [v0.58.7...v0.58.9](https://github.com/hashgraph/hedera-services/compare/v0.58.7...v0.58.9)

</details>

### [Build 0.58.8](https://github.com/hashgraph/hedera-services/releases/tag/v0.58.8)

<details>

<summary><strong>What's Changed</strong></summary>

Re-tag of `v0.58.7` to trigger workflow

* chore: (0.58) Remove unwanted post-upgrade work by [@tinker-michaelj](https://github.com/tinker-michaelj) in [#17637](https://github.com/hashgraph/hedera-services/pull/17637)
* chore: 0.58-specific state migrations by [@tinker-michaelj](https://github.com/tinker-michaelj) in [#17690](https://github.com/hashgraph/hedera-services/pull/17690)

**ull Changelog**: [v0.58.6...v0.58.7](https://github.com/hashgraph/hedera-services/compare/v0.58.6...v0.58.7)

</details>

### [Build 0.58.7](https://github.com/hashgraph/hedera-services/releases/tag/v0.58.7)

<details>

<summary><strong>What's Changed</strong></summary>

* chore: (0.58) Remove unwanted post-upgrade work by [@tinker-michaelj](https://github.com/tinker-michaelj) in [#17637](https://github.com/hashgraph/hedera-services/pull/17637)
* chore: 0.58-specific state migrations by [@tinker-michaelj](https://github.com/tinker-michaelj) in [#17690](https://github.com/hashgraph/hedera-services/pull/17690)

**Full Changelog**: [v0.58.6...v0.58.7](https://github.com/hashgraph/hedera-services/compare/v0.58.6...v0.58.7)

</details>

### [Build 0.58.6](https://github.com/hashgraph/hedera-services/releases/tag/v0.58.6)

<details>

<summary><strong>What's Changed</strong></summary>

* chore: Reapply "FileService address book and node details" by [@mhess-swl](https://github.com/mhess-swl) in [#17543](https://github.com/hashgraph/hedera-services/pull/17543)

**Full Changelog**: [v0.58.5...v0.58.6](https://github.com/hashgraph/hedera-services/compare/v0.58.5...v0.58.6)

</details>

### [Build 0.58.5](https://github.com/hashgraph/hedera-services/releases/tag/v0.58.5)

<details>

<summary><strong>What's Changed</strong></summary>

* fix: 17283: Backport the fix for [#17218](https://github.com/hashgraph/hedera-services/issues/17218) to release 0.58 by [@artemananiev](https://github.com/artemananiev) in [#17296](https://github.com/hashgraph/hedera-services/pull/17296)
* chore: (0.58) Support custom `Operation`s in standalone executor by [@tinker-michaelj](https://github.com/tinker-michaelj) in [#17354](https://github.com/hashgraph/hedera-services/pull/17354)
* fix: retain override values on `ConfigProviderImpl.update()` ([#17424](https://github.com/hashgraph/hedera-services/pull/17424)) by [@tinker-michaelj](https://github.com/tinker-michaelj) in [#17430](https://github.com/hashgraph/hedera-services/pull/17430)
* fix: cherry-pick: FileService address book and node details should be updated at genesis by [@iwsimon](https://github.com/iwsimon) in [#17368](https://github.com/hashgraph/hedera-services/pull/17368)
* fix: 17467: Back out changes for 15448 from release 0.58 by [@artemananiev](https://github.com/artemananiev) in [#17473](https://github.com/hashgraph/hedera-services/pull/17473)
* fix: Revert "cherry-pick: FileService address book and node details" by [@mhess-swl](https://github.com/mhess-swl) in [#17539](https://github.com/hashgraph/hedera-services/pull/17539)

**Full Changelog**: [v0.58.3...v0.58.5](https://github.com/hashgraph/hedera-services/compare/v0.58.3...v0.58.5)

</details>

### [Build 0.58.3](https://github.com/hashgraph/hedera-services/releases/tag/v0.58.3)

<details>

<summary><strong>What's Changed</strong></summary>

* feat: cherry-pick: Generated Files 101 & 102 Sequentially Ordered by Node ID by [@iwsimon](https://github.com/iwsimon) in [#17289](https://github.com/hashgraph/hedera-services/pull/17289)

**Full Changelog**: [v0.58.2...v0.58.3](https://github.com/hashgraph/hedera-services/compare/v0.58.2...v0.58.3)

</details>

### [Build 0.58.0](https://github.com/hashgraph/hedera-services/releases/tag/v0.58.0)

<details>

<summary><strong>What's Changed</strong></summary>

* chore: Modify and mount default block streams output directory by [@mhess-swl](https://github.com/mhess-swl) in [#16719](https://github.com/hashgraph/hedera-services/pull/16719)
* fix: 16657: State validation fails for round 191161423 on LSE by [@artemananiev](https://github.com/artemananiev) in [#16757](https://github.com/hashgraph/hedera-services/pull/16757)
* feat: Add time-driven event processing for triggering scheduled transactions by [@JivkoKelchev](https://github.com/JivkoKelchev) in [#16017](https://github.com/hashgraph/hedera-services/pull/16017)
* chore: Integrate latest cryptography library changes by [@Neeharika-Sompalli](https://github.com/Neeharika-Sompalli) in [#16615](https://github.com/hashgraph/hedera-services/pull/16615)
* fix: Add validation for grpc certificate hash by [@Neeharika-Sompalli](https://github.com/Neeharika-Sompalli) in [#16776](https://github.com/hashgraph/hedera-services/pull/16776)
* ci: Add workflow for manual XTS failed tests log collection by [@mishomihov00](https://github.com/mishomihov00) in [#16662](https://github.com/hashgraph/hedera-services/pull/16662)
* ci: Update slack reporting for XTS failure and CITR build promotion by [@rbarkerSL](https://github.com/rbarkerSL) in [#16760](https://github.com/hashgraph/hedera-services/pull/16760)
* ci: Change from setup-gradle action to ./gradlew command usage by [@mishomihov00](https://github.com/mishomihov00) in [#16706](https://github.com/hashgraph/hedera-services/pull/16706)
* build(deps): bump codecov/codecov-action from 5.0.2 to 5.0.7 by [@dependabot](https://github.com/dependabot) in [#16725](https://github.com/hashgraph/hedera-services/pull/16725)
* fix: 16748 Fixed serialization for AddressBookTestingToolState by [@imalygin](https://github.com/imalygin) in [#16799](https://github.com/hashgraph/hedera-services/pull/16799)
* build(deps): bump docker/setup-qemu-action from 3.0.0 to 3.2.0 by [@dependabot](https://github.com/dependabot) in [#16232](https://github.com/hashgraph/hedera-services/pull/16232)

#### New Contributors

* [@boooby19](https://github.com/boooby19) made their first contribution in [#16767](https://github.com/hashgraph/hedera-services/pull/16767)
* [@PavelSBorisov](https://github.com/PavelSBorisov) made their first contribution in [#16701](https://github.com/hashgraph/hedera-services/pull/16701)
* [@timfn-hg](https://github.com/timfn-hg) made their first contribution in [#16917](https://github.com/hashgraph/hedera-services/pull/16917)

**Full Changelog**: [v0.57.3...v0.58.0](https://github.com/hashgraph/hedera-services/compare/v0.57.3...v0.58.0)

</details>

<figure><img src="../../.gitbook/assets/‎0.58_Performance Measurement Results_Extract.‎001.png" alt=""><figcaption></figcaption></figure>

## Release v0.57

{% hint style="success" %}
**MAINNET UPDATE SCHEDULED: JANUARY 28, 2025**
{% endhint %}

{% hint style="success" %}
**TESTNET UPDATE SCHEDULED: JANUARY 8, 2025**
{% endhint %}

### Release Highlights

This release introduces several new features, improvements, and bug fixes, including:

#### HIPs

* **HIP-423: Long-Term Scheduled Transactions:** This release completes the implementation of [HIP-423](https://hips.hedera.com/hip/hip-423), enabling schedules to execute transactions at a future date and time. This provides developers with a powerful tool for automating on-chain actions and building time-based applications. Benefits include:
  * **Automated Transactions:** Schedule transactions to execute automatically at a specific time.
  * **Time-Based Applications:** Build applications that rely on time-based events, such as recurring payments or token distributions.
  * **Enhanced Security:** Schedule transactions can be signed by multiple parties, ensuring that they are executed only when all required approvals are obtained.

#### New Features

* **Node Operator Queries:** This release introduces a dedicated gRPC port for node operators to perform free queries. This enables node operators to monitor the network and their nodes more efficiently without incurring transaction fees.
* **Proxy Redirect Contract for Schedule Entities:** This release adds support for a proxy redirect contract for calls to schedule transactions. This allows EOAs to make function calls in schedule entity addresses, enabling more flexible and dynamic interactions with scheduled transactions.
* **HSS System Contract:** This release introduces the Hedera Schedule Service (HSS) system contract, providing a set of functions for managing scheduled transactions, including signing and authorizing schedules.
* **Support for Extra Dispatch Authorizations:** The `ScheduleSignHandler` now supports authorizing `Key{contractID=0.0.X}` and `Key{delegatable_contract_id=0.0.X}` keys in a schedule's signatories list, enabling more granular control over schedule execution.

### [Build 0.57.5](https://github.com/hashgraph/hedera-services/releases/tag/v0.57.5)

<details>

<summary><strong>What's Changed</strong></summary>

* chore: Cherry pick fixes for update of default branch to main ([#17200](https://github.com/hashgraph/hedera-services/pull/17200)) by [@rbarkerSL](https://github.com/rbarkerSL) in [#17235](https://github.com/hashgraph/hedera-services/pull/17235)

**Full Changelog**: [v0.57.4...v0.57.5](https://github.com/hashgraph/hedera-services/compare/v0.57.4...v0.57.5)

</details>

### [Build 0.57.4](https://github.com/hashgraph/hedera-services/releases/tag/v0.57.4)

<details>

<summary><strong>What's Changed</strong></summary>

* chore: (0.57) Keep default schedule lifetime 30min no matter max lifetime by [@tinker-michaelj](https://github.com/tinker-michaelj) in [#17196](https://github.com/hashgraph/hedera-services/pull/17196)

**Full Changelog**: [v0.57.3...v0.57.4](https://github.com/hashgraph/hedera-services/compare/v0.57.3...v0.57.4)

</details>

### [Build 0.57.3](https://github.com/hashgraph/hedera-services/releases/tag/v0.57.3)

<details>

<summary><strong>What's Changed</strong></summary>

* fix: tokenClaimAirdrop throws NPE on null sender or receiver by [@kimbor](https://github.com/kimbor) in [#17096](https://github.com/hashgraph/hedera-services/pull/17096)

**Full Changelog**: [v0.57.2...v0.57.3](https://github.com/hashgraph/hedera-services/compare/v0.57.2...v0.57.3)

</details>

### [Build 0.57.2](https://github.com/hashgraph/hedera-services/releases/tag/v0.57.2)

<details>

<summary><strong>What's Changed</strong></summary>

* fix: Revert HIP-796 Protobuf changes (cherry-pick 0.57) by [@thomas-swirlds-labs](https://github.com/thomas-swirlds-labs) in [#17028](https://github.com/hashgraph/hedera-services/pull/17028)

**Full Changelog**: [v0.57.1...v0.57.2](https://github.com/hashgraph/hedera-services/compare/v0.57.1...v0.57.2)

</details>

### [Build 0.57.1](https://github.com/hashgraph/hedera-services/releases/tag/v0.57.1)

<details>

<summary><strong>What's Changed</strong></summary>

* ci: Fix cron jobs to use github token for gh cli calls and specify java version by [@rbarkerSL](https://github.com/rbarkerSL) in [#16175](https://github.com/hashgraph/hedera-services/pull/16175)
* build(deps): bump actions/setup-java from 4.0.0 to 4.5.0 by [@dependabot](https://github.com/dependabot) in [#16168](https://github.com/hashgraph/hedera-services/pull/16168)
* build(deps): bump actions/setup-python from 5.0.0 to 5.3.0 by [@dependabot](https://github.com/dependabot) in [#16169](https://github.com/hashgraph/hedera-services/pull/16169)
* build(deps): bump actions/cache from 4.0.1 to 4.1.2 by [@dependabot](https://github.com/dependabot) in [#16101](https://github.com/hashgraph/hedera-services/pull/16101)
* refactor: create event creator modules by [@mustafauzunn](https://github.com/mustafauzunn) in [#16138](https://github.com/hashgraph/hedera-services/pull/16138)
* refactor: gossip module names and extract FallenBehindManager to gossip module by [@mustafauzunn](https://github.com/mustafauzunn) in [#16113](https://github.com/hashgraph/hedera-services/pull/16113)
* ci: disable release 0.53 regression by [@JeffreyDallas](https://github.com/JeffreyDallas) in [#16188](https://github.com/hashgraph/hedera-services/pull/16188)
* feat: HIP-904 Reject Tokens System Contract implementation by [@stoyanov-st](https://github.com/stoyanov-st) in [#16118](https://github.com/hashgraph/hedera-services/pull/16118)
* feat: HIP 904 SetUnlimitedAutoAssociations System Contract Implementation by [@stoyanov-st](https://github.com/stoyanov-st) in [#16141](https://github.com/hashgraph/hedera-services/pull/16141)
* fix: LegacyConfigPropertiesLoader should not suppress ParseException by [@leninmehedy](https://github.com/leninmehedy) in [#16133](https://github.com/hashgraph/hedera-services/pull/16133)

**Full Changelog**: [v0.56.7...v0.57.1](https://github.com/hashgraph/hedera-services/compare/v0.56.7...v0.57.1)

</details>

### Performance Results

<figure><img src="../../.gitbook/assets/‎0.57_Performance Measurement Results_Extract.‎001.png" alt=""><figcaption></figcaption></figure>

## Release v0.56

{% hint style="success" %}
**MAINNET UPDATE SCHEDULED: DECEMBER 11, 2024**
{% endhint %}

{% hint style="success" %}
**TESTNET UPDATE SCHEDULED: DECEMBER 4, 2024**
{% endhint %}

### Release Highlights

#### HIPs

**HIP-869 Dynamic Address Book—Stage 1**: This release includes the implementation of HIP-869, enabling the Dynamic Address Book. Node operators can now update node details and address books via Hedera transactions. This streamlines network operations and enables node operators to manage their associated node entries directly in the Address Book.\
\
**HIP-904 System Contract Functions**: Implements the System Contract Functions section within [HIP-904](http://hips.hedera.com/hip/hip-904#system-contract-functions). Introduces Hedera Token Service (HTS) support for the airdrop-related capabilities. These functions are implemented as system contract functions, making it possible for smart contracts to issue Frictionless Airdrops, Token Reject, and AutomaticToken Association configurations for efficient management.\
\
**HIP-632 - `isAuthorized()`**: The `isAuthorized()` function introduced in [HIP-632](https://hips.hedera.com/hip/hip-632) extends the Hedera Account Service (HAS) System Contract, enabling smart contracts to authenticate signatures against Hedera accounts. This provides functionality akin to the validation step following Ethereum's `ECRECOVER`, without recovering public keys. It supports ECDSA, ED25519, and complex keys such as threshold keys, though ECDSA is recommended for compatibility and interoperability with Ethereum. This builds on the previous functionality of `isAuthorizedRaw()` released in 0.52.\
\
**Other Notable Changes:**\
\
**Block Streams - Dev Access Preview:** Block Streams is a new output stream that will replace Hedera’s existing event and record streams into a single stream of verifiable data. This consolidated approach not only simplifies data consumption but also enhances Hedera's capabilities by including state data.\
\
Starting with version 0.56, consensus nodes will publish preview block stream files alongside the existing record stream, which remains the authoritative source of truth for Hedera. This preview allows the community to explore, test, and provide feedback on this new feature, paving the way for its future adoption.\
\
**Migration from `.pfx` to `.pem` Cryptography Files**: The consensus node cryptography system was migrated from using `.pfx` files to more manageable `.pem` files.

### [Build 0.56.7](https://github.com/hashgraph/hedera-services/releases/tag/v0.56.7)

<details>

<summary><strong>What's Changed</strong></summary>

* chore: Cherry-Pick (0.56): Increase CryptoGetAccountBalance throttle by [@kimbor](https://github.com/kimbor) in [#16852](https://github.com/hashgraph/hedera-services/pull/16852)

**Full Changelog**: [v0.56.6...v0.56.7](https://github.com/hashgraph/hedera-services/compare/v0.56.6...v0.56.7)

</details>

### [Build 0.56.6](https://github.com/hashgraph/hedera-services/releases/tag/v0.56.6)

<details>

<summary><strong>What's Changed</strong></summary>

* chore: Cherry Pick: Modify and mount default block streams output directory by [@mhess-swl](https://github.com/mhess-swl) in [#16753](https://github.com/hashgraph/hedera-services/pull/16753)

**Full Changelog**: [v0.56.5...v0.56.6](https://github.com/hashgraph/hedera-services/compare/v0.56.5...v0.56.6)

</details>

### [**Build 0.56.5**](https://github.com/hashgraph/hedera-services/releases/tag/v0.56.5)

<details>

<summary><strong>What's Changed</strong></summary>

* fix: correct a missing conversion between AddressBook cert hash hex-string-as-bytes and actual SHA2-384 hash bytes for Node entries. by [@jsync-swirlds](https://github.com/jsync-swirlds) in [#16659](https://github.com/hashgraph/hedera-services/pull/16659)
* chore: Do stricter validation of X.509 gossip cert in DAB transactions by [@tinker-michaelj](https://github.com/tinker-michaelj) in [#16666](https://github.com/hashgraph/hedera-services/pull/16666)

**Full Changelog**: [v0.56.4...v0.56.5](https://github.com/hashgraph/hedera-services/compare/v0.56.4...v0.56.5)

</details>

### [**Build 0.56.0**](https://github.com/hashgraph/hedera-services/releases/tag/v0.56.0)

<details>

<summary><strong>What's Changed</strong></summary>

* test: Added a test to submit DAB transactions for JRS test by [@Neeharika-Sompalli](https://github.com/Neeharika-Sompalli) in [#15549](https://github.com/hashgraph/hedera-services/pull/15549)
* chore: cover HIP-869 test plan by [@tinker-michaelj](https://github.com/tinker-michaelj) in [#15568](https://github.com/hashgraph/hedera-services/pull/15568)
* test: Use DAB upgrade test in CI runs by [@Neeharika-Sompalli](https://github.com/Neeharika-Sompalli) in [#15618](https://github.com/hashgraph/hedera-services/pull/15618)
* ci: continuous integration tests and release initial phase 1 changes by [@rbarkerSL](https://github.com/rbarkerSL) in [#15363](https://github.com/hashgraph/hedera-services/pull/15363)
* perf: increase Health Monitor invocation frequency by [@OlegMazurov](https://github.com/OlegMazurov) in [#15627](https://github.com/hashgraph/hedera-services/pull/15627)
* feat: created iterface for inline PCES writer by [@timo0](https://github.com/timo0) in [#15629](https://github.com/hashgraph/hedera-services/pull/15629)
* feat: Add TSS related system transaction and state protobufs (Services) by [@thomas-swirlds-labs](https://github.com/thomas-swirlds-labs) in [#15515](https://github.com/hashgraph/hedera-services/pull/15515)
* feat: increase version to 0.56 by [@povolev15](https://github.com/povolev15) in [#15765](https://github.com/hashgraph/hedera-services/pull/15765)
* ci: Remove unnecessary check in node-flow-deploy-release-artifact by [@rbarkerSL](https://github.com/rbarkerSL) in [#15768](https://github.com/hashgraph/hedera-services/pull/15768)
* feat: Activate smart contract module 0.51 by [@david-bakin-sl](https://github.com/david-bakin-sl) in [#15772](https://github.com/hashgraph/hedera-services/pull/15772)
* chore: Add missing config files to `previewnet` config dir by [@mhess-swl](https://github.com/mhess-swl) in [#15778](https://github.com/hashgraph/hedera-services/pull/15778)
* test: Extend HAPI tests for TokenAirdrop with custom fees - royalty fees by [@Evdokia-Georgieva](https://github.com/Evdokia-Georgieva) in [#15518](https://github.com/hashgraph/hedera-services/pull/15518)
* feat: Added states for TssService by [@Neeharika-Sompalli](https://github.com/Neeharika-Sompalli) in [#15622](https://github.com/hashgraph/hedera-services/pull/15622)
* chore: remove unnecessary checks for value xfer to system contracts by [@lukelee-sl](https://github.com/lukelee-sl) in [#15774](https://github.com/hashgraph/hedera-services/pull/15774)
* chore: Cleanup `Signature` by [@timo0](https://github.com/timo0) in [#15570](https://github.com/hashgraph/hedera-services/pull/15570)
* chore: Add configuration properties for HIP-904 System Contracts by [@stoyanov-st](https://github.com/stoyanov-st) in [#15800](https://github.com/hashgraph/hedera-services/pull/15800)
* feat: Regenerate keys and update node names for tests by [@anthony-swirldslabs](https://github.com/anthony-swirldslabs) in [#15793](https://github.com/hashgraph/hedera-services/pull/15793)
* feat: Replaced AddressBook based NetworkInfo implementations by [@Neeharika-Sompalli](https://github.com/Neeharika-Sompalli) in [#15781](https://github.com/hashgraph/hedera-services/pull/15781)
* chore: Address review comments by [@Neeharika-Sompalli](https://github.com/Neeharika-Sompalli) in [#15826](https://github.com/hashgraph/hedera-services/pull/15826)
* chore: add node details/address book export validation in `DabEnabledUpgradeTest` by [@tinker-michaelj](https://github.com/tinker-michaelj) in [#15764](https://github.com/hashgraph/hedera-services/pull/15764)
* fix: Handle non-existent token IDs in token fee schedule updates by [@mhess-swl](https://github.com/mhess-swl) in [#15831](https://github.com/hashgraph/hedera-services/pull/15831)
* chore: Add Configuration support for GRPC messages by [@thomas-swirlds-labs](https://github.com/thomas-swirlds-labs) in [#15472](https://github.com/hashgraph/hedera-services/pull/15472)
* feat: use FileChannel for PCES by [@lpetrovic05](https://github.com/lpetrovic05) in [#15604](https://github.com/hashgraph/hedera-services/pull/15604)
* feat: create inline pces wiring by [@lpetrovic05](https://github.com/lpetrovic05) in [#15785](https://github.com/hashgraph/hedera-services/pull/15785)
* chore: remove nextNodeId from config.txt by [@edward-swirldslabs](https://github.com/edward-swirldslabs) in [#15791](https://github.com/hashgraph/hedera-services/pull/15791)
* chore: Make hedera-services also code owner of hedera-app by [@netopyr](https://github.com/netopyr) in [#15911](https://github.com/hashgraph/hedera-services/pull/15911)
* fix(container): adds resiliency to the deterministic image entrypoint script by [@nathanklick](https://github.com/nathanklick) in [#15914](https://github.com/hashgraph/hedera-services/pull/15914)
* chore: Correct locations of various TSS protos by [@mhess-swl](https://github.com/mhess-swl) in [#15780](https://github.com/hashgraph/hedera-services/pull/15780)
* chore: Add constructor for `Bytes` in `Hash` to avoid copying by [@timo0](https://github.com/timo0) in [#15783](https://github.com/hashgraph/hedera-services/pull/15783)
* fix: Add query handling metrics upload by [@mhess-swl](https://github.com/mhess-swl) in [#15900](https://github.com/hashgraph/hedera-services/pull/15900)
* fix: Airdrop transfer list size validation by [@JivkoKelchev](https://github.com/JivkoKelchev) in [#15933](https://github.com/hashgraph/hedera-services/pull/15933)
* ci: Move jenkins checks into its own workflow that executes when node-zxc-build-release artifact completes by [@rbarkerSL](https://github.com/rbarkerSL) in [#15928](https://github.com/hashgraph/hedera-services/pull/15928)
* ci: Fix invalid workflow introduced by 15928 by [@rbarkerSL](https://github.com/rbarkerSL) in [#15948](https://github.com/hashgraph/hedera-services/pull/15948)
* ci: Add skipped status as possible triggering conclusion by [@rbarkerSL](https://github.com/rbarkerSL) in [#15956](https://github.com/hashgraph/hedera-services/pull/15956)
* ci: ensure prepare xts branch launches when node deploy production build finishes by [@rbarkerSL](https://github.com/rbarkerSL) in [#15957](https://github.com/hashgraph/hedera-services/pull/15957)
* fix: 15959: Add more logging for 12311 by [@artemananiev](https://github.com/artemananiev) in [#15960](https://github.com/hashgraph/hedera-services/pull/15960)
* chore: remove unused wiring options by [@lpetrovic05](https://github.com/lpetrovic05) in [#15931](https://github.com/hashgraph/hedera-services/pull/15931)
* build(deps): bump actions/upload-artifact from 4.3.1 to 4.4.3 by [@dependabot](https://github.com/dependabot) in [#15940](https://github.com/hashgraph/hedera-services/pull/15940)
* build(deps): bump actions/checkout from 4.1.1 to 4.2.1 by [@dependabot](https://github.com/dependabot) in [#15902](https://github.com/hashgraph/hedera-services/pull/15902)
* ci: Checkout the code with GH\_ACCESS\_TOKEN and persist the credentials by [@rbarkerSL](https://github.com/rbarkerSL) in [#15965](https://github.com/hashgraph/hedera-services/pull/15965)
* ci: Updated XTS job to check statuses and added gpg key to prepare XTS by [@rbarkerSL](https://github.com/rbarkerSL) in [#15967](https://github.com/hashgraph/hedera-services/pull/15967)
* ci: Update tag scheme in prepare XTS flow by [@rbarkerSL](https://github.com/rbarkerSL) in [#15968](https://github.com/hashgraph/hedera-services/pull/15968)
* ci: Add message parameter to forced tag step by [@rbarkerSL](https://github.com/rbarkerSL) in [#15970](https://github.com/hashgraph/hedera-services/pull/15970)
* fix: support restarting from `RECORDS` -> `BOTH` by [@tinker-michaelj](https://github.com/tinker-michaelj) in [#15904](https://github.com/hashgraph/hedera-services/pull/15904)
* ci: Fix issue with zxf prepare extended test suite by [@rbarkerSL](https://github.com/rbarkerSL) in [#15974](https://github.com/hashgraph/hedera-services/pull/15974)
* fix: ensure configuration loading and name resolution is resilient by [@nathanklick](https://github.com/nathanklick) in [#15943](https://github.com/hashgraph/hedera-services/pull/15943)
* feat: wire skeleton `TssBaseService` handlers to submission-enabled `AppContext` by [@tinker-michaelj](https://github.com/tinker-michaelj) in [#15975](https://github.com/hashgraph/hedera-services/pull/15975)
* feat: permit unpaid queries when executed from localhost by [@MiroslavGatsanoga](https://github.com/MiroslavGatsanoga) in [#15554](https://github.com/hashgraph/hedera-services/pull/15554)
* feat: introduce NodeId.of(long) by [@anthony-swirldslabs](https://github.com/anthony-swirldslabs) in [#15952](https://github.com/hashgraph/hedera-services/pull/15952)
* feat: 15154 Added `createSnapshot` method to State API by [@imalygin](https://github.com/imalygin) in [#15543](https://github.com/hashgraph/hedera-services/pull/15543)
* fix: 15994: Need more logging in AbstractHashListener by [@artemananiev](https://github.com/artemananiev) in [#15995](https://github.com/hashgraph/hedera-services/pull/15995)
* build(deps): bump org.gradlex:java-module-dependencies from 1.7 to 1.7.1 in /gradle/plugins by [@dependabot](https://github.com/dependabot) in [#15958](https://github.com/hashgraph/hedera-services/pull/15958)
* fix: Ensure `getAccountInfo` returns correct EVM address by [@tinker-michaelj](https://github.com/tinker-michaelj) in [#15969](https://github.com/hashgraph/hedera-services/pull/15969)
* chore: Fix compiler warnings in token service by [@derektriley](https://github.com/derektriley) in [#15265](https://github.com/hashgraph/hedera-services/pull/15265)
* test: add block contents validator by [@MiroslavGatsanoga](https://github.com/MiroslavGatsanoga) in [#15522](https://github.com/hashgraph/hedera-services/pull/15522)
* build: update Java Module patching by [@jjohannes](https://github.com/jjohannes) in [#15578](https://github.com/hashgraph/hedera-services/pull/15578)
* chore: add links to TSS issues by [@tinker-michaelj](https://github.com/tinker-michaelj) in [#15999](https://github.com/hashgraph/hedera-services/pull/15999)
* build: generalize publishing setup by [@jjohannes](https://github.com/jjohannes) in [#15471](https://github.com/hashgraph/hedera-services/pull/15471)
* fix: detect post-upgrade txn in presence of pre-upgrade events by [@tinker-michaelj](https://github.com/tinker-michaelj) in [#15834](https://github.com/hashgraph/hedera-services/pull/15834)
* fix: update the Schema class import statement by [@albertopasqualetto](https://github.com/albertopasqualetto) in [#15927](https://github.com/hashgraph/hedera-services/pull/15927)
* fix: stabilize `keyRotationDoesNotChangeEvmAddress()` by [@tinker-michaelj](https://github.com/tinker-michaelj) in [#16006](https://github.com/hashgraph/hedera-services/pull/16006)
* feat: updateNode needs both admin key and council to sign. by [@iwsimon](https://github.com/iwsimon) in [#15988](https://github.com/hashgraph/hedera-services/pull/15988)
* chore: enable `BLOCKS`-only stream mode by [@tinker-michaelj](https://github.com/tinker-michaelj) in [#15634](https://github.com/hashgraph/hedera-services/pull/15634)
* test: create fake TSS library for testing by [@MiroslavGatsanoga](https://github.com/MiroslavGatsanoga) in [#15908](https://github.com/hashgraph/hedera-services/pull/15908)
* chore: Fix ownership of services protobufs by [@netopyr](https://github.com/netopyr) in [#16015](https://github.com/hashgraph/hedera-services/pull/16015)
* feat: Remove default memo for lazy created accounts and auto created accounts by [@netopyr](https://github.com/netopyr) in [#15302](https://github.com/hashgraph/hedera-services/pull/15302)
* chore: use `0s` as `@RepeatableHapiTest` valid start offset by [@tinker-michaelj](https://github.com/tinker-michaelj) in [#16028](https://github.com/hashgraph/hedera-services/pull/16028)
* fix: DefaultKycStatusCall correct returned values from System Contract by [@stoyanov-st](https://github.com/stoyanov-st) in [#15595](https://github.com/hashgraph/hedera-services/pull/15595)
* chore: Remove hedera-base as code owner by [@netopyr](https://github.com/netopyr) in [#16043](https://github.com/hashgraph/hedera-services/pull/16043)
* chore: use `fireAndForget()` for freeze period background traffic by [@tinker-michaelj](https://github.com/tinker-michaelj) in [#16031](https://github.com/hashgraph/hedera-services/pull/16031)
* chore: cherry-pick, Do not update file 102 during the first transaction after a freeze upgrade when DAB is disabled by [@iwsimon](https://github.com/iwsimon) in [#16050](https://github.com/hashgraph/hedera-services/pull/16050)
* chore: tolerate nextNodeId field in config.txt by [@edward-swirldslabs](https://github.com/edward-swirldslabs) in [#16048](https://github.com/hashgraph/hedera-services/pull/16048)
* feat: 14726: Proposal for consensus node architecture update by [@rbair23](https://github.com/rbair23) in [#14772](https://github.com/hashgraph/hedera-services/pull/14772)
* refactor: gossip modules creation by [@mustafauzunn](https://github.com/mustafauzunn) in [#15837](https://github.com/hashgraph/hedera-services/pull/15837)
* ci: Updating workflow permissions as per step-security recommendations. by [@san-est](https://github.com/san-est) in [#16036](https://github.com/hashgraph/hedera-services/pull/16036)
* chore: standardize and simplify `ScheduleService` by [@tinker-michaelj](https://github.com/tinker-michaelj) in [#16053](https://github.com/hashgraph/hedera-services/pull/16053)
* ci: Enable build promotion tagging and XTS completion by [@rbarkerSL](https://github.com/rbarkerSL) in [#15971](https://github.com/hashgraph/hedera-services/pull/15971)
* feat: Readable and Writable Roster state stores by [@derektriley](https://github.com/derektriley) in [#16120](https://github.com/hashgraph/hedera-services/pull/16120)
* chore: eliminate duplicated signature verification logic by [@tinker-michaelj](https://github.com/tinker-michaelj) in [#16075](https://github.com/hashgraph/hedera-services/pull/16075)
* test: add test to validate null admin key for contract can still xfer value by [@lukelee-sl](https://github.com/lukelee-sl) in [#16063](https://github.com/hashgraph/hedera-services/pull/16063)
* feat: Add logic for `TssMessageHandler` for happy path by [@Neeharika-Sompalli](https://github.com/Neeharika-Sompalli) in [#16062](https://github.com/hashgraph/hedera-services/pull/16062)
* ci: Temporarily disable Trigger ZXF Deploy Integration. by [@rbarkerSL](https://github.com/rbarkerSL) in [#16122](https://github.com/hashgraph/hedera-services/pull/16122)
* feat: HIP-904 Token Airdrop System Contract by [@stoyanov-st](https://github.com/stoyanov-st) in [#15912](https://github.com/hashgraph/hedera-services/pull/15912)
* docs: Provide Design document for HIP-904 System Contracts flows by [@stoyanov-st](https://github.com/stoyanov-st) in [#15435](https://github.com/hashgraph/hedera-services/pull/15435)
* chore: migrate cryptography from .pfx to .pem files by [@edward-swirldslabs](https://github.com/edward-swirldslabs) in [#16025](https://github.com/hashgraph/hedera-services/pull/16025)
* ci: Add logic to only delete xts-candidate tag if it already exists by [@rbarkerSL](https://github.com/rbarkerSL) in [#16140](https://github.com/hashgraph/hedera-services/pull/16140)
* ci: Fix ZXCron Promote Build Candidate Checkout Tagged Code step by [@rbarkerSL](https://github.com/rbarkerSL) in [#16154](https://github.com/hashgraph/hedera-services/pull/16154)
* ci: Fix bug with deleting xts-candidate tag prior to creation or use by [@rbarkerSL](https://github.com/rbarkerSL) in [#16159](https://github.com/hashgraph/hedera-services/pull/16159)
* feat: HIP-904 Implement TokenClaimAirdrop System Contract by [@stoyanov-st](https://github.com/stoyanov-st) in [#16054](https://github.com/hashgraph/hedera-services/pull/16054)
* ci: Specify java major minor and patch versions by [@mishomihov00](https://github.com/mishomihov00) in [#16176](https://github.com/hashgraph/hedera-services/pull/16176)
* feat: counting get balance throttle by [@netopyr](https://github.com/netopyr) in [#16178](https://github.com/hashgraph/hedera-services/pull/16178)
* feat: HIP-904 Implement Token Cancel Airdrop System Contract by [@stoyanov-st](https://github.com/stoyanov-st) in [#15996](https://github.com/hashgraph/hedera-services/pull/15996)
* feat: align state and records for self managed contract keys on create by [@lukelee-sl](https://github.com/lukelee-sl) in [#16095](https://github.com/hashgraph/hedera-services/pull/16095)
* feat: Update BlockStreamConfig StreamMode default to BOTH by [@derektriley](https://github.com/derektriley) in [#16167](https://github.com/hashgraph/hedera-services/pull/16167)
* chore: replace usages of AddressBook with Roster in tipset by [@anthony-swirldslabs](https://github.com/anthony-swirldslabs) in [#16102](https://github.com/hashgraph/hedera-services/pull/16102)
* chore: Address review comments on PR [#420](https://github.com/hashgraph/hedera-services/pull/420) in protobufs by [@Neeharika-Sompalli](https://github.com/Neeharika-Sompalli) in [#16148](https://github.com/hashgraph/hedera-services/pull/16148)
* feat: throttled tx metrics by [@kimbor](https://github.com/kimbor) in [#16130](https://github.com/hashgraph/hedera-services/pull/16130)
* feat: Set TSS candidate roster logic by [@mhess-swl](https://github.com/mhess-swl) in [#16131](https://github.com/hashgraph/hedera-services/pull/16131)
* chore: schedule 0.56 release branch creation by [@kimbor](https://github.com/kimbor) in [#16184](https://github.com/hashgraph/hedera-services/pull/16184)
* feat: Initial TssVoteHandler by [@derektriley](https://github.com/derektriley) in [#16061](https://github.com/hashgraph/hedera-services/pull/16061)

#### New Contributors

* [@albertopasqualetto](https://github.com/albertopasqualetto) made their first contribution in [#15927](https://github.com/hashgraph/hedera-services/pull/15927)
* [@san-est](https://github.com/san-est) made their first contribution in [#16036](https://github.com/hashgraph/hedera-services/pull/16036)
* [@mishomihov00](https://github.com/mishomihov00) made their first contribution in [#16176](https://github.com/hashgraph/hedera-services/pull/16176)

**Full Changelog**: [v0.55.1...v0.56.0](https://github.com/hashgraph/hedera-services/compare/v0.55.1...v0.56.0)

</details>

### Performance Results

<figure><img src="../../.gitbook/assets/‎0.56_Performance Measurement Results_Extract.‎001.png" alt=""><figcaption></figcaption></figure>

### [Build v0.56.5](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.56.5)

<details>
<summary><strong>What's Changed</strong></summary>

* * fix: correct a missing conversion between AddressBook cert hash hex-string-as-bytes and actual SHA2-384 hash bytes for Node entries. by @jsync-swirlds in https://github.com/hashgraph/hedera-services/pull/16659
* * chore: Do stricter validation of X.509 gossip cert in DAB transactions by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/16666
* **Full Changelog**: https://github.com/hashgraph/hedera-services/compare/v0.56.4...v0.56.5

**Full Changelog**: [v0.56.0...v0.56.5](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.56.0...v0.56.5)

</details>

### [Build v0.56.4](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.56.4)

<details>
<summary><strong>What's Changed</strong></summary>

* * feat: change the staking defaults by @povolev15 in https://github.com/hashgraph/hedera-services/pull/16533
* * feat: (cherry-pick) Added 056 AddressBook schema by @iwsimon in https://github.com/hashgraph/hedera-services/pull/16528
* * fix: Cherry-Pick Enable HIP-904 System Contracts configuration by @stoyanov-st in https://github.com/hashgraph/hedera-services/pull/16545
* * feat: increase roundsExpired and maxAggregateRels by @poulok in https://github.com/hashgraph/hedera-services/pull/16567
* * fix: Cherry-pick pom name field fix by @rbarkerSL in https://github.com/hashgraph/hedera-services/pull/16586
* * fix: Genesis network info is not found issue. by @iwsimon in https://github.com/hashgraph/hedera-services/pull/16588
* * fix: weight update typo by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/16609
* * build(bug): cherry pick #16626 into release 0.56 by @rbarkerSL in https://github.com/hashgraph/hedera-services/pull/16628
* **Full Changelog**: https://github.com/hashgraph/hedera-services/compare/v0.56.1...v0.56.4

**Full Changelog**: [v0.56.0...v0.56.4](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.56.0...v0.56.4)

</details>

### [Build v0.56.1](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.56.1)

<details>
<summary><strong>What's Changed</strong></summary>

* * feat: Cherry-Pick (0.56): Define throttle for GetBalance queries by @vtronkov in https://github.com/hashgraph/hedera-services/pull/16338
* * fix: Cherry-Pick(0.56) HIP-904 Reject Tokens System Contract implementation by @stoyanov-st in https://github.com/hashgraph/hedera-services/pull/16195
* * fix: Cherry-Pick (0.56) HIP 904 SetUnlimitedAutoAssociations System Contract Implementation by @stoyanov-st in https://github.com/hashgraph/hedera-services/pull/16196
* * ci: specify java version by @rbarkerSL in https://github.com/hashgraph/hedera-services/pull/16360
* * feat: Cherry-Pick (0.56): Update TokensConfig countingGetBalanceThrottleEnabled default to true by @derektriley in https://github.com/hashgraph/hedera-services/pull/16366
* * fix: Cherry pick (0.56): `isAuthorizedRaw` bug fix by @david-bakin-sl in https://github.com/hashgraph/hedera-services/pull/16405
* * feat: Cherry pick (0.56): HIP-632 `isAuthorized` system contract method implementation by @david-bakin-sl in https://github.com/hashgraph/hedera-services/pull/16443
* * fix: cryptography always generates agreement keys on startup by @edward-swirldslabs in https://github.com/hashgraph/hedera-services/pull/16457
* * chore: support node admin key overrides at startup by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/16496
* * fix: Use disk address book to construct network Info by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/16500
* * perf: Improve health monitor efficiency by @OlegMazurov in https://github.com/hashgraph/hedera-services/pull/16423
* * feat: (cherry-pick) NodeUpdate needs only admin key to sign by @iwsimon in https://github.com/hashgraph/hedera-services/pull/16502
* * fix: Cherry-pick: Remove tss encryption key from node-related protos by @mhess-swl in https://github.com/hashgraph/hedera-services/pull/16514
* * feat: increase maximums to 100M each by default by @poulok in https://github.com/hashgraph/hedera-services/pull/16518
* **Full Changelog**: https://github.com/hashgraph/hedera-services/compare/v0.56.0...v0.56.1

**Full Changelog**: [v0.56.0...v0.56.1](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.56.0...v0.56.1)

</details>

### [Build v0.56.0](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.56.0)

<details>
<summary><strong>What's Changed</strong></summary>

* * test: Added a test to submit DAB transactions for JRS test by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/15549
* * chore: cover HIP-869 test plan by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/15568
* * test: Use DAB upgrade test in CI runs  by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/15618
* * ci: continuous integration tests and release initial phase 1 changes by @rbarkerSL in https://github.com/hashgraph/hedera-services/pull/15363
* * perf: increase Health Monitor invocation frequency by @OlegMazurov in https://github.com/hashgraph/hedera-services/pull/15627
* * feat: created iterface for inline PCES writer by @timo0 in https://github.com/hashgraph/hedera-services/pull/15629
* * feat: Add TSS related system transaction and state protobufs (Services)  by @thomas-swirlds-labs in https://github.com/hashgraph/hedera-services/pull/15515
* * feat: increase version to 0.56 by @povolev15 in https://github.com/hashgraph/hedera-services/pull/15765
* * ci: Remove unnecessary check in node-flow-deploy-release-artifact by @rbarkerSL in https://github.com/hashgraph/hedera-services/pull/15768
* * feat: Activate smart contract module 0.51 by @david-bakin-sl in https://github.com/hashgraph/hedera-services/pull/15772
* * chore: Add missing config files to `previewnet` config dir by @mhess-swl in https://github.com/hashgraph/hedera-services/pull/15778
* * test: Extend HAPI tests for TokenAirdrop with custom fees - royalty fees by @Evdokia-Georgieva in https://github.com/hashgraph/hedera-services/pull/15518
* * feat: Added states for TssService by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/15622
* * chore: remove unnecessary checks for value xfer to system contracts by @lukelee-sl in https://github.com/hashgraph/hedera-services/pull/15774
* * chore: Cleanup `Signature` by @timo0 in https://github.com/hashgraph/hedera-services/pull/15570
* * chore: Add configuration properties for HIP-904 System Contracts by @stoyanov-st in https://github.com/hashgraph/hedera-services/pull/15800
* * feat: Regenerate keys and update node names for tests by @anthony-swirldslabs in https://github.com/hashgraph/hedera-services/pull/15793
* * feat: Replaced AddressBook based NetworkInfo implementations by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/15781
* * chore: Address review comments by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/15826
* * chore: add node details/address book export validation in `DabEnabledUpgradeTest` by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/15764
* * fix: Handle non-existent token IDs in token fee schedule updates by @mhess-swl in https://github.com/hashgraph/hedera-services/pull/15831
* * chore: Add Configuration support for GRPC messages by @thomas-swirlds-labs in https://github.com/hashgraph/hedera-services/pull/15472
* * feat: use FileChannel for PCES by @lpetrovic05 in https://github.com/hashgraph/hedera-services/pull/15604
* * feat: create inline pces wiring by @lpetrovic05 in https://github.com/hashgraph/hedera-services/pull/15785
* * chore: remove nextNodeId from config.txt by @edward-swirldslabs in https://github.com/hashgraph/hedera-services/pull/15791
* * chore: Make hedera-services also code owner of hedera-app by @netopyr in https://github.com/hashgraph/hedera-services/pull/15911
* * fix(container): adds resiliency to the deterministic image entrypoint script by @nathanklick in https://github.com/hashgraph/hedera-services/pull/15914
* * chore: Correct locations of various TSS protos by @mhess-swl in https://github.com/hashgraph/hedera-services/pull/15780
* * chore: Add constructor for `Bytes` in `Hash` to avoid copying by @timo0 in https://github.com/hashgraph/hedera-services/pull/15783
* * fix: Add query handling metrics upload by @mhess-swl in https://github.com/hashgraph/hedera-services/pull/15900
* * fix: Airdrop transfer list size validation by @JivkoKelchev in https://github.com/hashgraph/hedera-services/pull/15933
* * ci: Move jenkins checks into its own workflow that executes when node-zxc-build-release artifact completes by @rbarkerSL in https://github.com/hashgraph/hedera-services/pull/15928
* * ci: Fix invalid workflow introduced by 15928 by @rbarkerSL in https://github.com/hashgraph/hedera-services/pull/15948
* * ci: Add skipped status as possible triggering conclusion by @rbarkerSL in https://github.com/hashgraph/hedera-services/pull/15956
* * ci: ensure prepare xts branch launches when node deploy production build finishes by @rbarkerSL in https://github.com/hashgraph/hedera-services/pull/15957
* * fix: 15959: Add more logging for 12311 by @artemananiev in https://github.com/hashgraph/hedera-services/pull/15960
* * chore: remove unused wiring options by @lpetrovic05 in https://github.com/hashgraph/hedera-services/pull/15931
* * build(deps): bump actions/upload-artifact from 4.3.1 to 4.4.3 by @dependabot in https://github.com/hashgraph/hedera-services/pull/15940
* * build(deps): bump actions/checkout from 4.1.1 to 4.2.1 by @dependabot in https://github.com/hashgraph/hedera-services/pull/15902
* * ci: Checkout the code with GH_ACCESS_TOKEN and persist the credentials by @rbarkerSL in https://github.com/hashgraph/hedera-services/pull/15965
* * ci: Updated XTS job to check statuses and added gpg key to prepare XTS by @rbarkerSL in https://github.com/hashgraph/hedera-services/pull/15967
* * ci: Update tag scheme in prepare XTS flow by @rbarkerSL in https://github.com/hashgraph/hedera-services/pull/15968
* * ci: Add message parameter to forced tag step by @rbarkerSL in https://github.com/hashgraph/hedera-services/pull/15970
* * fix: support restarting from `RECORDS` -> `BOTH` by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/15904
* * ci: Fix issue with zxf prepare extended test suite by @rbarkerSL in https://github.com/hashgraph/hedera-services/pull/15974
* * fix: ensure configuration loading and name resolution is resilient by @nathanklick in https://github.com/hashgraph/hedera-services/pull/15943
* * feat: wire skeleton `TssBaseService` handlers to submission-enabled `AppContext` by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/15975
* * feat: permit unpaid queries when executed from localhost by @MiroslavGatsanoga in https://github.com/hashgraph/hedera-services/pull/15554
* * feat: introduce NodeId.of(long) by @anthony-swirldslabs in https://github.com/hashgraph/hedera-services/pull/15952
* * feat: 15154 Added `createSnapshot` method to State API by @imalygin in https://github.com/hashgraph/hedera-services/pull/15543
* * fix: 15994: Need more logging in AbstractHashListener by @artemananiev in https://github.com/hashgraph/hedera-services/pull/15995
* * build(deps): bump org.gradlex:java-module-dependencies from 1.7 to 1.7.1 in /gradle/plugins by @dependabot in https://github.com/hashgraph/hedera-services/pull/15958
* * fix: Ensure `getAccountInfo` returns correct EVM address by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/15969
* * chore: Fix compiler warnings in token service by @derektriley in https://github.com/hashgraph/hedera-services/pull/15265
* * test: add block contents validator by @MiroslavGatsanoga in https://github.com/hashgraph/hedera-services/pull/15522
* * build: update Java Module patching by @jjohannes in https://github.com/hashgraph/hedera-services/pull/15578
* * chore: add links to TSS issues by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/15999
* * build: generalize publishing setup by @jjohannes in https://github.com/hashgraph/hedera-services/pull/15471
* * fix: detect post-upgrade txn in presence of pre-upgrade events by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/15834
* * fix: update the Schema class import statement by @albertopasqualetto in https://github.com/hashgraph/hedera-services/pull/15927
* * fix: stabilize `keyRotationDoesNotChangeEvmAddress()` by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/16006
* * feat: updateNode needs both admin key and council to sign. by @iwsimon in https://github.com/hashgraph/hedera-services/pull/15988
* * chore: enable `BLOCKS`-only stream mode by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/15634
* * test: create fake TSS library for testing by @MiroslavGatsanoga in https://github.com/hashgraph/hedera-services/pull/15908
* * chore: Fix ownership of services protobufs by @netopyr in https://github.com/hashgraph/hedera-services/pull/16015
* * feat: Remove default memo for lazy created accounts and auto created accounts by @netopyr in https://github.com/hashgraph/hedera-services/pull/15302
* * chore: use `0s` as `@RepeatableHapiTest` valid start offset by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/16028
* * fix: DefaultKycStatusCall correct returned values from System Contract by @stoyanov-st in https://github.com/hashgraph/hedera-services/pull/15595
* * chore: Remove hedera-base as code owner by @netopyr in https://github.com/hashgraph/hedera-services/pull/16043
* * chore: use `fireAndForget()` for freeze period background traffic by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/16031
* * chore: cherry-pick, Do not update file 102 during the first transaction after a freeze upgrade when DAB is disabled by @iwsimon in https://github.com/hashgraph/hedera-services/pull/16050
* * chore: tolerate nextNodeId field in config.txt by @edward-swirldslabs in https://github.com/hashgraph/hedera-services/pull/16048
* * feat: 14726: Proposal for consensus node architecture update by @rbair23 in https://github.com/hashgraph/hedera-services/pull/14772
* * refactor: gossip modules creation by @mustafauzunn in https://github.com/hashgraph/hedera-services/pull/15837
* * ci: Updating workflow permissions as per step-security recommendations. by @san-est in https://github.com/hashgraph/hedera-services/pull/16036
* * chore: standardize and simplify `ScheduleService` by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/16053
* * ci: Enable build promotion tagging and XTS completion by @rbarkerSL in https://github.com/hashgraph/hedera-services/pull/15971
* * feat: Readable and Writable Roster state stores by @derektriley in https://github.com/hashgraph/hedera-services/pull/16120
* * chore: eliminate duplicated signature verification logic by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/16075
* * test: add test to validate null admin key for contract can still xfer value by @lukelee-sl in https://github.com/hashgraph/hedera-services/pull/16063
* * feat: Add logic for `TssMessageHandler` for happy path by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/16062
* * ci: Temporarily disable Trigger ZXF Deploy Integration. by @rbarkerSL in https://github.com/hashgraph/hedera-services/pull/16122
* * feat: HIP-904 Token Airdrop System Contract by @stoyanov-st in https://github.com/hashgraph/hedera-services/pull/15912
* * docs: Provide Design document for HIP-904 System Contracts flows by @stoyanov-st in https://github.com/hashgraph/hedera-services/pull/15435
* * chore: migrate cryptography from .pfx to .pem files by @edward-swirldslabs in https://github.com/hashgraph/hedera-services/pull/16025
* * ci: Add logic to only delete xts-candidate tag if it already exists by @rbarkerSL in https://github.com/hashgraph/hedera-services/pull/16140
* * ci: Fix ZXCron Promote Build Candidate Checkout Tagged Code step by @rbarkerSL in https://github.com/hashgraph/hedera-services/pull/16154
* * ci: Fix bug with deleting xts-candidate tag prior to creation or use  by @rbarkerSL in https://github.com/hashgraph/hedera-services/pull/16159
* * feat: HIP-904 Implement TokenClaimAirdrop System Contract by @stoyanov-st in https://github.com/hashgraph/hedera-services/pull/16054
* * ci: Specify java major minor and patch versions by @mishomihov00 in https://github.com/hashgraph/hedera-services/pull/16176
* * feat: counting get balance throttle by @netopyr in https://github.com/hashgraph/hedera-services/pull/16178
* * feat: HIP-904 Implement Token Cancel Airdrop System Contract by @stoyanov-st in https://github.com/hashgraph/hedera-services/pull/15996
* * feat: align state and records for self managed contract keys on create by @lukelee-sl in https://github.com/hashgraph/hedera-services/pull/16095
* * feat: Update BlockStreamConfig StreamMode default to BOTH by @derektriley in https://github.com/hashgraph/hedera-services/pull/16167
* * chore: replace usages of AddressBook with Roster in tipset by @anthony-swirldslabs in https://github.com/hashgraph/hedera-services/pull/16102
* * chore: Address review comments on PR #420 in protobufs by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/16148
* * feat: throttled tx metrics by @kimbor in https://github.com/hashgraph/hedera-services/pull/16130
* * feat: Set TSS candidate roster logic by @mhess-swl in https://github.com/hashgraph/hedera-services/pull/16131
* * chore: schedule 0.56 release branch creation by @kimbor in https://github.com/hashgraph/hedera-services/pull/16184
* * feat: Initial TssVoteHandler by @derektriley in https://github.com/hashgraph/hedera-services/pull/16061
* ## New Contributors
* * @albertopasqualetto made their first contribution in https://github.com/hashgraph/hedera-services/pull/15927
* * @san-est made their first contribution in https://github.com/hashgraph/hedera-services/pull/16036
* * @mishomihov00 made their first contribution in https://github.com/hashgraph/hedera-services/pull/16176
* **Full Changelog**: https://github.com/hashgraph/hedera-services/compare/v0.55.1...v0.56.0

**Full Changelog**: [v0.56.0...v0.56.0](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.56.0...v0.56.0)

</details>

## Release v0.55

{% hint style="success" %}
**MAINNET UPDATE SCHEDULED: NOVEMBER 13, 2024**
{% endhint %}

{% hint style="success" %}
**TESTNET UPDATE SCHEDULED: NOVEMBER 5, 2024**
{% endhint %}

### Release Highlights

#### **Notable Change**

**Throttle for `AccountBalanceQuery`**

* A new throttle for `AccountBalanceQuery` requests to manage and optimize query load on the network.

### [Build 0.55.2](https://github.com/hashgraph/hedera-services/releases/tag/v0.55.2)

<details>

<summary><strong>What's Changed</strong></summary>

* chore: 16356 cherry pick java version fixes by [@rbarkerSL](https://github.com/rbarkerSL) in [#16358](https://github.com/hashgraph/hedera-services/pull/16358)
* feat: Cherry-Pick (0.55): Define throttle for GetBalance queries by [@vtronkov](https://github.com/vtronkov) in [#16339](https://github.com/hashgraph/hedera-services/pull/16339)

**Full Changelog**: [v0.55.1...v0.55.2](https://github.com/hashgraph/hedera-services/compare/v0.55.1...v0.55.2)

</details>

### [Build 0.55.1](https://github.com/hashgraph/hedera-services/releases/tag/v0.55.1)

{% hint style="success" %}
**TESTNET UPDATE SCHEDULED: OCTOBER 29, 2024**
{% endhint %}

<details>

<summary><strong>What's Changed</strong></summary>

* chore: cherry-pick, do not update file 102 during the first transaction after a freeze upgrade when DAB is disabled by [@iwsimon](https://github.com/iwsimon) in [#16045](https://github.com/hashgraph/hedera-services/pull/16045)

**Full Changelog**: [v0.55.0...v0.55.1](https://github.com/hashgraph/hedera-services/compare/v0.55.0...v0.55.1)

</details>

### [Build 0.55.0](https://github.com/hashgraph/hedera-services/releases/tag/v0.55.0)

<details>

<summary><strong>What's Changed</strong></summary>

* docs: tss ledger id platform design proposal by [@edward-swirldslabs](https://github.com/edward-swirldslabs) in [#13747](https://github.com/hashgraph/hedera-services/pull/13747)
* chore: remove unused `hedera-evm-*` and `cli-clients` modules by [@tinker-michaelj](https://github.com/tinker-michaelj) in [#15271](https://github.com/hashgraph/hedera-services/pull/15271)
* chore: 11771 Added more unit tests for `WritablePlatformStateStore` by [@imalygin](https://github.com/imalygin) in [#15268](https://github.com/hashgraph/hedera-services/pull/15268)
* test: Token Claim Airdrop with receiverSigReq test by [@ibankov](https://github.com/ibankov) in [#15279](https://github.com/hashgraph/hedera-services/pull/15279)
* chore: rename directory 'swirlds-jasperdb' to 'swirlds-merkledb' by [@jjohannes](https://github.com/jjohannes) in [#15143](https://github.com/hashgraph/hedera-services/pull/15143)
* chore: remove 'itest' test set by [@jjohannes](https://github.com/jjohannes) in [#15276](https://github.com/hashgraph/hedera-services/pull/15276)
* fix: code style and javadoc fixes by [@kimbor](https://github.com/kimbor) in [#15298](https://github.com/hashgraph/hedera-services/pull/15298)
* test: add a sigRequired true additional test by [@povolev15](https://github.com/povolev15) in [#15267](https://github.com/hashgraph/hedera-services/pull/15267)
* fix: use `ServicesSoftwareVersion` by [@tinker-michaelj](https://github.com/tinker-michaelj) in [#15294](https://github.com/hashgraph/hedera-services/pull/15294)
* fix: if the directory exist, don't create it in UnzipUtility by [@iwsimon](https://github.com/iwsimon) in [#15319](https://github.com/hashgraph/hedera-services/pull/15319)
* fix: 10342: HashListByteBuffer releases DirectByteBuffers lazily, adds memory pressure by [@artemananiev](https://github.com/artemananiev) in [#15296](https://github.com/hashgraph/hedera-services/pull/15296)
* feat: 15146 Added `calculateHash`, `setHash` and `getHash` methods to `State` interface by [@imalygin](https://github.com/imalygin) in [#15274](https://github.com/hashgraph/hedera-services/pull/15274)
* chore: Refactor and Remove Duplicate Documentation in Services by [@thomas-swirlds-labs](https://github.com/thomas-swirlds-labs) in [#15286](https://github.com/hashgraph/hedera-services/pull/15286)
* fix: stop using raw types in `Call{Attempt,Translator}` by [@tinker-michaelj](https://github.com/tinker-michaelj) in [#15331](https://github.com/hashgraph/hedera-services/pull/15331)
* chore: Integrate protobufs to build by [@tinker-michaelj](https://github.com/tinker-michaelj) in [#15324](https://github.com/hashgraph/hedera-services/pull/15324)
* ci: disable release 0.52 regression by [@JeffreyDallas](https://github.com/JeffreyDallas) in [#15228](https://github.com/hashgraph/hedera-services/pull/15228)
* chore: Remove the script forensic/start-investigation.py by [@tungbq](https://github.com/tungbq) in [#14264](https://github.com/hashgraph/hedera-services/pull/14264)
* chore: add unit tests for `ServicesSoftwareVersion` utilities by [@tinker-michaelj](https://github.com/tinker-michaelj) in [#15326](https://github.com/hashgraph/hedera-services/pull/15326)
* fix: Prevent designating deleted accounts as custom fee collectors by [@mhess-swl](https://github.com/mhess-swl) in [#15339](https://github.com/hashgraph/hedera-services/pull/15339)
* chore: Bump services version to 0.55 by [@mhess-swl](https://github.com/mhess-swl) in [#15321](https://github.com/hashgraph/hedera-services/pull/15321)
* fix: skip checkSignatures when state.isPcesRound() by [@edward-swirldslabs](https://github.com/edward-swirldslabs) in [#15289](https://github.com/hashgraph/hedera-services/pull/15289)
* fix: ensure `StakePeriodManager` current stake period is always up-to-date by [@tinker-michaelj](https://github.com/tinker-michaelj) in [#15346](https://github.com/hashgraph/hedera-services/pull/15346)
* feat: HIP-632 alias-to-accounts and back by [@david-bakin-sl](https://github.com/david-bakin-sl) in [#15281](https://github.com/hashgraph/hedera-services/pull/15281)
* fix: allow absent agreement keys on disk and in state by [@edward-swirldslabs](https://github.com/edward-swirldslabs) in [#15340](https://github.com/hashgraph/hedera-services/pull/15340)
* chore: Allow injection of CacheWarmer's Executor by [@netopyr](https://github.com/netopyr) in [#15353](https://github.com/hashgraph/hedera-services/pull/15353)
* fix: complete block -> record translation for all PR checks by [@tinker-michaelj](https://github.com/tinker-michaelj) in [#15300](https://github.com/hashgraph/hedera-services/pull/15300)
* chore: logging config is automatically reloaded by [@hendrikebbers](https://github.com/hendrikebbers) in [#13919](https://github.com/hashgraph/hedera-services/pull/13919)
* build: update to latest versions - Gradle / Develocity plugin / Dependency Analysis plugin by [@jjohannes](https://github.com/jjohannes) in [#15372](https://github.com/hashgraph/hedera-services/pull/15372)
* build: add 'timeConsuming' test set by [@jjohannes](https://github.com/jjohannes) in [#15371](https://github.com/hashgraph/hedera-services/pull/15371)
* fix: Remove HederaFileNumbers and HederaAccountNumbers by [@povolev15](https://github.com/povolev15) in [#15360](https://github.com/hashgraph/hedera-services/pull/15360)
* chore: cleanup exception behavior and add javadocs by [@lukelee-sl](https://github.com/lukelee-sl) in [#15364](https://github.com/hashgraph/hedera-services/pull/15364)
* chore: use correct Nullable annotation in 'smart-contract-service-impl' by [@jjohannes](https://github.com/jjohannes) in [#15373](https://github.com/hashgraph/hedera-services/pull/15373)
* feat: add PBJ support to platform streams by [@lpetrovic05](https://github.com/lpetrovic05) in [#15400](https://github.com/hashgraph/hedera-services/pull/15400)
* chore: Use GossipEvent in PlatformEvent by [@timo0](https://github.com/timo0) in [#15207](https://github.com/hashgraph/hedera-services/pull/15207)
* build: avoid mergeJar / Protobuf gRPC update by [@jjohannes](https://github.com/jjohannes) in [#15374](https://github.com/hashgraph/hedera-services/pull/15374)
* chore: improve `noStakingInteractionsForExtendedPeriodIsFine()` spec by [@tinker-michaelj](https://github.com/tinker-michaelj) in [#15388](https://github.com/hashgraph/hedera-services/pull/15388)
* chore: 15405 move tss to hedera cryptography by [@mxtartaglia-sl](https://github.com/mxtartaglia-sl) in [#15406](https://github.com/hashgraph/hedera-services/pull/15406)
* docs: 15091: Design proposal: migrate Queue states from FCQueue to VirtualMap by [@artemananiev](https://github.com/artemananiev) in [#15165](https://github.com/hashgraph/hedera-services/pull/15165)
* chore: add `StateHashedNotification` by [@tinker-michaelj](https://github.com/tinker-michaelj) in [#15395](https://github.com/hashgraph/hedera-services/pull/15395)
* chore: remove hapiProtoVersion by [@jjohannes](https://github.com/jjohannes) in [#15399](https://github.com/hashgraph/hedera-services/pull/15399)
* chore: implement and test indirect block proofs by [@tinker-michaelj](https://github.com/tinker-michaelj) in [#15387](https://github.com/hashgraph/hedera-services/pull/15387)
* fix: set active `ExchangeRateSet` on triggered txn receipts by [@tinker-michaelj](https://github.com/tinker-michaelj) in [#15396](https://github.com/hashgraph/hedera-services/pull/15396)
* chore: fix/disable hammer tests that are not working by [@jjohannes](https://github.com/jjohannes) in [#15370](https://github.com/hashgraph/hedera-services/pull/15370)
* chore: default `TransactionExecutor` simulator to no-op system contract authorization checks by [@tinker-michaelj](https://github.com/tinker-michaelj) in [#15392](https://github.com/hashgraph/hedera-services/pull/15392)
* fix: 15385 Used `MerkleStateRoot.getReadablePlatformState` where possible to prevent race conditions by [@imalygin](https://github.com/imalygin) in [#15389](https://github.com/hashgraph/hedera-services/pull/15389)
* fix: permit 100:1 deflation for upgrade ZIP files by [@tinker-michaelj](https://github.com/tinker-michaelj) in [#15422](https://github.com/hashgraph/hedera-services/pull/15422)
* feat: BlockStreams-Inversion of control by [@Neeharika-Sompalli](https://github.com/Neeharika-Sompalli) in [#15325](https://github.com/hashgraph/hedera-services/pull/15325)
* fix: Check for usability in various ops by [@mhess-swl](https://github.com/mhess-swl) in [#15390](https://github.com/hashgraph/hedera-services/pull/15390)
* chore: Remove PeerInfo.nodeName by [@anthony-swirldslabs](https://github.com/anthony-swirldslabs) in [#15441](https://github.com/hashgraph/hedera-services/pull/15441)
* refactor: remove AbortException by [@lukelee-sl](https://github.com/lukelee-sl) in [#15004](https://github.com/hashgraph/hedera-services/pull/15004)
* feat: metadata view functions via smart contracts by [@mustafauzunn](https://github.com/mustafauzunn) in [#15019](https://github.com/hashgraph/hedera-services/pull/15019)
* fix: freeze time reset check by [@tinker-michaelj](https://github.com/tinker-michaelj) in [#15429](https://github.com/hashgraph/hedera-services/pull/15429)
* chore: correct the variable name in roster.proto by [@edward-swirldslabs](https://github.com/edward-swirldslabs) in [#15465](https://github.com/hashgraph/hedera-services/pull/15465)
* fix: Precision loss for gas calculation of HTS system contracts v2 by [@stoyanov-st](https://github.com/stoyanov-st) in [#15446](https://github.com/hashgraph/hedera-services/pull/15446)
* feat: introduce PbjRecordHasher and RosterUtils.hash(Roster) by [@anthony-swirldslabs](https://github.com/anthony-swirldslabs) in [#15457](https://github.com/hashgraph/hedera-services/pull/15457)
* feat: Add TokenUpdateNFTs as a smart contract operation v2 by [@stoyanov-st](https://github.com/stoyanov-st) in [#15445](https://github.com/hashgraph/hedera-services/pull/15445)
* chore: remove snapshot ops by [@tinker-michaelj](https://github.com/tinker-michaelj) in [#15462](https://github.com/hashgraph/hedera-services/pull/15462)
* fix: 15167: Remove timeout from reconnect/rehash Iterators by [@artemananiev](https://github.com/artemananiev) in [#15468](https://github.com/hashgraph/hedera-services/pull/15468)
* chore: testnet event hashing by [@lpetrovic05](https://github.com/lpetrovic05) in [#15432](https://github.com/hashgraph/hedera-services/pull/15432)
* docs: Proposal Process Update - Specify post-acceptance non-material update procedure by [@poulok](https://github.com/poulok) in [#15447](https://github.com/hashgraph/hedera-services/pull/15447)
* fix: recreate block hash from state by [@tinker-michaelj](https://github.com/tinker-michaelj) in [#15444](https://github.com/hashgraph/hedera-services/pull/15444)
* test: fix CryptographyTests by [@OlegMazurov](https://github.com/OlegMazurov) in [#15529](https://github.com/hashgraph/hedera-services/pull/15529)
* build: cleanup settings.gradle.kts / remove build.gradle.kts by [@jjohannes](https://github.com/jjohannes) in [#15470](https://github.com/hashgraph/hedera-services/pull/15470)
* fix: 15438: Eliminate busy loop in HalfDiskHashMap.endWriting() by [@artemananiev](https://github.com/artemananiev) in [#15439](https://github.com/hashgraph/hedera-services/pull/15439)
* docs: tss block signing proposal by [@edward-swirldslabs](https://github.com/edward-swirldslabs) in [#15160](https://github.com/hashgraph/hedera-services/pull/15160)
* fix: 15494: Improve VirtualLeafRecord serialization to bytes during flushes by [@artemananiev](https://github.com/artemananiev) in [#15512](https://github.com/hashgraph/hedera-services/pull/15512)
* feat: migrate event serialization to protobuf by [@lpetrovic05](https://github.com/lpetrovic05) in [#15417](https://github.com/hashgraph/hedera-services/pull/15417)
* fix: Validate `CustomFees` input arrays in `UpdateTokenCustomFeesDecoder` by [@stoyanov-st](https://github.com/stoyanov-st) in [#15520](https://github.com/hashgraph/hedera-services/pull/15520)
* chore: Add missing javadocs in Consensus Service by [@petreze](https://github.com/petreze) in [#15299](https://github.com/hashgraph/hedera-services/pull/15299)
* chore: add `TracerBinding` interface for `TransactionExecutors`. by [@tinker-michaelj](https://github.com/tinker-michaelj) in [#15480](https://github.com/hashgraph/hedera-services/pull/15480)
* test: unit test verifySyncInvalidEd25519() is not stable by [@OlegMazurov](https://github.com/OlegMazurov) in [#15534](https://github.com/hashgraph/hedera-services/pull/15534)
* test: New HAPI test for TokenAirdrop transaction by [@Evdokia-Georgieva](https://github.com/Evdokia-Georgieva) in [#15348](https://github.com/hashgraph/hedera-services/pull/15348)
* fix: remove dependencies to 'org.testcontainers' in production code by [@jjohannes](https://github.com/jjohannes) in [#15473](https://github.com/hashgraph/hedera-services/pull/15473)
* chore: use 4.28.2 for `com.google.protobuf` artifacts by [@tinker-michaelj](https://github.com/tinker-michaelj) in [#15564](https://github.com/hashgraph/hedera-services/pull/15564)
* refactor: 15413 Split `PlatformStateAccessor` into two interfaces by [@imalygin](https://github.com/imalygin) in [#15544](https://github.com/hashgraph/hedera-services/pull/15544)
* feat: decouple event constraints from deserialization by [@lpetrovic05](https://github.com/lpetrovic05) in [#15519](https://github.com/hashgraph/hedera-services/pull/15519)
* feat: add file 101 update during the first transaction after a freeze upgrade by [@iwsimon](https://github.com/iwsimon) in [#15563](https://github.com/hashgraph/hedera-services/pull/15563)
* docs: Update Tss-Library proposal by [@mxtartaglia-sl](https://github.com/mxtartaglia-sl) in [#15170](https://github.com/hashgraph/hedera-services/pull/15170)
* chore: reduce `EthereumTransaction` relayer fees by [@tinker-michaelj](https://github.com/tinker-michaelj) in [#15577](https://github.com/hashgraph/hedera-services/pull/15577)
* chore: Remove `ImmutableHash` by [@timo0](https://github.com/timo0) in [#15556](https://github.com/hashgraph/hedera-services/pull/15556)
* feat: create release branch 0.55 by [@povolev15](https://github.com/povolev15) in [#15609](https://github.com/hashgraph/hedera-services/pull/15609)
* test: (cherry-pick) Added a test to submit DAB transactions for JRS test ([#15549](https://github.com/hashgraph/hedera-services/pull/15549)) by [@Neeharika-Sompalli](https://github.com/Neeharika-Sompalli) in [#15616](https://github.com/hashgraph/hedera-services/pull/15616)
* ci: cherry pick changes to HAPI version checks into release 0.55 by [@rbarkerSL](https://github.com/rbarkerSL) in [#15771](https://github.com/hashgraph/hedera-services/pull/15771)
* feat: cherry pick smart contract module 051 activation by [@david-bakin-sl](https://github.com/david-bakin-sl) in [#15776](https://github.com/hashgraph/hedera-services/pull/15776)
* chore: (Cherry Pick) Standardize previewnet config dir with other envs by [@mhess-swl](https://github.com/mhess-swl) in [#15779](https://github.com/hashgraph/hedera-services/pull/15779)
* fix: Cherry-Pick: Handle non-existent token IDs in token fee schedule updates by [@mhess-swl](https://github.com/mhess-swl) in [#15832](https://github.com/hashgraph/hedera-services/pull/15832)
* fix: Cherry-Pick: Add query handling metrics upload by [@mhess-swl](https://github.com/mhess-swl) in [#15901](https://github.com/hashgraph/hedera-services/pull/15901)
* fix: Cherry-Pick (0.55): Airdrop transfer list size validation by [@mhess-swl](https://github.com/mhess-swl) in [#15936](https://github.com/hashgraph/hedera-services/pull/15936)
* chore: disable dab in 0.55 by [@iwsimon](https://github.com/iwsimon) in [#15951](https://github.com/hashgraph/hedera-services/pull/15951)
* fix: (0.55) post-upgrade txn detection in presence of pre-upgrade events by [@tinker-michaelj](https://github.com/tinker-michaelj) in [#15835](https://github.com/hashgraph/hedera-services/pull/15835)

#### New Contributors

* [@tungbq](https://github.com/tungbq) made their first contribution in [#14264](https://github.com/hashgraph/hedera-services/pull/14264)

**Full Changelog**: [v0.54.2...v0.55.0](https://github.com/hashgraph/hedera-services/compare/v0.54.2...v0.55.0)

</details>

### **Performance Results**

<figure><img src="../../.gitbook/assets/‎0.55_Performance Measurement Results_Extract.‎001.png" alt=""><figcaption></figcaption></figure>

## **R**elease v0.54

{% hint style="success" %}
**MAINNET UPDATE SCHEDULED: OCTOBER 23, 2024**
{% endhint %}

{% hint style="success" %}
**TESTNET UPDATE SCHEDULED: OCTOBER 16, 2024**
{% endhint %}

### Release Highlights

This release introduces exciting new features and improvements, including HIP-904 for token airdrops, and HIP-1010 for updating custom fee via smart contracts.

#### **HIPs**

[**HIP-904**](https://hips.hedera.com/hip/hip-904)**: Token Airdrops and Claims**

Implementation: Partial implementation

Delivered in this release:

* TokenAirdrop transaction is similar to crypto transfers, but differs in one fundamental way - when an airdrop is performed and the receiver does not have available or automatic association slots, rather than failing, the transfer will be kept in state as a pending transfer.
* TokenClaimAirdrop transaction introduced for recipients to claim pending airdropped tokens.
* TokenCancelAirdrop transaction introduced giving senders the ability to cancel unclaimed airdrops.

**Benefits**:

* Streamlines token distribution, empowers token creators, developers, and projects by allowing them to distribute tokens more efficiently to a wider audience.\\

[**HIP-1010**](https://hips.hedera.com/hip/hip-1010)**: Update Token Custom Fee Schedules via Smart Contracts**

Implementation: Full implementation

Delivered in this release:

* updateFungibleTokenCustomFees system contract function for updating custom fees for fungible tokens.
* updateNonFungibleTokenCustomFees system contract function for updating custom fees for non-fungible tokens.

**Benefits:**

* Enables smart contracts to manage token custom fees, providing more dynamic and autonomous token management capabilities.

### [Build 0.54.2](https://github.com/hashgraph/hedera-services/releases/tag/v0.54.2)

<details>

<summary><strong>What's Changed</strong></summary>

* fix: Cherry-Pick (0.54): Airdrop transfer list size validation by [@mhess-swl](https://github.com/mhess-swl) in [#15937](https://github.com/hashgraph/hedera-services/pull/15937)

**Full Changelog**: [v0.54.1...v0.54.2](https://github.com/hashgraph/hedera-services/compare/v0.54.1...v0.54.2)

</details>

### [Build 0.54.1](https://github.com/hashgraph/hedera-services/releases/tag/v0.54.1)

{% hint style="success" %}
**TESTNET UPDATE SCHEDULED: OCTOBER 2, 2024**
{% endhint %}

<details>

<summary><strong>What's Changed</strong></summary>

* fix: cherry-pick: remove dependencies to 'org.testcontainers' in production code by [@iwsimon](https://github.com/iwsimon) in [#15559](https://github.com/hashgraph/hedera-services/pull/15559)
* chore: reducer EthTx relayer fees by [@tinker-michaelj](https://github.com/tinker-michaelj) in [#15580](https://github.com/hashgraph/hedera-services/pull/15580)

**Full Changelog**: [v0.54.0...v0.54.1](https://github.com/hashgraph/hedera-services/compare/v0.54.0...v0.54.1)

</details>

### [Build 0.54.0](https://github.com/hashgraph/hedera-services/releases/tag/v0.54.0)

<details>

<summary><strong>What's Changed</strong></summary>

* feat: Enable health monitor by [@litt3](https://github.com/litt3) in [#14392](https://github.com/hashgraph/hedera-services/pull/14392)
* chore: rename detailed consensus event by [@lpetrovic05](https://github.com/lpetrovic05) in [#14364](https://github.com/hashgraph/hedera-services/pull/14364)
* refactor: Use PBJ EventDescriptor by [@timo0](https://github.com/timo0) in [#14432](https://github.com/hashgraph/hedera-services/pull/14432)
* fix: split new Reconnect metrics by NodeId in Grafana by [@anthony-swirldslabs](https://github.com/anthony-swirldslabs) in [#14430](https://github.com/hashgraph/hedera-services/pull/14430)
* perf: VirtualHasher.hash() keeps too many tasks in memory by [@OlegMazurov](https://github.com/OlegMazurov) in [#14470](https://github.com/hashgraph/hedera-services/pull/14470)
* feat: refactor CryptoTransferHandler by [@JivkoKelchev](https://github.com/JivkoKelchev) in [#14278](https://github.com/hashgraph/hedera-services/pull/14278)
* feat: improve hashing performance by [@lpetrovic05](https://github.com/lpetrovic05) in [#14444](https://github.com/hashgraph/hedera-services/pull/14444)
* test: add test for validating numeric values for HAS and ExchangeRate functions by [@stoyanov-st](https://github.com/stoyanov-st) in [#14424](https://github.com/hashgraph/hedera-services/pull/14424)
* ci: Add registry mirrors to daemon-config on crazy-max/ghaction-setup-docker by [@rbarkerSL](https://github.com/rbarkerSL) in [#14469](https://github.com/hashgraph/hedera-services/pull/14469)
* docs: Update glossary defns of aliases, triplets by [@david-bakin-sl](https://github.com/david-bakin-sl) in [#14372](https://github.com/hashgraph/hedera-services/pull/14372)

**➡ See the full list of changes** [**here**](https://github.com/hashgraph/hedera-services/releases/tag/v0.54.0)**.**

</details>

### **Performance Results**

<figure><img src="../../.gitbook/assets/‎0.54_Performance Measurement Results_Extract.‎001.png" alt=""><figcaption></figcaption></figure>

## Release v0.53

{% hint style="success" %}
**MAINNET UPDATE SCHEDULED: SEPTEMBER 11, 2024**
{% endhint %}

{% hint style="success" %}
**TESTNET UPDATE SCHEDULED: SEPTEMBER 4, 2024**
{% endhint %}

<details>

<summary><strong>Binaries (</strong><a href="https://builds.hedera.com/"><strong>builds.hedera.com</strong></a><strong>)</strong> </summary>

Build version.0 - [zip](http://builds.hedera.com/node/software/v0.53/build-v0.53.0.zip) [sha384](http://builds.hedera.com/node/software/v0.53/build-v0.53.0.sha384)

Build version.1 - [zip](http://builds.hedera.com/node/software/v0.53/build-v0.53.1.zip) [sha384](http://builds.hedera.com/node/software/v0.53/build-v0.53.1.sha384)

Build version.2 - [zip](http://builds.hedera.com/node/software/v0.53/build-v0.53.2.zip) [sha384](http://builds.hedera.com/node/software/v0.53/build-v0.53.2.sha384)

Build version.3 - [zip](http://builds.hedera.com/node/software/v0.53/build-v0.53.3.zip) [sha384](http://builds.hedera.com/node/software/v0.53/build-v0.53.3.sha384)

Build version.4 - [zip](http://builds.hedera.com/node/software/v0.53/build-v0.53.4.zip) [sha384](http://builds.hedera.com/node/software/v0.53/build-v0.53.4.sha384)

Build version.5 - [zip](http://builds.hedera.com/node/software/v0.53/build-v0.53.5.zip) [sha384\
](http://builds.hedera.com/node/software/v0.53/build-v0.53.5.sha384)

</details>

### Release Highlights

#### [HIP-719](https://hips.hedera.com/hip/hip-719): Associate and Dissociate Tokens via Facade Contract

#### **Functionality**

Delivered in release 0.53

* `isAssociated` for token association via proxy facade contract.
  * Syntax
    * `<tokenAddress>.isAssociated()`
  * Example
    * IHRC719(\<tokenAddress>).isAssociated()

Delivered in prior release(0.38)

* Associate and Dissociate Tokens via proxy facade contract

**Benefits**

* Enables developers to call functions in a way familiar to [ERC-20](https://ethereum.org/en/developers/docs/standards/tokens/erc-20/) and [ERC-721](https://ethereum.org/en/developers/docs/standards/tokens/erc-721/).
* Token functions are callable by both EOAs and contracts.

#### [**HIP-904**](https://hips.hedera.com/hip/hip-904)**:** tokenReject, account infinite maxAutoAssociation & Sender pays auto association

#### **Functionality**

Partial completion of HIP-904 Delivered in 0.53

* Sender pays for association
  * Sender now pays for token association at the time of HTS transaction execution.
* Max\_auto\_associations
  * Default value for `max_auto_assocations` will now be `-1` meaning that if an account is created automatically by performing a token transfer to an alias that does not yet exist the account is configured with unlimited automatic token association.
  * HAPI:CryptoCreate will continue to have `max_auto_associations` defaulting to `0`.
  * Accounts created before the launch of this feature will remain unchanged.
* Token reject
  * Introduces _TokenReject_ Transaction.

#### Benefits

* `maxAutoAssociation` users can update their account preferences to unlimited association giving the ability to receive any airdrops without explicitly having to associate with that token.
* Slots are only paid for when used, and are initially paid for by the sender during automatic associations.

#### [HIP-850](https://hips.hedera.com/hip/hip-850): HTS Mutable metadata in treasury

#### Functionality

* Entire scope of HIP-850 delivered in release 0.53.
* Enables the Supply Key to update an NFT metadata field while the NFT is held in the treasury account via _TokenUpdateNftsTransaction_ function for a specific NFT serial number.

#### Benefits

* NFT owners can return an NFT to treasury custody in order to update parameters within the metadata of the NFT.
* NFT cannot be updated by unauthorized parties once distributed.

#### [HIP-993](https://hips.hedera.com/hip/hip-993): Improve record stream legibility and extensibility

#### Functionality

Delivered in release .53:

* Itemized auto-creation fees
* Unified child consensus times
* Clean hollow account completion records
* Synthetic file creations at genesis
* Use natural order for preceding dispatch records

Planned for delivery in release .54:

* Fail fast on throttled child transactions

#### Benefits

* This HIP refines the legibility and extensibility of the record stream.

### [Build 0.53.5](https://github.com/hashgraph/hedera-services/releases/tag/v0.53.5)

#### What's Changed

* feat: add enableDAB flag to enable and disable DAB features by [@iwsimon](https://github.com/iwsimon) in [#15232](https://github.com/hashgraph/hedera-services/pull/15232)
* ci: resolves release issue preventing the publication of the docker images by [@nathanklick](https://github.com/nathanklick) in [#15158](https://github.com/hashgraph/hedera-services/pull/15158)
* fix: hedera-evm and hedera-evm-impl are overwriting each other in MC by [@rbarkerSL](https://github.com/rbarkerSL) in [#15175](https://github.com/hashgraph/hedera-services/pull/15175)

### [Build 0.53.1](https://github.com/hashgraph/hedera-services/releases/tag/v0.53.1)

#### What's changed

* fix: change order of descriptor variables by [@lpetrovic05](https://github.com/lpetrovic05) in [#15016](https://github.com/hashgraph/hedera-services/pull/15016)

### [Build 0.53.0](https://github.com/hashgraph/hedera-services/releases/tag/v0.53.0)

<details>

<summary><strong>What's Changed</strong></summary>

* docs: 13690 Added a design doc for `Ledger State API` by [@imalygin](https://github.com/imalygin) in [#13730](https://github.com/hashgraph/hedera-services/pull/13730)
* chore: update Gradle to 8.8 / setup-gradle to v3.4.2 by [@jjohannes](https://github.com/jjohannes) in [#13757](https://github.com/hashgraph/hedera-services/pull/13757)
* chore: Cleanup obsolete `test-clients` code and resources by [@tinker-michaelj](https://github.com/tinker-michaelj) in [#14050](https://github.com/hashgraph/hedera-services/pull/14050)
* docs: update token reject design doc by [@MiroslavGatsanoga](https://github.com/MiroslavGatsanoga) in [#14061](https://github.com/hashgraph/hedera-services/pull/14061)
* fix: passing upgrade `@HapiTest` by [@tinker-michaelj](https://github.com/tinker-michaelj) in [#13992](https://github.com/hashgraph/hedera-services/pull/13992)
* feat: Ensure overwritten operations check for sufficient gas first by [@lukelee-sl](https://github.com/lukelee-sl) in [#11441](https://github.com/hashgraph/hedera-services/pull/11441)
* test: HIP-904 Create HAPI tests for a hollow account on an alias on which we have a deleted account by [@zhpetkov](https://github.com/zhpetkov) in [#14036](https://github.com/hashgraph/hedera-services/pull/14036)
* feat: HIP-904 Charge automatic associations during `CryptoTransfer` by [@Neeharika-Sompalli](https://github.com/Neeharika-Sompalli) in [#14107](https://github.com/hashgraph/hedera-services/pull/14107)
* chore: inline pces proposal 2.0 by [@cody-littley](https://github.com/cody-littley) in [#14056](https://github.com/hashgraph/hedera-services/pull/14056)
* feat: implement HIP-632 `isAuthorizedRaw` method by [@david-bakin-sl](https://github.com/david-bakin-sl) in [#14130](https://github.com/hashgraph/hedera-services/pull/14130)

**➡ See the full list of changes** [**here**](https://github.com/hashgraph/hedera-services/releases/tag/v0.53.0)**.**

</details>

### **Performance Results**

<figure><img src="../../.gitbook/assets/‎0.53_Performance Measurement Results_Extract.‎001.png" alt=""><figcaption></figcaption></figure>

## Release v0.52

### Release Highlights

#### [**HIP-632**](https://hips.hedera.com/hip/hip-632) **- isAuthorizedRaw**

#### **Functionality**

* Accepts three parameters:
  * `address`
  * `messageHash`
  * `signatureBlob`
* Validates the provided address (Hedera Account ID or virtual address)
* Determines signature type based on `signatureBlob` length:
  * 65 bytes: ECDSA
  * 64 bytes: ED25519

#### ECDSA Signature Handling

* Extracts `v`, `r`, and `s` components
* Runs ECRECOVER to recover signing address
* Compares result with the account's virtual addresses

#### ED25519 Signature Handling

* Retrieves Hedera address
* Checks for single associated key on account
* Verifies signature against message hash and account key

#### Benefits

* Similar functionality to Ethereum's ECRECOVER precompile
* Supports both ECDSA and ED25519 signature verification
* Works with Hedera Account IDs and virtual addresses
* Simplifies signature verification in smart contracts
* Streamlines transaction authentication within contracts
* Enhances Hedera-Ethereum authorization flow compatibility
* Improves developer experience with familiar authorization mechanism

#### [HIP 904](https://hips.hedera.com/hip/hip-904)

#### TokenRect Functionality

* Allows users to reject undesired tokens
* Transfers thefull balance of one or more tokens from the requesting account to the treasury
* Supports rejection of both fungible and non-fungible tokens
* Handles up to 10 token rejections in a single transaction
* Bypasses custom fees and royalties defined for the rejected tokens

#### Benefits of TokenReject

* Enables users to remove unwanted tokens from their accounts
* Protects users from potential scams or unwanted airdrops
* Allows rejection of tokens regardless of how they were acquired (manual or automatic association)
* Helps users manage their token holdings more effectively
* Prevents users from being forced to pay exorbitant or potentially malicious fees to remove tokens
* Maintains account association with the token, allowing for future transactions if desired
* Provides a simple mechanism for users to clean up their accounts
* Enhances user control over their token portfolio
* Improves overall user experience in token management

### [Build 0.52.3](https://github.com/hashgraph/hedera-services/releases/tag/v0.52.3)

{% hint style="success" %}
**MAINNET UPDATE SCHEDULED: AUGUST 28, 2024**
{% endhint %}

#### What's Changed

* fix: invalid `feeSchedules.json` by [@Neeharika-Sompalli](https://github.com/Neeharika-Sompalli) in [#14881](https://github.com/hashgraph/hedera-services/pull/14881)

### [Build 0.52.2](https://github.com/hashgraph/hedera-services/releases/tag/v0.52.2)

{% hint style="success" %}
**TESTNET UPDATE SCHEDULED: AUGUST 14, 2024**
{% endhint %}

#### What's Changed

* chore(0.52): updates the buildkit and docker daemon configuration to use the registry mirror by [@nathanklick](https://github.com/nathanklick) in [#14777](https://github.com/hashgraph/hedera-services/pull/14777)
* fix: immediately finalize transfer lists for scheduled crypto transfer by [@tinker-michaelj](https://github.com/tinker-michaelj) in [#14799](https://github.com/hashgraph/hedera-services/pull/14799)

### [Build 0.52.1](https://github.com/hashgraph/hedera-services/releases/tag/v0.52.1)

#### What's Changed

* ci: fix gradle publish failures in release-0.52 for hedera.com.evm by [@rbarkerSL](https://github.com/rbarkerSL) in [#14513](https://github.com/hashgraph/hedera-services/pull/14513)
* fix: 14489 cherry pick docker rate limit fix in release052 by [@rbarkerSL](https://github.com/rbarkerSL) in [#14490](https://github.com/hashgraph/hedera-services/pull/14490)
* fix(bug): Removed daemon config changes ([#14599](https://github.com/hashgraph/hedera-services/pull/14599)) by [@rbarkerSL](https://github.com/rbarkerSL) in [#14602](https://github.com/hashgraph/hedera-services/pull/14602)
* fix: cherry pick misc fixes by [@tinker-michaelj](https://github.com/tinker-michaelj) in [#14609](https://github.com/hashgraph/hedera-services/pull/14609)

### [Build 0.52.0](https://github.com/hashgraph/hedera-services/releases/tag/v0.52.0)

{% hint style="success" %}
**TESTNET UPDATE SCHEDULED: JULY 31, 2024**
{% endhint %}

#### What's Changed

* The `accounts.maxNumber` and `nfts.MaxAllowedMints` values both remain at 20 million for this release
* feat: extract `HederaNetwork` interface with initial `SubProcessNetwork` impl by [@tinker-michaelj](https://github.com/tinker-michaelj) in [#13540](https://github.com/hashgraph/hedera-services/pull/13540)
* build: make annotation library dependencies transitive by [@jjohannes](https://github.com/jjohannes) in [#13643](https://github.com/hashgraph/hedera-services/pull/13643)
* chore: Address compiler warnings in LoggerApiSpecAssertions by [@jjohannes](https://github.com/jjohannes) in [#13644](https://github.com/hashgraph/hedera-services/pull/13644)
* chore: disabled new backpressure via settings by [@cody-littley](https://github.com/cody-littley) in [#13635](https://github.com/hashgraph/hedera-services/pull/13635)
* chore: Add `FakePlatform` and `FakeServicesRegistry` by [@Neeharika-Sompalli](https://github.com/Neeharika-Sompalli) in [#13549](https://github.com/hashgraph/hedera-services/pull/13549)
* docs: File Service design doc by [@derektriley](https://github.com/derektriley) in [#13615](https://github.com/hashgraph/hedera-services/pull/13615)
* build: (de)activate selection of javac lint features by [@jjohannes](https://github.com/jjohannes) in [#11838](https://github.com/hashgraph/hedera-services/pull/11838)
* fix(reconnect): use AtomicLong for anticipatedMessages counter by [@anthony-swirldslabs](https://github.com/anthony-swirldslabs) in [#13650](https://github.com/hashgraph/hedera-services/pull/13650)
* feat: Move to fully connected network by [@kfa-aguda](https://github.com/kfa-aguda) in [#13010](https://github.com/hashgraph/hedera-services/pull/13010)
* docs: add design document for HIP-904 token cancel airdrop transaction by [@MiroslavGatsanoga](https://github.com/MiroslavGatsanoga) in [#12787](https://github.com/hashgraph/hedera-services/pull/12787)

**➡ See the full list of changes** [**here**](https://github.com/hashgraph/hedera-services/releases/tag/v0.52.0)**.**

### **Performance Results**

<figure><img src="../../.gitbook/assets/‎0.52_Performance Measurement Results_Extract.‎001.png" alt=""><figcaption></figcaption></figure>

## [v0.51](https://github.com/hashgraph/hedera-services/releases/tag/v0.51.5)

{% hint style="success" %}
**MAINNET UPDATE: JULY 17, 2024**
{% endhint %}

{% hint style="success" %}
**TESTNET UPDATE: JULY 2, 2024**
{% endhint %}

### Release Highlights

#### [HIP 206](https://hips.hedera.com/hip/hip-206)

**Functionality**

* Defines a new function to the Hedera Token Service system contract that allows for the atomic transfer of HBAR, fungible tokens and non-fungible tokens.
  * Function cryptoTransfer(TransferList transferList,TokenTransferList\[] tokenTransfer)
* Exposes an existing HAPI call via smart contracts.
* Transfer respects granted allowances.

**Benefits**

* Enables native royalty support on the EVM since native $hbar can now be transferred using spending allowances
* Direct interaction with HBAR and HTS tokens
* Eliminates the need for token wrapping.
* Enhances efficiency and reduces complexity.
* Cuts costs by removing intermediary steps i.e., wrapping assets to interact with them.
* Enables native royalty support on the EVM since native HBAR can now be transferred using spending allowances

#### [HIP 906](https://hips.hedera.com/hip/hip-906)

**Functionality**

* Introduces a new Hedera Account Service system contract.
* Enables querying and granting approval of HBAR to a spender account from smart contracts code
  * hbarAllowance, hbarApprove
* Developers do not have to context switch out of smart contract code

**Benefits**

* Introduces new account proxy contract for HBAR allowances
* Enables grant, retrieve, and manage HBAR allowances within smart contracts
  * Developers do not have to context switch out of smart contracts code
* Simplifies workflows and enhances security
* Expands potential use cases, especially for DeFi and token marketplaces

### [0.51.5](https://github.com/hashgraph/hedera-services/releases/tag/v0.51.5)

#### What's Changed

* feat(reconnect): introduce ReconnectMapStats interface by [@anthony-swirldslabs](https://github.com/anthony-swirldslabs) in [#13027](https://github.com/hashgraph/hedera-services/pull/13027)
* chore: revert removal of CLI report tool by [@lpetrovic05](https://github.com/lpetrovic05) in [#13002](https://github.com/hashgraph/hedera-services/pull/13002)
* docs: add design document for HIP-904 token reject operation by [@MiroslavGatsanoga](https://github.com/MiroslavGatsanoga) in [#12786](https://github.com/hashgraph/hedera-services/pull/12786)
* feat: gossip facade by [@cody-littley](https://github.com/cody-littley) in [#12897](https://github.com/hashgraph/hedera-services/pull/12897)
* feat: add the ability to disable the running event hasher by [@cody-littley](https://github.com/cody-littley) in [#13083](https://github.com/hashgraph/hedera-services/pull/13083)
* fix: ignore token expiry status in `TokenDissociate` by [@tinker-michaelj](https://github.com/tinker-michaelj) in [#13104](https://github.com/hashgraph/hedera-services/pull/13104)
* feat: add javadoc and diagram, delete dead code by [@tinker-michaelj](https://github.com/tinker-michaelj) in [#13070](https://github.com/hashgraph/hedera-services/pull/13070)
* fix: use civilian payer for modified variants by [@tinker-michaelj](https://github.com/tinker-michaelj) in [#13020](https://github.com/hashgraph/hedera-services/pull/13020)
* fix: 12853: Memory leak from MerkleDbDataSource.copyStatisticsFrom() by [@artemananiev](https://github.com/artemananiev) in [#13097](https://github.com/hashgraph/hedera-services/pull/13097)
* feat: Updated hedera-services code to support DAB protobuf changes. by [@iwsimon](https://github.com/iwsimon) in [#13090](https://github.com/hashgraph/hedera-services/pull/13090)

**➡ See the full list of changes** [**here**](https://github.com/hashgraph/hedera-services/releases/tag/v0.51.5)**.**

### Performance Results

<figure><img src="../../.gitbook/assets/‎0.51_Performance Measurement Results_Extract.‎001.png" alt=""><figcaption></figcaption></figure>

## [v0.50](https://github.com/hashgraph/hedera-services/releases/tag/v0.50.0)

{% hint style="success" %}
**MAINNET UPDATE: JUNE 20, 2024**
{% endhint %}

{% hint style="success" %}
**TESTNET UPDATE: JUNE 5, 2024**
{% endhint %}

### [0.50.1](https://github.com/hashgraph/hedera-services/releases/tag/v0.50.1)

#### What's Changed

* chore: Cherry pick 13648 into release 0.50 branch by [@lukelee-sl](https://github.com/lukelee-sl) in [#13662](https://github.com/hashgraph/hedera-services/pull/13662)
* fix(ci): cherry pick milestone assignee checks rel 50 by [@rbarkerSL](https://github.com/rbarkerSL) in [#13712](https://github.com/hashgraph/hedera-services/pull/13712)
* fix: (cherry-pick) Use restart method to all token schemas by [@Neeharika-Sompalli](https://github.com/Neeharika-Sompalli) in [#13676](https://github.com/hashgraph/hedera-services/pull/13676)
* fix: Enable tokens.balancesInQueries.enabled by [@netopyr](https://github.com/netopyr) in [#13716](https://github.com/hashgraph/hedera-services/pull/13716)
* chore: Enable tokens.balancesInQueries in code by [@netopyr](https://github.com/netopyr) in [#13769](https://github.com/hashgraph/hedera-services/pull/13769)

**➡ See the full list of changes** [**here**](https://github.com/hashgraph/hedera-services/compare/v0.50.0...v0.50.1)**.**

### [0.50.0](https://github.com/hashgraph/hedera-services/releases/tag/v0.50.0)

#### What's Changed

* feat: reorganize ISS wiring by [@alittley](https://github.com/alittley) in [#11685](https://github.com/hashgraph/hedera-services/pull/11685)
* feat(diff-testing): Script (python) to pull intervals - up to a day - from GCP by [@david-bakin-sl](https://github.com/david-bakin-sl) in [#11409](https://github.com/hashgraph/hedera-services/pull/11409)
* fix: 11750 Fixed synchronization in `BreakableDataSource.saveRecords` by [@imalygin](https://github.com/imalygin) in [#11756](https://github.com/hashgraph/hedera-services/pull/11756)
* feat: Differential testing: Enhance account store dumper to handle modular representation by [@vtronkov](https://github.com/vtronkov) in [#11489](https://github.com/hashgraph/hedera-services/pull/11489)
* test: add security v2 model tests for token associate by [@anastasiya-kovaliova](https://github.com/anastasiya-kovaliova) in [#11327](https://github.com/hashgraph/hedera-services/pull/11327)
* fix: stop checking for minimum birth round by [@cody-littley](https://github.com/cody-littley) in [#11769](https://github.com/hashgraph/hedera-services/pull/11769)
* feat: make the state compatible with birth rounds by [@cody-littley](https://github.com/cody-littley) in [#11780](https://github.com/hashgraph/hedera-services/pull/11780)
* fix: FilteredLoggingMonitor by [@mxtartaglia-sl](https://github.com/mxtartaglia-sl) in [#11754](https://github.com/hashgraph/hedera-services/pull/11754)
* feat: diagram tweaks by [@cody-littley](https://github.com/cody-littley) in [#11801](https://github.com/hashgraph/hedera-services/pull/11801)
* fix: wait longer for freeze transaction to be handled by [@JeffreyDallas](https://github.com/JeffreyDallas) in [#11790](https://github.com/hashgraph/hedera-services/pull/11790)

**➡ See the full list of changes** [**here**](https://github.com/hashgraph/hedera-services/releases/tag/v0.50.0)**.**

### Performance Results

<figure><img src="../../.gitbook/assets/0.50_Performance Measurement Results_Extract.001.png" alt=""><figcaption></figcaption></figure>

## [v0.49](https://github.com/hashgraph/hedera-services/releases/tag/v0.49.0)

{% hint style="success" %}
**MAINNET UPDATE: MAY 22, 2024**
{% endhint %}

{% hint style="success" %}
**TESTNET UPDATE: MAY 14, 2024**
{% endhint %}

### [0.49.7](https://github.com/hashgraph/hedera-services/releases/tag/v0.49.7)

#### What's Changed

* fix: support crypto admin keys in system contract `tokenCreate()` by [@tinker-michaelj](https://github.com/tinker-michaelj) in [#13148](https://github.com/hashgraph/hedera-services/pull/13148)
* fix: remove balance adjustment limit from record in state, use `0` for initial gas snapshot by [@tinker-michaelj](https://github.com/tinker-michaelj) in [#13185](https://github.com/hashgraph/hedera-services/pull/13185)

### [0.49.6](https://github.com/hashgraph/hedera-services/releases/tag/v0.49.6)

#### What's Changed

* fix: cherry-pick midnight rate management on restart ([#13071](https://github.com/hashgraph/hedera-services/pull/13071)) by [@povolev15](https://github.com/povolev15) in [#13091](https://github.com/hashgraph/hedera-services/pull/13091)
* feat: auto-resubmit operations with modifications ([#12811](https://github.com/hashgraph/hedera-services/pull/12811)) by [@Neeharika-Sompalli](https://github.com/Neeharika-Sompalli) in [#13088](https://github.com/hashgraph/hedera-services/pull/13088)
* fix: ignore token expiry status in `TokenDissociate` by [@tinker-michaelj](https://github.com/tinker-michaelj) in [#13106](https://github.com/hashgraph/hedera-services/pull/13106)
* fix: avoid NPE when migrating from genesis (non-prod) state by [@tinker-michaelj](https://github.com/tinker-michaelj) in [#13123](https://github.com/hashgraph/hedera-services/pull/13123)

### [0.49.5](https://github.com/hashgraph/hedera-services/releases/tag/v0.49.5)

#### What's Changed

* fix: storage link management by [@tinker-michaelj](https://github.com/tinker-michaelj) in [#13056](https://github.com/hashgraph/hedera-services/pull/13056)

### [0.49.1](https://github.com/hashgraph/hedera-services/releases/tag/v0.49.1)

#### What's Changed

* fix: manage `StakingInfos` in restart by [@tinker-michaelj](https://github.com/tinker-michaelj) in [#12911](https://github.com/hashgraph/hedera-services/pull/12911)

### [0.49.0](https://github.com/hashgraph/hedera-services/releases/tag/v0.49.0)

#### What's changed

* feat: address cold read issue in ExtCodeHash operation by [@lukelee-sl](https://github.com/lukelee-sl) in [#11323](https://github.com/hashgraph/hedera-services/pull/11323)
* fix: 11348: The fix for 11231 doesn't cover ParsedBucket by [@artemananiev](https://github.com/artemananiev) in [#11349](https://github.com/hashgraph/hedera-services/pull/11349)
* chore: Create ISS detector component by [@lpetrovic05](https://github.com/lpetrovic05) in [#11075](https://github.com/hashgraph/hedera-services/pull/11075)
* chore: Add `orderedSolderTo` method to OutputWire by [@poulok](https://github.com/poulok) in [#11330](https://github.com/hashgraph/hedera-services/pull/11330)
* chore: remove hashgraph demo by [@lpetrovic05](https://github.com/lpetrovic05) in [#11352](https://github.com/hashgraph/hedera-services/pull/11352)

**➡ See the full list of changes** [**here**](https://github.com/hashgraph/hedera-services/releases/tag/v0.49.0)**.**

### **Performance Results**

<figure><img src="../../.gitbook/assets/0.49_Performance Measurement Results_Extract.001.png" alt=""><figcaption></figcaption></figure>

## [v0.48](https://github.com/hashgraph/hedera-services/releases/tag/v0.48.0)

{% hint style="success" %}
**MAINNET UPDATE: APRIL 25, 2024**
{% endhint %}

{% hint style="success" %}
**TESTNET UPDATE: APRIL 18, 2024**
{% endhint %}

### [0.48.1](https://github.com/hashgraph/hedera-services/releases/tag/v0.48.1)

#### What's Changed

* fix: remove adjustments limit by [@tinker-michaelj](https://github.com/tinker-michaelj) in [#12826](https://github.com/hashgraph/hedera-services/pull/12826)

### [0.48.0](https://github.com/hashgraph/hedera-services/releases/tag/v0.48.0)

{% hint style="success" %}
**TESTNET UPDATE: APRIL 11, 2024**
{% endhint %}

#### What's Changed

* feat: Check platform status before syncing ([#11429](https://github.com/hashgraph/hedera-services/pull/11429)) by [@alittley](https://github.com/alittley) in [#12679](https://github.com/hashgraph/hedera-services/pull/12679)

### Performance Results

<figure><img src="../../.gitbook/assets/0.48_Performance Measurement Results_Extract.001.png" alt=""><figcaption></figcaption></figure>

## [v0.47](https://github.com/hashgraph/hedera-services/releases/tag/v0.47.0)

{% hint style="success" %}
**MAINNET UPDATE: APRIL 4, 2024**
{% endhint %}

{% hint style="success" %}
**TESTNET UPDATE: MARCH 28, 2024**
{% endhint %}

### [0.47.4](https://github.com/hashgraph/hedera-services/releases/tag/v0.47.4)

#### What's Changed

* chore: cherry-pick unified CryptoCreate throttle reclamation ([#12339](https://github.com/hashgraph/hedera-services/pull/12339)).

### [0.47.3](https://github.com/hashgraph/hedera-services/releases/tag/v0.47.3)

{% hint style="success" %}
**TESTNET UPDATE: MARCH 20, 2024**
{% endhint %}

#### What's Changed

* chore: Configure `maxAggregateRels` to 15 million (all envs) ([#12053](https://github.com/hashgraph/hedera-services/pull/12053)).

### [0.47.2](https://github.com/hashgraph/hedera-services/releases/tag/v0.47.2)

#### What's Changed

* fix: Update Configuration `hashesRamToDiskThreshold` to 0 in `MerkleDbConfig`
* fix: Backport the fix for virtual map flushes.

### [0.47.1](https://github.com/hashgraph/hedera-services/releases/tag/v0.47.1)

{% hint style="success" %}
**TESTNET UPDATE: FEBRUARY 29, 2024**
{% endhint %}

#### What's Changed

* fix: only compare child time created against self-parent time created by [@alittley](https://github.com/alittley) in [#11673](https://github.com/hashgraph/hedera-services/pull/11673)
* chore: add an old-style queue thread for intake by [@cody-littley](https://github.com/cody-littley) in [#11671](https://github.com/hashgraph/hedera-services/pull/11671)
* fix: 11746: Backport the fix for [#11304](https://github.com/hashgraph/hedera-services/issues/11304) to release 0.47 by [@artemananiev](https://github.com/artemananiev) in [#11747](https://github.com/hashgraph/hedera-services/pull/11747)

### [0.47.0](https://github.com/hashgraph/hedera-services/releases/tag/v0.47.0)

#### What's Changed

* fix: bug when node is removed by [@cody-littley](https://github.com/cody-littley) in [#10687](https://github.com/hashgraph/hedera-services/pull/10687)
* fix: Fuzzy matching for CreateOperationSuite and Create2OperationSuite 09431 by [@JivkoKelchev](https://github.com/JivkoKelchev) in [#10185](https://github.com/hashgraph/hedera-services/pull/10185)
* fix: recordCache to commit added entries and implemented correctly the remove elements from the queue by [@povolev15](https://github.com/povolev15) in [#10523](https://github.com/hashgraph/hedera-services/pull/10523)
* fix: Fix and enable all Schedule HapiTests by [@povolev15](https://github.com/povolev15) in [#10551](https://github.com/hashgraph/hedera-services/pull/10551)
* fix: implement sidecars by [@JivkoKelchev](https://github.com/JivkoKelchev) in [#9815](https://github.com/hashgraph/hedera-services/pull/9815)
* feat: add setting for birth round ancient threshold by [@cody-littley](https://github.com/cody-littley) in [#10660](https://github.com/hashgraph/hedera-services/pull/10660)
* chore: drop chatter by [@cody-littley](https://github.com/cody-littley) in [#10670](https://github.com/hashgraph/hedera-services/pull/10670)
* chore: remove state info by [@cody-littley](https://github.com/cody-littley) in [#10685](https://github.com/hashgraph/hedera-services/pull/10685)
* chore: Rename contract causing services regression due to long name by [@stoqnkpL](https://github.com/stoqnkpL) in [#10700](https://github.com/hashgraph/hedera-services/pull/10700)
* fix: state leak by [@cody-littley](https://github.com/cody-littley) in [#10690](https://github.com/hashgraph/hedera-services/pull/10690)

**➡ See the full list of changes** [**here**](https://github.com/hashgraph/hedera-services/releases/tag/v0.47.0)**.**

### Performance Results

<figure><img src="../../.gitbook/assets/0.47_Performance Measurement Results_Extract.png" alt=""><figcaption></figcaption></figure>

## [v0.46](https://github.com/hashgraph/hedera-services/releases/tag/v0.46.0)

{% hint style="success" %}
**MAINNET UPDATE: FEBRUARY 21, 2024**
{% endhint %}

{% hint style="success" %}
**TESTNET UPDATE: FEBRUARY 6, 2024**
{% endhint %}

### [**0.46.3**](https://github.com/hashgraph/hedera-services/releases/tag/v0.46.3)

#### What's Changed

* chore: bump HAPI proto version by [@tinker-michaelj](https://github.com/tinker-michaelj) in [#11232](https://github.com/hashgraph/hedera-services/pull/11232)

### [**0.46.2**](https://github.com/hashgraph/hedera-services/releases/tag/v0.46.2)

{% hint style="success" %}
**TESTNET UPDATE: JANUARY 30, 2024**
{% endhint %}

#### What's Changed

* fix: Ensure that the pending creation customizer applies to the address being created by [@lukelee-sl](https://github.com/lukelee-sl) in [#11213](https://github.com/hashgraph/hedera-services/pull/11213)

### [**0.46.1**](https://github.com/hashgraph/hedera-services/releases/tag/v0.46.1)

#### What's Changed

* chore: bump HAPI proto version by [@tinker-michaelj](https://github.com/tinker-michaelj) in [#11232](https://github.com/hashgraph/hedera-services/pull/11232)

### [0.46.0](https://github.com/hashgraph/hedera-services/releases/tag/v0.46.0)

{% hint style="success" %}
**TESTNET UPDATE: JANUARY 23, 2024**
{% endhint %}

#### What's Changed

* feat: wiring diagram improvements by [@cody-littley](https://github.com/cody-littley) in [#10233](https://github.com/hashgraph/hedera-services/pull/10233)
* chore: Change `HashMap` to `LinkedHashMap` in custom fees assessment by [@Neeharika-Sompalli](https://github.com/Neeharika-Sompalli) in [#10240](https://github.com/hashgraph/hedera-services/pull/10240)
* feat: add implementation in throttling facility to handle N-Of-Unscaled type of throttling by [@MiroslavGatsanoga](https://github.com/MiroslavGatsanoga) in [#10142](https://github.com/hashgraph/hedera-services/pull/10142)
* build: do not publish test fixtures by [@jjohannes](https://github.com/jjohannes) in [#10147](https://github.com/hashgraph/hedera-services/pull/10147)
* build: patch everything we use to be a real Java Module by [@jjohannes](https://github.com/jjohannes) in [#10056](https://github.com/hashgraph/hedera-services/pull/10056)
* chore!: More common tests moved to correct module by [@hendrikebbers](https://github.com/hendrikebbers) in [#10133](https://github.com/hashgraph/hedera-services/pull/10133)
* feat: Config constants created & used by [@hendrikebbers](https://github.com/hendrikebbers) in [#10117](https://github.com/hashgraph/hedera-services/pull/10117)
* feat: script for cleaning build files by [@cody-littley](https://github.com/cody-littley) in [#10190](https://github.com/hashgraph/hedera-services/pull/10190)
* fix: Compact last PCES file at boot time by [@cody-littley](https://github.com/cody-littley) in [#10257](https://github.com/hashgraph/hedera-services/pull/10257)
* feat: sync++- by [@cody-littley](https://github.com/cody-littley) in [#10260](https://github.com/hashgraph/hedera-services/pull/10260)

**➡ See the full list of changes** [**here**](https://github.com/hashgraph/hedera-services/releases/tag/v0.46.0)**.**

### Performance Results

<figure><img src="../../.gitbook/assets/0.46_Performance Measurement Results.001.png" alt=""><figcaption></figcaption></figure>

## [v0.45](https://github.com/hashgraph/hedera-services/releases/tag/v0.45.0)

{% hint style="success" %}
**MAINNET UPDATE: JANUARY 9, 2024**
{% endhint %}

{% hint style="success" %}
**TESTNET UPDATE: DECEMBER 28, 2023**
{% endhint %}

### [0.45.2](https://github.com/hashgraph/hedera-services/releases/tag/v0.45.2)

#### What's Changed

* fix: Added a feature flag which is by default enabled to disable tokenBalances and tokenRelationships in `getAccountInfo`, `getAccountBalance` and `getContractInfo` queries. [#10639](https://github.com/hashgraph/hedera-services/pull/10639)

### [0.45.0](https://github.com/hashgraph/hedera-services/releases/tag/v0.45.0)

* Populate evm function result on failing eth transaction by [@stoqnkpL](https://github.com/stoqnkpL) in [#9453](https://github.com/hashgraph/hedera-services/pull/9453)
* Disable compression. by [@cody-littley](https://github.com/cody-littley) in [#9554](https://github.com/hashgraph/hedera-services/pull/9554)
* Fix tests in unique token management spec by [@mhess-swl](https://github.com/mhess-swl) in [#9537](https://github.com/hashgraph/hedera-services/pull/9537)
* enaled one more test and remove the other one that not really in use by [@povolev15](https://github.com/povolev15) in [#9557](https://github.com/hashgraph/hedera-services/pull/9557)
* Enable tests from CannotDeleteSystemEntitiesSuite by [@Ivo-Yankov](https://github.com/Ivo-Yankov) in [#9440](https://github.com/hashgraph/hedera-services/pull/9440)
* Fix tests in ContractBurnHTSSuite by [@agadzhalov](https://github.com/agadzhalov) in [#9572](https://github.com/hashgraph/hedera-services/pull/9572)
* Tune dependency scopes by [@jjohannes](https://github.com/jjohannes) in [#8455](https://github.com/hashgraph/hedera-services/pull/8455)
* unneeded calls to swirlds-common removed by [@hendrikebbers](https://github.com/hendrikebbers) in [#9003](https://github.com/hashgraph/hedera-services/pull/9003)
* Fixed CryptoRecordsSanityCheckSuite by [@iwsimon](https://github.com/iwsimon) in [#9551](https://github.com/hashgraph/hedera-services/pull/9551)
* Enable test from AssociatePrecompileSuite by [@mustafauzunn](https://github.com/mustafauzunn) in [#9571](https://github.com/hashgraph/hedera-services/pull/9571)

### Performance Results

<figure><img src="../../.gitbook/assets/0.45_Performance Measurement Results_Extract.png" alt=""><figcaption></figcaption></figure>

## [v0.44](https://github.com/hashgraph/hedera-services/releases/tag/v0.44.0)

{% hint style="success" %}
**MAINNET UPDATE: DECEMBER 19, 2023**
{% endhint %}

{% hint style="success" %}
**TESTNET UPDATE: DECEMBER 12, 2023**
{% endhint %}

### [0.44.3](https://github.com/hashgraph/hedera-services/releases/tag/v0.44.3)

#### What's Changed

* Enforce NFT allowance check on auto-creation by [@tinker-michaelj](https://github.com/tinker-michaelj) in [e69d0a9](https://github.com/hashgraph/hedera-services/commit/e69d0a917c1c0a9417a3f335129a74ac3004b7c9)

### [0.44.2](https://github.com/hashgraph/hedera-services/releases/tag/v0.44.2)

#### What's Changed

* Catch UncheckedIOException during PCES file copy. ([#10083](https://github.com/hashgraph/hedera-services/pull/10083)) by [@cody-littley](https://github.com/cody-littley) in [#10087](https://github.com/hashgraph/hedera-services/pull/10087)

### [0.44.1](https://github.com/hashgraph/hedera-services/releases/tag/v0.44.1)

#### Bug Fixes

* Fix PCES copy bugs. ([#10057](https://github.com/hashgraph/hedera-services/pull/10057)) [#10062](https://github.com/hashgraph/hedera-services/pull/10062)

### [0.44.0](https://github.com/hashgraph/hedera-services/releases/tag/v0.44.0)

#### Features

* Re-add bootstrap.properties file to maintain downstream processes and increase accounts.maxNumber=20\_000\_000 [#8915](https://github.com/hashgraph/hedera-services/pull/8915)
* 8815: sort dirty leaves during flush [#8981](https://github.com/hashgraph/hedera-services/pull/8981)
* Add setting to disable critical quorum. [#8961](https://github.com/hashgraph/hedera-services/pull/8961)
* Add a doc for all system entity numbers [#8993](https://github.com/hashgraph/hedera-services/pull/8993)
* 08566 - Validate PCES Events When Loading State On Different Network [#8568](https://github.com/hashgraph/hedera-services/pull/8568)
* Differential testing analytic engine: State file file dumper now dumps special files [#8991](https://github.com/hashgraph/hedera-services/pull/8991)
* Added improved startup ASCII art. [#9028](https://github.com/hashgraph/hedera-services/pull/9028)
* Characterize invalid id failure modes for classic HTS calls [#9053](https://github.com/hashgraph/hedera-services/pull/9053)
* Add ordinals to status diagram, and update javadocs [#9108](https://github.com/hashgraph/hedera-services/pull/9108)
* 5552: Create a Grafana Data Dashboard to view all existing relevant data metrics [#8845](https://github.com/hashgraph/hedera-services/pull/8845)
* Update Besu to version 23.10.0 [#9168](https://github.com/hashgraph/hedera-services/pull/9168)

**➡ See the full list of changes** [**here**](https://github.com/hashgraph/hedera-services/releases/tag/v0.44.0)**.**

### Performance Results

<figure><img src="../../.gitbook/assets/0.44_Performance Measurement Results.001.png" alt=""><figcaption></figcaption></figure>

## [v0.43](https://github.com/hashgraph/hedera-services/releases/tag/v0.43.0)

{% hint style="success" %}
**MAINNET UPDATE: NOVEMBER 27, 2023**
{% endhint %}

{% hint style="success" %}
**TESTNET UPDATE: NOVEMBER 2, 2023**
{% endhint %}

Services v0.43.0 adds the following features:

* HIP-786 ([#8620](https://github.com/hashgraph/hedera-services/pull/8620))

#### Enhancements

Services v0.43.0 adds the following enhancements:

* Update Besu to 23.10.0 - cherry pick ([#9199](https://github.com/hashgraph/hedera-services/pull/9199))
* Update the Besu EVM library to version 23.7.2 ([#8472](https://github.com/hashgraph/hedera-services/pull/8472))
* "Productizing" contract disassembler at last ([#8563](https://github.com/hashgraph/hedera-services/pull/8563))
* Auto sidecar validations ([#8404](https://github.com/hashgraph/hedera-services/pull/8404))
* Create fat jar with services CLI so it can be run standalone ([#8519](https://github.com/hashgraph/hedera-services/pull/8519))

### Performance Results

<figure><img src="../../.gitbook/assets/0.43_Performance Measurement Results.001.png" alt=""><figcaption></figcaption></figure>

## [v0.42](https://github.com/hashgraph/hedera-services/releases/tag/v0.42.0)

{% hint style="success" %}
**MAINNET UPDATE: OCTOBER 24, 2023**
{% endhint %}

{% hint style="success" %}
**TESTNET UPDATE: SEPTEMBER 26, 2023**
{% endhint %}

### [0.42.6](https://github.com/hashgraph/hedera-services/releases/tag/v0.42.6)

This release updates the platform SDK version from `0.42.0` to `0.42.6`, which removes `reconnect.asyncStreamTimeout` from the settings files. Doing so ensures that this property will default to the value specified in code (300 seconds).

#### Changes

* Upgrade platform SDK ([#9224](https://github.com/hashgraph/hedera-services/pull/9224))

### [0.42.2](https://github.com/hashgraph/hedera-services/releases/tag/v0.42.2)

#### Changes

* 0.42 account balance test ([#8866](https://github.com/hashgraph/hedera-services/pull/8866))
* Re-add bootstrap.properties file and increase `accounts.maxNumber=20_000_000` ([#8928](https://github.com/hashgraph/hedera-services/pull/8928))

### [0.42.1](https://github.com/hashgraph/hedera-services/releases/tag/v0.42.1)

#### Changes

* Chore: normalize configuration values (release/0.42) ([#8668](https://github.com/hashgraph/hedera-services/pull/8668))
* 8751: No data source metrics for accounts, NFTs, or token rels ([#8798](https://github.com/hashgraph/hedera-services/pull/8798))

### [0.42.0](https://github.com/hashgraph/hedera-services/releases/tag/v0.42.0)

* Add EIP 2930 support to EthTXData ([#7696](https://github.com/hashgraph/hedera-services/pull/7696))
* Provide entity and throttle dashboards ([#7774](https://github.com/hashgraph/hedera-services/pull/7774))
* 07748 Postconsensus signature gathering ([#7776](https://github.com/hashgraph/hedera-services/pull/7776))
* Enable EIP-2930 transactions by default ([#7786](https://github.com/hashgraph/hedera-services/pull/7786))
* 7570: Remove JasperDB ([#7803](https://github.com/hashgraph/hedera-services/pull/7803))
* Remove support for legacy sync gossip. ([#8059](https://github.com/hashgraph/hedera-services/pull/8059))
* Disable account balance exports ([#8272](https://github.com/hashgraph/hedera-services/pull/8272))
* Modify config to support state on disk by default ([#8510](https://github.com/hashgraph/hedera-services/pull/8510))

### Performance Results

<figure><img src="../../.gitbook/assets/0.42_Performance Measurement Results.001.png" alt=""><figcaption></figcaption></figure>

## [v0.41](https://github.com/hashgraph/hedera-services/releases/tag/v0.41.0)

{% hint style="success" %}
**MAINNET UPDATE: SEPTEMBER 20, 2023**
{% endhint %}

{% hint style="success" %}
**TESTNET UPDATE: AUGUST 22, 2023**
{% endhint %}

* Ethereum transaction type support is expanded to include type 1 transactions ([#7670](https://github.com/hashgraph/hedera-services/issues/7670)) which follow EIP 2930 RLP encoding. This increases the number of native EVM tools and scenarios the Hedera Smart Contract Service supports.
* NFT mint pricing is changed to linearly scale based on number of serials minted. Also, minting a single NFT in collection is changed to cost $0.02 from $0.05. [#7769](https://github.com/hashgraph/hedera-services/issues/7769)

### Performance Results

<figure><img src="../../.gitbook/assets/0.41_Performance Measurement.png" alt=""><figcaption></figcaption></figure>

## [v0.40](https://github.com/hashgraph/hedera-services/releases/tag/v0.40.0)

{% hint style="success" %}
**MAINNET UPDATE: AUGUST 15, 2023**
{% endhint %}

{% hint style="success" %}
**TESTNET UPDATE: AUGUST 8, 2023**
{% endhint %}

{% hint style="success" %}
**TESTNET UPDATE: JULY 19, 2023**
{% endhint %}

The 0.40 release of Consensus Node delivers [HIP-729 \~ "Contract Accounts Nonce Externalization"](https://hips.hedera.com/hip/hip-729). Smart contract developers using the Hedera public mirror node can now track contract nonces as they would on e.g., Ethereum. Use cases might include troubleshooting failed contract calls or writing unit tests that validate transaction ordering based on `CREATE1` addresses (once these are set by default in release 0.41+).

Open source contributors to the project will notice major refinements in the Gradle build, thanks to [@jjohannes](https://github.com/jjohannes)'s expert touch.

### Performance Results

<figure><img src="../../.gitbook/assets/0.40_Performance Measurement.png" alt=""><figcaption></figcaption></figure>

## [v0.39](https://github.com/hashgraph/hedera-services/tags)

{% hint style="success" %}
**MAINNET UPDATE: JULY 11, 2023**
{% endhint %}

{% hint style="success" %}
**TESTNET UPDATE: JUNE 21, 2023**
{% endhint %}

Services v0.39.0 adds the following features:

* VirtualRootNode constructor creates a cache object that doesn't get reused [#6321](https://github.com/hashgraph/hedera-services/pull/6321)
* Implement blocklisting of EVM addresses [#5799](https://github.com/hashgraph/hedera-services/pull/5799)
* Optimize virtual node cache flush strategy [#5568](https://github.com/hashgraph/hedera-services/pull/5568)
* HIP-721: 06026 - add software version to events [#6236](https://github.com/hashgraph/hedera-services/pull/6236)
* Implement CryptoCreate handle method [#6112](https://github.com/hashgraph/hedera-services/pull/6112)
* UtilPrng handle Implementation [#6310](https://github.com/hashgraph/hedera-services/pull/6310)
* Add a PCLI sub command to sign services stream files [#6309](https://github.com/hashgraph/hedera-services/pull/6309)
* Implement token freeze handling [#6467](https://github.com/hashgraph/hedera-services/pull/6467)
* Implement token unfreeze handle() [#6502](https://github.com/hashgraph/hedera-services/pull/6502)
* Combine Admin and Network modules [#6511](https://github.com/hashgraph/hedera-services/pull/6511)
* Implement the modular Pre-Handle Workflow [#6291](https://github.com/hashgraph/hedera-services/pull/6291)
* Move hashes out of leaves node in VirtualMap [#5825](https://github.com/hashgraph/hedera-services/pull/5825)
* TokenFeeScheduleUpdate handle() implementation [#6582](https://github.com/hashgraph/hedera-services/pull/6582)
* Basic File service implementation [#6522](https://github.com/hashgraph/hedera-services/pull/6522)
* Implement Token Association to Account [#6609](https://github.com/hashgraph/hedera-services/pull/6609)
* Implementation of handle workflow [#6476](https://github.com/hashgraph/hedera-services/pull/6476)
* Implement the modular record cache [#6754](https://github.com/hashgraph/hedera-services/pull/6754)
* CryptoDelete handle implementation [#6694](https://github.com/hashgraph/hedera-services/pull/6694)

### Performance Results

<figure><img src="../../.gitbook/assets/0.39_Performance Measurement.png" alt=""><figcaption></figcaption></figure>

## [v0.38](https://github.com/hashgraph/hedera-services/releases/tag/v0.38.0)

{% hint style="success" %}
**MAINNET UPDATE: JUNE 8, 2023**
{% endhint %}

{% hint style="success" %}
**TESTNET UPDATE: JUNE 1, 2023**
{% endhint %}

{% hint style="success" %}
**TESTNET UPDATE: MAY 18, 2023**
{% endhint %}

* Upgrade EVM to Shanghai [#5964](https://github.com/hashgraph/hedera-services/pull/5964)
* EVM version update and optimizations [#5962](https://github.com/hashgraph/hedera-services/pull/5962)
* Turn on the Shanghai version of the EVM in previewnet [#6212](https://github.com/hashgraph/hedera-services/pull/6212)
* Update hedera-protobufs-java version to 0.38.10 [#6579](https://github.com/hashgraph/hedera-services/pull/6579)
* Add PCLI command to sign account balance files [#6264](https://github.com/hashgraph/hedera-services/pull/6264)

### Performance Results

<figure><img src="../../.gitbook/assets/0.38_Performance Measurement Results_Extract.001.jpeg" alt=""><figcaption></figcaption></figure>

## [v0.37](https://github.com/hashgraph/hedera-services/releases/tag/v0.37.0)

{% hint style="success" %}
**MAINNET UPDATE: MAY 17, 2023**
{% endhint %}

{% hint style="success" %}
**TESTNET UPDATE: APRIL 24, 2023**
{% endhint %}

### Features

* Implement topic deletion prehandle ([#5033](https://github.com/hashgraph/hedera-services/pull/5033))
* Generalize workflows enabled and add workflow ports ([#5032](https://github.com/hashgraph/hedera-services/pull/5032))
* Pre-handle improvements ([#5056](https://github.com/hashgraph/hedera-services/pull/5056))
* Support auto-scheduling operations by type within a suite ([#5054](https://github.com/hashgraph/hedera-services/pull/5054))
* Add SPI and App components supporting TransactionDispatcher for modularized HCS ([#5062](https://github.com/hashgraph/hedera-services/pull/5062))
* added the missing functionality to FileSignTool ([#5100](https://github.com/hashgraph/hedera-services/pull/5100))
* Consensus Message Submission Prehandle ([#5059](https://github.com/hashgraph/hedera-services/pull/5059))
* Add IngestChecker mono adapters for sigs and solvency ([#5098](https://github.com/hashgraph/hedera-services/pull/5098))
* \[HIP-583] Finalize hollow accounts via any required signature in a txn ([#4990](https://github.com/hashgraph/hedera-services/pull/4990))
* Remove CryptoCreate capability to create hollow accounts ([#4998](https://github.com/hashgraph/hedera-services/pull/4998))
* Populate EVM Address in CryptoTranscation ([#5010](https://github.com/hashgraph/hedera-services/pull/5010))
* Enable All EVM E2E suites to run with Ethereum Calls ([#4375](https://github.com/hashgraph/hedera-services/pull/4375))

### Performance Results

<figure><img src="../../.gitbook/assets/0_37Performance Measurement Results_Extract.001.jpeg" alt=""><figcaption></figcaption></figure>

## [v0.36](https://github.com/hashgraph/hedera-services/releases/tag/v0.36.0)

{% hint style="success" %}
**MAINNET UPDATE: APRIL 20, 2023**
{% endhint %}

{% hint style="success" %}
**TESTNET UPDATE: APRIL 13, 2023**
{% endhint %}

{% hint style="success" %}
**TESTNET UPDATE: APRIL 4, 2023**
{% endhint %}

#### Features

Services v0.36.0 adds the following functionality:

* Add tracking of property changes for hollow account completion ([#4647](https://github.com/hashgraph/hedera-services/pull/4647))
* Adding support for Redirect Token Calls fro evm-module ([#4880](https://github.com/hashgraph/hedera-services/pull/4880))
* Update FileSignTool ([#4988](https://github.com/hashgraph/hedera-services/pull/4988))
* Adding block number tool ([#4997](https://github.com/hashgraph/hedera-services/pull/4997))
* Add client.workflow.operations and test with workflows ([#5053](https://github.com/hashgraph/hedera-services/pull/5053))
* update hedera-services to use FSTS CLI instead of system properties
* 6166: Migrate VirtualMap data from JasperDB to MerkleDb data sources
* Implementation of current network functionality in new, modularized application architecture: consensus operations, query workflow, and various preHandle implementations

### Security Updates: Hedera Smart Contract Service Security Model Changes

Changes from services v0.35.2 have also been ported to v0.36.0.

* After the security incident on March 9th, the engineers conducted a thorough analysis of the Smart Contract Service and the Hedera Token Service system contracts.
* As part of this exercise, we did not find any additional vulnerabilities that could result in an attack that that which we witnessed on March 9th.
* The team also looked for any disparities between the expectations of a typical smart contract developer who is used to working with the Ethereum Virtual Machine (EVM) or ERC token APIs and the behaviors of the Hedera Token Service system contract APIs. Such differences in behavior could be used by a malicious smart contract developer in unexpected ways.
* In order to eliminate the possibility of these behavioral differences being utilized as attack vectors in the future, the consensus node software will align the behaviors of the Hedera Smart Contract Service token system contracts with those of EVM and typical token APIs such as ERC 20 and ERC 721.
* As a result, the following changes are made as of the mainnet 0.35.2 release on March 31st:
  * An EOA (externally owned account) will have to provide explicit approval/allowance to a contract if they want the contract to transfer value from their account balance.
  * The behavior of `transferFrom` system contract will be exactly the same as that of the ERC 20 and ERC 721 spec `transferFrom` function.
  * For HTS specific token functionality (e.g. Pause, Freeze, or Grant KYC), a contract will be authorized to perform the associated token management function only if the ContractId is listed as a key on the token (i.e. Pause Key, Freeze Key, KYC Key respectively).
  * The `transferToken` and `transferNFT` APIs will behave as `transfer` in ERC20/721 if the caller owns the value being transferred, otherwise it will rely on approve spender allowances from the token owner.
  * The above model will dictate entity (EOA and contracts) permissions during contract executions when modifying state. Contracts will no longer rely on Hedera transaction signature presence, but will instead be in accordance with EVM, ERC and ContractId key models noted.
* As part of this release, the network will include logic to grandfather in previous contracts.
  * Any contracts created from this release onwards will utilize the stricter security model and as such will not have considerations for top-level signatures on transactions to provide permissions.
  * Existing contracts deployed prior to this upgrade will be automatically grandfathered in and continue to use the old model that was in place prior to this release for a limited time to allow for DApp/UX modification to work with the new security model.
  * The grandfather logic will be maintained for an approximate period of 3 months from this release. In a future release in July 2023, the network will remove the grandfather logic, and all contracts will follow the new security model.
  * Developers are encouraged to test their DApps with new contracts and UX using the new security model to avoid unintended consequences. If any DApp developers fail to modify their applications or upgrade their contracts (as applicable) to adhere to the new security model, they may experience issues in their applications.

### Performance Results

<figure><img src="../../.gitbook/assets/0.36_Performance Measurement Results_Extract.001 (1).png" alt=""><figcaption></figcaption></figure>

## [v0.35](https://github.com/hashgraph/hedera-services/releases)

{% hint style="success" %}
**MAINNET UPDATE: MARCH 31, 2023**
{% endhint %}

{% hint style="success" %}
**TESTNET UPDATE: MARCH 16, 2023**
{% endhint %}

### [0.35.2 Hedera Smart Contract Service Security Model Changes](https://github.com/hashgraph/hedera-services/releases/tag/v0.35.2)

* After the security incident on March 9th, the engineers conducted a thorough analysis of the Smart Contract Service and the Hedera Token Service system contracts.
* As part of this exercise, we did not find any additional vulnerabilities that could result in an attack that that which we witnessed on March 9th.
* The team also looked for any disparities between the expectations of a typical smart contract developer who is used to working with the Ethereum Virtual Machine (EVM) or ERC token APIs and the behaviors of the Hedera Token Service system contract APIs. Such differences in behavior could be used by a malicious smart contract developer in unexpected ways.
* In order to eliminate the possibility of these behavioral differences being utilized as attack vectors in the future, the consensus node software will align the behaviors of the Hedera Smart Contract Service token system contracts with those of EVM and typical token APIs such as ERC 20 and ERC 721.
* As a result, the following changes are made as of the mainnet 0.35.2 release on March 31st:
  * An EOA (externally owned account) will have to provide explicit approval/allowance to a contract if they want the contract to transfer value from their account balance.
  * The behavior of `transferFrom` system contract will be exactly the same as that of the ERC 20 and ERC 721 spec `transferFrom` function.
  * For HTS specific token functionality (e.g. Pause, Freeze, or Grant KYC), a contract will be authorized to perform the associated token management function only if the ContractId is listed as a key on the token (i.e. Pause Key, Freeze Key, KYC Key respectively).
  * The `transferToken` and `transferNFT` APIs will behave as `transfer` in ERC20/721 if the caller owns the value being transferred, otherwise it will rely on approve spender allowances from the token owner.
  * The above model will dictate entity (EOA and contracts) permissions during contract executions when modifying state. Contracts will no longer rely on Hedera transaction signature presence, but will instead be in accordance with EVM, ERC and ContractId key models noted.
* As part of this release, the network will include logic to grandfather in previous contracts.
  * Any contracts created from this release onwards will utilize the stricter security model and as such will not have considerations for top-level signatures on transactions to provide permissions.
  * Existing contracts deployed prior to this upgrade will be automatically grandfathered in and continue to use the old model that was in place prior to this release for a limited time to allow for DApp/UX modification to work with the new security model.
  * The grandfather logic will be maintained for an approximate period of 3 months from this release. In a future release in July 2023, the network will remove the grandfather logic, and all contracts will follow the new security model.
  * Developers are encouraged to test their DApps with new contracts and UX using the new security model to avoid unintended consequences. If any DApp developers fail to modify their applications or upgrade their contracts (as applicable) to adhere to the new security model, they may experience issues in their applications.

#### Features

* [HIP-583](https://hips.hedera.com/hip/hip-583) to expand alias support in CryptoCreate & CryptoTransfer Transactions.

This includes,

* CryptoTransfer to non-existing EVM address alias causing hollow-account creation.
* Finalizing a hollow account with the payer signature in an incoming transaction

Use cases for HIP-583 that work in this release :

1. As a user with an ECDSA based account from another chain I can have a new Hedera account created based on my evm-address alias.
2. As a developer, I can create a new account using a evm-address alias via the CryptoTransfer transaction.
3. As a developer, I can transfer HBAR or tokens to a Hedera account using their evm-address alias.
4. As a Hedera user with an Ethereum-native wallet, I can receive HBAR or tokens in my account by sharing only my evm-address alias.
5. As a Hedera user with a Hedera-native wallet, I can transfer HBAR or tokens to another account using only the recipient's evm-address alias.

#### Configuration Changes

```
autoCreation.enabled=true
lazyCreation.enabled=true
cryptoCreateWithAliasAndEvmAddress.enabled=false
contracts.evm.version=v0.34
```

### Performance Results

<figure><img src="../../.gitbook/assets/0.35_results.001.jpeg" alt=""><figcaption></figcaption></figure>

## [**v0.34**](https://github.com/hashgraph/hedera-services/releases/tag/v0.34.0)

{% hint style="success" %}
**MAINNET UPDATE: FEBRUARY 9, 2023**
{% endhint %}

{% hint style="success" %}
**TESTNET UPDATE: JANUARY 24, 2023**
{% endhint %}

### [0.34.3](https://github.com/hashgraph/hedera-services/releases/tag/v0.34.3)

Use `v0.34.3` SDK.

### [0.34.0](https://github.com/hashgraph/hedera-services/releases/tag/v0.34.0)

Services `v0.34.0` completes the implementation of [HIP-583](https://hips.hedera.com/hip/hip-583).

To ensure full test coverage of this intricate feature, it will first be enabled **only on previewnet**.

This release will not enable smart contract rent.

### Performance Results

<figure><img src="../../.gitbook/assets/0.34.1.001.png" alt=""><figcaption></figcaption></figure>

## [v0.33](https://github.com/hashgraph/hedera-services/releases/tag/v0.33.0)

{% hint style="success" %}
**MAINNET UPDATE: JANUARY 12, 2023**
{% endhint %}

{% hint style="success" %}
**TESTNET UPDATE: DECEMBER 22, 2022**
{% endhint %}

Services v0.33.0 adds the following features:

* Hyperledger Besu EVM updated to version 22.10.x
* 'accounts send' subcommand added to yahcli to support sending HTS token units
* Developer documentation updates

<figure><img src="../../.gitbook/assets/Performance Measurement Results_033.001.png" alt=""><figcaption></figcaption></figure>

## [v0.31](https://github.com/hashgraph/hedera-services/releases/tag/v0.31.0)

{% hint style="success" %}
**MAINNET UPDATE: DECEMBER 9, 2022**
{% endhint %}

{% hint style="success" %}
**TESTNET UPDATE: DECEMBER 1, 2022**
{% endhint %}

{% hint style="success" %}
**TESTNET UPDATE: NOVEMBER 11, 2022**
{% endhint %}

{% hint style="success" %}
**TESTNET UPDATE: OCTOBER 27, 2022**
{% endhint %}

Services 0.31 completes the following features:

* [HIP-542 roadmap](https://hips.hedera.com/hip/hip-542) for making payer of the `CryptoTransfer` sponsor for `auto-creation`. It also enables auto-creation with Token transfers in addition to Hbar transfers.
* [HIP-564 roadmap](https://hips.hedera.com/hip/hip-564) for allowing zero unit fungible token transfers
* [HIP-573 roadmap](https://hips.hedera.com/hip/hip-573) for enabling token creators an option to exempt _all_ of their token’s fee collectors from a custom fee.

In addition to the above features,

* Adds support of the ERC20/721 `transferFrom` method for HTS precompiles from [HIP-514 roadmap](https://hips.hedera.com/hip/hip-514).
* Enables Smart Contract Traceability.
* Adds some changes related to testability improvements.

<figure><img src="../../.gitbook/assets/0.31_results.001.png" alt=""><figcaption></figcaption></figure>

## [v0.30](https://github.com/hashgraph/hedera-services/releases/tag/v0.30.0)

{% hint style="success" %}
**MAINNET UPDATE: OCTOBER 21, 2022**
{% endhint %}

{% hint style="success" %}
**TESTNET UPDATE: OCTOBER 19, 2022**
{% endhint %}

{% hint style="success" %}
**TESTNET UPDATE: OCTOBER 6, 2022**
{% endhint %}

Services 0.30 completes the [HIP-514 roadmap](https://hips.hedera.com/hip/hip-514) for making Hedera native tokens manageable via smart contracts. There are five new system contracts: `getTokenExpiryInfo(address)`, `updateTokenExpiryInfo(address, Expiry)`, `isToken(address token)`, `getTokenType(address token)`, and `updateTokenInfo(address, HederaToken)`.

The `updateTokenInfo(address, HederaToken)` call is especially powerful. If a token's admin key signs the transaction calling a contract, that contract can now make itself the token's treasury, assume authority to mint or burn units or NFTs, and so on.

⚠️ Contract authors should know this release initiates Hedera's [expiration and rent model for contracts](https://hedera.com/blog/smart-contract-rent-on-hedera-is-coming-what-you-need-to-know). There will be two visible effects immediately after the 0.30 upgrade:

* All non-deleted contracts will have their expiry extended to at least 90 days after the upgrade date.
* Deleted contracts will start to be purged from state; so a `getContractInfo` query that previously\
  returned `CONTRACT_DELETED` may now report `INVALID_CONTRACT_ID`.

About 90 days after the 0.30 upgrade, some contracts will begin to expire. The network will try to automatically charge the renewal fee (approximately `$0.026` for 90 days) to the expired contract's auto-renew account. If an auto-renew account has zero balance, the network will then try to charge the contract itself.

A contract unable to pay renewal fees will enter a week-long "grace period" during which it is unusable, unless its expiry is extended via `ContractUpdate` or it receives hbar. After this grace period, the contract will be purged from state.

We **strongly** encourage all contract authors to set an auto-renew account for their contract. This isolates the contract logic from the existence of rent.

This release also brings two peripheral improvements:

1. It will become possible to schedule a `CryptoApproveAllowance` transaction.
2. Mirror node operators will be able to use the daily `NodeStakeUpdate` export to track the current values of [several key staking properties](https://github.com/hashgraph/hedera-protobufs/blob/main/services/node_stake_update.proto#L45). Please review the linked protobuf comments for more details on these properties.

<figure><img src="../../.gitbook/assets/0.30_results.001.png" alt=""><figcaption></figcaption></figure>

## [v0.29](https://github.com/hashgraph/hedera-services/releases/tag/v0.29.0)

{% hint style="success" %}
**MAINNET UPDATE: SEPTEMBER 27, 2022**
{% endhint %}

{% hint style="success" %}
**TESTNET UPDATE: SEPTEMBER 7, 2022**
{% endhint %}

{% hint style="success" %}
**TESTNET UPDATE: AUGUST 30, 2022**
{% endhint %}

### Contract-managed tokens 🪙

In Services 0.29 we have followed the [HIP-514 roadmap](https://hips.hedera.com/hip/hip-514) to give contract authors many new ways to inspect and manage HTS tokens.

The HIP enumerates the ways; examples include a contract that revokes an account's KYC for a token, or deletes a token for which it has admin privileges, or even changes a token's supply key based on the metadata in an NFT!

Note there are four HIP-514 functions that will be part of release 0.30, as follows: `getTokenExpiryInfo(address)`, `updateTokenExpiryInfo(address, Expiry)`, `updateTokenInfo(address, HederaToken)`, `isToken(address token)` and `getTokenType(address token)`.

[HIP-435 Record Stream v6](https://hips.hedera.com/hip/hip-435) will be enabled on testnet and mainnet in this release.

### Deprecations

Please note this [important deprecation](https://github.com/hashgraph/hedera-protobufs/blob/main/services/crypto_get_info.proto#L141) that will change how clients fetch token associations and balances after the November release in this year. At that time, mirror nodes will become the exclusive source of token association metadata. This is because [HIP-367](https://hips.hedera.com/hip/hip-367) made token associations unlimited, so in the long run it will not be efficient for consensus nodes to serve this information.

<figure><img src="../../.gitbook/assets/0.29.2.png" alt=""><figcaption></figcaption></figure>

## [v0.28](https://github.com/hashgraph/hedera-services/releases/tag/v0.28.0)

{% hint style="success" %}
**MAINNET UPDATE: AUGUST 25, 2022**
{% endhint %}

{% hint style="success" %}
**TESTNET UPDATE: JULY 29, 2022**
{% endhint %}

Services 0.28 gives Hedera devs a new dApp building block in [HIP-351 (Pseudorandom Numbers)](https://hips.hedera.com/hip/hip-351). HAPI has a new [`UtilService`](https://hashgraph.github.io/hedera-protobufs/#proto.UtilService) with a `prng` transaction that generates a record with either a pseudorandom 48-byte seed, or an integer in a requested range.

Smart contracts can also get pseudorandom values by calling a new system contract at address `0x169`, using the interface [here](https://github.com/hashgraph/hedera-services/blob/master/test-clients/src/main/resource/contract/contracts/PrngSystemContract/IPrngSystemContract.sol#L4) as in [this example](https://github.com/hashgraph/hedera-services/blob/master/test-clients/src/main/resource/contract/contracts/PrngSystemContract/PrngSystemContract.sol). Applications might include NFT mint contracts, lotteries, and so on.

📝 The HIP-351 text does not yet reflect the name change from `RandomGenerate` to `prng`, or the system contract specification. It does explain in detail how `prng` derives its entropy from the running hash of transaction records generated by the network.

This release also includes some bug fixes and smaller improvements; notably, it:

1. Extends [`ContractCallLocal` support](https://github.com/hashgraph/hedera-services/issues/3632) to the ERC-20 and ERC-721 functions `allowance`, `getApproved`, and `isApprovedForAll`.
2. Permits staking to contract accounts.

![](../../.gitbook/assets/0.28.0_results.001.jpeg)

## [v0.27](https://github.com/hashgraph/hedera-services/releases)

### v0.27.7

{% hint style="success" %}
**MAINNET UPDATE: AUGUST 9, 2022**
{% endhint %}

Any ledger that will grow to billions of entities must have an efficient way to remove expired entities. In the Hedera network, this means keeping a list of NFTs owned by an account, so that when an account expires, we can return its NFTs to their respective treasury accounts.

Under certain conditions in the 0.27.5 release, a bug in the logic maintaining these lists could cause NFT transfers to fail, without refunding fees.

We appreciate the Hedera community working with us on this issue. We invite any users who were affected by this bug to contact support at support@hedera.com.

### v0.27.0

{% hint style="success" %}
**MAINNET UPDATE: JULY 21, 2022**
{% endhint %}

{% hint style="success" %}
**TESTNET UPDATE: JULY 1, 2022**
{% endhint %}

The 0.27 release of Consensus Node initiates the first phase of [HIP-406 (Staking)](https://hips.hedera.com/hip/hip-406). We deeply appreciate the community’s feedback on this critical feature!

As wallets and exchanges roll out client support, users will now have the choice to stake their hbar to a node. As nodes accumulate stake, from both individuals and organizations, they will become eligible to pay rewards to their stakers. At this point, once the `0.0.800` account balance has crossed a threshold to be set by the council coin committee, rewards will be permanently activated.

This will set the stage for the second phase of staking, in which a node’s contribution to consensus becomes a direct function of its stake, and community nodes with sufficient stake can begin to participate in consensus. Please note the decentralized nature of this process makes it hard to predict exactly when each milestone and phase will be achieved. The immediately visible consequences of the 0.27 release will be simply,

1. The consensus nodes handle `CryptoCreate` and `CryptoUpdate` transactions with staking elections---even if not all wallets and exchanges are updated to make these elections just yet.

Observant readers might recall that an earlier [alpha release](https://github.com/hashgraph/hedera-services/releases/tag/v0.27.0-alpha.5) of Services 0.27 _also_ enabled [HIP-423 (Long Term Scheduled Transactions)](https://hips.hedera.com/hip/hip-423). This is a complex feature with some deep implications, and we have decided to defer for one more release before going to production.

![](<../../.gitbook/assets/0.27.4_results copy.001.jpeg>)

## [v0.26](https://github.com/hashgraph/hedera-services/releases)

{% hint style="success" %}
**MAINNET UPDATE: JUNE 9, 2022**
{% endhint %}

{% hint style="success" %}
**TESTNET UPDATE: MAY 25, 2022**
{% endhint %}

In this release, we are excited to deploy support for [HIP-410 (Wrapping Ethereum Transaction Bytes in a Hedera Transaction)](https://github.com/hashgraph/hedera-improvement-proposal/blob/master/HIP/hip-410.md). and [HIP-415 (Introduction Of Blocks)](https://github.com/hashgraph/hedera-improvement-proposal/blob/master/HIP/hip-415.md).

HIP-410 adds a HAPI `EthereumTransaction` by which an account that was [auto-created](https://hips.hedera.com/hip/hip-32) with an [ECDSA(secp256k1) key](https://hips.hedera.com/hip/hip-222) can submit Ethereum transactions to Hedera by signing with its ECDSA key. (Standard Ethereum restrictions on the sender's `nonce` apply.) Please see HIP-410 for details, including a summary of some very compelling use cases that the `EthereumTransaction` enables---for example, "I want to use MetaMask to create a transaction to transfer HBAR to another account".

HIP-415 also anticipates such use cases by standardizing the concept of a Hedera "block"; this is important for a full implementation of the [Ethereum JSON-RPC API](https://eth.wiki/json-rpc/API). The definition is simple: One _block_ is all the transactions in a record stream file. The _block hash_ is the 32-byte prefix of the transaction running hash at the end of the file. And the _block number_ is the index of the record file in the full stream history, where the first file had index `0`.

Consensus Node 0.26 implements [HIP-376](https://hips.hedera.com/hip/hip-376), allowing smart contract developers to use the familiar [EIP-20](https://eips.ethereum.org/EIPS/eip-20) and [EIP-721](https://eips.ethereum.org/EIPS/eip-721) "operator approval" with both fungible and non-fungible HTS tokens.

Approved operators can manage an owner's tokens on their behalf; this is necessary for many consignment use cases with third party brokers/wallets/auctioneers.

Any permissions granted in a contract through `approve()` or `setApprovalForAll()` have an equivalent HAPI `cryptoApproveAllowance` or `cryptoDeleteAllowance` expression---and this expression is externalized as a HAPI `TransactionBody` in the record stream. That is, the HIP-376 system contracts expose a subset of the native HAPI operations, only within the EVM.

![](<../../.gitbook/assets/image (2).png>)

## [v0.25](https://github.com/hashgraph/hedera-services/releases/tag/v0.25.0)

{% hint style="success" %}
**MAINNET UPDATE: MAY 19, 2022**
{% endhint %}

{% hint style="success" %}
**TESTNET UPDATE: APRIL 26, 2022**
{% endhint %}

{% hint style="success" %}
**TESTNET UPDATE: APRIL 21, 202**
{% endhint %}

The Consensus Node 0.25 release brings good news for HTS users who manage large numbers of token types, as it delivers [HIP-367 (Unlimited Token Associations per Account)](https://hips.hedera.com/hip/hip-367). In particular, a single account can now serve as treasury for any number of token types. (Please do note the `CryptoService` HAPI queries still return information for only an account’s 1000 most recently associated tokens; mirror nodes remain the best source for full history.)

We are also very excited to announce support for [HIP-358 (Allow `TokenCreate` through Hedera Token Service Precompiled Contract)](https://hips.hedera.com/hip/hip-358). This HIP supercharges contract integration, making it possible for a smart contract to create a new HTS token---fungible or non-fungible, with or without custom fees. (An interested Solidity developer might consult the examples in [this contract](https://github.com/hashgraph/hedera-services/blob/master/test-clients/src/main/resource/contract/solidity/FeeHelper.sol).)

In a harbinger of [more upcoming HTS precompile support](https://hips.hedera.com/hip/hip-376), this release will also enable [HIP-336 (Approval and Allowance API for Tokens)](https://github.com/hashgraph/hedera-improvement-proposal/blob/master/HIP/hip-336.md). Token owners can now approve other accounts to manage their HTS tokens or NFTs, in direct analogy to the `approve()` and `transferFrom()` mechanisms in ERC-20 and ERC-721 style tokens.

### Enhancements

* HIP-336 implementation [#2814](https://github.com/hashgraph/hedera-services/issues/2814)
* HIP-358 implementation [#3015](https://github.com/hashgraph/hedera-services/issues/3015)
* HIP-367 implementation [#2917](https://github.com/hashgraph/hedera-services/issues/2917)

### Fixes

* ERC `view` functions now usable in `ContractCallLocalQuery` [#3061](https://github.com/hashgraph/hedera-services/issues/3061)

![](<../../.gitbook/assets/image (11).png>)

## [v0.24](https://github.com/hashgraph/hedera-services/releases/tag/v0.24.0)

{% hint style="success" %}
**MAINNET UPDATE: APRIL 15, 2022**
{% endhint %}

{% hint style="success" %}
**TESTNET UPDATE: APRIL 7, 2022**
{% endhint %}

{% hint style="success" %}
**TESTNET UPDATE: MARCH 31, 2022**
{% endhint %}

{% hint style="success" %}
**TESTNET UPDATE: MARCH 24, 2022**
{% endhint %}

In the 0.24 release of Consensus Node, we are excited to give smart contract developers a new level of interoperability with native Hedera Token Service (HTS) tokens via [HIP-218 (Smart Contract interactions with Hedera Token Accounts)](https://hips.hedera.com/hip/hip-218). The Hedera EVM now exposes every HTS fungible token as an ERC-20 token at the address of the token’s `0.0.X` entity id; and analogously, every HTS non-fungible token appears as an ERC-721 token. This means a smart contract can look up its balance of a fungible HTS token; or change its behavior based on the owner of a particular HTS NFT. Please see the linked HIP for full details.

This upgrade also creates two new system accounts 0.0.800 and 0.0.801 that will hold reward funds.

One change to the Hedera API (HAPI) is that we now have enough evidence to conclude the experimental `getAccountNftInfos` and `getTokenNftInfos` queries do not have a favorable cost/benefit ratio, and these queries are now [permanently disabled](https://hashgraph.github.io/hedera-protobufs/#proto.TokenService).

![](<../../.gitbook/assets/Performance Measurement Results_Extract.001 (4).jpeg>)

## [v0.23](https://github.com/hashgraph/hedera-services/releases/tag/v0.23.0)

{% hint style="success" %}
**MAINNET UPDATE: MARCH 10, 2022**
{% endhint %}

{% hint style="success" %}
**TESTNET UPDATE: FEBRUARY 17, 2022**
{% endhint %}

Consensus Node 0.23 fleshes out our smart contract service via the implementation of [HIP-329 (Support `CREATE2` opcode)](https://hips.hedera.com/hip/hip-329). Smart contract developers are now free to use the `CREATE2` EVM opcode. A typical use case is a distributed exchange that wants its pair contracts to have deterministic addresses based on the tokens in the pair.

Please note two issues fixed in this release. [First](https://github.com/hashgraph/hedera-services/issues/2841), in release 0.22, the nodes returned the `bytes ledger_id` stipulated by [HIP-33](https://hips.hedera.com/hip/hip-33) as a UTF-8 encoding of a hex string. The returned bytes are now the big-endian representation of the ledger's numeric id. [Second](https://github.com/hashgraph/hedera-services/issues/2857), prior to this release, the record of a `dissociateToken` from a deleted token did not list the discarded balance of the dissociated account if the token's treasury was missing. This is now fixed.

![](<../../.gitbook/assets/Performance Measurement Results_Extract.001 (2).jpeg>)

## [v0.22](https://github.com/hashgraph/hedera-services/releases/tag/v0.22.1)

{% hint style="success" %}
**MAINNET UPDATE: FEBRUARY 3, 2022**
{% endhint %}

{% hint style="success" %}
**TESTNET UPDATE: JANUARY 20, 2022**
{% endhint %}

The 0.22 release is a paradigm shift for Consensus Node, as we deliver the next major step in our Smart Contracts 2.0 roadmap on the strength of the protean [HIP-25](https://hips.hedera.com/hip/hip-25), a technical foundation for scaling the world state of our ledger to billions of entities _without_ sacrificing the high TPS enabled by the hashgraph consensus algorithm.

Highlights of this release include:

* Network EVM capacity increased to 15M `gas`-per-second. (Please see [HIP-185](https://hips.hedera.com/hip/hip-185) for details.)
* Gas limit per `ContractCreate` or `ContractCall` raised to 4M.
* Per-contract storage capacity increased to 10MB.
* Solidity integration with native HTS tokens. (Please see [HIP-206](https://hips.hedera.com/hip/hip-206) for details.)

We expect more progress in these directions over the coming releases. Do note that the gas usage of the HTS integrations is still evolving; follow [this issue](https://github.com/hashgraph/hedera-services/issues/2786) to track the finalized gas charges leading up to mainnet release.

There are two other HIP's included in this release not related to the smart contract service. First, [HIP-33](https://hips.hedera.com/hip/hip-33) enhances queries like `CryptoGetInfo` with a _ledger id_ that marks which Hedera network answered the query. Second, [HIP-31](https://hips.hedera.com/hip/hip-31) allows a client to include the expected decimals for a token in a `CryptoTransfer`. This means a hardware wallet can guarantee its token transactions will have the precision seen by the user in the device display.

While we are gaining momentum in our smart contracts roadmap, we are also deeply committed to improving the developer experience, and welcome issues and ideas in our [GitHub repository](https://github.com/hashgraph/hedera-services) and [Discord](https://hedera.com/discord)!

![](<../../.gitbook/assets/Performance Measurement Results_Extract.001 (1).jpeg>)

## [v0.21.0](https://github.com/hashgraph/hedera-services/releases/tag/v0.21.0-rc.1)

{% hint style="success" %}
**MAINNET UPDATE: JANUARY 13, 2022**
{% endhint %}

{% hint style="success" %}
**TESTNET UPDATE: DECEMBER 21, 2021**
{% endhint %}

In Consensus Node 0.21 we are pleased to announce support for [ECDSA(secp256k1) keys](https://hips.hedera.com/hip/hip-222) and [auto-account creation](https://hips.hedera.com/hip/hip-32).

The Ethereum network makes heavy use of ECDSA cryptography with the secp256k1 curve, and by supporting these keys we ease the developer experience of migrating a dApp to Hedera. Anywhere a Ed25519 key can be used in the Hedera API, it is now possible to substitute an ECDSA(secp256k1) key.

Auto-account creation lets a new user receive ℏ via a `CryptoTransfer` _without_ having already created an `0.0.X` id on the network. The new user only needs to provide their public key, and when a sponsor account sends ℏ "to" their key via a new [`AccountID.alias` field](https://hashgraph.github.io/hedera-protobufs/#proto.AccountID), the network automatically creates an account with their key. Additional transfers to and from an auto-created account may also use its alias instead of the account id.

An alias may also be used to get the account balance and account info for the account. (Do note there is a [known issue](https://github.com/hashgraph/hedera-services/issues/2653) that causes the `getAccountInfo` query response to echo back the account alias instead of its `0.0.<num>` id; this will be fixed in the next release. Please use the free `getAccountBalance` query to check the `0.0.<num>` id that corresponds to an alias.) You will be able to use the alias in all other transactions and queries in a future release.

Meanwhile, our team continues exhaustive due diligence for Smart Contracts 2.0... 🚀

![](<../../.gitbook/assets/Performance Measurements.jpeg>)

## [v0.20.0](https://github.com/hashgraph/hedera-services/releases/tag/v0.20.0)

{% hint style="success" %}
**MAINNET UPDATE: DECEMBER 2,2021**
{% endhint %}

{% hint style="success" %}
**TESTNET UPDATE: NOVEMBER 18, 2021**
{% endhint %}

Consensus Node 0.20 is primarily a scaffolding release, as our team is working heads-down to deliver the Smart Contract Service refresh with massive new scale and performance; as well as smart contract integration with native tokens created using the Hedera Token Service. The scope of this refresh is significant, and we believe it will be well worth the wait.

The main deliverables in this release are improved automation for node operators to use in software upgrades; and a handful of minor bug fixes, including for [<mark style="color:purple;">#2432</mark>](https://github.com/hashgraph/hedera-services/issues/2432).

Please also note the following deprecations in the Hedera API protobufs:

* The [<mark style="color:purple;">`ContractUpdateTransactionBody.fileID`</mark> <mark style="color:purple;">field</mark>](https://github.com/hashgraph/hedera-protobufs/blob/main/services/contract_update.proto#L82), which is redundant given the existence of the [<mark style="color:purple;">`ContractGetBytecode`</mark> <mark style="color:purple;">quer</mark>y](https://github.com/hashgraph/hedera-protobufs/blob/main/services/smart_contract_service.proto#L63).
* The [<mark style="color:purple;">`ContractCallLocalQuery.maxResultSize`</mark> <mark style="color:purple;">field</mark>](https://github.com/hashgraph/hedera-protobufs/blob/main/services/contract_call_local.proto#L136), as this limit is now simply a side-effect of the given gas limit.

![](https://github.com/hashgraph/hedera-docs/blob/master/.gitbook/assets/Performance%20Measurement%20Results_Extract.001%20\(1\)%20\(1\)%20\(1\)%20\(1\)%20\(1\)%20\(1\)%20\(1\)%20\(1\)%20\(1\)%20\(1\)%20\(1\)%20\(1\)%20\(1\)%20\(1\)%20\(1\).jpeg)

## [v0.19.4](https://github.com/hashgraph/hedera-services/releases/tag/v0.19.4)

{% hint style="success" %}
**MAINNET UPDATE: NOVEMBER 4,2021**
{% endhint %}

{% hint style="success" %}
**TESTNET UPDATE: OCTOBER 28, 2021**
{% endhint %}

## [v0.19.3](https://github.com/hashgraph/hedera-services/releases/tag/v0.19.1)

{% hint style="success" %}
**TESTNET UPDATE: OCTOBER 21, 2021**
{% endhint %}

In Consensus Node 0.19, we are thrilled to announce migration of the Hedera smart contract service to the Hyperledger Besu EVM, as laid out in [HIP-26](https://github.com/hashgraph/hedera-improvement-proposal/blob/master/HIP/hip-26.md). This enables support for the latest v0.8.9 Solidity contracts, and harmonizes our gas schedule with that of the “London” hard fork. The Besu migration also sets the stage for a step change in smart contract performance on Hedera.

Two other HIPs targeting the Hedera Token Service go live in this release. First, the [HIP-23](https://github.com/hashgraph/hedera-improvement-proposal/blob/master/HIP/hip-23.md) feature set is now enabled, so that any account that has been configured with a non-zero `maxAutoAssociations` can receive air-drops (i.e., units or NFTs of a token type without explicit association). Second, we have also implemented [HIP-24](https://github.com/hashgraph/hedera-improvement-proposal/blob/master/HIP/hip-24.md), which provides a safety measure for token types created with a `pauseKey`. If a `TokenPause` is submitted with this key’s signature, then all operations on the token will be suspended until a subsequent `TokenUnpause`.

## [v0.18.1](https://github.com/hashgraph/hedera-services/releases/tag/v0.18.1)

{% hint style="success" %}
**MAINNET UPDATE: OCTOBER 7, 2021**
{% endhint %}

In Consensus Node 0.18.1, we have a new scalability profile for NFTs in the Hedera Token Service (HTS). Up to fifty million (50M) NFTs, each with 100 bytes of metadata, may now be minted. Of course our `CryptoTransfer` and `ConsensusSubmitMessage` operations are still supported at 10k TPS even with this scale.

In this release, we have also enabled automatic reconnect. This feature comes into play when a network partition causes a node to "fall behind" in the consensus protocol. With reconnect enabled, the node can use a special form of gossip to "catch up" and resume participation in the network with no human intervention. This works even when the node has missed many millions of transactions, and the world state is very different from when it was last active.

We are happy to also announce that accounts can be customized to take advantage of the upcoming [HIP-23 (Opt-in Token Associations)](https://github.com/hashgraph/hedera-improvement-proposal/blob/master/HIP/hip-23.md) feature set. That is, an account owner can now "pre-pay" for token associations via a [`CryptoCreate`](https://hashgraph.github.io/hedera-protobufs/#proto.CryptoCreateTransactionBody) or [`CryptoUpdate`](https://hashgraph.github.io/hedera-protobufs/#proto.CryptoUpdateTransactionBody) transaction, _without_ knowing in advance which specific token types they will use.

Once HIP-23 is fully enabled in release 0.19, when their account receives units or NFT's of a new token type via a `CryptoTransfer`, the network will automatically create the needed association---no explicit `TokenAssociate` transaction needed. This supports several interesting use cases; please see the linked HIP-23 for more details.

There are three other points of interest in this release.

First, we have removed the HIP-18 limitations noted in the previous release. The `tokenFeeScheduleUpdate` transaction has been re-enabled, and multiple royalty fees can now be charged for a non-fungible token type.

Second, the address books in system files `0.0.101` and `0.0.102` will now populate their `ServiceEndpoint` fields. (However, the deprecated `ipAddress`, `portno`, and `memo` fields will no longer be populated after the next release.)

Third, please note that the `TokenService` `getTokenNftInfos` and `getAccountNftInfos` queries are now **deprecated** and will be removed in a future release. The best answers to such queries demand historical context that only Mirror Nodes have; so these and related queries will move to mirror REST APIs.

Developers will likely appreciate two other release 0.18.1 items. First, we have migrated to [Dagger2](https://dagger.dev/) for dependency injection. Second, there is a new `getExecutionTime` query in the [`NetworkService`](https://hashgraph.github.io/hedera-protobufs/#proto.NetworkService) that supports granular performance testing in development environments.

![](<../../.gitbook/assets/image (3).png>)

## v0.18.0

{% hint style="success" %}
**TESTNET UPDATE: SEPTEMBER 23, 2021**
{% endhint %}

In Consensus Node 0.18.0, we are happy to announce support for [HIP-23 (Opt-in Token Associations)](https://github.com/hashgraph/hedera-improvement-proposal/blob/master/HIP/hip-23.md). This feature lets an Hedera account owner "pre-pay" for token associations via a [`CryptoCreate`](https://hashgraph.github.io/hedera-protobufs/#proto.CryptoCreateTransactionBody) or [`CryptoUpdate`](https://hashgraph.github.io/hedera-protobufs/#proto.CryptoUpdateTransactionBody) transaction, _without_ knowing in advance which specific token types they will use.

Then, when their account receives units or NFT's of a new token type via a `CryptoTransfer`, the network automatically creates the needed association---no explicit `TokenAssociate` transaction needed. This supports several interesting use cases; please see the linked HIP-23 for more details.

There are three other points of interest in this release.

First, we have removed the HIP-18 limitations noted in the previous release. The `tokenFeeScheduleUpdate` transaction has been re-enabled, and multiple royalty fees can now be charged for a non-fungible token type.

Second, the address books in system files `0.0.101` and `0.0.102` will now populate their `ServiceEndpoint` fields. (However, the deprecated `ipAddress`, `portno`, and `memo` fields will not be no longer be populated after the next release.)

Third, please note that the `TokenService` `getTokenNftInfos` and `getAccountNftInfos` queries are now **deprecated** and will be removed in a future release. The best answers to such queries demand historical context that only Mirror Nodes have; so these and related queries will move to mirror REST APIs.

Developers will likely appreciate two other release 0.18.0 items. First, we have migrated to [Dagger2](https://dagger.dev/) for dependency injection. Second, there is a new `getExecutionTime` query in the [`NetworkService`](https://hashgraph.github.io/hedera-protobufs/#proto.NetworkService) that supports granular performance testing in development environments.

**Performance Measurement Results:**

![](<../../.gitbook/assets/Performance Measurement Results.jpeg>)

## [v0.17.4](https://github.com/hashgraph/hedera-services/releases/tag/v0.17.3)

{% hint style="success" %}
**MAINNET UPDATE: SEPTEMBER 2, 2021**
{% endhint %}

{% hint style="success" %}
**TESTNET UPDATE: AUGUST 30, 2021**
{% endhint %}

In Consensus Node 0.17.2, we are excited to announce support for [HIP-17 (Non-fungible Tokens)](https://github.com/hashgraph/hedera-improvement-proposal/blob/master/HIP/hip-17.md), with a complementary extension to [HIP-18 (Custom Hedera Token Service Fees)](https://github.com/hashgraph/hedera-improvement-proposal/blob/master/HIP/hip-18.md) that lets an NFT creator set a royalty fee to be charged when fungible value is exchanged for one of their creations.

Unique token types and minted NFTs are more natural for many use cases than fungible token types. The Hedera Token Service now supports both natively, so that a single `CryptoTransfer` can perform atomic swaps with any arbitrary combination of fungible, non-fungible, and ℏ transfers. (Please do note that the "paged" `getAccountNftInfos` and `getTokenNftInfos` queries will remain disabled until release 0.18.0, as several large performance improvements are pending.)

In this release we have made it possible to denominate a fixed fee in the units of the token to which it is attached (assuming the type of this token is `FUNGIBLE_COMMON`). Custom fractional fees may now also be set as "net-of-transfer". In this case the recipient(s) in the transfer list receive the stated amounts, and the assessed fee is charged to the sender.

There are a few final points of more specialized interest. First, users of the scheduled transaction facility may now also schedule `TokenBurn` and `TokenMint` transactions. Second, network administrators issuing a `CryptoUpdate` to change the treasury account's key must now sign with the new treasury key. Third, the supported TLS cipher suites have been updated to the following list:

1. `TLS_DHE_RSA_WITH_AES_256_GCM_SHA384` (TLS v1.2)
2. `TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384` (TLS v1.2)
3. `TLS_AES_256_GCM_SHA384` (TLS v1.3)

⚠️ There are two temporary limitations to HIP-18 in this release. First, the `tokenFeeScheduleUpdate` transaction is not currently available. Second, only one royalty fee will be charged for a non-fungible token type. Both limitations will be removed in release 0.18.0.

#### Performance Measurement Results:

![](../../.gitbook/assets/0.17.png)

## [v0.17.3](https://github.com/hashgraph/hedera-services/releases/tag/v0.17.3-rc.1)

{% hint style="success" %}
**TESTNET UPDATE: AUGUST 24, 2021**
{% endhint %}

Please see 0.17.4 release notes.

## [v0.17.2](https://github.com/hashgraph/hedera-services/releases/tag/v0.17.2)

{% hint style="success" %}
**TESTNET UPDATE: AUGUST 19, 2021**
{% endhint %}

Please see 0.17.4 release notes.

## [v0.16.1](https://github.com/hashgraph/hedera-services/releases/tag/v0.16.1)

{% hint style="success" %}
**MAINNET UPDATE COMPLETED: AUGUST 5, 2021**
{% endhint %}

{% hint style="success" %}
**TESTNET UPDATE COMPLETED: JULY 22, 2021**
{% endhint %}

In Consensus Node 0.16.0, we are excited to announce support for [HIP-18 (Custom Hedera Token Service Fees)](https://github.com/hashgraph/hedera-improvement-proposal/blob/master/HIP/hip-18.md).

Hedera tokens can now be created with a schedule of up to 10 custom fees, which are either _fixed_ in units of ℏ or another token; or _fractional_ and computed in the units of the owning token. The ledger automatically charges custom fees to accounts as they send units of a fungible token (or ownership of a NFT, see below) via a `CryptoTransfer`.

When a custom fee cannot be charged, the `CryptoTransfer` fails atomically, changing no balances other than for the Hedera network fees.

The five case studies in [this document](https://github.com/hashgraph/hedera-services/blob/master/docs/fees/custom-fees-characterization.md) show the basics of how custom fees are charged, and how they appear in records. Note that at most two "levels" of custom HTS fees are allowed, and custom fee-charging cannot require changing more than 20 account balances.

⚠️ There is one variation on custom fees that requires a work-around in this release. Specifically, if a fixed fee should be collected _in the units of the "parent" token to whose schedule it belongs_, then in Release 0.16.0 this must be accomplished using a `FractionalFee` as described in [this issue](https://github.com/hashgraph/hedera-services/issues/1925). In Release 0.17.0 the more natural `FixedFee` configuration will be available.

In this release, we have also enabled previewnet support for [HIP-17 (Non-fungible Tokens)](https://github.com/hashgraph/hedera-improvement-proposal/blob/master/HIP/hip-17.md). Unique token types and minted NFTs are more natural for many use cases than fungible token types. The Hedera Token Service will soon support both natively, so that a single `CryptoTransfer` can perform atomic swaps with any arbitrary combination of fungible, non-fungible, and ℏ transfers.

We are very grateful to the Hedera user community for these interesting and powerful new feature sets.

#### Performance Measurement Results:

![](../../.gitbook/assets/0.16.1.png)

## [v0.15.1](https://github.com/hashgraph/hedera-services/releases/tag/v0.15.1)

{% hint style="success" %}
**MAINNET UPDATE COMPLETED: JULY 1, 2021**
{% endhint %}

{% hint style="success" %}
**TESTNET UPDATE COMPLETED: JUNE 17, 2021**
{% endhint %}

In Consensus Node 0.15.1, we improved performance and integrated with the latest Platform SDK to enable full support of network reconnect.

These performance improvements let us augment the Hedera world state with records of all transactions handled in the three minutes of consensus time, even when handling 10,000 transactions per second. The HAPI `GetAccountRecords` query now returns, from state, all such records for which the queried account was the payer account.

We have also finalized the design for the non-fungible token (NFT) support to be added to the Hedera Token Service (HTS) in release 0.16.0. The protobufs for new HAPI operations are available in the 0.15.0 tag of the[ hedera-protobufs](https://github.com/hashgraph/hedera-protobufs) GitHub repository.\
\
To simplify fee calculations, there is now a maximum entity lifetime of a century for any entity whose lifetime is not \_already\_ constrained by the maximum auto-renew period. A HAPI transaction that tries to set an expiration further than a century from the current consensus time will resolve to `INVALID_EXPIRATION_TIME`.

## [v0.14.0](https://github.com/hashgraph/hedera-services/releases/tag/0.14.0)

{% hint style="success" %}
**MAINNET UPDATE COMPLETED: JUNE 3, 2021**
{% endhint %}

{% hint style="success" %}
**TESTNET UPDATE COMPLETED: MAY 20, 2021**
{% endhint %}

In Consensus Node 0.14.0, we have implemented account auto-renewal according to the specifications of [HIP-16](https://github.com/hashgraph/hedera-improvement-proposal). This feature will not be enabled until a later date, after ensuring universal awareness of its impact in the user community.

This release includes notable infrastructure work to enable use of the Platform reconnect feature. Reconnect allows a node that has fallen behind in consensus gossip to catch back up dynamically.

A minor improvement to the Hedera API is that the GetVersionInfo query now includes the optional pre-release version and build metadata fields from the Semantic Versioning spec (if applicable).

To simplify life for system admins who are updating a system account's key, we now waive the signing requirement for the account's new key.

## [v0.13.2](https://github.com/hashgraph/hedera-services/releases/tag/v0.13.2)

{% hint style="success" %}
**MAINNET UPDATE COMPLETED: MAY 6, 2021**
{% endhint %}

{% hint style="success" %}
**TESTNET UPDATE COMPLETED: APRIL 29, 2021 \[v0.13.2]**
{% endhint %}

{% hint style="success" %}
**TESTNET UPDATE COMPLETED: APRIL 22, 2021 \[v0.13.0]**
{% endhint %}

In Consensus Node v0.13.0, we have [redesigned](https://github.com/hashgraph/hedera-services/blob/master/docs/scheduled-transactions/revised-spec.md) schedule transactions. The new design gives collaborating nodes a well-defined workflow if they happen to schedule identical transactions, _even if_ they are using different gRPC client libraries (for example, Go and JavaScript). The new design also reduces the number of signatures required to submit a valid `ScheduleSign` transaction in many common use cases. Users will be able to schedule `CryptoTransfer` and `ConsensusSubmitMessage` transactions in this release. Other transaction types will be introduced in future releases.

{% hint style="warning" %}
**Note:** The schedule transactions feature will not be enabled in this release; it's expected to be enabled on testnet in a subsequent v0.13.2 update on April 29th. This feature is enabled on previewnet.
{% endhint %}

This release deprecates three fields in the [protobuf](https://hashgraph.github.io/hedera-protobufs/#proto.NodeAddress) for system files `0.0.101` and `0.0.102`. The three deprecated fields are `ipAddress`, `portno`, and `memo`. When we rely on these fields, we cannot concisely represent node with multiple IP addresses. For example, take mainnet node 0 (account `0.0.3`), which as of this writing has proxy IPs `13.82.40.153`, `34.239.82.6`, and `35.237.200.180`. The mainnet `0.0.101` file must include a `NodeAddress` entry for each proxy, which means duplicating fields like `nodeCertHash`.

The new protobuf avoid this duplication, letting us represent node 0 in a protobuf equivalent of,

```
{
    "nodeId" : 0,
    "certHash" : "337390d8fea144afc12e81254a28dac6ea82893836ac072effd85e0a7748580ef28096648c5a7f8dbb4ce81476815137",
    "nodeAccount" : "0.0.3",
    "serviceEndpoints" : [ {
      "ipAddressV4" : "13.82.40.153",
      "port" : 50211
    }, {
      "ipAddressV4" : "34.239.82.6",
      "port" : 50211
    }, {
      "ipAddressV4" : "35.237.200.180",
      "port" : 50211
    } ]
}
```

However, Services will continue to populate the deprecated fields in duplicate entries for six months, to give all consumers of files `0.0.101` and `0.0.102` time to prepare for exclusive use of the new format. After six months, we will eliminate the duplication and the `ipAddress`, `portno`, and `memo` fields will be left empty. (The fields will never be removed to ensure it remains possible to parse early versions of these system files.)

In a minor point, Services now rejects any protobuf `string` field whose UTF-8 encoding includes the zero-byte character; that is, Unicode code point 0, `NUL`. Databases (for example, PostgreSQL) commonly reserve this character as a delimiter in their internal formats, so allowing it to occur in entity fields can make life harder for Mirror Node operators.

To simplify tasks for network admins, we have also streamlined the signing requirements for updates to system accounts, and introduced a Docker-based utility called "yahcli" for admin actions such as updating system files.

## [v0.12.0](https://github.com/hashgraph/hedera-services/releases/tag/v0.12.0-rc.2)

{% hint style="success" %}
**MAINNET UPDATE COMPLETED: MARCH 12, 2021**
{% endhint %}

{% hint style="success" %}
**TESTNET UPDATE COMPLETED: FEBRUARY 26, 2021**
{% endhint %}

In Consensus Node v0.12.0, we completed the MVP implementation of the Hedera Scheduled Transaction Service (HSTS) as detailed in [this](https://github.com/hashgraph/hedera-services/blob/master/docs/scheduled-transactions/spec.md) design document. This service decouples _what_ should execute on the ledger from _when_ it should execute, giving new flexibility and programmability to users. Note that HSTS operations are enabled on Previewnet, but remain disabled on Testnet and Mainnet at this time.

We have given users of the Hedera Token Service (HTS) more control over the lifecycle of their token associations. In v0.11.0, deleted tokens were immediately dissociated from all accounts. This automatic dissociation no longer occurs. If account `X` is associated with token `Y`, then even if token `Y` is marked for deletion, a `getAccountInfo` query for `X` will continue to show the association with `Y` \_until\_it is explicitly removed via a `tokenDissociateFromAccount` transaction. Note that for convenience, queries that return token balances now also return the `decimals` value for the relevant token. This allows a user to interpret e.g. `balance=10050` as `100.50` tokens given `decimals=2`.

In a final Hedera API (HAPI) change, we have extended the `memo` field present on contract and topic entities to the account, file, token, and scheduled transaction entities. (Note this `memo` is distinct from the short-lived `memo` that may be given to any `TransactionBody`for inclusion in the `TransactionRecord`.) All of these changes to HAPI are now more easily browsed via GitHub pages [here](https://hashgraph.github.io/hedera-protobufs/); the new [`hashgraph/hedera-protobufs` repository](https://github.com/hashgraph/hedera-protobufs) is now the authoritative source of the protobuf files defining HAPI.

Apart from these enhancements to HAPI, the "streams" consumable by mirror node operators now include an alpha version of a protobuf file that contains the same information as the `_Balances.csv` files. The type of this file is [`AllAccountBalances`](https://hashgraph.github.io/hedera-protobufs/#proto.AllAccountBalances).

## [v0.11.0](https://github.com/hashgraph/hedera-services/releases/tag/v0.11.0)

{% hint style="success" %}
**MAINNET UPDATE COMPLETED: FEBRUARY 4, 2021**
{% endhint %}

{% hint style="success" %}
**TESTNET UPDATE COMPLETED: JANUARY 26, 2021**
{% endhint %}

In Consensus Node v0.11.0, we upgraded the record stream format from v2 to v5 and the event stream format from v3 to v5. These changes are described in detail in the "Record and Event Stream File Formats" [article](https://docs.hedera.com/guides/docs/record-and-event-stream-file-formats).

We also updated startup code to make the number of system accounts in development and pre-production networks match the number of system accounts on mainnet, [creating](https://github.com/hashgraph/hedera-services/issues/784) account numbers `900-1000` on startup if they do not exist.

## [v0.10.0](https://github.com/hashgraph/hedera-services/releases/tag/v0.10.0)

{% hint style="success" %}
**MAINNET UPDATE COMPLETED: JANUARY 7, 2021**
{% endhint %}

{% hint style="success" %}
**TESTNET UPDATE COMPLETED: DECEMBER 17, 2020**
{% endhint %}

In Consensus Node v0.10.0, we improved the usability of the Hedera Token Service (HTS) with a `newTotalSupply` field in the receipts of `TokenMint` and `TokenBurn` transactions. Without this field, a client must follow the entire record stream of a token's supply changes to be certain of its supply at the consensus timestamp in the receipt. (Note that HTS operations are now enabled on Previewnet and Testnet, but remain disabled on Mainnet at this time. Please consult the [SDK documentation](https://docs.hedera.com/452354233115445331/token-service) for HTS semantics.)

Also for HTS, we added a property `fees.tokenTransferUsageMultiplier` that scales the resource usage assigned to a `CryptoTransfer` that changes token balances. This scaling factor is expected to be set so that the cost of a `CryptoTransfer` that changes two token balances is roughly 10x the cost of a `CryptoTransfer` that changes only two hbar balances.

Apart from HTS, this release drops a restriction on what payer accounts can be used for `CryptoUpdate` transactions that target system accounts. (That is, accounts with numbers not greater than `hedera.numReservedSystemEntities`.) In earlier versions, only three payers were accepted: The target account itself, the system admin account, or the treasury account. Other payers resulted in a status of `AUTHORIZATION_FAILED`. This entire restriction is removed, with one exception---the treasury must pay for a `CryptoUpdate` targeting the treasury.

Apart from these functional changes, we fixed an unintentional change in the naming of the crypto balances CSV file, and improved the usefulness of clients under _test-clients/_ for testing reconnect scenarios.

## [v0.9.0](https://github.com/hashgraph/hedera-services/releases/tag/v0.9.0-rc.1)

{% hint style="success" %}
**MAINNET UPDATE COMPLETED: DECEMBER 3, 2020**
{% endhint %}

{% hint style="success" %}
**TESTNET UPDATE COMPLETED: NOVEMBER 19, 2020**
{% endhint %}

In Consensus Node v0.9.0, we finished the alpha implementation of the Hedera Token Service (HTS). Note that all HTS operations are enabled on Previewnet, but remain disabled on Testnet and Mainnet. Please consult the [SDK documentation](https://docs.hedera.com/452354233115445331/token-service) for HTS semantics.

We made several changes to the HAPI protobuf. First, we removed the deprecated `SignatureList` message type. Second, we added a top-level `signedTransactionBytes` field to the `Transaction` message to ensure deterministic transaction hashes across different client libraries; the top-level `bodyBytes` and `sigMap` fields are now deprecated and the already-deprecated `body` field is removed. Third, we deprecated all fields related to non-payer records, include account send and receive thresholds. This followed from the effective removal of non-payer records in v0.8.1.

For the same reason, the semantics of the `CryptoGetRecords` and `ContractGetRecords` queries have also changed. The only queryable records are now those granted to the effective payer of a transaction that was handled while the network property `ledger.keepRecordsInState=true`. Such records have an expiry of 180 seconds. It is important to note that because a contract account can never be the effective payer for a transaction, any `ContractGetRecords` query will always return an empty record list, and we have deprecated the query.

## [v0.8.1](https://github.com/hashgraph/hedera-services/releases/tag/v0.8.1-rc1)

{% hint style="success" %}
**MAINNET UPDATE COMPLETED: OCTOBER 22, 2020**
{% endhint %}

{% hint style="success" %}
**TESTNET UPDATE COMPLETED: OCTOBER 7, 2020**
{% endhint %}

The mainnet release includes the 0.8.0 version updates.

## [v0.8.0](https://github.com/hashgraph/hedera-services/releases/tag/v0.8.0-rc1)

{% hint style="success" %}
**TESTNET UPDATE COMPLETED: SEPTEMBER 17, 2020**
{% endhint %}

In Consensus Node v0.8.0, we made several minor fixes and improvements. This tag also includes pre-release implementations of several operations for an incipient Hedera Token Service (HTS).

**NOTE:** HTS operations will remain disabled in non-development environments for some time. These operations are under active development; please consult `master` for up-to-date semantics.

### Enhancements

* Deprecated fields related to threshold records in HAPI protobuf [#506](https://github.com/hashgraph/hedera-services/issues/506)
* Update Receipt proto to pair each Status with NodeID - Receipt is deleted only when the latest (duplicate) transaction expires. `getTxRecord` API will continue to return ALL records with the transaction ID.
* First drafts of `tokenCreate`, `tokenUpdate`, `tokenDelete`, `tokenTransfer`, `tokenFreeze`, `tokenUnfreeze`, `tokenGrantKyc`, `tokenRevokeYc`, `tokenWipe`, and `getTokenInfo` HAPI operations. [#505](https://github.com/hashgraph/hedera-services/pull/505) and [#522](https://github.com/hashgraph/hedera-services/pull/522)

## [v0.7.0](https://github.com/hashgraph/hedera-services/releases/tag/v0.7.0-alpha1)

{% hint style="success" %}
**MAINNET UPDATE COMPLETED: SEPTEMBER 8, 2020**
{% endhint %}

{% hint style="success" %}
**TESTNET UPDATE COMPLETED: AUGUST 20, 2020**
{% endhint %}

In Consensus Node v0.7.0, we’ve moved to Swirlds SDK release `0.7.3` which enables zero-stake nodes to be part of a network without affecting consensus. Consensus Node v0.7.0 migrated to new interfaces and methods provided in this version of the Swirlds SDK. HCS topic running hashes are now calculated including the payer account id. The release includes other minor fixes and improvements.

**Enhancements**

* Migrate to Swirlds SDK release `0.7.3` with appropriate settings and logging configurations [#347](https://github.com/hashgraph/hedera-services/issues/347), [#427](https://github.com/hashgraph/hedera-services/issues/427)
* Update HCS topic running hash to include the payer account id [#88](https://github.com/hashgraph/hedera-services/issues/88)
* Add zero-stake node functionality [#274](https://github.com/hashgraph/hedera-services/issues/274)
* Add new stats for the average size of HCS submit message transactions that got handled and for counting the number of platform transactions not created per second [#316](https://github.com/hashgraph/hedera-services/issues/316), [#334](https://github.com/hashgraph/hedera-services/issues/334)
* Change gRPC CipherSuite to be CNSA compliant [#215](https://github.com/hashgraph/hedera-services/issues/215)
* Make recordLogPeriod dynamic with a default of 2 seconds [#315](https://github.com/hashgraph/hedera-services/issues/315)
* Add record with 3-min expiry to effective payer account after handling transaction [#348](https://github.com/hashgraph/hedera-services/issues/348)
* Enhancements for going open source [#378](https://github.com/hashgraph/hedera-services/issues/378), [#379](https://github.com/hashgraph/hedera-services/issues/379)

**Documentation changes**

* Clarify interpretation of response codes `UNKNOWN` and `PLATFORM_TRANSACTION_NOT_CREATED` [#314](https://github.com/hashgraph/hedera-services/issues/314), [#394](https://github.com/hashgraph/hedera-services/issues/394)

**Bug fixes**

* Prevent `CryptoCreate` and `CryptoUpdate` transactions from giving an account an empty key [#58](https://github.com/hashgraph/hedera-services/issues/58), [#60](https://github.com/hashgraph/hedera-services/issues/60)
* Fix incorrect submitted smart contract transactions count [#371](https://github.com/hashgraph/hedera-services/issues/371)
* Validate total ledger balance before starting up Services [#258](https://github.com/hashgraph/hedera-services/issues/258)
* Add a new rolling file to log all queries with controlled maximum rate [#59](https://github.com/hashgraph/hedera-services/issues/59)
* Other minor bugs [#373](https://github.com/hashgraph/hedera-services/issues/373)

## [v0.6.0](https://github.com/hashgraph/hedera-services/releases/tag/v0.6.0)

{% hint style="success" %}
**MAINNET UPGRADE COMPLETED: AUGUST 6, 2020**
{% endhint %}

{% hint style="success" %}
**TESTNET UPGRADE COMPLETED: JULY 16, 2020**
{% endhint %}

In Consensus Node v0.6.0, we’ve enhanced the Hedera Consensus Service by supporting [HCS Topic Fragmentation](https://github.com/hashgraph/hedera-services/issues/53). We added, into the `ConsensusSubmitMessageTransactionBody`, an optional field for the current chunk information. For every chunk, the payer account that is part of the `initialTransactionID` must match the Payer Account of this transaction. The entire `initialTransactionID` should match the `transactionID` of the first chunk, but this is not checked or enforced by Hedera except when the chunk number is 1.

**Enhancements**

* Add support for HCS Topic Fragmentation

**Documentation changes**

* Protobuf v0.6.0 with HAPI doc update to support HCS Topic Fragmentation

## [**v0.5.8**](https://github.com/hashgraph/hedera-services/releases/tag/oa-release-r5-rc8)

{% hint style="success" %}
**MAINNET UPGRADE COMPLETED: JUNE 18, 2020**

v0.5.8 includes all of the updates found in [v0.5.0](services.md#v-0-5-0)
{% endhint %}

{% hint style="success" %}
**TESTNET UPGRADE COMPLETED: JUNE 8, 2020**
{% endhint %}

Version 0.5.8 includes a patch which addresses the resilience of peer-to-peer networking in the hashgraph consensus platform.

## **v0.5.0**

{% hint style="success" %}
**TESTNET UPGRADE COMPLETED: MAY 5, 2020**
{% endhint %}

In Consensus Node v0.5.0, we’ve added TLS for trusted communication with nodes on the Hedera network. For better security, only TLS v1.2 and v1.3 with TLS\_ECDHE\_ECDSA\_WITH\_AES\_256\_GCM\_SHA384 and TLS\_RSA\_WITH\_AES\_256\_GCM\_SHA384 cipher suites are allowed.

We’ve added new metadata in the Hedera NodeAddressBook, accessible in system file 0.0.101. The versions of the node software and gRPC Hedera API (HAPI) are now queryable via GetVersionInfo under the new NetworkService for node and network-scoped operations.

For Hedera Consensus Service, we’ve updated the topic running hash calculation to use the SHA-384 hash of the submitted message, rather than the message itself. This reduces the storage requirements needed to validate the hash of a topic. The record of a ConsensusSubmitMessage transaction that uses the new hashing scheme will have a new topicRunningHashVersion field in its receipt. The value of the field will be 2.

Hedera File Service also has several fixes of note. First, we enabled immutable files. Second, we relaxed the signing requirements for a FileDelete transaction to match the semantics of a revocation service. Third, we fixed a fee calculation bug that overcharged certain FileUpdate transactions.

For Hedera Smart Contract Service, we’ve improved visibility into transactions that create child contracts using the new keyword by putting created ids in the record of the transaction; and we now propagate parent contract metadata to created children.

Finally, if you use the throttle properties in system file 0.0.121 to estimate network performance limits, you will also be interested in a new standardized format of those properties. The lists below contain these and other minor updates, bug fixes, and documentation changes.

**Enhancements**

* Add support for TLS
* Expand address book metadata
* Return all created contract ids
* Propagate creator contract metadata
* Introduce GetVersionInfo query
* Standardize throttle configuration
* Enforce file.encoding=utf-8 on startup
* Make duration properties inclusive for readability

**Bug fixes**

* Use message SHA-384 hash in running hash
* Enable immutable files
* Relax FileDelete signing requirements
* Fix sbh calculation in FileUpdate
* Return metadata for deleted files
* Enforce receiver signing requirements during contract execution
* Reject invalid CryptoGetInfo
* Reject CryptoCreate with empty key
* Return NOT\_SUPPORTED for state proof queries
* Waive fees for 0.0.57 updating 0.0.111
* Waive signing requirements for 0.0.55 updating 0.0.121/0.0.122
* Waive all fees for 0.0.2
* Do not throttle system accounts

**Documentation changes**

* Replace “claim” with “livehash” as appropriate
* Standardize and clarify HAPI doc

## v0.4.1

* Software update includes the ability for Hedera to dynamically set throttles on network transaction types.
* The following throttles would be updated to: 1000 submit messages per second and 5 topic creates per second.
* Reassigning of new Council Member nodes

## v0.4.0

* Say hello to the Hedera Consensus Service! This release is the first to include HCS, allowing verifiable timestamping and ordering of application messages.
* Network pricing has been updated to include HCS transactions and queries
* Network throttle for HCS set to 1000 tps for submitting messages, and 100 tps for each of the other HCS operations.
* Improved end to end testing.
* General code clean up and refactoring.
* ContractCall - TransactionReceipt response to ContractCall no longer includes the contractID called
* CryptoUpdate - TransactionReceipt response to CryptoUpdate no longer includes the accountID updated
* CryptoTransfer – CryptoTransfer transactions resulting in INSUFFICIENT\_ACCOUNT\_BALANCE error no longer list Transfers in the TransactionRecord transferList that were not applied

### Miscellaneous

### SDKs

* Java SDK has been updated to support the Hedera Consensus Service
* JavaScript/Typescript SDK has reached version 1.0.0, supporting all four mainnet services
* JavaScript/Typescript SDK supports both running in the browser (with Envoy Proxy) and in Node.
* Go SDK now supports all four mainnet services.

**Fees**

* Transfer list within transaction records now shows only a single net amount in or out for each account, reflecting both transfers and any fees paid.
* Fixed bug in fee schedule that had resulted in fees for ContractCallLocal, ContractGetBytecode, and getVersion queries being undercharged by \~33%
* You may get more information regarding transaction record fees [here](https://docs.hedera.com/guides/mainnet/fees/transaction-records).

### SDK Extension Components

* The Hedera SDK Extension Components (SXC) is an open sourced set of pre-built components that aim to provide additional functionality over and above HCS to make it easier and quicker to develop applications, particularly if they require secure communications between participants.
* Components use the Hedera Java SDK to communicate with the Hedera Consensus Service.
* Learn more about Hedera SXC [here](https://github.com/hashgraph/hedera-hcs-sxc).

## Release v0.51

### [Build v0.51.5](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.51.5)

<details>
<summary><strong>What's Changed</strong></summary>

* * feat(reconnect): introduce ReconnectMapStats interface by @anthony-swirldslabs in https://github.com/hashgraph/hedera-services/pull/13027
* * chore: revert removal of CLI report tool by @lpetrovic05 in https://github.com/hashgraph/hedera-services/pull/13002
* * docs: add design document for HIP-904 token reject operation by @MiroslavGatsanoga in https://github.com/hashgraph/hedera-services/pull/12786
* * feat: gossip facade by @cody-littley in https://github.com/hashgraph/hedera-services/pull/12897
* * feat: add the ability to disable the running event hasher by @cody-littley in https://github.com/hashgraph/hedera-services/pull/13083
* * fix: ignore token expiry status in `TokenDissociate` by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/13104
* * feat: add javadoc and diagram, delete dead code by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/13070
* * fix: use civilian payer for modified variants by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/13020
* * fix: 12853: Memory leak from MerkleDbDataSource.copyStatisticsFrom() by @artemananiev in https://github.com/hashgraph/hedera-services/pull/13097
* * feat: Updated hedera-services code to support DAB protobuf changes. by @iwsimon in https://github.com/hashgraph/hedera-services/pull/13090
* * refactor: state signature collector proxy wiring by @edward-swirldslabs in https://github.com/hashgraph/hedera-services/pull/13066
* * refactor: refactor and rename hts classes for reuse by @lukelee-sl in https://github.com/hashgraph/hedera-services/pull/13107
* * feat: Map HapiContractCreate to HapiEthereumContractCreate by @vtronkov in https://github.com/hashgraph/hedera-services/pull/12093
* * feat: simulated TURTLE gossip by @cody-littley in https://github.com/hashgraph/hedera-services/pull/13129
* * chore: Base uses same singleton pattern at all places by @hendrikebbers in https://github.com/hashgraph/hedera-services/pull/12888
* * fix: add createTokenWithEthereumContractCallSignedWithSECP256K1 hapi… by @Ivo-Yankov in https://github.com/hashgraph/hedera-services/pull/13119
* * chore: Provide executor factory by PlatformContext by @hendrikebbers in https://github.com/hashgraph/hedera-services/pull/12891
* * docs: add design document for HIP-904 token claim airdrop transaction by @MiroslavGatsanoga in https://github.com/hashgraph/hedera-services/pull/12838
* * chore: Increased test coverage for NetworkingStakingTranslator by @thomas-swirlds-labs in https://github.com/hashgraph/hedera-services/pull/13116
* * feat: 11425: level by level reconnect by @anthony-swirldslabs in https://github.com/hashgraph/hedera-services/pull/11755
* * chore: add javadoc to file service by @povolev15 in https://github.com/hashgraph/hedera-services/pull/13159
* * feat: Created hedera-addressbook-service package for Dynamic Address Book P2. by @iwsimon in https://github.com/hashgraph/hedera-services/pull/13151
* * fix: (cherry pick) Enhance purechecks for CryptoGetAccountBalanceHandler (#12839) by @thomas-swirlds-labs in https://github.com/hashgraph/hedera-services/pull/13143
* * chore: TokenHandlers test coverage (#13160) by @derektriley in https://github.com/hashgraph/hedera-services/pull/13165
* * fix: (cherry pick) Enhance purechecks for CryptoCreateHandler (#12797) by @thomas-swirlds-labs in https://github.com/hashgraph/hedera-services/pull/13142
* * chore: Add missing javadocs in `TokenService` by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/13134
* * chore: Improve unit test coverage on TokenServiceImpl by @mhess-swl in https://github.com/hashgraph/hedera-services/pull/13186
* * chore: Add missing code coverage in `EndOfStakingPeriodUpdater` by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/13158
* * fix: revert CES name by @cody-littley in https://github.com/hashgraph/hedera-services/pull/13199
* * fix: internal calls to system accounts by @petreze in https://github.com/hashgraph/hedera-services/pull/13175
* * fix: Add test cases for TokenInfo single field update via contract calls and update handler logic to match the wanted behaviour by @stoyanov-st in https://github.com/hashgraph/hedera-services/pull/12720
* * chore: BaseCryptoHandler test coverage (#13146) by @derektriley in https://github.com/hashgraph/hedera-services/pull/13157
* * feat(cancun): Finish HIP-866 non-support for Cancun blobs by @david-bakin-sl in https://github.com/hashgraph/hedera-services/pull/13178
* * chore: Add tests for NetworkAdminHandlers class by @kimbor in https://github.com/hashgraph/hedera-services/pull/13197
* * chore: Increased test coverage for StakingUtiliites  by @thomas-swirlds-labs in https://github.com/hashgraph/hedera-services/pull/13140
* * fix: Restart test fix for flakiness by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/13179
* * fix: bugs found in Hedera > Ethereum conversion framework by @vtronkov in https://github.com/hashgraph/hedera-services/pull/12118
* * fix: services bugs found when running ConcurrentSuites.ethereumSuites tests with Ethereum contrext by @vtronkov in https://github.com/hashgraph/hedera-services/pull/12834
* * build: automate publishing to Maven Central by @jjohannes in https://github.com/hashgraph/hedera-services/pull/11731
* * fix: Exchange rate precompile return error when called with value #13052 by @stefan-stefanooov in https://github.com/hashgraph/hedera-services/pull/13053
* * chore: Update log rolling policy to size based only by @timo0 in https://github.com/hashgraph/hedera-services/pull/12949
* * feat: misc cleanup tasks in SwirldsPlatform by @cody-littley in https://github.com/hashgraph/hedera-services/pull/13184
* * chore: Implement unit tests for UtilHandlers class by @kimbor in https://github.com/hashgraph/hedera-services/pull/13222
* * chore: Implement unit tests for ConsensusHandlers class by @kimbor in https://github.com/hashgraph/hedera-services/pull/13218
* * feat: stale event detector by @cody-littley in https://github.com/hashgraph/hedera-services/pull/13009
* * chore: 11765 Migrate Merkle state classes to `swirlds-platform-core` module by @imalygin in https://github.com/hashgraph/hedera-services/pull/12570
* * feat: Write tests for burn operations #12726 by @stefan-stefanooov in https://github.com/hashgraph/hedera-services/pull/12998
* * chore: new test coverage for ConsensusServiceImpl by @povolev15 in https://github.com/hashgraph/hedera-services/pull/13252
* * feat: real keys in fake address books by @cody-littley in https://github.com/hashgraph/hedera-services/pull/13177
* * build: remove 'publish EVM' step from GH pipeline by @jjohannes in https://github.com/hashgraph/hedera-services/pull/13228
* * chore: Fixes compile issues on develop from protobufs by @MiroslavGatsanoga in https://github.com/hashgraph/hedera-services/pull/13244
* * chore: Add code coverage to `CustomRoyaltyFeeAssessor`, `CustomFixedFeeAssessor` by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/13224
* * chore: add unit test for UtilPrngHandler by @povolev15 in https://github.com/hashgraph/hedera-services/pull/13254
* * chore: Implement unit tests for FileHandlers class by @kimbor in https://github.com/hashgraph/hedera-services/pull/13255
* * chore: FileAppendHandler unit test coverage by @kimbor in https://github.com/hashgraph/hedera-services/pull/13256
* * chore: increase consensus submit message handler code coverage by @povolev15 in https://github.com/hashgraph/hedera-services/pull/13250
* * chore: Improve unit test coverage on CryptoAddLiveHashHandler, CryptoApproveAllowanceHandler by @mhess-swl in https://github.com/hashgraph/hedera-services/pull/13215
* * chore: add NetworkServiceImpl test code coverage to 100% by @povolev15 in https://github.com/hashgraph/hedera-services/pull/13292
* * fix: stabilize exchange rate system contract spec by @lukelee-sl in https://github.com/hashgraph/hedera-services/pull/13281
* * fix: add codecov token so that codecov can upload unit test data by @jeromy-cannon in https://github.com/hashgraph/hedera-services/pull/13283
* * chore: Improve unit test coverage on adding test coverage on CryptoCreateHandler  by @thomas-swirlds-labs in https://github.com/hashgraph/hedera-services/pull/13269
* * chore: Increase coverage in CustomFeeExemptions by @thomas-swirlds-labs in https://github.com/hashgraph/hedera-services/pull/13233
* * chore: Increase coverage in schedule API and base impl classes by @mhess-swl in https://github.com/hashgraph/hedera-services/pull/13223
* * feat: better state hasher wiring by @cody-littley in https://github.com/hashgraph/hedera-services/pull/13237
* * chore: move towards making `Hash` immutable by @lpetrovic05 in https://github.com/hashgraph/hedera-services/pull/13115
* * test: Add hapi tests for ECDSA hollow account alias as different types of keys by @bilyana-gospodinova in https://github.com/hashgraph/hedera-services/pull/12916
* * fix: use mainnet `throttles.json` for testnet  by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/13297
* * chore: Unit test coverage for NetworkTransactionGetRecordHandler  by @thomas-swirlds-labs in https://github.com/hashgraph/hedera-services/pull/13309
* * feat: implement base hedera account service system contract classes by @lukelee-sl in https://github.com/hashgraph/hedera-services/pull/13167
* * feat: clean up event hashing schedulers by @cody-littley in https://github.com/hashgraph/hedera-services/pull/13248
* * chore: Add code coverage for `CustomFractionalFeeAssessor`  by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/13278
* * build: require a fixed 'major.minor.patch' Java version to be installed by @jjohannes in https://github.com/hashgraph/hedera-services/pull/13108
* * build: use 'jacoco-report-aggregation' Gradle plugin for a unified setup by @jjohannes in https://github.com/hashgraph/hedera-services/pull/13073
* * chore: use `Bytes` for event signatures by @lpetrovic05 in https://github.com/hashgraph/hedera-services/pull/13231
* * chore: FileServiceImpl test coverage by @derektriley in https://github.com/hashgraph/hedera-services/pull/13332
* * build: consistent naming of Gradle configuration files / Gradle updates by @jjohannes in https://github.com/hashgraph/hedera-services/pull/12997
* * chore: Switch to Transaction.getApplicationPayload() by @netopyr in https://github.com/hashgraph/hedera-services/pull/13345
* * chore: Added unit tests for FileSystemUndeleteHandler by @derektriley in https://github.com/hashgraph/hedera-services/pull/13261
* * feat: remove `BaseEventHashedData` from `DetailedConsensusEvent` by @lpetrovic05 in https://github.com/hashgraph/hedera-services/pull/13343
* * chore: Additional Unit Tests - TokenFeeScheduleUpdateHandler, CryptoTransferHandler, CryptoUpdateHandler #13166 by @derektriley in https://github.com/hashgraph/hedera-services/pull/13243
* * chore: Add Unit tests for FileDeleteHandler by @derektriley in https://github.com/hashgraph/hedera-services/pull/13259
* * chore: Added unit tests for FileSignatureWaiversImpl by @derektriley in https://github.com/hashgraph/hedera-services/pull/13260
* * fix: 13336: :swirlds-virtualmap:timingSensitive sizeBasedFlushes is flaky by @artemananiev in https://github.com/hashgraph/hedera-services/pull/13338
* * chore: Added Unit tests to FileSystemDeleteHandler by @derektriley in https://github.com/hashgraph/hedera-services/pull/13258
* * test: Improve code coverage for initial mod schema, schedule handlers by @mhess-swl in https://github.com/hashgraph/hedera-services/pull/13337
* * fix: revert recycle-bin store location by @mxtartaglia-sl in https://github.com/hashgraph/hedera-services/pull/13339
* * feat: less state logging spam by @cody-littley in https://github.com/hashgraph/hedera-services/pull/13280
* * feat: implement v0.51 evm module and HAS functions by @lukelee-sl in https://github.com/hashgraph/hedera-services/pull/13326
* * feat: Write tests for kyc operations by @stefan-stefanooov in https://github.com/hashgraph/hedera-services/pull/13062
* * chore: Add test coverage for UnzipUtility and NetworkUncheckedSubmitHandler by @thomas-swirlds-labs in https://github.com/hashgraph/hedera-services/pull/13351
* * build: switch to Dependabot friendly dependency version notation by @jjohannes in https://github.com/hashgraph/hedera-services/pull/13132
* * feat: signed state file manager wiring cleanup by @cody-littley in https://github.com/hashgraph/hedera-services/pull/13330
* * chore: TokenUnpauseHandler increase unit test coverage by @derektriley in https://github.com/hashgraph/hedera-services/pull/13364
* * chore: TokenPauseHandler increase unit test coverage by @derektriley in https://github.com/hashgraph/hedera-services/pull/13362
* * chore: add InitialModServiceAdminSchema test coverage by @povolev15 in https://github.com/hashgraph/hedera-services/pull/13365
* * fix: fix javadoc errors by @kimbor in https://github.com/hashgraph/hedera-services/pull/13220
* * fix: 13300 Added special handling for `com.swirlds.platform.state.merkle.logging.StateLogger` by @imalygin in https://github.com/hashgraph/hedera-services/pull/13312
* * fix: 13335 Fixed incorrect classId in `OnDiskKeySerializer` and `OnDiskValueSerializer` classes by @imalygin in https://github.com/hashgraph/hedera-services/pull/13377
* * fix: Fix records for dissociating tokens by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/13378
* * feat: use container environment by @matteriben in https://github.com/hashgraph/hedera-services/pull/13168
* * chore: add coverage to InitialModServiceNetworkSchema by @povolev15 in https://github.com/hashgraph/hedera-services/pull/13415
* * fix: resolve release pipeline failures due to job dependencies by @nathanklick in https://github.com/hashgraph/hedera-services/pull/13422
* * fix: allow default `ContractID`s by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/13421
* * feat: remove byte array from transaction by @lpetrovic05 in https://github.com/hashgraph/hedera-services/pull/13400
* * feat: hashlogger wiring cleanup by @cody-littley in https://github.com/hashgraph/hedera-services/pull/13402
* * feat: misc platform cleanup by @cody-littley in https://github.com/hashgraph/hedera-services/pull/13404
* * fix: improved linker error log by @cody-littley in https://github.com/hashgraph/hedera-services/pull/13414
* * feat: Direct call w/o value to system accounts [0.0.361-0.0.750] change output by @stefan-stefanooov in https://github.com/hashgraph/hedera-services/pull/12833
* * fix: Fix record for treasury update by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/13416
* * test: Write v2 security tests for token create operation by @fchitakova in https://github.com/hashgraph/hedera-services/pull/12952
* * feat(reconnect): introduce ReconnectMapMetrics that implements Reconn… by @anthony-swirldslabs in https://github.com/hashgraph/hedera-services/pull/13101
* * feat: turtle by @cody-littley in https://github.com/hashgraph/hedera-services/pull/13354
* * fix: flush status state machine by @cody-littley in https://github.com/hashgraph/hedera-services/pull/13413
* * chore: remove running event hasher by @cody-littley in https://github.com/hashgraph/hedera-services/pull/13419
* * fix: compiling in develop (bad merge) by @cody-littley in https://github.com/hashgraph/hedera-services/pull/13441
* * fix: Enable `@HapiTest` concurrency by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/13380
* * fix: keep staking account creation and initial wait in the same staking period by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/13444
* * chore: Move RecycleBin from FsManager to PlatformContext by @mxtartaglia-sl in https://github.com/hashgraph/hedera-services/pull/13409
* * feat: Write tests for freeze/unfreeze operations by @stefan-stefanooov in https://github.com/hashgraph/hedera-services/pull/13016
* * feat: apps provide a PBJ software version by @lpetrovic05 in https://github.com/hashgraph/hedera-services/pull/13353
* * feat: move hapi utils to hapi module by @lpetrovic05 in https://github.com/hashgraph/hedera-services/pull/13433
* * fix: invalid package name for HapiUtils by @lpetrovic05 in https://github.com/hashgraph/hedera-services/pull/13461
* * chore: move scratchpad out of common by @cody-littley in https://github.com/hashgraph/hedera-services/pull/13446
* * feat: Write tests for dissociate operations #12724 by @stefan-stefanooov in https://github.com/hashgraph/hedera-services/pull/13169
* * perf: Warm up fungible token relations by @OlegMazurov in https://github.com/hashgraph/hedera-services/pull/13453
* * chore: Increased cover for readable freeze upgrade actions by @thomas-swirlds-labs in https://github.com/hashgraph/hedera-services/pull/13426
* * feat: cleaner ISS hanlder wiring by @cody-littley in https://github.com/hashgraph/hedera-services/pull/13457
* * feat: remove `hash.getValue()` usage from mono services code by @lpetrovic05 in https://github.com/hashgraph/hedera-services/pull/13428
* * chore: Bump service version to 0.51 by @iwsimon in https://github.com/hashgraph/hedera-services/pull/13481
* * build: do not write test data into source folder by @jjohannes in https://github.com/hashgraph/hedera-services/pull/13303
* * build: set UTF-8 encoding for Gradle daemon process by @jjohannes in https://github.com/hashgraph/hedera-services/pull/13484
* * feat: enable loading keys from PEM files by @edward-swirldslabs in https://github.com/hashgraph/hedera-services/pull/13489
* * feat: delete unused code by @cody-littley in https://github.com/hashgraph/hedera-services/pull/13501
* * chore: fix PTT by @cody-littley in https://github.com/hashgraph/hedera-services/pull/13496
* * feat: move sequence map/set to platform core by @cody-littley in https://github.com/hashgraph/hedera-services/pull/13495
* * feat: generate mTLS key if absent on start by @edward-swirldslabs in https://github.com/hashgraph/hedera-services/pull/13363
* * feat: Added hedera-addressbook-service-impl package for DAB P2 by @iwsimon in https://github.com/hashgraph/hedera-services/pull/13470
* * fix: close last sidecar file by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/13448
* * feat: remove all threads from Cryptography by @cody-littley in https://github.com/hashgraph/hedera-services/pull/13493
* * chore: add coverage InitialModServiceConsensusSchema by @povolev15 in https://github.com/hashgraph/hedera-services/pull/13498
* * feat: move checks from `IngestChecker` to `pureChecks` methods by @lukelee-sl in https://github.com/hashgraph/hedera-services/pull/13520
* * perf: don't block heartbeats by @OlegMazurov in https://github.com/hashgraph/hedera-services/pull/13526
* * fix: include retry information in timeout failures by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/13529
* * chore: Improve code coverage by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/13504
* * fix: Fix NPE in `QueryWorkflowImpl` by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/13541
* * fix: update first key on insertion or removal; add log validation to CI by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/13533
* * fix: waive privileged signing requirements for file append by @povolev15 in https://github.com/hashgraph/hedera-services/pull/13519
* * feat: health monitor by @cody-littley in https://github.com/hashgraph/hedera-services/pull/13532
* * feat: Improve logging for failure case when reading config file by @matteriben in https://github.com/hashgraph/hedera-services/pull/13507
* * fix: disable broken consensusTests::nodeRemoveTest by @edward-swirldslabs in https://github.com/hashgraph/hedera-services/pull/13557
* * chore: Increase code coverage for InitialModService Token Schema by @thomas-swirlds-labs in https://github.com/hashgraph/hedera-services/pull/13544
* * fix: Skip transactions older than the software version by @mhess-swl in https://github.com/hashgraph/hedera-services/pull/13527
* * fix: add v0.50 migrations; clean up schema mgmt by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/13535
* * feat: put pbj consensus data into gossip event by @lpetrovic05 in https://github.com/hashgraph/hedera-services/pull/13462
* * chore: Metrics impl module started by @hendrikebbers in https://github.com/hashgraph/hedera-services/pull/13264
* * feat: branch detector by @cody-littley in https://github.com/hashgraph/hedera-services/pull/13518
* * fix: 13300 Added missing logger. by @imalygin in https://github.com/hashgraph/hedera-services/pull/13458
* * feat: state signer wiring by @cody-littley in https://github.com/hashgraph/hedera-services/pull/13485
* * feat: Backout dynamic address book change for release 0.51 by @iwsimon in https://github.com/hashgraph/hedera-services/pull/13562
* * fix: add chainId=298 to preprod/application.properties by @ElijahLynn in https://github.com/hashgraph/hedera-services/pull/13574
* * chore: Update build to use main branch of hedera-protobufs. by @iwsimon in https://github.com/hashgraph/hedera-services/pull/13583
* * fix: 13584: Thread race between VirtualPipeline.hashCopy() and VirtualRootNode.computeHash() by @artemananiev in https://github.com/hashgraph/hedera-services/pull/13586
* * perf: HapiUtils.parsedIntOrZero() throws too many exceptions by @OlegMazurov in https://github.com/hashgraph/hedera-services/pull/13591
* * fix: write v2 security model tests for token update HSCS operations by @petreze in https://github.com/hashgraph/hedera-services/pull/13467
* * feat: Finally make Hash immutable by @lpetrovic05 in https://github.com/hashgraph/hedera-services/pull/13512
* * chore: #13370 Change Log4j Bridge from appender to logger factory by @timo0 in https://github.com/hashgraph/hedera-services/pull/13371
* * fix: skip storage link repair with more than 4M slots in state by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/13578
* * fix: consensus partition test flake by @cody-littley in https://github.com/hashgraph/hedera-services/pull/13598
* * feat: remove context from platform builder by @cody-littley in https://github.com/hashgraph/hedera-services/pull/13579
* * feat: limit resubmission of transactions by @cody-littley in https://github.com/hashgraph/hedera-services/pull/13570
* * feat: move business logic out of SwirldsPlatform.java by @cody-littley in https://github.com/hashgraph/hedera-services/pull/13581
* * feat: Remove "proto." prefix from metric names by @netopyr in https://github.com/hashgraph/hedera-services/pull/13619
* * chore: Schedule release 0.51 branch creation. by @iwsimon in https://github.com/hashgraph/hedera-services/pull/13614
* * feat: transaction handler wiring by @cody-littley in https://github.com/hashgraph/hedera-services/pull/13590
* * chore: Increased Code Coverage for DispatchPredicate Handler by @thomas-swirlds-labs in https://github.com/hashgraph/hedera-services/pull/13603
* * chore: Bump hapi version to 0.51.0 by @iwsimon in https://github.com/hashgraph/hedera-services/pull/13626
* * chore: Added checks for assignee and milestone on PRs and associated issues by @rbarkerSL in https://github.com/hashgraph/hedera-services/pull/13629
* * feat: no status nexus by @cody-littley in https://github.com/hashgraph/hedera-services/pull/13608
* * chore: disabled new backpressure via settings by @cody-littley in https://github.com/hashgraph/hedera-services/pull/13646
* * chore: Cherry pick 13648 into release 0.51 branch by @lukelee-sl in https://github.com/hashgraph/hedera-services/pull/13663
* * fix: 13674: Backport the fix for 13531 to release 0.51 by @artemananiev in https://github.com/hashgraph/hedera-services/pull/13675
* * chore: cherry pick #13479 - redirectForAccount proxy contract support by @lukelee-sl in https://github.com/hashgraph/hedera-services/pull/13668
* * fix: Cherry-pick: Enable tokens.balancesInQueries.enabled by @netopyr in https://github.com/hashgraph/hedera-services/pull/13718
* * fix: (cherry-pick) Add `restart` method to all token schemas (#13673) by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/13720
* * fix: Make PostHashCollector SEQUENTIAL by @litt3 in https://github.com/hashgraph/hedera-services/pull/13722
* * fix: (cherry pick to 0.51) Ethereum contract calls where high-bit of amount is set, fail by @david-bakin-sl in https://github.com/hashgraph/hedera-services/pull/13840
* * chore: Cherry pick #13786 by @lukelee-sl in https://github.com/hashgraph/hedera-services/pull/13807
* * chore: Increase default to 40 million each by @poulok in https://github.com/hashgraph/hedera-services/pull/13858
* * chore: Cherry pick 13849 by @lukelee-sl in https://github.com/hashgraph/hedera-services/pull/13869
* * fix: work around missing `clearOneOfType()` method on PBJ builder by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/13863
* * fix: Cherry pick 11381 for 0.51 by @rbarkerSL in https://github.com/hashgraph/hedera-services/pull/13883
* * fix: Fix hollow account completion when completing with nft transfer … by @kselveliev in https://github.com/hashgraph/hedera-services/pull/13837
* * build: Set 'packageGroup' in 'nexusPublishing' by @jjohannes in https://github.com/hashgraph/hedera-services/pull/13896
* * build: split publish of 'platform' and 'services' / do not publish blocknode by @jjohannes in https://github.com/hashgraph/hedera-services/pull/13973
* * feat: invalid query error handling (#13900) by @kimbor in https://github.com/hashgraph/hedera-services/pull/14023
* * feat: Change config defaults by @litt3 in https://github.com/hashgraph/hedera-services/pull/14058
* * perf: Create platform ForkJoinPool with asyncMode=true by @OlegMazurov in https://github.com/hashgraph/hedera-services/pull/14068
* * chore: Revert "feat: invalid query error handling (#13900) (#14023)" by @iwsimon in https://github.com/hashgraph/hedera-services/pull/14085
* ## New Contributors
* * @matteriben made their first contribution in https://github.com/hashgraph/hedera-services/pull/13168
* **Full Changelog**: https://github.com/hashgraph/hedera-services/compare/v0.50.1...v0.51.5

**Full Changelog**: [v0.51.0...v0.51.5](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.51.0...v0.51.5)

</details>

## Release v0.50

### [Build v0.50.1](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.50.1)

<details>
<summary><strong>What's Changed</strong></summary>

* * chore: Cherry pick 13648 into release 0.50 branch by @lukelee-sl in https://github.com/hashgraph/hedera-services/pull/13662
* * fix(ci): cherry pick milestone assignee checks rel 50 by @rbarkerSL in https://github.com/hashgraph/hedera-services/pull/13712
* * fix: (cherry-pick) Use restart method to all token schemas  by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/13676
* * fix: Enable tokens.balancesInQueries.enabled by @netopyr in https://github.com/hashgraph/hedera-services/pull/13716
* * chore: Enable tokens.balancesInQueries in code by @netopyr in https://github.com/hashgraph/hedera-services/pull/13769
* **Full Changelog**: https://github.com/hashgraph/hedera-services/compare/v0.50.0...v0.50.1

**Full Changelog**: [v0.50.0...v0.50.1](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.50.0...v0.50.1)

</details>

### [Build v0.50.0](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.50.0)

<details>
<summary><strong>What's Changed</strong></summary>

* * feat: reorganize ISS wiring by @alittley in https://github.com/hashgraph/hedera-services/pull/11685
* * feat(diff-testing): Script (python) to pull intervals - up to a day - from GCP by @david-bakin-sl in https://github.com/hashgraph/hedera-services/pull/11409
* * fix: 11750 Fixed synchronization in   `BreakableDataSource.saveRecords` by @imalygin in https://github.com/hashgraph/hedera-services/pull/11756
* * feat: Differential testing: Enhance account store dumper to handle modular representation by @vtronkov in https://github.com/hashgraph/hedera-services/pull/11489
* * test: add security v2 model tests for token associate by @anastasiya-kovaliova in https://github.com/hashgraph/hedera-services/pull/11327
* * fix: stop checking for minimum birth round by @cody-littley in https://github.com/hashgraph/hedera-services/pull/11769
* * feat: make the state compatible with birth rounds by @cody-littley in https://github.com/hashgraph/hedera-services/pull/11780
* * fix: FilteredLoggingMonitor by @mxtartaglia-sl in https://github.com/hashgraph/hedera-services/pull/11754
* * feat: diagram tweaks by @cody-littley in https://github.com/hashgraph/hedera-services/pull/11801
* * fix: wait longer for freeze transaction to be handled by @JeffreyDallas in https://github.com/hashgraph/hedera-services/pull/11790
* * feat: Differential testing: Enhance contract bytecode dumper to handle modular representation by @vtronkov in https://github.com/hashgraph/hedera-services/pull/11523
* * feat: Remove unidirectional networks - no longer supported by @kfa-aguda in https://github.com/hashgraph/hedera-services/pull/11798
* * feat: Differential testing: Enhance token (type) dumper to handle modular representation by @JivkoKelchev in https://github.com/hashgraph/hedera-services/pull/11543
* * feat: scheduled txs modularization signed state dumper by @dikel in https://github.com/hashgraph/hedera-services/pull/11524
* * feat: Differential testing: Enhance topics store dumper to handle modular representation by @vtronkov in https://github.com/hashgraph/hedera-services/pull/11601
* * chore: 11770 Removed unused adapter classes. by @imalygin in https://github.com/hashgraph/hedera-services/pull/11807
* * fix: consensus test flake by @lpetrovic05 in https://github.com/hashgraph/hedera-services/pull/11817
* * refactor: Flatten gossip class 11506 by @kfa-aguda in https://github.com/hashgraph/hedera-services/pull/11827
* * chore: 11767 Removed state classes that are no longer in use by @imalygin in https://github.com/hashgraph/hedera-services/pull/11811
* * fix: fix ERC-20 log events and custom fee calculations by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/11789
* * feat: pbj-208: upgrade PBJ dependency to 0.7.20 by @anthony-swirldslabs in https://github.com/hashgraph/hedera-services/pull/11829
* * build: fix visibility of JMH classes in IDEA by @jjohannes in https://github.com/hashgraph/hedera-services/pull/11792
* * build: rename 'com.hedera.node.blocknode' -> 'com.hedera.storage.blocknode' by @jjohannes in https://github.com/hashgraph/hedera-services/pull/11675
* * chore: decouple socket factory by @lpetrovic05 in https://github.com/hashgraph/hedera-services/pull/11836
* * build: support running selected JMH tests by @jjohannes in https://github.com/hashgraph/hedera-services/pull/11865
* * fix: 11636 VirtualHasher performance improvements by @imalygin in https://github.com/hashgraph/hedera-services/pull/11787
* * fix: fix schedules-by-equality migration, fractional custom fees, and special reward situations by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/11823
* * chore: Enable modularization by @netopyr in https://github.com/hashgraph/hedera-services/pull/11753
* * fix: bug in future event buffer by @cody-littley in https://github.com/hashgraph/hedera-services/pull/11875
* * feat: wiring proxy by @cody-littley in https://github.com/hashgraph/hedera-services/pull/11846
* * chore: serializable list tweaks by @cody-littley in https://github.com/hashgraph/hedera-services/pull/11825
* * fix: cherry-pick fixed diff test issue 11822 by @iwsimon in https://github.com/hashgraph/hedera-services/pull/11907
* * fix: Log correct PCES lower bound by @alittley in https://github.com/hashgraph/hedera-services/pull/11922
* * fix: 11507 Temporary disabled test to prevent non-deterministic failures. by @imalygin in https://github.com/hashgraph/hedera-services/pull/11929
* * chore: update design doc for atomic crypto transfer by @lukelee-sl in https://github.com/hashgraph/hedera-services/pull/11918
* * chore: Bump services version to current cycle (0.49.x) by @mhess-swl in https://github.com/hashgraph/hedera-services/pull/11931
* * fix: pbj-221: upgrade PBJ dependency to 0.7.22 by @anthony-swirldslabs in https://github.com/hashgraph/hedera-services/pull/11934
* * chore: Fix issues related to upgrade by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/11884
* * feat: event br migration by @cody-littley in https://github.com/hashgraph/hedera-services/pull/11842
* * feat: faster wiring backpressure by @cody-littley in https://github.com/hashgraph/hedera-services/pull/11690
* * chore: Remove explicit fuzzy matching (cherry-pick) by @netopyr in https://github.com/hashgraph/hedera-services/pull/11943
* * feat: use automatic wiring for event deduplicator by @cody-littley in https://github.com/hashgraph/hedera-services/pull/11936
* * feat: 11830 performance improvements log fwk by @mxtartaglia-sl in https://github.com/hashgraph/hedera-services/pull/11831
* * feat: dispatch the dispatcher by @cody-littley in https://github.com/hashgraph/hedera-services/pull/11950
* * fix: properly handle services software version migration by @cody-littley in https://github.com/hashgraph/hedera-services/pull/11957
* * feat: Rework extraction utils by @alittley in https://github.com/hashgraph/hedera-services/pull/11962
* * fix: flaky backpressure unit test by @cody-littley in https://github.com/hashgraph/hedera-services/pull/11963
* * refactor: PlatformContext to configure Consensus by @edward-swirldslabs in https://github.com/hashgraph/hedera-services/pull/11961
* * fix: ensure ECDSA `ExpandedSigPair` always has EVM alias by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/11955
* * perf: Move remaining in-memory maps on disk by @netopyr in https://github.com/hashgraph/hedera-services/pull/11974
* * fix: pbj-220: upgrade PBJ dependency to 0.7.23 by @anthony-swirldslabs in https://github.com/hashgraph/hedera-services/pull/11958
* * chore: cherry pick pr 11944, added unit tests to validateTopLevelAllowances() by @iwsimon in https://github.com/hashgraph/hedera-services/pull/11976
* * fix: cherry-pick fixed diff test issue 11952 (#11965) by @iwsimon in https://github.com/hashgraph/hedera-services/pull/11990
* * fix: avoid NPE in `ThrottlesManager` post-BBM by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/11970
* * feat: pbj-212: upgrade PBJ dependency to 0.8.1 by @anthony-swirldslabs in https://github.com/hashgraph/hedera-services/pull/11914
* * fix: bug in backpressure test by @cody-littley in https://github.com/hashgraph/hedera-services/pull/11994
* * fix: 11996: The fix for #11498 doesn't cover generic object keys by @artemananiev in https://github.com/hashgraph/hedera-services/pull/11998
* * fix: use `signedTransactionBytes` in synthetic record builders by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/12008
* * chore: add JMH event serialization benchmark by @lpetrovic05 in https://github.com/hashgraph/hedera-services/pull/12014
* * feat: Combine ISS detector inputs by @alittley in https://github.com/hashgraph/hedera-services/pull/11902
* * fix: 12000 Increased timeout for `ConcurrentNodeStatusTrackerTests.setsBoundValue` by @imalygin in https://github.com/hashgraph/hedera-services/pull/12001
* * feat: Extract interface from `LatestCompleteStateNexus` by @alittley in https://github.com/hashgraph/hedera-services/pull/11988
* * chore(deps): bump crazy-max/ghaction-import-gpg from 6.0.0 to 6.1.0 by @dependabot in https://github.com/hashgraph/hedera-services/pull/11175
* * fix: 12032 temporally disable log tests by @mxtartaglia-sl in https://github.com/hashgraph/hedera-services/pull/12033
* * fix: remove null checks for non-nullable runningHash() by @anthony-swirldslabs in https://github.com/hashgraph/hedera-services/pull/12036
* * chore(deps): bump peter-evans/repository-dispatch from 2.1.2 to 3.0.0 by @dependabot in https://github.com/hashgraph/hedera-services/pull/11176
* * chore(deps): bump aslafy-z/conventional-pr-title-action from 3.1.1 to 3.2.0 by @dependabot in https://github.com/hashgraph/hedera-services/pull/11177
* * chore(deps): bump actions/upload-artifact from 4.3.0 to 4.3.1 by @dependabot in https://github.com/hashgraph/hedera-services/pull/11375
* * chore(deps): bump actions/setup-node from 4.0.1 to 4.0.2 by @dependabot in https://github.com/hashgraph/hedera-services/pull/11437
* * build(deps): bump gradle/gradle-build-action from 2.12.0 to 3.1.0 by @dependabot in https://github.com/hashgraph/hedera-services/pull/11515
* * chore(deps): bump slackapi/slack-github-action from 1.24.0 to 1.25.0 by @dependabot in https://github.com/hashgraph/hedera-services/pull/11210
* * build(deps): bump google-github-actions/auth from 2.1.0 to 2.1.2 by @dependabot in https://github.com/hashgraph/hedera-services/pull/11757
* * build(deps): bump codecov/codecov-action from 3.1.4 to 4.1.0 by @dependabot in https://github.com/hashgraph/hedera-services/pull/11758
* * build(deps): bump actions/cache from 3.3.2 to 4.0.1 by @dependabot in https://github.com/hashgraph/hedera-services/pull/11828
* * chore(deps): bump mikefarah/yq from 4.40.5 to 4.42.1 by @dependabot in https://github.com/hashgraph/hedera-services/pull/12043
* * chore(deps): bump peterjgrainger/action-create-branch from 2.4.0 to 3.0.0 by @dependabot in https://github.com/hashgraph/hedera-services/pull/12044
* * chore: Configure maxAggregateRels to 15 million (all envs) by @mhess-swl in https://github.com/hashgraph/hedera-services/pull/12051
* * feat: Extract interface from SignedStateHasher by @alittley in https://github.com/hashgraph/hedera-services/pull/12035
* * feat: Extract interface from `SavedStateController` by @alittley in https://github.com/hashgraph/hedera-services/pull/11986
* * fix: set `SUCCESS` status in genesis records by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/12038
* * fix: add positive suite tests for fixed custom fee by @petreze in https://github.com/hashgraph/hedera-services/pull/11795
* * fix: use Bytes instead of String for SCHEDULES_BY_EQUALITY_KEY (#11995) by @kimbor in https://github.com/hashgraph/hedera-services/pull/12030
* * feat: automatic transformers by @cody-littley in https://github.com/hashgraph/hedera-services/pull/11992
* * fix(pbj): stabilize hashCode() for Enums by @anthony-swirldslabs in https://github.com/hashgraph/hedera-services/pull/12045
* * fix: future event buffer bug by @cody-littley in https://github.com/hashgraph/hedera-services/pull/12066
* * fix: invalid wiring diagram by @alittley in https://github.com/hashgraph/hedera-services/pull/12074
* * fix(ci): issue with improperly generated artifact file names by @nathanklick in https://github.com/hashgraph/hedera-services/pull/12088
* * fix: differential testing: add singleton stores mono and modular representation by @petreze in https://github.com/hashgraph/hedera-services/pull/11275
* * chore: add mainnet event migration test by @lpetrovic05 in https://github.com/hashgraph/hedera-services/pull/12048
* * feat: wiring proxy splitters by @cody-littley in https://github.com/hashgraph/hedera-services/pull/12078
* * feat: better bind API by @cody-littley in https://github.com/hashgraph/hedera-services/pull/12069
* * feat: add log4j to swirlds-logging bridge by @timo0 in https://github.com/hashgraph/hedera-services/pull/12016
* * test: add security V2 tests for mint with staticcall and callcode by @anastasiya-kovaliova in https://github.com/hashgraph/hedera-services/pull/11294
* * fix: 12032 Handle Log framework System.err output in tests by @mxtartaglia-sl in https://github.com/hashgraph/hedera-services/pull/12080
* * fix: create sidecar metadata before writing `RecordStreamFile` footer by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/12091
* * feat: 12040 logging framework: NotNull & Nullable changes for consistency by @mxtartaglia-sl in https://github.com/hashgraph/hedera-services/pull/12041
* * feat: Use proxy wiring for event hasher by @alittley in https://github.com/hashgraph/hedera-services/pull/12100
* * feat: 11925 millisecond parser performance improvements by @mxtartaglia-sl in https://github.com/hashgraph/hedera-services/pull/11969
* * fix: wire `HashingOutputStream` into sidecar writing by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/12114
* * test:  Add tests for V2 token burn for EOA-CONTRACT-PRECOMPILE by @nickeynikolovv in https://github.com/hashgraph/hedera-services/pull/11072
* * feat: Use proxy wiring for pces sequencer by @alittley in https://github.com/hashgraph/hedera-services/pull/12106
* * feat: proxy filter by @cody-littley in https://github.com/hashgraph/hedera-services/pull/12111
* * fix: encode zero allowance in success response for non-fungible token by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/12134
* * feat: install script for pcli by @cody-littley in https://github.com/hashgraph/hedera-services/pull/12125
* * feat: Use proxy wiring for future event buffer by @alittley in https://github.com/hashgraph/hedera-services/pull/12103
* * fix: (mod-service) Fix a case for identifying `RESTART` scenario by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/12130
* * feat: Metadata HIPs by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/11766
* * chore: Base executor by @hendrikebbers in https://github.com/hashgraph/hedera-services/pull/12067
* * feat: Use proxy wiring for internal event validator by @alittley in https://github.com/hashgraph/hedera-services/pull/12132
* * feat: transform/filter on split proxy output by @cody-littley in https://github.com/hashgraph/hedera-services/pull/12151
* * chore: merge `release/0.48` Services changes by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/12139
* * refactor: Create ProtocolFactory for creation or protocols by @kfa-aguda in https://github.com/hashgraph/hedera-services/pull/11920
* * feat: add negative suite tests for fixed custom fee by @stefan-stefanooov in https://github.com/hashgraph/hedera-services/pull/11802
* * fix: re-cherry-pick allowance fix by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/12182
* * feat: Use proxy wiring for consensus engine by @alittley in https://github.com/hashgraph/hedera-services/pull/12129
* * feat: pces birth round migration by @cody-littley in https://github.com/hashgraph/hedera-services/pull/12107
* * fix: 11966: Revisit MerkleDbConfig initialization in MerkleDb classes by @artemananiev in https://github.com/hashgraph/hedera-services/pull/11973
* * feat(ReconnectBench): reuse generated state between invocations by @anthony-swirldslabs in https://github.com/hashgraph/hedera-services/pull/12155
* * fix: wire name by @cody-littley in https://github.com/hashgraph/hedera-services/pull/12191
* * chore: Remove unnecessary deleted flag in `TokenRelation` by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/12188
* * chore: Update to use main protobufs branch by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/12199
* * feat: State dumper final changes by @vtronkov in https://github.com/hashgraph/hedera-services/pull/12092
* * feat: Implement wired round handler output by @alittley in https://github.com/hashgraph/hedera-services/pull/11983
* * fix: `numPositiveBalances` mgmt by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/12196
* * fix: (cherry-pick) Fix updateWeight for removed nodes by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/12216
* * fix: back pressure test flake by @cody-littley in https://github.com/hashgraph/hedera-services/pull/12221
* * feat: Add additional suites for FRACTIONAL_FEE plus MIXED_SCENARIO by @stefan-stefanooov in https://github.com/hashgraph/hedera-services/pull/11897
* * fix: make `HederaSoftwareVersion` match Services upgrade semantics by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/12228
* * chore: update nightly workflow to run on new network by @tomzhenghedera in https://github.com/hashgraph/hedera-services/pull/12206
* * test: Add negative test cases to AssociationsPrecompileSuite by @stoyanov-st in https://github.com/hashgraph/hedera-services/pull/12163
* * test: Add negative test cases to ContractBurnHTSSuit by @stoyanov-st in https://github.com/hashgraph/hedera-services/pull/12049
* * test: Add negative tests for MintPrecompile by @MrValioBg in https://github.com/hashgraph/hedera-services/pull/11951
* * chore: public api for update log config by @hendrikebbers in https://github.com/hashgraph/hedera-services/pull/12047
* * chore: Add benchmarks for log4j to swirlds-logging bridge by @timo0 in https://github.com/hashgraph/hedera-services/pull/12161
* * feat: unsoldered wires by @cody-littley in https://github.com/hashgraph/hedera-services/pull/12197
* * feat: Use proxy wiring for birth round shim by @alittley in https://github.com/hashgraph/hedera-services/pull/12185
* * feat: ShrinkeableSizeCache Should use BaseExecutor by @mxtartaglia-sl in https://github.com/hashgraph/hedera-services/pull/12229
* * refactor: GraphGenerator with accurate BirthRounds by @edward-swirldslabs in https://github.com/hashgraph/hedera-services/pull/11886
* * feat: use mermaid cli by @alittley in https://github.com/hashgraph/hedera-services/pull/12249
* * refactor: fix compilation of unit test. by @edward-swirldslabs in https://github.com/hashgraph/hedera-services/pull/12252
* * chore: Refactoring logging tests by @timo0 in https://github.com/hashgraph/hedera-services/pull/12240
* * refactor: pass through wiring postHashCollector by @edward-swirldslabs in https://github.com/hashgraph/hedera-services/pull/12192
* * fix: Implement modular freeze time (develop) by @mhess-swl in https://github.com/hashgraph/hedera-services/pull/12263
* * feat: clickable wiring diagram by @cody-littley in https://github.com/hashgraph/hedera-services/pull/12275
* * refactor: move EventStreamManager to Platform Core by @edward-swirldslabs in https://github.com/hashgraph/hedera-services/pull/12276
* * chore(reconnect): add more logs to Learner by @anthony-swirldslabs in https://github.com/hashgraph/hedera-services/pull/12284
* * feat: split transaction prehandle out of `SwirldStateManager` by @alittley in https://github.com/hashgraph/hedera-services/pull/11722
* * fix: Add null check for autorenew account update by @0xivanov in https://github.com/hashgraph/hedera-services/pull/12207
* * fix: JTR sorting bug by @cody-littley in https://github.com/hashgraph/hedera-services/pull/12287
* * feat: proxy event creation by @alittley in https://github.com/hashgraph/hedera-services/pull/12256
* * feat: config extension by @cody-littley in https://github.com/hashgraph/hedera-services/pull/12167
* * feat: disentangle UI from shadowgraph by @cody-littley in https://github.com/hashgraph/hedera-services/pull/12264
* * feat: Cherry-pick: throttle metrics by @netopyr in https://github.com/hashgraph/hedera-services/pull/12294
* * fix: deterministic order of effective payer numbers by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/12317
* * feat: 11868 file size rolling by @mxtartaglia-sl in https://github.com/hashgraph/hedera-services/pull/12201
* * refactor: proxy wiring for EventStreamManager by @edward-swirldslabs in https://github.com/hashgraph/hedera-services/pull/12289
* * fix: avoid precheck `FAIL_INVALID` for `CryptoApproveAllowance` with missing token by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/12324
* * feat: Permit wires bound to methods without param and without return by @alittley in https://github.com/hashgraph/hedera-services/pull/12304
* * chore: unify logic for reclaiming frontend throttle capacity by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/12314
* * feat(ci): enable publication of the production-next deterministic image by @nathanklick in https://github.com/hashgraph/hedera-services/pull/12316
* * fix: Cherry-pick: fixed diff test 11885 (#12297)  by @iwsimon in https://github.com/hashgraph/hedera-services/pull/12330
* * fix: JTR sorting issue by @cody-littley in https://github.com/hashgraph/hedera-services/pull/12338
* * fix: services config registration fix by @cody-littley in https://github.com/hashgraph/hedera-services/pull/12342
* * fix: address book testing tool config by @cody-littley in https://github.com/hashgraph/hedera-services/pull/12353
* * feat: Create notification wiring component by @alittley in https://github.com/hashgraph/hedera-services/pull/12245
* * fix: (mod-service) Allow removing `SubmitKey` on Topic (#12301) by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/12360
* * fix: Xtests by passing default values to runningHashes and init platformState by @petreze in https://github.com/hashgraph/hedera-services/pull/12326
* * fix: add royalty fee suite tests by @dikel in https://github.com/hashgraph/hedera-services/pull/11979
* * fix: Hapi local call to deleted contract behaviour by @dikel in https://github.com/hashgraph/hedera-services/pull/12056
* * chore: (cherry-pick) Fix state dumpers (#12318) by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/12359
* * chore: fix failing `HapiTest`s by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/12374
* * feat(ReconnectBench): emulate slow I/O by @anthony-swirldslabs in https://github.com/hashgraph/hedera-services/pull/12315
* * fix: disable the future event buffer by @cody-littley in https://github.com/hashgraph/hedera-services/pull/12381
* * ci: do not use generated slack channel for PR Check test result by @JeffreyDallas in https://github.com/hashgraph/hedera-services/pull/12345
* * refactor: proxy wiring for EventWindowManager by @edward-swirldslabs in https://github.com/hashgraph/hedera-services/pull/12285
* * docs: update throttles section of config readme by @ElijahLynn in https://github.com/hashgraph/hedera-services/pull/11346
* * ci: Removed deprecated GitHub actions workflows by @rbarkerSL in https://github.com/hashgraph/hedera-services/pull/12400
* * refactor: Limit scope of `TestingEventBuilder` by @alittley in https://github.com/hashgraph/hedera-services/pull/12349
* * feat: Disable token associations in AccountInfo, ContractInfo, and AccountBalance by @netopyr in https://github.com/hashgraph/hedera-services/pull/12293
* * chore: remove bloom filters by @cody-littley in https://github.com/hashgraph/hedera-services/pull/12386
* * feat(ReconnectBench): generate .csv with metrics by @anthony-swirldslabs in https://github.com/hashgraph/hedera-services/pull/12391
* * ci: Reverted publish-unit-test-result-action from actionite fork to EnricoMi by @rbarkerSL in https://github.com/hashgraph/hedera-services/pull/12408
* * ci: Updated the PR checks to handle forks/dependabot. by @rbarkerSL in https://github.com/hashgraph/hedera-services/pull/12410
* * fix: cherry-pick: fixed diff test issue 12355. (#12375) by @iwsimon in https://github.com/hashgraph/hedera-services/pull/12382
* * fix: allow contracts as auto-renew accounts for all entity types by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/12323
* * chore: update code ownership of platform documentation by @cody-littley in https://github.com/hashgraph/hedera-services/pull/12384
* * feat: build context first by @cody-littley in https://github.com/hashgraph/hedera-services/pull/12379
* * fix: (cherry-pick) Fix to deterministic iteration order (#12401) by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/12421
* * fix: 12388: VirtualMap / DataSource metrics should not contain certain chars in the names by @artemananiev in https://github.com/hashgraph/hedera-services/pull/12390
* * refactor: proxy wiring for EventSignatureValidator by @edward-swirldslabs in https://github.com/hashgraph/hedera-services/pull/12141
* * fix: Clean up leaked virtual maps after migration (develop) by @mhess-swl in https://github.com/hashgraph/hedera-services/pull/12429
* * test: add tests for multiple transactions with fixed fee by @fchitakova in https://github.com/hashgraph/hedera-services/pull/12415
* * chore: remove verify signature method from DTO by @lpetrovic05 in https://github.com/hashgraph/hedera-services/pull/12366
* * fix: unsoldered wire instantiation bug by @cody-littley in https://github.com/hashgraph/hedera-services/pull/12442
* * refactor: Simplify `TestingEventBuilder` by @alittley in https://github.com/hashgraph/hedera-services/pull/12405
* * ci: add new uprade test panel by @JeffreyDallas in https://github.com/hashgraph/hedera-services/pull/12431
* * chore: (cherry-pick) Migration fixes from state dumpers (#12392) by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/12425
* * feat: Add maximum entity count metrics (#12200) by @netopyr in https://github.com/hashgraph/hedera-services/pull/12204
* * chore: Fix synk expiry by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/12477
* * fix: (cherry-pick) Fix signing requirements for updating metadata on Token (#12409) by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/12423
* * fix: don't use explicit `0.0.0` auto-renew account id in synth `ContractCreateTransactionBody` by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/12438
* * fix: verify payer solvency before validating non-payer sigs by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/12448
* * fix: (cherry-pick) Fix `ConfigVersion` serialization (#12439) by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/12457
* * fix: 12466 Fixed NPE intermitently occurring after 0.47 -> 0.48 migration by @imalygin in https://github.com/hashgraph/hedera-services/pull/12467
* * fix: always finalize pending precompile `CONTRACT_ACTION` in `MessageCallProcessor.start()` by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/12407
* * fix: divide summed lazy-create cost by gas price by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/12450
* * feat: task scheduler config by @cody-littley in https://github.com/hashgraph/hedera-services/pull/12305
* * chore: fix and add tests for atomic crypt transfer by @lukelee-sl in https://github.com/hashgraph/hedera-services/pull/11895
* * fix: update prng system contract gas requirements by @lukelee-sl in https://github.com/hashgraph/hedera-services/pull/12309
* * fix: wiring diagram by @cody-littley in https://github.com/hashgraph/hedera-services/pull/12470
* * fix: version backwards compatability (#12494) by @cody-littley in https://github.com/hashgraph/hedera-services/pull/12501
* * fix: Manually set event time created in SimpleGraphs by @alittley in https://github.com/hashgraph/hedera-services/pull/12500
* * fix: remove spurious `createTopic()` call by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/12517
* * feat: Cherry-pick: Pass Metrics to created VirtualMaps by @netopyr in https://github.com/hashgraph/hedera-services/pull/12495
* * feat: construct schedulers automatically by @cody-littley in https://github.com/hashgraph/hedera-services/pull/12504
* * chore: Change owner of DEV configuration by @netopyr in https://github.com/hashgraph/hedera-services/pull/12523
* * chore: Added extra-checks to prevent unchecked submits by @netopyr in https://github.com/hashgraph/hedera-services/pull/12436
* * test: security v2 model - add test for token associate with callcode by @anastasiya-kovaliova in https://github.com/hashgraph/hedera-services/pull/12168
* * refactor: Migrate some tests to use event test util by @alittley in https://github.com/hashgraph/hedera-services/pull/12471
* * feat: improve bottom half of the wiring diagram by @cody-littley in https://github.com/hashgraph/hedera-services/pull/12511
* * feat: address book serializes text hostnames by @edward-swirldslabs in https://github.com/hashgraph/hedera-services/pull/12515
* * feat: platform component builder by @cody-littley in https://github.com/hashgraph/hedera-services/pull/12499
* * fix: finalize stake metadata only once per transaction by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/12537
* * feat: cleaner wiring for complete state nexus by @cody-littley in https://github.com/hashgraph/hedera-services/pull/12502
* * feat: Automate scheduler construction for the event deduplicator by @cody-littley in https://github.com/hashgraph/hedera-services/pull/12527
* * feat: move the JVM anchor into the wiring model by @cody-littley in https://github.com/hashgraph/hedera-services/pull/12534
* * feat: restrict qualified delegates to appropriate transfer functions only by @lukelee-sl in https://github.com/hashgraph/hedera-services/pull/12358
* * fix: treat an out-of-range allowance amount as an invalid op by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/12445
* * fix: tokenAssociate throws IndexOutOfBoundsException by @JivkoKelchev in https://github.com/hashgraph/hedera-services/pull/12453
* * fix: enable HelloWorldEthereumSuite hapi tests by @Ivo-Yankov in https://github.com/hashgraph/hedera-services/pull/11602
* * fix: tokenAssociate throws IndexOutOfBoundsException by @JivkoKelchev in https://github.com/hashgraph/hedera-services/pull/12552
* * feat: Remove getOtherId by @alittley in https://github.com/hashgraph/hedera-services/pull/12465
* * feat: Introduce software update admin by @netopyr in https://github.com/hashgraph/hedera-services/pull/12489
* * test: add tests to PauseUnpauseTokenAccountPrecompileSuite by @mustafauzunn in https://github.com/hashgraph/hedera-services/pull/12492
* * test: add tests to DeleteTokenPrecompileSuite by @mustafauzunn in https://github.com/hashgraph/hedera-services/pull/12525
* * feat: no op scheduler by @cody-littley in https://github.com/hashgraph/hedera-services/pull/12530
* * test: add negative test cases for token info system contracts by @MrValioBg in https://github.com/hashgraph/hedera-services/pull/12416
* * test: add negative test cases for transferFrom and transferFromNFT by @MrValioBg in https://github.com/hashgraph/hedera-services/pull/12443
* * fix: ContractCallLocal INSUFFICIENT_GAS ERROR #12484 by @kimbor in https://github.com/hashgraph/hedera-services/pull/12543
* * test: add tests to WipeTokenAccountPrecompileSuite by @mustafauzunn in https://github.com/hashgraph/hedera-services/pull/12459
* * fix: tokenDissociate can fail with NullPointerException by @JivkoKelchev in https://github.com/hashgraph/hedera-services/pull/12553
* * feat(ReconnectBench): fuzz slow I/O delay emulation by @anthony-swirldslabs in https://github.com/hashgraph/hedera-services/pull/12544
* * feat: disentangle consensus and gossip by @cody-littley in https://github.com/hashgraph/hedera-services/pull/12428
* * fix: (cherry-pick) Fix issues found during replaying events and dumping state (#12531) by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/12560
* * chore: 12227 Moved HAPI to the project root level. by @imalygin in https://github.com/hashgraph/hedera-services/pull/12540
* * test: add fee assertion on lazy account creation tests by @natanasow in https://github.com/hashgraph/hedera-services/pull/12488
* * feat: Cherry-pick: Utilization metrics by @netopyr in https://github.com/hashgraph/hedera-services/pull/12435
* * fix: cherry-pick: fixed topicMessageSubmit without topicID throws unexpected NPE by @iwsimon in https://github.com/hashgraph/hedera-services/pull/12573
* * feat: EventSignatureValidator cleanup by @cody-littley in https://github.com/hashgraph/hedera-services/pull/12556
* * fix: use non-default contract query costs by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/12512
* * fix: use 0 for unset auto-renew period by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/12577
* * fix: set provided expiry on new schedule by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/12584
* * chore: PBJ interface for state signature transaction by @lpetrovic05 in https://github.com/hashgraph/hedera-services/pull/12487
* * chore: updated nightly test workflow state loading wait time by @tomzhenghedera in https://github.com/hashgraph/hedera-services/pull/12603
* * fix: Cherry-pick: Set minimum staking to 0 (#12601) by @iwsimon in https://github.com/hashgraph/hedera-services/pull/12606
* * fix: Cherry-pick: fixed diff test issue 12509 (#12597) by @iwsimon in https://github.com/hashgraph/hedera-services/pull/12610
* * fix: long hostnames supported in addressbook serialization by @edward-swirldslabs in https://github.com/hashgraph/hedera-services/pull/12613
* * fix: failing test due to typo for NegativeHtsTransferFrom contract  by @MrValioBg in https://github.com/hashgraph/hedera-services/pull/12596
* * fix: Cherry-pick: add pureChecks to ingest workflow by @netopyr in https://github.com/hashgraph/hedera-services/pull/12549
* * test: Add negative test cases to DissociatePrecompileSuite  by @stoyanov-st in https://github.com/hashgraph/hedera-services/pull/12272
* * test: Negative cases for getTokenCustomFees, approve, approveNFT by @stoyanov-st in https://github.com/hashgraph/hedera-services/pull/12454
* * chore: Cherry-pick: Increase max token associations to 50M by @netopyr in https://github.com/hashgraph/hedera-services/pull/12520
* * perf: Cherry-pick: reorganize metrics initialization by @netopyr in https://github.com/hashgraph/hedera-services/pull/12633
* * fix: Cherry-pick: Return REQUIRED_KEY in CryptoCreate if no alias is used by @netopyr in https://github.com/hashgraph/hedera-services/pull/12632
* * fix: Cherry-pick: Enable pureChecks in TokenAssociateToAccountHandler (#12590) by @netopyr in https://github.com/hashgraph/hedera-services/pull/12631
* * fix: Cherry-pick: Add pure check to ContractDeleteHandler by @netopyr in https://github.com/hashgraph/hedera-services/pull/12630
* * chore: Cherry-pick: unit test and add the right response code (#12581) by @povolev15 in https://github.com/hashgraph/hedera-services/pull/12640
* * feat: 11403: Switch virtual map reconnects to the pull model by @artemananiev in https://github.com/hashgraph/hedera-services/pull/11724
* * chore: handleFatalError out of SwirldsPlatform.java by @cody-littley in https://github.com/hashgraph/hedera-services/pull/12617
* * fix: flaky PCES test by @cody-littley in https://github.com/hashgraph/hedera-services/pull/12643
* * fix: support receipt/record queries with nonce by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/12653
* * fix: catch and translate `EthTxSigs` IAE by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/12624
* * fix: don't directly throttle unsupported/privileged transactions by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/12547
* * fix: Cherry-pick: Allow scheduled transactions to have preceding transactions by @netopyr in https://github.com/hashgraph/hedera-services/pull/12634
* * fix: (cherry-pick) Add fees for ContractCallLocalHandler by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/12663
* * fix: (cherry-pick) Fixes response code when failing in HbarChangesStep with customFees by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/12599
* * refactor: use new test utility for Orphan Buffer tests by @alittley in https://github.com/hashgraph/hedera-services/pull/12650
* * feat: state garbage collector by @cody-littley in https://github.com/hashgraph/hedera-services/pull/12542
* * fix: 12247 Remove incorrect assert from `reopenFileChannel` by @imalygin in https://github.com/hashgraph/hedera-services/pull/12665
* * feat: deterministic wiring model by @cody-littley in https://github.com/hashgraph/hedera-services/pull/12604
* * chore: tuned the time to wait for state to be loaded by @tomzhenghedera in https://github.com/hashgraph/hedera-services/pull/12670
* * feat: random builder by @cody-littley in https://github.com/hashgraph/hedera-services/pull/12642
* * fix: compile errors by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/12684
* * fix: 12693: Enhance ReconnectBench to reconnect merkle trees with multiple virtual maps by @artemananiev in https://github.com/hashgraph/hedera-services/pull/12695
* * fix: Cherry-pick: Return NOT_SUPPORTED in assertThrottlingPreconditions() by @netopyr in https://github.com/hashgraph/hedera-services/pull/12676
* * feat: 11224 platform-base example app by @mxtartaglia-sl in https://github.com/hashgraph/hedera-services/pull/11408
* * fix: use exact math for all summed balances by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/12669
* * fix: cherry-pick: fixed diff test issue 12615 (#12691) by @iwsimon in https://github.com/hashgraph/hedera-services/pull/12701
* * ci: disable release 0.47 regression by @JeffreyDallas in https://github.com/hashgraph/hedera-services/pull/12608
* * fix: 12609: Merkle synchronization tests take too long for no obvious reason [TEST_ONLY] by @artemananiev in https://github.com/hashgraph/hedera-services/pull/12618
* * refactor: Use `TestingEventBuilder` in `InOrderLinkerTests` by @alittley in https://github.com/hashgraph/hedera-services/pull/12683
* * feat: componetize event signing by @cody-littley in https://github.com/hashgraph/hedera-services/pull/12655
* * fix: Add EETs and pureChecks in few handlers by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/12696
* * feat: Create utility for validating TLS certificates  by @kfa-aguda in https://github.com/hashgraph/hedera-services/pull/12265
* * feat(pbj): upgrade PBJ dependency to v0.8.5 to default repeated field… by @anthony-swirldslabs in https://github.com/hashgraph/hedera-services/pull/12605
* * chore: Cherry-pick: Improve HAPI test to contain only checked error by @netopyr in https://github.com/hashgraph/hedera-services/pull/12729
* * refactor: Delete unused platform interfaces by @alittley in https://github.com/hashgraph/hedera-services/pull/12708
* * test: Improvements to smart contract specs related to aliases by @victor-yanev in https://github.com/hashgraph/hedera-services/pull/12493
* * feat: swirlds-logging changes after jitwatch analysis by @mxtartaglia-sl in https://github.com/hashgraph/hedera-services/pull/12478
* * chore: NonAncientEventWindow to EventWindow by @cody-littley in https://github.com/hashgraph/hedera-services/pull/12614
* * refactor: Use TestingEventBuilder in ConsensusRoundHandlerTests by @alittley in https://github.com/hashgraph/hedera-services/pull/12741
* * fix: marking states to be saved by @cody-littley in https://github.com/hashgraph/hedera-services/pull/12674
* * fix: PCES test flake by @cody-littley in https://github.com/hashgraph/hedera-services/pull/12735
* * fix: (cherry-pick) Fix schedules during replay (#12585) by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/12716
* * docs: document test plan for green wire. by @edward-swirldslabs in https://github.com/hashgraph/hedera-services/pull/11784
* * fix: cherry-pick: fixed diff test issue #12699 (#12737) by @iwsimon in https://github.com/hashgraph/hedera-services/pull/12747
* * fix: 11507 Enabled logging exceptions processed by StandardWorkGroup into System.err. by @imalygin in https://github.com/hashgraph/hedera-services/pull/12262
* * chore: Cherry-pick: Implement un-HAPI tests for TokenAssociateToAccountHandler by @netopyr in https://github.com/hashgraph/hedera-services/pull/12730
* * chore: refactoring of base sample by @hendrikebbers in https://github.com/hashgraph/hedera-services/pull/12740
* * chore: refactor transactions by @lpetrovic05 in https://github.com/hashgraph/hedera-services/pull/12554
* * chore: fix compile issue by @lpetrovic05 in https://github.com/hashgraph/hedera-services/pull/12767
* * feat: proxy orphan buffer wiring by @cody-littley in https://github.com/hashgraph/hedera-services/pull/12706
* * perf: Cherry-pick: reduced warmup overhead #11915;  warm treasury account for token transfer by @netopyr in https://github.com/hashgraph/hedera-services/pull/12765
* * feat: stand alone running event hash by @cody-littley in https://github.com/hashgraph/hedera-services/pull/12744
* * fix: (cherry-pick) Allow aliases only in CryptoTransfer by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/12764
* * feat: better event creator wiring by @cody-littley in https://github.com/hashgraph/hedera-services/pull/12749
* * feat: improve in order linker wiring by @cody-littley in https://github.com/hashgraph/hedera-services/pull/12771
* * feat: improve consensus engine wiring by @cody-littley in https://github.com/hashgraph/hedera-services/pull/12783
* * fix: remove admin key as defaultSigner for HapiTokenUpdate by @petreze in https://github.com/hashgraph/hedera-services/pull/12396
* * feat: 8344: Drop JDB format support in MerkleDb by @artemananiev in https://github.com/hashgraph/hedera-services/pull/12582
* * feat: allow the deterministic deployment proxy contract transaction to succeed by @lukelee-sl in https://github.com/hashgraph/hedera-services/pull/12713
* * feat(cancun): Establish Cancun EVM module by @david-bakin-sl in https://github.com/hashgraph/hedera-services/pull/12371
* * chore: Add test for validating aliases in token operations by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/12812
* * feat: wire routers by @cody-littley in https://github.com/hashgraph/hedera-services/pull/12781
* * feat: improve performance of tlsPeerIdentifier to O(1) by @kfa-aguda in https://github.com/hashgraph/hedera-services/pull/12751
* * fix: make pureChecks required in all handlers (#12578) by @kimbor in https://github.com/hashgraph/hedera-services/pull/12756
* * refactor: Rework `EventDeduplicator` and `TransactionPrehandler` tests by @alittley in https://github.com/hashgraph/hedera-services/pull/12778
* * feat(cancun): EIP-6780 SELFDESTRUCT semantics by @david-bakin-sl in https://github.com/hashgraph/hedera-services/pull/12686
* * feat(cancun): Enable Cancun EVM (module v0.50) by @david-bakin-sl in https://github.com/hashgraph/hedera-services/pull/12762
* * feat: platform writes diagnostic marker files. by @edward-swirldslabs in https://github.com/hashgraph/hedera-services/pull/12635
* * fix: 12311: HalfDiskHashMap: Unknown bucket field 2 by @artemananiev in https://github.com/hashgraph/hedera-services/pull/12845
* * feat: ces off switch by @cody-littley in https://github.com/hashgraph/hedera-services/pull/12795
* * refactor: Delete chatter by @alittley in https://github.com/hashgraph/hedera-services/pull/12743
* * fix: failing SelfDestructSuite using the correct evm version for cancun by @petreze in https://github.com/hashgraph/hedera-services/pull/12849
* * feat: PCES sequencer wiring improvement by @cody-littley in https://github.com/hashgraph/hedera-services/pull/12818
* * chore: documentation of base service pattern by @hendrikebbers in https://github.com/hashgraph/hedera-services/pull/12814
* * test: 11676 fuzzy tests for hollow accounts by @kselveliev in https://github.com/hashgraph/hedera-services/pull/12253
* * chore: cherry-pick: updated pureChecks(), refactored some code in consensus services by @iwsimon in https://github.com/hashgraph/hedera-services/pull/12860
* * chore: Add github actions for uploading junit test reports as artifacts by @yaroslav-007 in https://github.com/hashgraph/hedera-services/pull/12393
* * chore: Improvements to swirlds base example project by @mxtartaglia-sl in https://github.com/hashgraph/hedera-services/pull/12861
* * chore: Base executor observer by @hendrikebbers in https://github.com/hashgraph/hedera-services/pull/12242
* * chore: Executor factory for the platform by @hendrikebbers in https://github.com/hashgraph/hedera-services/pull/11818
* * fix: Update weights of newly added nodes in `updateWeight` (#12841) by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/12871
* * fix: unit test marker file writing collision by @edward-swirldslabs in https://github.com/hashgraph/hedera-services/pull/12859
* * feat: Implement new random test utility by @alittley in https://github.com/hashgraph/hedera-services/pull/12856
* * chore: 12862 Added null checks to  Hash.serialize and Hash.deserialize by @imalygin in https://github.com/hashgraph/hedera-services/pull/12863
* * chore: start using protobuf state signature payload by @lpetrovic05 in https://github.com/hashgraph/hedera-services/pull/12846
* * feat: 12226 flush task for swirlds-log by @mxtartaglia-sl in https://github.com/hashgraph/hedera-services/pull/12821
* * feat: Reloadable TLSFactory to support dynamic addressbook by @kfa-aguda in https://github.com/hashgraph/hedera-services/pull/12377
* * feat(build): fail if Gradle is started with Java 20 or older by @anthony-swirldslabs in https://github.com/hashgraph/hedera-services/pull/12780
* * chore: Enable smart contract team to approve tests by @netopyr in https://github.com/hashgraph/hedera-services/pull/12893
* * perf: Cherry-pick: synchronous signature verification by @netopyr in https://github.com/hashgraph/hedera-services/pull/12887
* * fix: (cherry-pick) update versions to 0.49 (#12819) by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/12892
* * feat: wait for round durability using wiring framework by @cody-littley in https://github.com/hashgraph/hedera-services/pull/12854
* * fix: Cherry-pick: Better handling of fatal errors in handle workflow by @netopyr in https://github.com/hashgraph/hedera-services/pull/12886
* * chore: Delete SimpleEvent by @alittley in https://github.com/hashgraph/hedera-services/pull/12899
* * feat: 12414 remove tcpfactory by @kfa-aguda in https://github.com/hashgraph/hedera-services/pull/12896
* * feat: internal call against PRNG returns success instead of invalid fee submitted by @natanasow in https://github.com/hashgraph/hedera-services/pull/12793
* * fix: Transferring tokens with HTS precompile to system accounts between 0.0.350 and 0.0.361 returns INVALID_ALIAS_KEY by @stefan-stefanooov in https://github.com/hashgraph/hedera-services/pull/11643
* * chore: Metrics for Base Executor by @hendrikebbers in https://github.com/hashgraph/hedera-services/pull/12788
* * refactor: Remove BaseEvent by @alittley in https://github.com/hashgraph/hedera-services/pull/12877
* * refactor: Remove epochHash field access by @alittley in https://github.com/hashgraph/hedera-services/pull/12923
* * feat: auto-resubmit operations with modifications by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/12811
* * feat: turn on atomic crypto transfer in preprod and previewnet by @lukelee-sl in https://github.com/hashgraph/hedera-services/pull/12830
* * test: add additional tests for custom fees with hollow account collector by @fchitakova in https://github.com/hashgraph/hedera-services/pull/12769
* * fix: contractCalls to etheretumContractCalls NPE by @vtronkov in https://github.com/hashgraph/hedera-services/pull/12832
* * fix: consensus writes marker before exception by @edward-swirldslabs in https://github.com/hashgraph/hedera-services/pull/12928
* * fix: wiring test flake by @cody-littley in https://github.com/hashgraph/hedera-services/pull/12925
* * feat: Modify protobuf setup by @alittley in https://github.com/hashgraph/hedera-services/pull/12932
* * fix(PBJ): upgrade to PBJ v0.8.7 to address bugs by @anthony-swirldslabs in https://github.com/hashgraph/hedera-services/pull/12939
* * feat(reconnect): add duration metrics by @anthony-swirldslabs in https://github.com/hashgraph/hedera-services/pull/12759
* * feat: prehandle wiring improvements by @cody-littley in https://github.com/hashgraph/hedera-services/pull/12930
* * fix: implement `updateWeight()` without States API by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/12941
* * feat: pces wiring improvement by @cody-littley in https://github.com/hashgraph/hedera-services/pull/12920
* * fix: misc EET expectations by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/12966
* * refactor: Point back to protobuf main branch by @alittley in https://github.com/hashgraph/hedera-services/pull/12963
* * fix(cancun): HAPI test `deletedContractsCannotBeUpdated` fails by @david-bakin-sl in https://github.com/hashgraph/hedera-services/pull/12946
* * docs: Add documentation for the differences in the operations with system accounts by @bilyana-gospodinova in https://github.com/hashgraph/hedera-services/pull/12328
* * chore: remove event stream cli commands by @lpetrovic05 in https://github.com/hashgraph/hedera-services/pull/12951
* * chore: delete TimeoutStreamExtension by @cody-littley in https://github.com/hashgraph/hedera-services/pull/12969
* * chore: apps start using protobuf payloads by @lpetrovic05 in https://github.com/hashgraph/hedera-services/pull/12884
* * fix: write marker file on consensus exception by @edward-swirldslabs in https://github.com/hashgraph/hedera-services/pull/12955
* * refactor: Remove `PlatformEvent` by @alittley in https://github.com/hashgraph/hedera-services/pull/12961
* * fix: Enable aliases in TokenWipe as per mono service (#12967) by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/12974
* * chore: 11772 Refactored `AddressBook` - it's no longer a `MerkleLeaf` by @imalygin in https://github.com/hashgraph/hedera-services/pull/12908
* * test: Improvements to assertions on sidecar files by @victor-yanev in https://github.com/hashgraph/hedera-services/pull/12678
* * chore: Update version on develop to 0.50.0 by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/12983
* * fix: hapi test expectations by @kimbor in https://github.com/hashgraph/hedera-services/pull/12986
* * fix: Cherry Pick of #12905 (double-count child staking rewards) by @mhess-swl in https://github.com/hashgraph/hedera-services/pull/12965
* * chore: delete ThreadDumpGenerator by @cody-littley in https://github.com/hashgraph/hedera-services/pull/12972
* * refactor: Proxy Wiring for Signed State Sentinel by @edward-swirldslabs in https://github.com/hashgraph/hedera-services/pull/12843
* * fix: refactor pure checks smart contracts network admin by @kimbor in https://github.com/hashgraph/hedera-services/pull/12909
* * feat: more precisely calculate tinybar gas price for deterministic deployment contract by @lukelee-sl in https://github.com/hashgraph/hedera-services/pull/12844
* * feat: Componetize platform status by @alittley in https://github.com/hashgraph/hedera-services/pull/12964
* * test: Add Completed Hollow Account fuzzy tests by @0xivanov in https://github.com/hashgraph/hedera-services/pull/12123
* * feat(cancun): Upgrade `GasCalculator` to Cancun and also take latest Besu EVM client by @david-bakin-sl in https://github.com/hashgraph/hedera-services/pull/12995
* * test: add negative tests for transferNFT, transferNFTs, transferToken, transferTokens by @MrValioBg in https://github.com/hashgraph/hedera-services/pull/12593
* * feat: FileSystemManager by @mxtartaglia-sl in https://github.com/hashgraph/hedera-services/pull/12692
* * docs: add design document for HIP-904 maxAutoAssociations changes by @MiroslavGatsanoga in https://github.com/hashgraph/hedera-services/pull/12785
* * perf: warm up more entities by @OlegMazurov in https://github.com/hashgraph/hedera-services/pull/13005
* * fix: Fix config bug by @alittley in https://github.com/hashgraph/hedera-services/pull/13018
* * feat: Update hapi version in use by services to 0.50 by @kimbor in https://github.com/hashgraph/hedera-services/pull/13022
* * fix: use `targeted_address` for action sidecar call to missing address by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/12977
* * fix: storage link migration and management by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/13038
* * fix: 12950 Enhance error report on ConfigData annotation processing by @mxtartaglia-sl in https://github.com/hashgraph/hedera-services/pull/12960
* * chore: remove legacy event serialization by @lpetrovic05 in https://github.com/hashgraph/hedera-services/pull/12999
* * fix: storage link mgmt with multiple inserts by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/13055
* * fix: Add check for parent's existence when checking delegate call by @lukelee-sl in https://github.com/hashgraph/hedera-services/pull/13013
* * feat: simplify platform interfaces by @cody-littley in https://github.com/hashgraph/hedera-services/pull/13075
* * build: support 'tags' in 'cloneHederaProtobufs' by @jjohannes in https://github.com/hashgraph/hedera-services/pull/13051
* * chore: swirlds-logging rolling max-files property name change by @mxtartaglia-sl in https://github.com/hashgraph/hedera-services/pull/12889
* * fix: midnight rate management on restart by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/13071
* * feat: cleaner ISS detector wiring by @cody-littley in https://github.com/hashgraph/hedera-services/pull/13067
* * feat: add `htsCallWithInsufficientGasHasNoStateChanges()` test by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/13045
* * feat: HIP-540 full implementation by @petreze in https://github.com/hashgraph/hedera-services/pull/12736
* * chore: Update default fees to a constant value (#13044) by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/13047
* * fix: Cherry-pick: Avoid catastrophic failure for too large transactions (#13029) by @netopyr in https://github.com/hashgraph/hedera-services/pull/13079
* * fix: Cherry pick: remove gas cost check (#13031) by @netopyr in https://github.com/hashgraph/hedera-services/pull/13078
* * chore: update release branch creation schedule for 0.50 by @kimbor in https://github.com/hashgraph/hedera-services/pull/13095
* * fix: (cherry-pick) Ignore token expiry status in TokenDissociate by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/13114
* * fix: (cherry pick) Enhance purechecks for CryptoGetAccountBalanceHandler (#12839) into release 50 by @thomas-swirlds-labs in https://github.com/hashgraph/hedera-services/pull/13171
* * fix: (cherry pick) feat: Enhance purechecks for CryptoCreateHandler (#12797) into release/0.50 by @thomas-swirlds-labs in https://github.com/hashgraph/hedera-services/pull/13170
* * fix: use civilian payer for modified variants  by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/13121
* * fix: revert ces name by @cody-littley in https://github.com/hashgraph/hedera-services/pull/13200
* * fix: stabilize `SysDelSysUndelSpec` by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/13289
* * fix: use mainnet `throttles.json` for testnet by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/13298
* * feat(cancun): Finish HIP-866 non-support for Cancun blobs (#13178) by @david-bakin-sl in https://github.com/hashgraph/hedera-services/pull/13211
* * fix: revert recycle-bin store location (#13339) by @mxtartaglia-sl in https://github.com/hashgraph/hedera-services/pull/13366
* * fix: 13128: Backport the fix for #12853 to release 0.50 by @artemananiev in https://github.com/hashgraph/hedera-services/pull/13130
* * fix: (Cherry-pick) Fix records for dissociating deleted tokens by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/13408
* * fix: (cherry pick) TokenInfo single field update via contract calls by @mustafauzunn in https://github.com/hashgraph/hedera-services/pull/13369
* * fix: (cherry-pick) Fix record for treasury update by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/13417
* * chore: disable the running event hasher by @cody-littley in https://github.com/hashgraph/hedera-services/pull/13434
* * fix: unbind gRPC server from previous `daggerApp` by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/13513
* * fix: only clear memo if the original `TokenUpdate` is HAPI, allow `ContractID.DEFAULT` by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/13442
* * fix: support crypto admin keys in system contract `tokenCreate()`  by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/13149
* * chore: Cherry pick 13520 by @lukelee-sl in https://github.com/hashgraph/hedera-services/pull/13528
* * fix: Fix NPE in `QueryWorkflowImpl` (#13541) by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/13550
* * chore: 13519 cherry pick wave file append sign by @povolev15 in https://github.com/hashgraph/hedera-services/pull/13555
* * fix: increase capacity for the event creation manager's queue by @cody-littley in https://github.com/hashgraph/hedera-services/pull/13577
* * chore: disable idVariantsTreatedAsExpected spec by @lukelee-sl in https://github.com/hashgraph/hedera-services/pull/13592
* * fix: cherry-pick: Skip transactions older than the software version (#13527) by @mhess-swl in https://github.com/hashgraph/hedera-services/pull/13563
* * fix: remove pointless `WARN` logs, fix first contract key management by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/13553
* * fix: add migrations to repair storage links by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/13595
* * perf: cherry-pick: HapiUtils.parsedIntOrZero() throws too many exceptions by @OlegMazurov in https://github.com/hashgraph/hedera-services/pull/13609
* * fix: 13610: Backport the fix for 13584 to 0.50 by @artemananiev in https://github.com/hashgraph/hedera-services/pull/13611
* ## New Contributors
* * @nickeynikolovv made their first contribution in https://github.com/hashgraph/hedera-services/pull/11072
* * @tomzhenghedera made their first contribution in https://github.com/hashgraph/hedera-services/pull/12206
* * @victor-yanev made their first contribution in https://github.com/hashgraph/hedera-services/pull/12493
* * @kselveliev made their first contribution in https://github.com/hashgraph/hedera-services/pull/12253
* * @yaroslav-007 made their first contribution in https://github.com/hashgraph/hedera-services/pull/12393
* **Full Changelog**: https://github.com/hashgraph/hedera-services/compare/v0.49.7...v0.50.0

**Full Changelog**: [v0.50.0...v0.50.0](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.50.0...v0.50.0)

</details>

## Release v0.49

### [Build v0.49.7](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.49.7)

<details>
<summary><strong>What's Changed</strong></summary>

* * fix: support crypto admin keys in system contract `tokenCreate()` by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/13148
* * fix: remove balance adjustment limit from record in state, use `0` for initial gas snapshot by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/13185
* **Full Changelog**: https://github.com/hashgraph/hedera-services/compare/v0.49.6...v0.49.7

**Full Changelog**: [v0.49.0...v0.49.7](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.49.0...v0.49.7)

</details>

### [Build v0.49.6](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.49.6)

<details>
<summary><strong>What's Changed</strong></summary>

* * fix: cherry-pick midnight rate management on restart (#13071) by @povolev15 in https://github.com/hashgraph/hedera-services/pull/13091
* * feat: auto-resubmit operations with modifications (#12811) by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/13088
* * fix: ignore token expiry status in `TokenDissociate`  by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/13106
* * fix: avoid NPE when migrating from genesis (non-prod) state by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/13123
* **Full Changelog**: https://github.com/hashgraph/hedera-services/compare/v0.49.5...v0.49.6

**Full Changelog**: [v0.49.0...v0.49.6](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.49.0...v0.49.6)

</details>

### [Build v0.49.5](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.49.5)

<details>
<summary><strong>What's Changed</strong></summary>

* * fix: storage link management by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/13056
* **Full Changelog**: https://github.com/hashgraph/hedera-services/compare/v0.49.4...v0.49.5

**Full Changelog**: [v0.49.0...v0.49.5](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.49.0...v0.49.5)

</details>

### [Build v0.49.1](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.49.1)

<details>
<summary><strong>What's Changed</strong></summary>

* * fix: manage `StakingInfos` in restart by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/12911
* **Full Changelog**: https://github.com/hashgraph/hedera-services/compare/v0.49.0...v0.49.1

**Full Changelog**: [v0.49.0...v0.49.1](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.49.0...v0.49.1)

</details>

### [Build v0.49.0](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.49.0)

<details>
<summary><strong>What's Changed</strong></summary>

* * chore: Update throttles.json by @rbair23 in https://github.com/hashgraph/hedera-services/pull/11339
* * feat: address cold read issue in ExtCodeHash operation by @lukelee-sl in https://github.com/hashgraph/hedera-services/pull/11323
* * fix: 11348: The fix for 11231 doesn't cover ParsedBucket by @artemananiev in https://github.com/hashgraph/hedera-services/pull/11349
* * chore: Create ISS detector component by @lpetrovic05 in https://github.com/hashgraph/hedera-services/pull/11075
* * chore: Add `orderedSolderTo` method to OutputWire by @poulok in https://github.com/hashgraph/hedera-services/pull/11330
* * chore: remove hashgraph demo by @lpetrovic05 in https://github.com/hashgraph/hedera-services/pull/11352
* * feat: Migrate transaction handling to framework by @alittley in https://github.com/hashgraph/hedera-services/pull/11144
* * fix: broken unit test by @kfa-aguda in https://github.com/hashgraph/hedera-services/pull/11233
* * fix: Return invalid token even if expected decimals are present by @mhess-swl in https://github.com/hashgraph/hedera-services/pull/11342
* * fix: 11298: VirtualMapReconnectTest fails intermittently with path not in range log message by @artemananiev in https://github.com/hashgraph/hedera-services/pull/11370
* * fix: 10315 halt on wrong token type (ERCPrecompileSuite fuzzy match) by @JivkoKelchev in https://github.com/hashgraph/hedera-services/pull/11164
* * fix: Modify where components look to indicate overloaded intake by @alittley in https://github.com/hashgraph/hedera-services/pull/11369
* * feat: enable fuzzy record matching for `TokenUpdatePrecompileSuite` by @georgi-l95 in https://github.com/hashgraph/hedera-services/pull/11008
* * fix: token associations modular dumper by @petreze in https://github.com/hashgraph/hedera-services/pull/11242
* * chore: Update PBJ dependency by @netopyr in https://github.com/hashgraph/hedera-services/pull/11397
* * chore: add `-l` option to diff limited interval sizes by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/11361
* * chore: Update protobuf version on develop by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/11355
* * chore: reload config from saved state by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/11341
* * fix: matching the signature for NonFungibleTokenInfo and FungibleTokenInfo on failure by @mustafauzunn in https://github.com/hashgraph/hedera-services/pull/11133
* * chore: Merkle test fixtures moved by @hendrikebbers in https://github.com/hashgraph/hedera-services/pull/11382
* * perf: Warm tokens as they are also on-disk now by @netopyr in https://github.com/hashgraph/hedera-services/pull/11412
* * perf: Evaluate logging parameters only when needed by @netopyr in https://github.com/hashgraph/hedera-services/pull/11413
* * fix: Fix generated metric names by @netopyr in https://github.com/hashgraph/hedera-services/pull/11423
* * fix: 11391adapting DurationGauge naming to conventions by @mxtartaglia-sl in https://github.com/hashgraph/hedera-services/pull/11416
* * feat: address account nonce discrepancies mono by @natanasow in https://github.com/hashgraph/hedera-services/pull/11045
* * fix: revert changes from enabling fuzzy matching for TokenUpdatePrecompileSuite by @georgi-l95 in https://github.com/hashgraph/hedera-services/pull/11419
* * chore: move RandomAddressBookGenerator from swirlds-common to swirlds-platform-core by @edward-swirldslabs in https://github.com/hashgraph/hedera-services/pull/11428
* * fix: transaction fee in record for mono code by @povolev15 in https://github.com/hashgraph/hedera-services/pull/11434
* * fix: 10904 Log catastrophic failures during ingest  by @thomas-swirlds-labs in https://github.com/hashgraph/hedera-services/pull/11415
* * feat: Implement task scheduler squelching by @alittley in https://github.com/hashgraph/hedera-services/pull/11398
* * feat: Check platform status before syncing by @alittley in https://github.com/hashgraph/hedera-services/pull/11429
* * test: Create hapi tests for transfer and send operations for system accounts Part 1 by @0xivanov in https://github.com/hashgraph/hedera-services/pull/11359
* * fix: 11328 Optimized `DataFileReaderPbj.leaseFileChannel` method  by @imalygin in https://github.com/hashgraph/hedera-services/pull/11331
* * fix: contracts.evm.allowCallsToNonContractAccounts flag misbehaviour by @thenswan in https://github.com/hashgraph/hedera-services/pull/11244
* * fix: static call with selfdestruct to system account between 0.0.751 and 0.0.999 results in FAIL_INVALID by @natanasow in https://github.com/hashgraph/hedera-services/pull/11243
* * fix: 11298: VirtualMapReconnectTest fails intermittently with path not in range log message by @artemananiev in https://github.com/hashgraph/hedera-services/pull/11435
* * refactor: gossip birth round by @cody-littley in https://github.com/hashgraph/hedera-services/pull/11149
* * fix: Fix service names for metrics by @netopyr in https://github.com/hashgraph/hedera-services/pull/11456
* * refactor: EventSignatureValidator uses AncientMode by @edward-swirldslabs in https://github.com/hashgraph/hedera-services/pull/11433
* * fix: fixed diff test, ContractCall has status: CONSENSUS_GAS_EXHAUSTED by @iwsimon in https://github.com/hashgraph/hedera-services/pull/11457
* * fix: SignedStateFileManagerTests  by @lpetrovic05 in https://github.com/hashgraph/hedera-services/pull/11468
* * chore: migrate per node pending rewards by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/11381
* * fix: Increase wait for squelch test assertion by @alittley in https://github.com/hashgraph/hedera-services/pull/11461
* * build: re-enable running timing sensitive tests on CI by @jjohannes in https://github.com/hashgraph/hedera-services/pull/11444
* * feat: Integrate Validations in HAPI tests by @thenswan in https://github.com/hashgraph/hedera-services/pull/10944
* * fix: mark scheduler tests as timing sensitive by @cody-littley in https://github.com/hashgraph/hedera-services/pull/11470
* * fix: 11472 Added @Tag(TIMING_SENSITIVE) to the tests to stabilize the test pipeline. by @imalygin in https://github.com/hashgraph/hedera-services/pull/11475
* * fix: revert gossip birth round refactor by @cody-littley in https://github.com/hashgraph/hedera-services/pull/11482
* * chore: add debug info by @lpetrovic05 in https://github.com/hashgraph/hedera-services/pull/11473
* * fix: Enable tests from Issue2319Spec by @Ivo-Yankov in https://github.com/hashgraph/hedera-services/pull/10975
* * test: 11134 -  Create hapi tests for extCode operations for system accounts by @0xivanov in https://github.com/hashgraph/hedera-services/pull/11278
* * fix: 11496 Temporary disabled `VirtualPipelineTests.flushThrottle`  by @imalygin in https://github.com/hashgraph/hedera-services/pull/11497
* * build: add back '-XX:ActiveProcessorCount=6' to 'eet' by @jjohannes in https://github.com/hashgraph/hedera-services/pull/11483
* * build: Gradle update and QoL improvements by @jjohannes in https://github.com/hashgraph/hedera-services/pull/11443
* * fix: state sent to be saved twice by @lpetrovic05 in https://github.com/hashgraph/hedera-services/pull/11488
* * chore: use shorter contract names by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/11491
* * fix: check throttle usage on committing changes  by @petreze in https://github.com/hashgraph/hedera-services/pull/11064
* * fix: Migration only sets node ID under specific condition by @mhess-swl in https://github.com/hashgraph/hedera-services/pull/11485
* * feat: scheduled txs mono signed state dumper by @dikel in https://github.com/hashgraph/hedera-services/pull/11390
* * feat: Address stores X509Certificate by @edward-swirldslabs in https://github.com/hashgraph/hedera-services/pull/11318
* * refactor: EventCreator compatible with AncientMode by @edward-swirldslabs in https://github.com/hashgraph/hedera-services/pull/11499
* * fix: 11507 Temporary disabled tests to stabilize pipeline by @imalygin in https://github.com/hashgraph/hedera-services/pull/11509
* * feat: 11347: introduce ReconnectHalfMillionNodesBench by @anthony-swirldslabs in https://github.com/hashgraph/hedera-services/pull/11487
* * chore: fix yahcli build, `activate-staking` bug by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/11501
* * fix: fixed IndexOutOfBoundsException by @iwsimon in https://github.com/hashgraph/hedera-services/pull/11493
* * chore: remove files with long names by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/11512
* * fix: 11320: Use num sigs instead of num keys in token mint fee by @mhess-swl in https://github.com/hashgraph/hedera-services/pull/11464
* * fix: rbs calculation in modularize code by @povolev15 in https://github.com/hashgraph/hedera-services/pull/11518
* * feat: Enhance storage (file) store dumper to handle modular representation by @vtronkov in https://github.com/hashgraph/hedera-services/pull/11385
* * fix: Improvements for ConcurrentTestSupport by @hendrikebbers in https://github.com/hashgraph/hedera-services/pull/11276
* * fix: 11507 Temporary disabled a test  by @imalygin in https://github.com/hashgraph/hedera-services/pull/11517
* * fix: Enable fuzzy matching for ApproveAllowanceSuite by @Ivo-Yankov in https://github.com/hashgraph/hedera-services/pull/10787
* * feat: use ordered soldering for PCES flush requests by @alittley in https://github.com/hashgraph/hedera-services/pull/11451
* * chore: Add NotNull/Nullable annotations to Metrics module by @mxtartaglia-sl in https://github.com/hashgraph/hedera-services/pull/11532
* * fix: Enable fuzzy matching for HRCPrecompileSuite by @stoyanov-st in https://github.com/hashgraph/hedera-services/pull/11032
* * refactor: return AddressBook from AddressBookRoster by @edward-swirldslabs in https://github.com/hashgraph/hedera-services/pull/11511
* * chore: remove event observer dispatcher by @alittley in https://github.com/hashgraph/hedera-services/pull/11449
* * feat: Create new status panel, and add to existing dashboards by @alittley in https://github.com/hashgraph/hedera-services/pull/11533
* * fix: Nonce Discrepancies in Modularization by @Ivo-Yankov in https://github.com/hashgraph/hedera-services/pull/11074
* * fix: 11540-ConcurrentTestSupportTest by @mxtartaglia-sl in https://github.com/hashgraph/hedera-services/pull/11541
* * fix: reduce sync permit count by @cody-littley in https://github.com/hashgraph/hedera-services/pull/11545
* * fix: make verifyAsync() a passthrough method to the executor service by @cody-littley in https://github.com/hashgraph/hedera-services/pull/11547
* * build: add new Gradle modules for the block node by @nathanklick in https://github.com/hashgraph/hedera-services/pull/11552
* * test: add `revertedAutoCreationRollsBackEvenIfTopLevelSucceeds` to `LazyCreateThroughPrecompileSuite` and enable fuzzy-matching on it by @thenswan in https://github.com/hashgraph/hedera-services/pull/11131
* * fix: add legacy etx support before EIP155 by @petreze in https://github.com/hashgraph/hedera-services/pull/11504
* * fix: fee charge token create tx and also transaction hashing by @povolev15 in https://github.com/hashgraph/hedera-services/pull/11562
* * fix: conditional records hollow account creation via internal transfer with max child records exceeded by @MiroslavGatsanoga in https://github.com/hashgraph/hedera-services/pull/10631
* * chore: Allow multiple logging handlers of the same type by @timo0 in https://github.com/hashgraph/hedera-services/pull/11466
* * fix: Save freeze states immediately by @alittley in https://github.com/hashgraph/hedera-services/pull/11528
* * fix: 10506 fuzzy match lazy create precompile by @JivkoKelchev in https://github.com/hashgraph/hedera-services/pull/11465
* * fix: 11498 Fix MapTest. by @imalygin in https://github.com/hashgraph/hedera-services/pull/11500
* * chore: Rename `LinkedEventIntake` to `ConsensusEngine` by @alittley in https://github.com/hashgraph/hedera-services/pull/11548
* * fix: 11496 Rewrote `testFlushBackpressure`. by @imalygin in https://github.com/hashgraph/hedera-services/pull/11536
* * fix: Specify transfer precedence to match mono behavior by @mhess-swl in https://github.com/hashgraph/hedera-services/pull/11577
* * chore: tune checkstyle config by @nathanklick in https://github.com/hashgraph/hedera-services/pull/11594
* * chore: resolve check style detections in the swirlds-base module by @nathanklick in https://github.com/hashgraph/hedera-services/pull/11595
* * chore: resolve check style detections in the swirlds-config-api module by @nathanklick in https://github.com/hashgraph/hedera-services/pull/11596
* * chore: resolve check style detections in the swirlds-config-extensions module by @nathanklick in https://github.com/hashgraph/hedera-services/pull/11597
* * chore: resolve check style detections in the swirlds-config-impl module by @nathanklick in https://github.com/hashgraph/hedera-services/pull/11598
* * chore: add debug info to PTT by @lpetrovic05 in https://github.com/hashgraph/hedera-services/pull/11580
* * fix: reset event creator as part of reconnect cleanup by @cody-littley in https://github.com/hashgraph/hedera-services/pull/11463
* * fix: fallen behind detection by @cody-littley in https://github.com/hashgraph/hedera-services/pull/11480
* * chore: cleanup event building and mocking in tests by @lpetrovic05 in https://github.com/hashgraph/hedera-services/pull/11579
* * chore: match mono-service `contractCallResult`/`contractID` externalization by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/11578
* * feat: Add metrics that measure the duration for each transaction type by @netopyr in https://github.com/hashgraph/hedera-services/pull/11606
* * feat: add a service integration test to PR checks by @JeffreyDallas in https://github.com/hashgraph/hedera-services/pull/11519
* * chore: rename DIRECT_STATELESS to DIRECT_THREADSAFE by @alittley in https://github.com/hashgraph/hedera-services/pull/11587
* * chore: resolve check style detections in the hapi-utils module by @nathanklick in https://github.com/hashgraph/hedera-services/pull/11600
* * fix: update version of commons-compress external dependency by @alittley in https://github.com/hashgraph/hedera-services/pull/11656
* * fix: only compare child time created against self parent time created by @alittley in https://github.com/hashgraph/hedera-services/pull/11668
* * feat: Add file handler by @timo0 in https://github.com/hashgraph/hedera-services/pull/11584
* * fix: fixed diff test issue 11522 by @iwsimon in https://github.com/hashgraph/hedera-services/pull/11592
* * feat: use direct scheduler when soldering directly to consumer by @alittley in https://github.com/hashgraph/hedera-services/pull/11628
* * chore: Remove postgres comments by @poulok in https://github.com/hashgraph/hedera-services/pull/11661
* * chore: 11615 add log statement when snapshot is inconsistent with init info by @mxtartaglia-sl in https://github.com/hashgraph/hedera-services/pull/11631
* * feat: #10899 Componentize Hash Logger by @kfa-aguda in https://github.com/hashgraph/hedera-services/pull/11379
* * fix: Handle more modular records than mono records in RcDiff by @iwsimon in https://github.com/hashgraph/hedera-services/pull/11682
* * chore: update migration test state by @cody-littley in https://github.com/hashgraph/hedera-services/pull/11634
* * feat: diagram tweaks by @cody-littley in https://github.com/hashgraph/hedera-services/pull/11649
* * fix: mark count up latch tests as timing sensitive by @cody-littley in https://github.com/hashgraph/hedera-services/pull/11654
* * chore: fix differences from 15 min post round 162559605 by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/11639
* * fix: Use an alias payer account to submit a transaction should be rejected. by @iwsimon in https://github.com/hashgraph/hedera-services/pull/11669
* * fix: 11304: Unit Test Failure: VirtualMapHashingTest#fullLeavesRehash fails intermittently by @artemananiev in https://github.com/hashgraph/hedera-services/pull/11660
* * chore: use safest `fromPbj()` translation approach for PBJ `CustomFee` objects by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/11617
* * ci: disable regression tests for release 0.46 by @JeffreyDallas in https://github.com/hashgraph/hedera-services/pull/11663
* * ci: removing sonar related configurations and tasks from gradle and ci workflow by @JeffreyDallas in https://github.com/hashgraph/hedera-services/pull/11576
* * chore: don't modify an `InMemoryValue#List` in-place by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/11688
* * feat: Componentize App communication component by @kfa-aguda in https://github.com/hashgraph/hedera-services/pull/11586
* * feat: use elk renderer for mermaid diagrams by @alittley in https://github.com/hashgraph/hedera-services/pull/11694
* * feat: 11347: introduce ReconnectBench by @anthony-swirldslabs in https://github.com/hashgraph/hedera-services/pull/11589
* * feat: use real birth rounds by @cody-littley in https://github.com/hashgraph/hedera-services/pull/11563
* * fix: 11715 Properly handle closed `PairedStreams` object by @imalygin in https://github.com/hashgraph/hedera-services/pull/11718
* * chore: (mod) ignore `FileAlreadyExistsException` when trying to create a signature file by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/11627
* * fix: print illegal payload messages by @alittley in https://github.com/hashgraph/hedera-services/pull/11719
* * fix: Fix 30 mins diff tests show hundreds of thousands of errors by @iwsimon in https://github.com/hashgraph/hedera-services/pull/11696
* * fix: 11507 Re-enabled previously disabled tests by @imalygin in https://github.com/hashgraph/hedera-services/pull/11638
* * chore: refactor mod `ThrottleService, fix restart ISS by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/11672
* * feat: limit number of events sent during a sync by @cody-littley in https://github.com/hashgraph/hedera-services/pull/11608
* * chore: old style queue by @cody-littley in https://github.com/hashgraph/hedera-services/pull/11686
* * perf: Minor performance improvements by @netopyr in https://github.com/hashgraph/hedera-services/pull/11742
* * fix: (mod) fix alias management by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/11743
* * fix: consensus tests by @lpetrovic05 in https://github.com/hashgraph/hedera-services/pull/11710
* * chore: preserve assessed fees even on insufficient token balances by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/11717
* * feat: rename MinGenInfo to be compatible with birth rounds. by @cody-littley in https://github.com/hashgraph/hedera-services/pull/11721
* * build: Adjust node release for 0.48 branch by @mhess-swl in https://github.com/hashgraph/hedera-services/pull/11775
* * chore: Add README file to explain xTests by @lukelee-sl in https://github.com/hashgraph/hedera-services/pull/11695
* * feat: Add design doc for atomic crypto transfer by @lukelee-sl in https://github.com/hashgraph/hedera-services/pull/11525
* * fix: stop checking for minimum birth round by @cody-littley in https://github.com/hashgraph/hedera-services/pull/11797
* * fix: fix ERC-20 log events and custom fee calculations (#11789) by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/11843
* * fix: fixed diff test issue 11822 by @iwsimon in https://github.com/hashgraph/hedera-services/pull/11848
* * chore: cherry-pick 11823 by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/11855
* * chore: Enable modularization on release branch 0.48 by @netopyr in https://github.com/hashgraph/hedera-services/pull/11906
* * chore: Update release version to match release branch by @mhess-swl in https://github.com/hashgraph/hedera-services/pull/11932
* * chore: Remove explicit fuzzy matching by @netopyr in https://github.com/hashgraph/hedera-services/pull/11939
* * chore: Cherry-pick Fix issues related to upgrade (#11884) by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/11942
* * fix: 11636 VirtualHasher performance improvements (#11787) by @netopyr in https://github.com/hashgraph/hedera-services/pull/11928
* * fix: bug in future event buffer by @cody-littley in https://github.com/hashgraph/hedera-services/pull/11923
* * chore: added unit tests to validateTopLevelAllowances() by @iwsimon in https://github.com/hashgraph/hedera-services/pull/11944
* * fix: fixed diff test issue 11952 by @iwsimon in https://github.com/hashgraph/hedera-services/pull/11965
* * perf: Move remaining in-memory maps on disk (#11974) by @netopyr in https://github.com/hashgraph/hedera-services/pull/11984
* * fix: release/0.48 - Fix throttles error by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/11982
* * fix: use Bytes instead of String for SCHEDULES_BY_EQUALITY_KEY by @kimbor in https://github.com/hashgraph/hedera-services/pull/11995
* * fix: ensure ECDSA `ExpandedSigPair` always has EVM alias by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/12009
* * fix: use `signedTxnBytes` in synthetic creation records by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/12010
* * fix: multiple diff-testing issues by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/12006
* * fix: 12004: Backport the fix for 11996 to release 0.48 by @artemananiev in https://github.com/hashgraph/hedera-services/pull/12005
* * feat(pbj): upgrade PBJ dependency to 0.8.1 by @anthony-swirldslabs in https://github.com/hashgraph/hedera-services/pull/12003
* * chore: Configure maxAggregateRels to 15 million (all envs) by @mhess-swl in https://github.com/hashgraph/hedera-services/pull/12052
* * fix(pbj): stabilize hashCode() for Enums by @anthony-swirldslabs in https://github.com/hashgraph/hedera-services/pull/12070
* * fix: future event buffer bug by @cody-littley in https://github.com/hashgraph/hedera-services/pull/12065
* * fix: 12071: Forwardport the fix for 11964 to release 0.48 by @artemananiev in https://github.com/hashgraph/hedera-services/pull/12072
* * fix(ci): issue with improperly generated artifact file names by @nathanklick in https://github.com/hashgraph/hedera-services/pull/12089
* * feat: Add gasPerConsSec metric by @netopyr in https://github.com/hashgraph/hedera-services/pull/12079
* * fix: (mod-service) Fix a case for identifying `RESTART` scenario by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/12109
* * fix: match mono-service gas throttling by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/12011
* * fix: create sidecar metadata before writing RecordStreamFile footer #12091 by @netopyr in https://github.com/hashgraph/hedera-services/pull/12121
* * fix: wire `HashingOutputStream` into sidecar writing (#12114) by @netopyr in https://github.com/hashgraph/hedera-services/pull/12120
* * feat: (cherry-pick) Metadata HIPs  by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/12149
* * fix: always encode length-2 output for `AllowanceCall` success by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/12136
* * chore: Remove unnecessary deleted flag in `TokenRelation` by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/12187
* * feat: Add maximum entity count metrics by @netopyr in https://github.com/hashgraph/hedera-services/pull/12200
* * fix: Fix `updateWeight` for removed nodes by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/12122
* * chore: Update to use main protobufs branch by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/12198
* * feat: Cherry-pick: Enhance account store dumper to handle modular representation by @netopyr in https://github.com/hashgraph/hedera-services/pull/12213
* * feat: Cherry-pick: Enhance token (type) dumper to handle modular representation by @netopyr in https://github.com/hashgraph/hedera-services/pull/12211
* * feat: Cherry-pick: scheduled txs modularization signed state dumper by @netopyr in https://github.com/hashgraph/hedera-services/pull/12212
* * fix: only migrate non-empty aliases by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/12172
* * fix: (cherry-pick) make `HederaSoftwareVersion` match Services upgrade semantics by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/12230
* * fix: (cherry-pick) `numPositiveBalances` mgmt  by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/12224
* * feat: Cherry Pick: Enhance topics store dumper to handle modular representation by @netopyr in https://github.com/hashgraph/hedera-services/pull/12209
* * fix: cherry-pick: consensus test flake by @netopyr in https://github.com/hashgraph/hedera-services/pull/12219
* * feat: Cherry-pick: Enhance contract bytecode dumper to handle modular representation by @netopyr in https://github.com/hashgraph/hedera-services/pull/12223
* * fix: Cherry-pick: add singleton stores mono and modular representation by @netopyr in https://github.com/hashgraph/hedera-services/pull/12225
* * feat: State dumper final changes (#12092) by @netopyr in https://github.com/hashgraph/hedera-services/pull/12243
* * fix: Implement modular freeze time by @mhess-swl in https://github.com/hashgraph/hedera-services/pull/12261
* * feat: throttle metrics by @netopyr in https://github.com/hashgraph/hedera-services/pull/12254
* * fix: KYC default status is true without KYC key by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/12260
* * fix: set `SUCCESS` status in genesis records (#12038) by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/12306
* * fix: fixed diff test 11885 by @iwsimon in https://github.com/hashgraph/hedera-services/pull/12297
* * fix: (mod-service) Allow removing `SubmitKey` on Topic by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/12301
* * fix: Cherry-pick: Add null check for autorenew account update by @netopyr in https://github.com/hashgraph/hedera-services/pull/12312
* * fix: apply consistent auto-renew account policy by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/12321
* * chore: Fix state dumpers by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/12318
* * fix: disable birth rounds by @cody-littley in https://github.com/hashgraph/hedera-services/pull/12351
* * fix: ContractCallLocal INSUFFICIENT_GAS ERROR by @kimbor in https://github.com/hashgraph/hedera-services/pull/12362
* * fix: fixed diff test issue 12355. by @iwsimon in https://github.com/hashgraph/hedera-services/pull/12375
* * chore: rely on protobuf release 48 branch instead of main by @mhess-swl in https://github.com/hashgraph/hedera-services/pull/12376
* * fix: (mono) reclaim entity id after failed auto-create; avoid `FAIL_INVALID` on invalid token id by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/12322
* * fix: Fix to deterministic iteration order by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/12401
* * feat: Utilization metrics by @netopyr in https://github.com/hashgraph/hedera-services/pull/12402
* * fix: Fix signing requirements for updating metadata on Token by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/12409
* * fix: Clean up leaked virtual maps after migration by @mhess-swl in https://github.com/hashgraph/hedera-services/pull/12411
* * chore: Migration fixes from state dumpers by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/12392
* * fix: 12424: Backport the fix for 12388 to release 0.48 by @artemananiev in https://github.com/hashgraph/hedera-services/pull/12426
* * chore: Added extra-checks to prevent unchecked submits on mainnet and testnet by @netopyr in https://github.com/hashgraph/hedera-services/pull/12418
* * feat: Pass Metrics to created VirtualMaps by @netopyr in https://github.com/hashgraph/hedera-services/pull/12369
* * fix: Fix `ConfigVersion` serialization by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/12439
* * fix: treat an out-of-range allowance amount as an invalid op by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/12444
* * chore: (cherry-pick) Fix synk expiry (#12477) by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/12480
* * fix: block no migration by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/12476
* * chore: reclaim EthTx lazy-create id on INSUFFICIENT_GAS; use INVALID_ACCOUNT_ID by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/12451
* * fix: verify payer solvency before verifying non-payer sigs by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/12447
* * chore: divide summed lazy-create cost by gas price by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/12449
* * fix: version backwards compatability by @cody-littley in https://github.com/hashgraph/hedera-services/pull/12494
* * fix: always finalize pending precompile contract action by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/12461
* * fix: 12466 Fixed NPE intermitently occurring after 0.47 -> 0.48 migration by @imalygin in https://github.com/hashgraph/hedera-services/pull/12479
* * fix: ContractCallLocal INSUFFICIENT_GAS ERROR by @kimbor in https://github.com/hashgraph/hedera-services/pull/12484
* * chore: Increase max token associations to 50M by @thomas-swirlds-labs in https://github.com/hashgraph/hedera-services/pull/12282
* * fix: Setup metrics for WritableKVStateStack by @netopyr in https://github.com/hashgraph/hedera-services/pull/12486
* * fix: cherry pick 12512 by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/12513
* * fix: add pureChecks to ingest workflow by @netopyr in https://github.com/hashgraph/hedera-services/pull/12535
* * fix: tokenAssociate throws IndexOutOfBoundsException (#12453) by @JivkoKelchev in https://github.com/hashgraph/hedera-services/pull/12550
* * fix: Fix issues found during replaying events and dumping state by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/12531
* * fix: fixed topicMessageSubmit without topicID throws unexpected NPE by @iwsimon in https://github.com/hashgraph/hedera-services/pull/12568
* * chore: cherry pick 12547 by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/12569
* * fix: use `0` for missing auto-renew period in `getTokenInfo()` result by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/12576
* * chore: cherry pick pause fix by @mustafauzunn in https://github.com/hashgraph/hedera-services/pull/12557
* * fix: set provided expiry on new schedule by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/12583
* * fix: Cherry-pick: tokenDissociate can fail with NullPointerException by @netopyr in https://github.com/hashgraph/hedera-services/pull/12575
* * fix: Add pure check to ContractDeleteHandler by @netopyr in https://github.com/hashgraph/hedera-services/pull/12574
* * fix: Fixes response code when failing in HbarChangesStep with custom fees by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/12586
* * fix: Enable pureChecks in TokenAssociateToAccountHandler by @netopyr in https://github.com/hashgraph/hedera-services/pull/12590
* * fix: Return REQUIRED_KEY in CryptoCreate if no alias is used by @netopyr in https://github.com/hashgraph/hedera-services/pull/12595
* * fix: Fix schedules during replay by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/12585
* * fix: Set minimum staking to 0 by @iwsimon in https://github.com/hashgraph/hedera-services/pull/12601
* * fix: fixed diff test issue 12509 by @iwsimon in https://github.com/hashgraph/hedera-services/pull/12597
* * fix: catch and translate `EthTxSigs` IAE by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/12623
* * perf: reorganize metrics initialization by @netopyr in https://github.com/hashgraph/hedera-services/pull/12622
* * fix: Allow scheduled transactions to have preceding transactions by @netopyr in https://github.com/hashgraph/hedera-services/pull/12626
* * fix: unit test and add the right response code by @povolev15 in https://github.com/hashgraph/hedera-services/pull/12581
* * fix: Add fees for ContractCallLocalHandler by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/12645
* * fix: support receipt/record queries with nonce  by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/12654
* * fix: Return NOT_SUPPORTED in assertThrottlingPreconditions() by @netopyr in https://github.com/hashgraph/hedera-services/pull/12647
* * fix: make pureChecks required in all handlers by @kimbor in https://github.com/hashgraph/hedera-services/pull/12578
* * fix: use exact math for all summed balances by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/12668
* * fix: fixed diff test issue 12615 by @iwsimon in https://github.com/hashgraph/hedera-services/pull/12691
* * chore: Implement un-HAPI tests for TokenAssociateToAccountHandler by @netopyr in https://github.com/hashgraph/hedera-services/pull/12698
* * chore: Improve HAPI test to contain only checked error by @netopyr in https://github.com/hashgraph/hedera-services/pull/12719
* * fix: fixed diff test issue #12699 by @iwsimon in https://github.com/hashgraph/hedera-services/pull/12737
* * fix: (cherry-pick)Add EETs and pureChecks in few handlers (#12696) by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/12710
* * perf: reduced warmup overhead #11915;  warm treasury account for token transfer #12278 by @OlegMazurov in https://github.com/hashgraph/hedera-services/pull/12753
* * chore: Update protobuf version 0.49 by @povolev15 in https://github.com/hashgraph/hedera-services/pull/12752
* * fix: Allow aliases only in CryptoTransfer by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/12754
* * fix: refactor pure checks smart contracts network admin by @kimbor in https://github.com/hashgraph/hedera-services/pull/12748
* * chore: Add test for validating aliases in token operations (#12812) by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/12829
* * fix: update versions to 0.49 by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/12819
* * chore: updated pureChecks(), refactored some code in consensus service by @iwsimon in https://github.com/hashgraph/hedera-services/pull/12755
* * fix: Update weights of newly added nodes in `updateWeight` by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/12841
* * fix: Revert pureChecks exception thrown in unchecked submit by @mhess-swl in https://github.com/hashgraph/hedera-services/pull/12874
* * feat: #12713 cherry pick by @lukelee-sl in https://github.com/hashgraph/hedera-services/pull/12820
* * chore: Fix Restart test by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/12878
* * fix: Better handling of fatal errors in handle workflow by @netopyr in https://github.com/hashgraph/hedera-services/pull/12867
* * perf: synchronous signature verification by @netopyr in https://github.com/hashgraph/hedera-services/pull/12881
* * fix: 12247 Remove incorrect assert from `reopenFileChannel` (#12665) by @imalygin in https://github.com/hashgraph/hedera-services/pull/12883
* * chore: 12862 Added null checks to `Hash.serialize` and `Hash.deserialize` by @imalygin in https://github.com/hashgraph/hedera-services/pull/12879
* * fix: cherry-pick main fixes from #12811 by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/12900
* * fix: 12901: Backport the fix for 11966 to release 0.49 by @artemananiev in https://github.com/hashgraph/hedera-services/pull/12903
* * fix: Don't double-count child staking rewards in parent finalization by @mhess-swl in https://github.com/hashgraph/hedera-services/pull/12905
* ## Type restrictions in `SignaturePair` construction
* In previous releases, node software would accept a signature for an Ed25519 key even if it was set in the `ECDSA_secp256k1` field of the signature `oneof` (and vice versa for an ECDSA key with an `ed25519` signature). This is no longer supported; but note the restriction to matching `key`/`signature` types is a low-level detail that should affect few or no clients.
* **Full Changelog**: https://github.com/hashgraph/hedera-services/compare/v0.48.1...v0.49.0

**Full Changelog**: [v0.49.0...v0.49.0](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.49.0...v0.49.0)

</details>

## Release v0.48

### [Build v0.48.1](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.48.1)

<details>
<summary><strong>What's Changed</strong></summary>

* * fix: remove adjustments limit by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/12826
* **Full Changelog**: https://github.com/hashgraph/hedera-services/compare/v0.48.0...v0.48.1

**Full Changelog**: [v0.48.0...v0.48.1](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.48.0...v0.48.1)

</details>

### [Build v0.48.0](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.48.0)

<details>
<summary><strong>What's Changed</strong></summary>

* * feat: Check platform status before syncing (#11429) by @alittley in https://github.com/hashgraph/hedera-services/pull/12679
* **Full Changelog**: https://github.com/hashgraph/hedera-services/compare/v0.47.4...v0.48.0

**Full Changelog**: [v0.48.0...v0.48.0](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.48.0...v0.48.0)

</details>

## Release v0.47

### [Build v0.47.4](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.47.4)

<details>
<summary><strong>What's Changed</strong></summary>

* * Unified `CryptoCreate` throttle reclamation
* **Full Changelog**: https://github.com/hashgraph/hedera-services/compare/v0.47.3...v0.47.4

**Full Changelog**: [v0.47.0...v0.47.4](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.47.0...v0.47.4)

</details>

### [Build v0.47.3](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.47.3)

<details>
<summary><strong>What's Changed</strong></summary>

* * Changed the configuration for `tokens.maxAggregateRels` to 15 million in all environments
* **Full Changelog**: https://github.com/hashgraph/hedera-services/compare/v0.47.2...v0.47.3

**Full Changelog**: [v0.47.0...v0.47.3](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.47.0...v0.47.3)

</details>

### [Build v0.47.2](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.47.2)

<details>
<summary><strong>What's Changed</strong></summary>

* Fixes
* * fix: Update Configuration `hashesRamToDiskThreshold` to 0 in `MerkleDbConfig`
* * fix: Backport the fix for virtual map flushes.
* **Full Changelog**: https://github.com/hashgraph/hedera-services/compare/v0.47.1...v0.47.2

**Full Changelog**: [v0.47.0...v0.47.2](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.47.0...v0.47.2)

</details>

### [Build v0.47.1](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.47.1)

<details>
<summary><strong>What's Changed</strong></summary>

* * fix: only compare child time created against self parent time created by @alittley in https://github.com/hashgraph/hedera-services/pull/11673
* * chore: add an old-style queue thread for intake by @cody-littley in https://github.com/hashgraph/hedera-services/pull/11671
* * fix: 11746: Backport the fix for #11304 to release 0.47 by @artemananiev in https://github.com/hashgraph/hedera-services/pull/11747
* **Full Changelog**: https://github.com/hashgraph/hedera-services/compare/v0.47.0...v0.47.1

**Full Changelog**: [v0.47.0...v0.47.1](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.47.0...v0.47.1)

</details>

### [Build v0.47.0](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.47.0)

<details>
<summary><strong>What's Changed</strong></summary>

* * fix: bug when node is removed by @cody-littley in https://github.com/hashgraph/hedera-services/pull/10687
* * fix: Fuzzy matching for CreateOperationSuite and Create2OperationSuite 09431 by @JivkoKelchev in https://github.com/hashgraph/hedera-services/pull/10185
* * fix: recordCache to commit added entries and implemented correctly the remove elements from the queue  by @povolev15 in https://github.com/hashgraph/hedera-services/pull/10523
* * fix: Fix and enable all Schedule HapiTests by @povolev15 in https://github.com/hashgraph/hedera-services/pull/10551
* * fix: implement sidecars by @JivkoKelchev in https://github.com/hashgraph/hedera-services/pull/9815
* * feat: add setting for birth round ancient threshold by @cody-littley in https://github.com/hashgraph/hedera-services/pull/10660
* * chore: drop chatter by @cody-littley in https://github.com/hashgraph/hedera-services/pull/10670
* * chore: remove state info by @cody-littley in https://github.com/hashgraph/hedera-services/pull/10685
* * chore: Rename contract causing services regression due to long name by @stoqnkpL in https://github.com/hashgraph/hedera-services/pull/10700
* * fix: state leak by @cody-littley in https://github.com/hashgraph/hedera-services/pull/10690
* * fix: state leak during migration by @cody-littley in https://github.com/hashgraph/hedera-services/pull/10706
* * fix: Mark prehandle as complete in legacy intake pipeline by @alittley in https://github.com/hashgraph/hedera-services/pull/10711
* * chore: fix mutability exception in pre-handle; stabilize CI by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/10716
* * chore: add s6-overlay based init process support by @nathanklick in https://github.com/hashgraph/hedera-services/pull/10717
* * fix: restore accidentally disable reconnect tests by @JeffreyDallas in https://github.com/hashgraph/hedera-services/pull/10560
* * ci: turn off regression for release 0.44 by @JeffreyDallas in https://github.com/hashgraph/hedera-services/pull/10708
* * chore: Clean up schedule HapiSpec suites by @jsync-swirlds in https://github.com/hashgraph/hedera-services/pull/10710
* * fix: change cron job to once a day by @JeffreyDallas in https://github.com/hashgraph/hedera-services/pull/10570
* * chore: Update copyrights to 2024 on the repo by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/10752
* * chore: set event birthRound to pendingConsensusRound by @edward-swirldslabs in https://github.com/hashgraph/hedera-services/pull/10681
* * chore: Rename files to Pces by @alittley in https://github.com/hashgraph/hedera-services/pull/10754
* * chore: clean up contract call sanity precheck logic by @lukelee-sl in https://github.com/hashgraph/hedera-services/pull/10750
* * chore: 10593 move nanoclock to base by @mxtartaglia-sl in https://github.com/hashgraph/hedera-services/pull/10641
* * fix: stabilize remaining un-enabled `@HapiSpec`'s by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/10733
* * fix: diagram commands by @cody-littley in https://github.com/hashgraph/hedera-services/pull/10773
* * fix: Solve bad metric units by @alittley in https://github.com/hashgraph/hedera-services/pull/10777
* * chore: Create a thorough unit test for KeyComparator by @jsync-swirlds in https://github.com/hashgraph/hedera-services/pull/10753
* * test: enable ContractGetBytecodeSuite fuzzy matching by @mustafauzunn in https://github.com/hashgraph/hedera-services/pull/10764
* * chore: remove the unused encryption key pair and silently ignore if present by @nathanklick in https://github.com/hashgraph/hedera-services/pull/10757
* * chore: account for staking records in various specs by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/10783
* * chore: add "Possibly CATASTROPHIC failure" logs by @petreze in https://github.com/hashgraph/hedera-services/pull/10760
* * chore: 10561 chage withConverter signature by @mxtartaglia-sl in https://github.com/hashgraph/hedera-services/pull/10614
* * fix: fix permissions for upgrade test by @JeffreyDallas in https://github.com/hashgraph/hedera-services/pull/10779
* * chore: remove legacy intake flag by @alittley in https://github.com/hashgraph/hedera-services/pull/10744
* * chore: only override Netty defaults on non-`DEV` profile; other fixes by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/10786
* * test: enable fuzzy matching for some suites by @mustafauzunn in https://github.com/hashgraph/hedera-services/pull/10736
* * feat: adding getter to RecordStreamEntry for TransactionRecord by @stefan-stefanooov in https://github.com/hashgraph/hedera-services/pull/10703
* * chore: fix mod-service congestion start time mgmt by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/10797
* * chore: Enable restart and reconnect tests in CI under a different Tag by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/10604
* * fix: Enable fuzzy matching in `SelfDestructSuite` by @georgi-l95 in https://github.com/hashgraph/hedera-services/pull/10788
* * feat: Enable fuzzy matching in `ContractHTSSuite` by @georgi-l95 in https://github.com/hashgraph/hedera-services/pull/10792
* * fix: Enable fuzzy matching for `ERC20ContractInteractions` by @Ivo-Yankov in https://github.com/hashgraph/hedera-services/pull/10768
* * chore: Document why the deduplicator considers signature by @alittley in https://github.com/hashgraph/hedera-services/pull/10799
* * feat: Add new logging api (#9631) by @timo0 in https://github.com/hashgraph/hedera-services/pull/10332
* * chore: reduce static config use by @cody-littley in https://github.com/hashgraph/hedera-services/pull/10663
* * chore: Migrate PCES to new framework by @alittley in https://github.com/hashgraph/hedera-services/pull/10795
* * fix: Fix timing sensitivity in `LoggingSystemTest` by @jsync-swirlds in https://github.com/hashgraph/hedera-services/pull/10826
* * fix: refactor the code to use explicit Schema and not anonymous Schema and one flaky test by @povolev15 in https://github.com/hashgraph/hedera-services/pull/10756
* * chore: Remove preconsensus observer by @alittley in https://github.com/hashgraph/hedera-services/pull/10816
* * chore: use INFO level for state changes log by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/10818
* * fix: Cache ReadableStates by @netopyr in https://github.com/hashgraph/hedera-services/pull/10813
* * chore: Skip methods annotated with BddMethodIsNotATest by @netopyr in https://github.com/hashgraph/hedera-services/pull/10823
* * fix: Enable Smart Contract Records and Operations suites fuzzy matching by @stoyanov-st in https://github.com/hashgraph/hedera-services/pull/10697
* * fix: Enable fuzzy matching in PrngSeedOperationSuite by @stoyanov-st in https://github.com/hashgraph/hedera-services/pull/10699
* * fix: Enable fuzzy matching for SStoreSuite by @Ivo-Yankov in https://github.com/hashgraph/hedera-services/pull/10766
* * test: enable SigningReqsSuite fuzzy matching by @mustafauzunn in https://github.com/hashgraph/hedera-services/pull/10836
* * fix: Enable Fuzzy matching for some Smart Contract suites and BlockSuite by @stoyanov-st in https://github.com/hashgraph/hedera-services/pull/10807
* * chore: allow starting from genesis state with null address book. by @edward-swirldslabs in https://github.com/hashgraph/hedera-services/pull/10817
* * chore: Test fuzzy-matching for token specs by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/10842
* * chore: disable flaky test by @mxtartaglia-sl in https://github.com/hashgraph/hedera-services/pull/10882
* * fix: Repair and reenable PCES File Manager test by @alittley in https://github.com/hashgraph/hedera-services/pull/10886
* * chore: Component Documentation by @poulok in https://github.com/hashgraph/hedera-services/pull/10821
* * feat: sync metrics by @cody-littley in https://github.com/hashgraph/hedera-services/pull/10891
* * chore: orphan buffer supports birthRound ancient threshold. by @edward-swirldslabs in https://github.com/hashgraph/hedera-services/pull/10844
* * test: enable GrantRemoveKycSuite fuzzy matching by @dikel in https://github.com/hashgraph/hedera-services/pull/10857
* * chore: remove file sign tool by @cody-littley in https://github.com/hashgraph/hedera-services/pull/10883
* * fix: Make Hasher use a DIRECT scheduler by @alittley in https://github.com/hashgraph/hedera-services/pull/10889
* * test: Fix fuzzy match flakiness by @vtronkov in https://github.com/hashgraph/hedera-services/pull/10856
* * chore: use metadata-derived class id for QueueNode by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/10885
* * feat: 5592: Modify platform data to use PBJ DataIO serialization by @artemananiev in https://github.com/hashgraph/hedera-services/pull/7545
* * fix: bug with wiring diagram substitution by @cody-littley in https://github.com/hashgraph/hedera-services/pull/10934
* * feat: removal of address validity checks for top-level EVM calls by @natanasow in https://github.com/hashgraph/hedera-services/pull/9628
* * feat: PCES can use either birth round or generation by @cody-littley in https://github.com/hashgraph/hedera-services/pull/10808
* * chore: update local node images to Java 21 by @isavov in https://github.com/hashgraph/hedera-services/pull/10834
* * fix: address book jrs test failing by @edward-swirldslabs in https://github.com/hashgraph/hedera-services/pull/10928
* * feat: Add explicit `TokenType` to `SingleTransactionRecord`. by @jsync-swirlds in https://github.com/hashgraph/hedera-services/pull/10827
* * fix: Implement new PCES writer flush by @alittley in https://github.com/hashgraph/hedera-services/pull/10945
* * fix: (mod-service)Use concurrent read cache by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/10965
* * chore: Validate other token spec fuzzy matching by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/10888
* * test: enable RedirectPrecompileSuite fuzzy matching by @mustafauzunn in https://github.com/hashgraph/hedera-services/pull/10921
* * fix: Enable fuzzy match in ContractBurnHTSSuite by @stoyanov-st in https://github.com/hashgraph/hedera-services/pull/10868
* * test: Enable fuzzy record matching for PrngPrecompileSuite by @vtronkov in https://github.com/hashgraph/hedera-services/pull/10850
* * test: Enable fuzzy record matching for ERC1155ContractInteractions by @vtronkov in https://github.com/hashgraph/hedera-services/pull/10852
* * chore: add warmup hook by @netopyr in https://github.com/hashgraph/hedera-services/pull/10941
* * test: enable ContractCreateSuite fuzzy matching by @mustafauzunn in https://github.com/hashgraph/hedera-services/pull/10806
* * test: enable DefaultTokenStatusSuite fuzzy matching by @mustafauzunn in https://github.com/hashgraph/hedera-services/pull/10906
* * test: enable PauseUnpauseTokenAccountPrecompileSuite fuzzy matching by @mustafauzunn in https://github.com/hashgraph/hedera-services/pull/10970
* * test: enable AssociatePrecompileSuite fuzzy matching by @mustafauzunn in https://github.com/hashgraph/hedera-services/pull/10866
* * test: enable EthereumSuite fuzzy matching by @mustafauzunn in https://github.com/hashgraph/hedera-services/pull/10943
* * fix: Enable fuzzy matching for DelegatePrecompile by @stoyanov-st in https://github.com/hashgraph/hedera-services/pull/10873
* * test: Enable fuzzy record matching for FreezeUnfreezeTokenPrecompileSuite by @vtronkov in https://github.com/hashgraph/hedera-services/pull/10867
* * test: enable TokenExpiryInfoSuite fuzzy matching by @dikel in https://github.com/hashgraph/hedera-services/pull/10861
* * test: Enable fuzzy match for all CreatePrecompileSuite tests by @vtronkov in https://github.com/hashgraph/hedera-services/pull/10839
* * chore: create state signature collector component by @lpetrovic05 in https://github.com/hashgraph/hedera-services/pull/10838
* * feat: Create command to generate a legend for framework diagrams by @alittley in https://github.com/hashgraph/hedera-services/pull/10963
* * fix: 10948: JRS failure SmartContractByteCodeMapValueSerializer.getSerializedSize by @artemananiev in https://github.com/hashgraph/hedera-services/pull/10957
* * fix: Enable fuzzy matching for ContractDeleteSuite by @MrValioBg in https://github.com/hashgraph/hedera-services/pull/10939
* * fix:  Logging configuration updates test  by @mxtartaglia-sl in https://github.com/hashgraph/hedera-services/pull/10952
* * feat: wiring offer cleanup by @cody-littley in https://github.com/hashgraph/hedera-services/pull/10925
* * fix: sync filtering by @cody-littley in https://github.com/hashgraph/hedera-services/pull/11002
* * feat: transform evm v46 checks to prechecks by @natanasow in https://github.com/hashgraph/hedera-services/pull/11013
* * test: enable `TokenAndTypeCheckSuite` fuzzy matching by @natanasow in https://github.com/hashgraph/hedera-services/pull/10977
* * chore: Extend Mixed operation submitted for Restart and Reconnect tests by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/11007
* * test: Add tests for V2 token mint for EOA-CONTRACT-PRECOMPILE by @anastasiya-kovaliova in https://github.com/hashgraph/hedera-services/pull/10840
* * chore: remove check which performs receiver signature check  by @lukelee-sl in https://github.com/hashgraph/hedera-services/pull/11031
* * fix: Reclaim throttle usage for auto account creation by @petreze in https://github.com/hashgraph/hedera-services/pull/10940
* * chore: skip unwanted parts of init during mono event stream recovery by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/11004
* * fix: state unchanged on restart without upgrade by @edward-swirldslabs in https://github.com/hashgraph/hedera-services/pull/11043
* * fix: Improve ugly html by @alittley in https://github.com/hashgraph/hedera-services/pull/11029
* * ci: turning off release 0.45 regression by @JeffreyDallas in https://github.com/hashgraph/hedera-services/pull/11040
* * fix: Use a sequential thread scheduler for LinkedEventIntake by @alittley in https://github.com/hashgraph/hedera-services/pull/11048
* * fix: Enable fuzzy matching for TraceabilitySuite by @MrValioBg in https://github.com/hashgraph/hedera-services/pull/11037
* * fix: event stream replay by @cody-littley in https://github.com/hashgraph/hedera-services/pull/11049
* * fix: Flush transaction handling after replay by @alittley in https://github.com/hashgraph/hedera-services/pull/11000
* * fix: pcli diagram by @cody-littley in https://github.com/hashgraph/hedera-services/pull/11053
* * feat: add expired threshold to ancient window by @cody-littley in https://github.com/hashgraph/hedera-services/pull/10960
* * chore: use fixed missing contract numbers in `Evm46ValidationSuite` by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/11061
* * chore: refactor to remove dependencies to contractMustBePresent by @lukelee-sl in https://github.com/hashgraph/hedera-services/pull/11005
* * chore: Add first logging documentation by @timo0 in https://github.com/hashgraph/hedera-services/pull/10911
* * fix: Reenable concurrent hashing by @alittley in https://github.com/hashgraph/hedera-services/pull/10986
* * chore: ensure validation runners use the same docker & containerd versions by @nathanklick in https://github.com/hashgraph/hedera-services/pull/11070
* * chore: Fix `TokenTransactSpecs` fuzzy matching by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/10951
* * fix: 11054: API for abstract tasks by @artemananiev in https://github.com/hashgraph/hedera-services/pull/11056
* * fix: 11042 Upgraded PBJ version to 0.7.12 by @imalygin in https://github.com/hashgraph/hedera-services/pull/11044
* * feat: shadowgraph wiring by @cody-littley in https://github.com/hashgraph/hedera-services/pull/10937
* * chore: use birth round in InOrderLinker by @edward-swirldslabs in https://github.com/hashgraph/hedera-services/pull/11084
* * chore: Update develop to use `add-pbj-types-for-state` by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/11094
* * chore: Remove old intake queue by @alittley in https://github.com/hashgraph/hedera-services/pull/10814
* * test: enable fuzzy match on TokenInfoHTSSuite by @vtronkov in https://github.com/hashgraph/hedera-services/pull/11014
* * chore: warm token transfer by @netopyr in https://github.com/hashgraph/hedera-services/pull/11017
* * chore: Metrics module added by @hendrikebbers in https://github.com/hashgraph/hedera-services/pull/9846
* * fix: (mod-service)Fix block number closing issue on restart by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/11097
* * feat: unlink alias on account deletion by @natanasow in https://github.com/hashgraph/hedera-services/pull/10701
* * feat: add support for industry standard key storage by @nathanklick in https://github.com/hashgraph/hedera-services/pull/11060
* * fix: Initial Differential Testing Fixes by @mhess-swl in https://github.com/hashgraph/hedera-services/pull/11100
* * fix: use concurrent hashmap instead of synchroniztion for recordcache by @povolev15 in https://github.com/hashgraph/hedera-services/pull/11112
* * feat: Big-bang migration code by @mhess-swl in https://github.com/hashgraph/hedera-services/pull/11003
* * chore: Track pending rewards per node by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/11062
* * chore: Remove usage of snapshotMode in HAPI tests by @netopyr in https://github.com/hashgraph/hedera-services/pull/11128
* * chore: MinGenInfo serialization cleanup by @cody-littley in https://github.com/hashgraph/hedera-services/pull/11115
* * fix: let shadowgraph be responsible for all unlinking by @cody-littley in https://github.com/hashgraph/hedera-services/pull/11121
* * chore: make shadowgraph compatible with birth rounds by @cody-littley in https://github.com/hashgraph/hedera-services/pull/11095
* * feat: use ContractID as contract identifier by @kimbor in https://github.com/hashgraph/hedera-services/pull/10958
* * ci: Add ping exporter to poll github runner delay and push to promethus by @JeffreyDallas in https://github.com/hashgraph/hedera-services/pull/11089
* * feat: 10961: Virtual hashing is the next bottleneck by @artemananiev in https://github.com/hashgraph/hedera-services/pull/11001
* * chore: add tool configuration files to support Codacy reporting by @nathanklick in https://github.com/hashgraph/hedera-services/pull/11147
* * fix: 11030: replace ProtoUtils with PBJ APIs by @anthony-swirldslabs in https://github.com/hashgraph/hedera-services/pull/11098
* * ci(codacy): enable Codacy coverage reporting by @nathanklick in https://github.com/hashgraph/hedera-services/pull/11150
* * fix: add missing credential for ping grafana agent by @JeffreyDallas in https://github.com/hashgraph/hedera-services/pull/11162
* * chore: 10285 split records by @mxtartaglia-sl in https://github.com/hashgraph/hedera-services/pull/11093
* * chore(deps): bump com.diffplug.spotless:spotless-plugin-gradle from 6.23.3 to 6.25.0 by @dependabot in https://github.com/hashgraph/hedera-services/pull/11122
* * chore(deps): bump google-github-actions/upload-cloud-storage from 1.0.3 to 2.1.0 by @dependabot in https://github.com/hashgraph/hedera-services/pull/11126
* * build(deps): bump actions/setup-python from 4.8.0 to 5.0.0 by @dependabot in https://github.com/hashgraph/hedera-services/pull/10373
* * build(deps): bump actions/checkout from 4.1.0 to 4.1.1 by @dependabot in https://github.com/hashgraph/hedera-services/pull/10432
* * build(deps): bump mikefarah/yq from 4.40.2 to 4.40.5 by @dependabot in https://github.com/hashgraph/hedera-services/pull/10457
* * build(deps): bump actions/setup-node from 4.0.0 to 4.0.1 by @dependabot in https://github.com/hashgraph/hedera-services/pull/10562
* * chore(deps): bump fjogeleit/http-request-action from 1.14.2 to 1.15.2 by @dependabot in https://github.com/hashgraph/hedera-services/pull/10824
* * chore(deps): bump org.owasp:dependency-check-gradle from 8.4.2 to 9.0.9 by @dependabot in https://github.com/hashgraph/hedera-services/pull/11028
* * chore(deps): bump actions/upload-artifact from 3.1.3 to 4.3.0 by @dependabot in https://github.com/hashgraph/hedera-services/pull/11123
* * chore(deps): bump google-github-actions/setup-gcloud from 1.1.1 to 2.1.0 by @dependabot in https://github.com/hashgraph/hedera-services/pull/11125
* * chore(deps): bump google-github-actions/auth from 1.1.1 to 2.1.0 by @dependabot in https://github.com/hashgraph/hedera-services/pull/11124
* * build(deps): Bump actions/setup-java from 3.13.0 to 4.0.0 by @dependabot in https://github.com/hashgraph/hedera-services/pull/10178
* * chore(deps): bump gradle/gradle-build-action from 2.9.0 to 2.12.0 by @dependabot in https://github.com/hashgraph/hedera-services/pull/11167
* * refactor(#10023): EventDeduplicator uses AncientMode by @edward-swirldslabs in https://github.com/hashgraph/hedera-services/pull/11145
* * build(deps): Bump org.antlr:antlr4 from 4.11.1 to 4.13.1 by @dependabot in https://github.com/hashgraph/hedera-services/pull/10266
* * chore(deps): bump com.autonomousapps:dependency-analysis-gradle-plugin from 1.26.0 to 1.29.0 by @dependabot in https://github.com/hashgraph/hedera-services/pull/11059
* * feat: Use Journaled EVM Updater by @shemnon in https://github.com/hashgraph/hedera-services/pull/11171
* * refactor(#10023): InternalEventValidator Checks BirthRound by @edward-swirldslabs in https://github.com/hashgraph/hedera-services/pull/11091
* * feat: cleaner manual event window overrides by @cody-littley in https://github.com/hashgraph/hedera-services/pull/11165
* * feat: add a wiring stub for gossip by @cody-littley in https://github.com/hashgraph/hedera-services/pull/11170
* * fix: 114: handle ParseException from PBJ Codec.parse() by @anthony-swirldslabs in https://github.com/hashgraph/hedera-services/pull/11151
* * fix: allow negative birthRound event validation by @edward-swirldslabs in https://github.com/hashgraph/hedera-services/pull/11209
* * perf: Execute each cache warming on individual virtual thread by @netopyr in https://github.com/hashgraph/hedera-services/pull/11216
* * feat: clean up wiring diagram by @cody-littley in https://github.com/hashgraph/hedera-services/pull/11228
* * build: perform git clone/update of 'hedera-protobufs' in a task by @jjohannes in https://github.com/hashgraph/hedera-services/pull/10278
* * test: 11135 - create hapi tests for balance operation for system accounts by @0xivanov in https://github.com/hashgraph/hedera-services/pull/11184
* * fix: 10315 use ordinal when revert PrecompileContractResult (ERCPrecompileSuite fuzzy match) by @JivkoKelchev in https://github.com/hashgraph/hedera-services/pull/11183
* * build: JMH - do not include test classes/dependencies by @jjohannes in https://github.com/hashgraph/hedera-services/pull/10384
* * test: add additional test for conditional records by @georgi-l95 in https://github.com/hashgraph/hedera-services/pull/10735
* * feat: dumper for signed state `topics` from mono by @agadzhalov in https://github.com/hashgraph/hedera-services/pull/11081
* * test: add `htsTransferFromForNFTViaContractCreateLazyCreate` to `LazyCreateThroughPrecompileSuite` and enable fuzzy-matching on it by @thenswan in https://github.com/hashgraph/hedera-services/pull/11163
* * fix: 10315 Add ALLOW_EMPTY_ERROR_MSG snapshot mode (ERCPrecompileSuite fuzzy match) by @JivkoKelchev in https://github.com/hashgraph/hedera-services/pull/11185
* * perf: Turn workflows into Singletons by @netopyr in https://github.com/hashgraph/hedera-services/pull/11222
* * feat: future event buffer by @cody-littley in https://github.com/hashgraph/hedera-services/pull/11168
* * build: improve test run parallelization and cleanup test categories by @jjohannes in https://github.com/hashgraph/hedera-services/pull/8456
* * test: unlinking of alias is not working as expected by @natanasow in https://github.com/hashgraph/hedera-services/pull/11239
* * fix: Fuzzy match AtomicCryptoTransferSuite by @MrValioBg in https://github.com/hashgraph/hedera-services/pull/11181
* * chore: add `RcDiff` tool by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/11148
* * fix: resolve Snyk Report workflow step failure by @nathanklick in https://github.com/hashgraph/hedera-services/pull/11269
* * fix: 10315 fix leftovers (ERCPrecompileSuite fuzzy match) by @JivkoKelchev in https://github.com/hashgraph/hedera-services/pull/11179
* * perf: Ensure TransactionStateLogger is not logging on info level by @netopyr in https://github.com/hashgraph/hedera-services/pull/11274
* * fix: platform should not use common fork join pool by @cody-littley in https://github.com/hashgraph/hedera-services/pull/11267
* * fix:  Fix flaky parallel tests by @timo0 in https://github.com/hashgraph/hedera-services/pull/11281
* * fix: 11255: Discrepancy protobuf bucket bytes between Bucket and ParsedBucket if bucket index is zero by @artemananiev in https://github.com/hashgraph/hedera-services/pull/11261
* * chore: 5967 validate metric naming rules by @mxtartaglia-sl in https://github.com/hashgraph/hedera-services/pull/11142
* * chore: stabilize a few specs by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/11258
* * fix: 10315 add logs to grant approval calls (ERCPrecompileSuite fuzzy match) by @JivkoKelchev in https://github.com/hashgraph/hedera-services/pull/11178
* * fix: Ensure that the pending creation customizer applies to the address being created by @lukelee-sl in https://github.com/hashgraph/hedera-services/pull/11214
* * test: Enable fuzzy matching for ContractKeysStillWorkAsExpectedSuite by @vtronkov in https://github.com/hashgraph/hedera-services/pull/11272
* * chore: Unit test modules removed by @hendrikebbers in https://github.com/hashgraph/hedera-services/pull/10832
* * test: 11136 - Create hapi tests for selfDestruct operation with system accounts as beneficiaries by @0xivanov in https://github.com/hashgraph/hedera-services/pull/11249
* * feat: Make updates to dashboards, and add new ones by @alittley in https://github.com/hashgraph/hedera-services/pull/11259
* * perf: Move token on disk by @netopyr in https://github.com/hashgraph/hedera-services/pull/11273
* * feat: pcli state validateAddressBook command by @edward-swirldslabs in https://github.com/hashgraph/hedera-services/pull/11287
* * fix: use an unbounded queue for the crypto engine by @cody-littley in https://github.com/hashgraph/hedera-services/pull/11289
* * feat: charge gas if contract call fails before calling the evm by @lukelee-sl in https://github.com/hashgraph/hedera-services/pull/11096
* * perf: Avoid excessive creation of Executors by @netopyr in https://github.com/hashgraph/hedera-services/pull/11311
* * fix: Ui metrics name by @mxtartaglia-sl in https://github.com/hashgraph/hedera-services/pull/11317
* * fix: 11305: failing application metrics by @mxtartaglia-sl in https://github.com/hashgraph/hedera-services/pull/11321
* * chore: drop support for async hashing by @cody-littley in https://github.com/hashgraph/hedera-services/pull/11319
* * chore: fix the record mismatch for `prng` transactions by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/11238
* * fix: rejected execution in wiring framework by @cody-littley in https://github.com/hashgraph/hedera-services/pull/11293
* * chore: Fix Some other issues faced during differential testing for 15 min window by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/11297
* * feat: 11231: Improved virtual node remover by @artemananiev in https://github.com/hashgraph/hedera-services/pull/11268
* * chore: Update protobuf version by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/11338
* * fix: 11363: Backport the fix for 11348 to release 0.47 by @artemananiev in https://github.com/hashgraph/hedera-services/pull/11368
* * fix: 11367 Use correct measure for intake backpressure by @alittley in https://github.com/hashgraph/hedera-services/pull/11393
* * fix: Return invalid token even if expected decimals are present (#11342) by @mhess-swl in https://github.com/hashgraph/hedera-services/pull/11374
* * chore: cherry pick fix to address cold read issue in ExtCodeHash by @lukelee-sl in https://github.com/hashgraph/hedera-services/pull/11344
* * chore: cherry pick fix for matching the signature for precompiles on failure by @mustafauzunn in https://github.com/hashgraph/hedera-services/pull/11411
* * chore: cherry-pick fix for address account nonce discrepancies mono by @natanasow in https://github.com/hashgraph/hedera-services/pull/11450
* * chore: cherry-pick static call with selfdestruct to system account between 0.0.751  and 0.0.999 results in FAIL_INVALID by @stoqnkpL in https://github.com/hashgraph/hedera-services/pull/11453
* * chore: Cherry pick fix: contracts.evm.allowCallsToNonContractAccounts flag misbehaviour by @stoqnkpL in https://github.com/hashgraph/hedera-services/pull/11454
* * chore: Cherry pick Create hapi tests for transfer and send operations for system accounts  by @stoqnkpL in https://github.com/hashgraph/hedera-services/pull/11452
* * fix: Cherry pick fix to release 0.47 to shorten contract name by @JeffreyDallas in https://github.com/hashgraph/hedera-services/pull/11535
* * chore: cherry pick #11504 by @lukelee-sl in https://github.com/hashgraph/hedera-services/pull/11567
* * fix: reduce sync permit count (#11545) by @cody-littley in https://github.com/hashgraph/hedera-services/pull/11550
* * fix: 11561 Added `isReconnectContext` flag to handle node removal properly in the reconnect context. by @imalygin in https://github.com/hashgraph/hedera-services/pull/11591
* ## New Contributors
* * @stefan-stefanooov made their first contribution in https://github.com/hashgraph/hedera-services/pull/10703
* * @anastasiya-kovaliova made their first contribution in https://github.com/hashgraph/hedera-services/pull/10840
* **Full Changelog**: https://github.com/hashgraph/hedera-services/compare/v0.46.3...v0.47.0

**Full Changelog**: [v0.47.0...v0.47.0](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.47.0...v0.47.0)

</details>

## Release v0.46

### [Build v0.46.3](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.46.3)

<details>
<summary><strong>What's Changed</strong></summary>

* * chore: bump HAPI proto version by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/11232
* **Full Changelog**: https://github.com/hashgraph/hedera-services/compare/v0.46.2...v0.46.3

**Full Changelog**: [v0.46.0...v0.46.3](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.46.0...v0.46.3)

</details>

### [Build v0.46.2](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.46.2)

<details>
<summary><strong>What's Changed</strong></summary>

* * fix: Ensure that the pending creation customizer applies to the address being created by @lukelee-sl in https://github.com/hashgraph/hedera-services/pull/11213
* **Full Changelog**: https://github.com/hashgraph/hedera-services/compare/v0.46.1...v0.46.2

**Full Changelog**: [v0.46.0...v0.46.2](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.46.0...v0.46.2)

</details>

### [Build v0.46.1](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.46.1)

<details>
<summary><strong>What's Changed</strong></summary>

* * feat: Use Journaled EVM Updater (0.46) by @shemnon in https://github.com/hashgraph/hedera-services/pull/11172
* **Full Changelog**: https://github.com/hashgraph/hedera-services/compare/v0.46.0...v0.46.1

**Full Changelog**: [v0.46.0...v0.46.1](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.46.0...v0.46.1)

</details>

### [Build v0.46.0](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.46.0)

<details>
<summary><strong>What's Changed</strong></summary>

* * feat: wiring diagram improvements by @cody-littley in https://github.com/hashgraph/hedera-services/pull/10233
* * chore: Change `HashMap` to `LinkedHashMap` in custom fees assessment by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/10240
* * feat: add implementation in throttling facility to handle N-Of-Unscaled type of throttling by @MiroslavGatsanoga in https://github.com/hashgraph/hedera-services/pull/10142
* * build: do not publish test fixtures by @jjohannes in https://github.com/hashgraph/hedera-services/pull/10147
* * build: patch everything we use to be a real Java Module by @jjohannes in https://github.com/hashgraph/hedera-services/pull/10056
* * chore!: More common tests moved to correct module by @hendrikebbers in https://github.com/hashgraph/hedera-services/pull/10133
* * feat: Config constants created & used by @hendrikebbers in https://github.com/hashgraph/hedera-services/pull/10117
* * feat: script for cleaning build files by @cody-littley in https://github.com/hashgraph/hedera-services/pull/10190
* * fix: Compact last PCES file at boot time by @cody-littley in https://github.com/hashgraph/hedera-services/pull/10257
* * feat: sync++- by @cody-littley in https://github.com/hashgraph/hedera-services/pull/10260
* * feat: roster change objects by @cody-littley in https://github.com/hashgraph/hedera-services/pull/9908
* * chore(ci): change the trigger on the PR Formatting workflow by @nathanklick in https://github.com/hashgraph/hedera-services/pull/10267
* * feat(migration): Migrate contract store (contract's slots) from monservice to modular-service representation by @david-bakin-sl in https://github.com/hashgraph/hedera-services/pull/10252
* * chore: ensure the pull request check workflow properly handles forks by @nathanklick in https://github.com/hashgraph/hedera-services/pull/10268
* * fix: fix failing PCES unit test. by @cody-littley in https://github.com/hashgraph/hedera-services/pull/10290
* * fix: 2098 metadata clone by @mmalik-al in https://github.com/hashgraph/hedera-services/pull/10108
* * feat: don't link parents if relationship to child is invalid by @alittley in https://github.com/hashgraph/hedera-services/pull/10235
* * feat: move SignedStateFileManagerWiring into PlatformWiring by @alittley in https://github.com/hashgraph/hedera-services/pull/10207
* * chore: disable sync++- by @cody-littley in https://github.com/hashgraph/hedera-services/pull/10304
* * fix: enable contract hapi-tests, eliminate v1 security model by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/10155
* * fix: suite test in `TokenAndTypeCheckSuite` by @petreze in https://github.com/hashgraph/hedera-services/pull/10140
* * fix: tests from LeakyContractTestsSuite by @MrValioBg in https://github.com/hashgraph/hedera-services/pull/9997
* * fix: fuzzy match records with mono-service for ContractMintHTSSuite by @thenswan in https://github.com/hashgraph/hedera-services/pull/10282
* * fix: remove incompatible ip printing in linux by @mxtartaglia-sl in https://github.com/hashgraph/hedera-services/pull/10296
* * feat(event serialization): add `birthRound`, `EventDescriptor` and multiple other parents to serialized event  by @edward-swirldslabs in https://github.com/hashgraph/hedera-services/pull/9344
* * fix(migration): Migrate contract slots from mono- to modular- in deterministic order by @david-bakin-sl in https://github.com/hashgraph/hedera-services/pull/10310
* * chore(ci): add a new CI workflow to ensure release artifact determinism by @nathanklick in https://github.com/hashgraph/hedera-services/pull/10347
* * feat: Implement lazyCreationCostInGas method by @lukelee-sl in https://github.com/hashgraph/hedera-services/pull/10337
* * fix(ci): disable Gradle configuration cache before executing Snyk by @nathanklick in https://github.com/hashgraph/hedera-services/pull/10349
* * fix: 10227 use dev config with modrun by @jamesnguyentech in https://github.com/hashgraph/hedera-services/pull/10249
* * fix(ci): snyk workflow should not run on dependabot or forked pull requests by @nathanklick in https://github.com/hashgraph/hedera-services/pull/10355
* * chore(ci): drop upgrade test support for Ubuntu 18.04 by @JeffreyDallas in https://github.com/hashgraph/hedera-services/pull/10344
* * feat: make branch more visually distinct in JTR report. by @cody-littley in https://github.com/hashgraph/hedera-services/pull/10329
* * fix: ContractCallLocalSuite Fix by @ilko-iliev-lime in https://github.com/hashgraph/hedera-services/pull/10038
* * fix: fix some sonar bugs and suppress others by @povolev15 in https://github.com/hashgraph/hedera-services/pull/10261
* * fix: disassociate deleted nft does not commit a transfer list by @georgi-l95 in https://github.com/hashgraph/hedera-services/pull/10097
* * feat: Implement synthetic records for immediate genesis reconnect scenario by @mhess-swl in https://github.com/hashgraph/hedera-services/pull/10176
* * chore: Fix `HashMap` in token service `CryptoTransfer` to `LinkedHashMap` by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/10361
* * chore: Fix ContractKeysHTSSuite records by @thenswan in https://github.com/hashgraph/hedera-services/pull/10110
* * feat: Set recipient to null as appropriate during contract tracing by @lukelee-sl in https://github.com/hashgraph/hedera-services/pull/10348
* * fix: canUseAliasesInPrecompilesAndContractKeys checks EVM_ADDRESS is 20 bytes by @agadzhalov in https://github.com/hashgraph/hedera-services/pull/10327
* * fix: change glibc malloc behavior to help reduce memory consumption by @nathanklick in https://github.com/hashgraph/hedera-services/pull/10359
* * feat: Hook midnight rate updates into handle workflow by @netopyr in https://github.com/hashgraph/hedera-services/pull/10322
* * fix: ensure failed `CREATE2` action is finalized w/ proper frame by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/10366
* * fix: `Erc20ContractInteractions` suite test by @petreze in https://github.com/hashgraph/hedera-services/pull/10378
* * fix: suite tests in `ERC721ContractInteractions` by @dikel in https://github.com/hashgraph/hedera-services/pull/10377
* * fix: finalize actions from stack for ALL failed creation attempts by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/10356
* * fix: correct owner/spender priority addresses by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/10312
* * fix: Match monoservice "hidden default payer" behavior by @jsync-swirlds in https://github.com/hashgraph/hedera-services/pull/10365
* * chore: move platform code out of swirlds-common by @cody-littley in https://github.com/hashgraph/hedera-services/pull/10370
* * build: update e2e and itests to use Java 21 during runtime by @nathanklick in https://github.com/hashgraph/hedera-services/pull/10376
* * fix: 10116 intake clearing by @alittley in https://github.com/hashgraph/hedera-services/pull/10306
* * chore: Turn new intake on by @alittley in https://github.com/hashgraph/hedera-services/pull/10393
* * fix: Validate records of Consensus Service handlers using snapshotMod() by @iwsimon in https://github.com/hashgraph/hedera-services/pull/10340
* * feat(ci): Add github action flow for daily performance testing by @JeffreyDallas in https://github.com/hashgraph/hedera-services/pull/9906
* * chore(ci): change order of cluster parameter  by @JeffreyDallas in https://github.com/hashgraph/hedera-services/pull/10406
* * build: update 'extra-java-module-info' for reproducible Jar patching by @jjohannes in https://github.com/hashgraph/hedera-services/pull/10362
* * chore: 09882 dashboard updates by @poulok in https://github.com/hashgraph/hedera-services/pull/10302
* * chore: Add platform-base as code owners to two platform modules by @poulok in https://github.com/hashgraph/hedera-services/pull/10324
* * chore: remove platform version by @cody-littley in https://github.com/hashgraph/hedera-services/pull/10397
* * chore: Enable `evmLazyCreateViaSolidityCallTooManyCreatesFails` HapiTest by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/10341
* * chore: add new legacy intake tests to nightly regression by @JeffreyDallas in https://github.com/hashgraph/hedera-services/pull/10394
* * fix: only enable `TargetNetworkPrep` suite by @petreze in https://github.com/hashgraph/hedera-services/pull/10410
* * fix: Consider input bytes when calculating gas cost by @stoqnkpL in https://github.com/hashgraph/hedera-services/pull/10379
* * feat: migrate event creation to new wiring framework by @cody-littley in https://github.com/hashgraph/hedera-services/pull/10236
* * feat: enable Journaled update in the EVM by @shemnon in https://github.com/hashgraph/hedera-services/pull/10395
* * fix: moving socket.close() to after server join in SocketFactoryTest by @edward-swirldslabs in https://github.com/hashgraph/hedera-services/pull/10423
* * fix: Fix typo in compare two string variables by @JeffreyDallas in https://github.com/hashgraph/hedera-services/pull/10441
* * build: fix Jar artifacts determinism by @jjohannes in https://github.com/hashgraph/hedera-services/pull/10436
* * fix: keep first cons time of current block in state by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/10404
* * fix: Flush intake prior to finishing replay by @alittley in https://github.com/hashgraph/hedera-services/pull/10452
* * fix: Make event descriptor building and accessing thread safe by @alittley in https://github.com/hashgraph/hedera-services/pull/10445
* * fix: support all 10 upgrade files from 150-159 by @povolev15 in https://github.com/hashgraph/hedera-services/pull/10369
* * fix: Add check for empty inline initcode for contract creation by @lukelee-sl in https://github.com/hashgraph/hedera-services/pull/10449
* * chore: AbstractEnumConfigConverter moved by @hendrikebbers in https://github.com/hashgraph/hedera-services/pull/10321
* * fix: windows runner failure when verifying the artifact determinism by @nathanklick in https://github.com/hashgraph/hedera-services/pull/10461
* * fix: Fix regression tests failed due to HapiGetAccountInfo by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/10455
* * fix: use `RecordBuilder` variants of result construction in transfer HtsCalls by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/10439
* * chore: create a state signer component by @lpetrovic05 in https://github.com/hashgraph/hedera-services/pull/10411
* * fix: enable someErc20NegativeTransferFromScenariosPass hapi test by @MrValioBg in https://github.com/hashgraph/hedera-services/pull/10479
* * chore: Enable some tests and ignore others by @netopyr in https://github.com/hashgraph/hedera-services/pull/10485
* * fix: make event creator ignore ancient events by @cody-littley in https://github.com/hashgraph/hedera-services/pull/10482
* * fix: `LeakyContractTestsSuite` test with top-level signatures by @stoyanov-st in https://github.com/hashgraph/hedera-services/pull/10486
* * chore: make hapi tests non private by @kimbor in https://github.com/hashgraph/hedera-services/pull/10446
* * chore: create latest immutable state nexus by @lpetrovic05 in https://github.com/hashgraph/hedera-services/pull/10291
* * fix: use the marker EXCEPTION for error level messages by @cody-littley in https://github.com/hashgraph/hedera-services/pull/10490
* * fix: NPE on reconnect teacher by @lpetrovic05 in https://github.com/hashgraph/hedera-services/pull/10503
* * fix: Enable HAPI test in `ERCPrecompileSuite` by @stoyanov-st in https://github.com/hashgraph/hedera-services/pull/10502
* * fix: always set intrinsic gas even if no gas charges by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/10499
* * chore: Add Node Death reconnect test by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/10232
* * chore: Remove `concurrentEthSpecs()` by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/10517
* * fix: Override properties for `Issue2098Spec` by @georgi-l95 in https://github.com/hashgraph/hedera-services/pull/10511
* * chore: execute the build workflow before running other workflows to improve cache utilization by @nathanklick in https://github.com/hashgraph/hedera-services/pull/10515
* * fix: Enable Tests from HelloWorldEthereumSuite by @Ivo-Yankov in https://github.com/hashgraph/hedera-services/pull/10440
* * fix: clear "side-effect fields" after switch a child record from SUCCESS to REVERTED_SUCCESS by @thenswan in https://github.com/hashgraph/hedera-services/pull/10385
* * fix: reuse `preHandleTransaction()` in `HandleWorkflow` by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/10462
* * chore: Disable some reconnect and upgrade tests for coming hedera modularization by @JeffreyDallas in https://github.com/hashgraph/hedera-services/pull/10492
* * fix: add record list checkpoint, so following & preceding child records are reverted correctly by @MrValioBg in https://github.com/hashgraph/hedera-services/pull/10137
* * fix: Correct payer account on `Issue1744Spec` by @georgi-l95 in https://github.com/hashgraph/hedera-services/pull/10510
* * chore: move saved state controller invocation by @lpetrovic05 in https://github.com/hashgraph/hedera-services/pull/10505
* * ci: change cron job to every 16 hours by @JeffreyDallas in https://github.com/hashgraph/hedera-services/pull/10491
* * test: turn on fuzzy matching on CreatePrecompileSuite by @vtronkov in https://github.com/hashgraph/hedera-services/pull/10318
* * feat: Add test setting to force ignore PCES signatures by @alittley in https://github.com/hashgraph/hedera-services/pull/10538
* * chore: Move sequence number to GossipEvent by @alittley in https://github.com/hashgraph/hedera-services/pull/10509
* * fix: Eliminate extra service registration by @mhess-swl in https://github.com/hashgraph/hedera-services/pull/10526
* * fix: race condition in wiring unit test by @cody-littley in https://github.com/hashgraph/hedera-services/pull/10525
* * chore: Config records moved to correct modules by @hendrikebbers in https://github.com/hashgraph/hedera-services/pull/10284
* * docs: Consensus Roster Terminology by @edward-swirldslabs in https://github.com/hashgraph/hedera-services/pull/9834
* * build: merge 'Sync' tasks that wrote into the same destination by @jjohannes in https://github.com/hashgraph/hedera-services/pull/10533
* * test: Fix transferFailsWithIncorrectAmounts test by @stoyanov-st in https://github.com/hashgraph/hedera-services/pull/10214
* * chore: enable passing `ContractCallSuite` specs by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/10528
* * feat(docker): add support for overriding the java main class by @nathanklick in https://github.com/hashgraph/hedera-services/pull/10460
* * feat: use address book to determine node id by @kimbor in https://github.com/hashgraph/hedera-services/pull/10453
* * feat: Unconditional, enriched, traced records of UtilPrng system contract calls by @vtronkov in https://github.com/hashgraph/hedera-services/pull/10074
* * chore: Update cgroup and ionice limits for regression workflow by @JeffreyDallas in https://github.com/hashgraph/hedera-services/pull/10519
* * fix: removed PTT log that was failing tests. by @cody-littley in https://github.com/hashgraph/hedera-services/pull/10554
* * fix: LeakyContractTestsSuite HAPI tests  by @MrValioBg in https://github.com/hashgraph/hedera-services/pull/10287
* * fix: downgrade migration testing tool errors to warnings by @cody-littley in https://github.com/hashgraph/hedera-services/pull/10556
* * build: Upgrade PBJ to 0.7.11 by @imalygin in https://github.com/hashgraph/hedera-services/pull/10426
* * fix: owngrade PTT error to a warning by @cody-littley in https://github.com/hashgraph/hedera-services/pull/10574
* * fix: `DataFileCollectionCompactionTest.testMergeUpdateSnapshotRestore` flake by @imalygin in https://github.com/hashgraph/hedera-services/pull/10577
* * chore: avoid confusing `INSUFFICIENT_PAYER_BALANCE` warnings by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/10578
* * fix: use `haltResult()` instead of throwing `HandleException` in `HtsSystemContract` by @petreze in https://github.com/hashgraph/hedera-services/pull/10534
* * chore: Follow up - Unconditional, enriched, traced records of UtilPrng system contract calls by @vtronkov in https://github.com/hashgraph/hedera-services/pull/10567
* * chore: Remove throw arg null by @mxtartaglia-sl in https://github.com/hashgraph/hedera-services/pull/10433
* * feat: Create hasher classes by @alittley in https://github.com/hashgraph/hedera-services/pull/10572
* * chore: try to stabilize concurrentEthSpecs() by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/10522
* * test: fix submittingNodeChargedNetworkFeeForIgnoringPayerUnwillingness by @mustafauzunn in https://github.com/hashgraph/hedera-services/pull/10587
* * fix: Added asserts for threads in all modifying methods by @imalygin in https://github.com/hashgraph/hedera-services/pull/10584
* * feat: design roster interfaces by @edward-swirldslabs in https://github.com/hashgraph/hedera-services/pull/10428
* * chore: Fix remaining `Crypto` tests by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/10500
* * fix: getErc20TokenNameExceedingLimits and getErc721TokenURIFromErc20TokenFails tests by @MrValioBg in https://github.com/hashgraph/hedera-services/pull/10568
* * fix: 10535 add enum converter by @mxtartaglia-sl in https://github.com/hashgraph/hedera-services/pull/10557
* * fix: Resolve EthereumSuite Errors by @Ivo-Yankov in https://github.com/hashgraph/hedera-services/pull/10230
* * fix: 10558 remove AbstractEnumConfigConverter by @mxtartaglia-sl in https://github.com/hashgraph/hedera-services/pull/10559
* * feat: add sanity precheck for contract call by @lukelee-sl in https://github.com/hashgraph/hedera-services/pull/10585
* * test: fix submittingNodeStillPaidIfServiceFeesOmitted by @mustafauzunn in https://github.com/hashgraph/hedera-services/pull/10589
* * feat: move transaction prehandling into the wiring framework by @cody-littley in https://github.com/hashgraph/hedera-services/pull/10493
* * fix: Improved error message and for properties file missing by @thomas-swirlds-labs in https://github.com/hashgraph/hedera-services/pull/10591
* * fix: ERC approve and remove scenarios by @mustafauzunn in https://github.com/hashgraph/hedera-services/pull/10325
* * chore: Disable reconnect test in CI  by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/10603
* * feat: add manual link support to wiring diagram by @cody-littley in https://github.com/hashgraph/hedera-services/pull/10607
* * feat: html improvements by @alittley in https://github.com/hashgraph/hedera-services/pull/10600
* * fix: adding enum mention to supported datatypes by @mxtartaglia-sl in https://github.com/hashgraph/hedera-services/pull/10596
* * fix: sync ppm optimization by @cody-littley in https://github.com/hashgraph/hedera-services/pull/10569
* * fix: add event creation throttle for new intake pipeline by @cody-littley in https://github.com/hashgraph/hedera-services/pull/10611
* * feat: Add broken up version of PCES classes by @alittley in https://github.com/hashgraph/hedera-services/pull/10595
* * chore: update gradle to support Java 21 by @JeffreyDallas in https://github.com/hashgraph/hedera-services/pull/10513
* * chore: Misc contract cleanup and fixes by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/10634
* * fix: Add a feature flag for token balances and token relationships and enable them by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/10638
* * test: Enable fuzzy matching in LogsSuite by @stoyanov-st in https://github.com/hashgraph/hedera-services/pull/10630
* * fix: enable fuzzy record matching in some of the smart contract operations by @MrValioBg in https://github.com/hashgraph/hedera-services/pull/10625
* * fix: conditional records of hollow account creation via internal transfer with `EthereumTransaction` by @MiroslavGatsanoga in https://github.com/hashgraph/hedera-services/pull/10539
* * fix: `Issue305Spec` test by @dikel in https://github.com/hashgraph/hedera-services/pull/10437
* * chore: cleanup while itemizing remaining disabled specs  by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/10640
* * fix: `DuplicateManagementTest` tests by @dikel in https://github.com/hashgraph/hedera-services/pull/10622
* * fix: bug when node is removed by @cody-littley in https://github.com/hashgraph/hedera-services/pull/10643
* * fix: SigningReqsSuite by @agadzhalov in https://github.com/hashgraph/hedera-services/pull/10592
* * fix: bind prehandle signature transactions to correct handle by @cody-littley in https://github.com/hashgraph/hedera-services/pull/10649
* * fix: rate limit spammy log by @cody-littley in https://github.com/hashgraph/hedera-services/pull/10646
* * chore: create new production-next docker image definitions  by @nathanklick in https://github.com/hashgraph/hedera-services/pull/10652
* * chore: accommodate unclassifiable statuses in mod-service by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/10651
* * chore(ci): removes the legacy CircleCI configuration files by @nathanklick in https://github.com/hashgraph/hedera-services/pull/10655
* * chore(ci): gate the expensive pull request checks behind the spotless & module info checks by @nathanklick in https://github.com/hashgraph/hedera-services/pull/10657
* * chore: Add test for create2  by @stoqnkpL in https://github.com/hashgraph/hedera-services/pull/7559
* * chore: merge the dual state into the platform state by @cody-littley in https://github.com/hashgraph/hedera-services/pull/10429
* * chore: Fix StakingSuite in mono and modular service by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/10590
* * chore(ci): add support for docker image determinism checking by @nathanklick in https://github.com/hashgraph/hedera-services/pull/10662
* * chore: replacing `minGenNonAncient` data flow with `NonAncientEventWindow`  by @edward-swirldslabs in https://github.com/hashgraph/hedera-services/pull/10597
* * fix: JTR tool compatible with Java 21 by @edward-swirldslabs in https://github.com/hashgraph/hedera-services/pull/10672
* * chore: update JTR test metadata file by @edward-swirldslabs in https://github.com/hashgraph/hedera-services/pull/10674
* * chore(ci): reduce macOS runner usage footprint by @nathanklick in https://github.com/hashgraph/hedera-services/pull/10676
* * feat: add time to the platform context by @cody-littley in https://github.com/hashgraph/hedera-services/pull/10679
* * fix: state leak (#10690) by @cody-littley in https://github.com/hashgraph/hedera-services/pull/10707
* * fix: node removal bug by @cody-littley in https://github.com/hashgraph/hedera-services/pull/10742
* * fix: Mark prehandle as complete in legacy intake pipeline by @alittley in https://github.com/hashgraph/hedera-services/pull/10732
* * ci: 0.46 cherry pick fix long file name by @JeffreyDallas in https://github.com/hashgraph/hedera-services/pull/10745
* * fix: Solve bad metric units (#10777) by @alittley in https://github.com/hashgraph/hedera-services/pull/10781
* * chore: cherry pick #10750 by @lukelee-sl in https://github.com/hashgraph/hedera-services/pull/10778
* * fix: cherry pick fix permissions for upgrade test (#10779) by @JeffreyDallas in https://github.com/hashgraph/hedera-services/pull/10809
* * chore: Cherry pick 9628 by @lukelee-sl in https://github.com/hashgraph/hedera-services/pull/10938
* * chore: Update local-node Docker images to Java 21 (cherry pick #10834) by @isavov in https://github.com/hashgraph/hedera-services/pull/10968
* * fix: disable sync filtering by @cody-littley in https://github.com/hashgraph/hedera-services/pull/11020
* * chore:  cherry pick #11013 by @lukelee-sl in https://github.com/hashgraph/hedera-services/pull/11025
* ## New Contributors
* * @jamesnguyentech made their first contribution in https://github.com/hashgraph/hedera-services/pull/10249
* * @thomas-swirlds-labs made their first contribution in https://github.com/hashgraph/hedera-services/pull/10591
* **Full Changelog**: https://github.com/hashgraph/hedera-services/compare/v0.45.2...v0.46.0

**Full Changelog**: [v0.46.0...v0.46.0](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.46.0...v0.46.0)

</details>

## Release v0.45

### [Build v0.45.2](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.45.2)

<details>
<summary><strong>What's Changed</strong></summary>

* * fix: Added a feature flag which is by default enabled to disable tokenBalances and tokenRelationships in `getAccountInfo`, `getAccountBalance` and `getContractInfo` queries. https://github.com/hashgraph/hedera-services/pull/10639
* **Full Changelog**: https://github.com/hashgraph/hedera-services/compare/v0.45.1...v0.45.2

**Full Changelog**: [v0.45.0...v0.45.2](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.45.0...v0.45.2)

</details>

### [Build v0.45.0](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.45.0)

<details>
<summary><strong>What's Changed</strong></summary>

* * Populate evm function result on failing eth transaction by @stoqnkpL in https://github.com/hashgraph/hedera-services/pull/9453
* * Disable compression. by @cody-littley in https://github.com/hashgraph/hedera-services/pull/9554
* * Fix tests in unique token management spec by @mhess-swl in https://github.com/hashgraph/hedera-services/pull/9537
* * enaled one more test and remove the other one that not really in use by @povolev15 in https://github.com/hashgraph/hedera-services/pull/9557
* * Enable tests from CannotDeleteSystemEntitiesSuite by @Ivo-Yankov in https://github.com/hashgraph/hedera-services/pull/9440
* * Fix tests in ContractBurnHTSSuite by @agadzhalov in https://github.com/hashgraph/hedera-services/pull/9572
* * Tune dependency scopes by @jjohannes in https://github.com/hashgraph/hedera-services/pull/8455
* * unneeded calls to swirlds-common removed by @hendrikebbers in https://github.com/hashgraph/hedera-services/pull/9003
* * Fixed CryptoRecordsSanityCheckSuite by @iwsimon in https://github.com/hashgraph/hedera-services/pull/9551
* * Enable test from AssociatePrecompileSuite by @mustafauzunn in https://github.com/hashgraph/hedera-services/pull/9571
* * Implement TransactionRateMultiplierSource by @MiroslavGatsanoga in https://github.com/hashgraph/hedera-services/pull/9305
* * 9514: Reduce Java allocations when sending internal node hashes during reconnect by @artemananiev in https://github.com/hashgraph/hedera-services/pull/9538
* * Address PR review comments for #8374 by @vtronkov in https://github.com/hashgraph/hedera-services/pull/9266
* * 9479: Add more logs to debug virtual map reconnect issues by @artemananiev in https://github.com/hashgraph/hedera-services/pull/9481
* * Increase contract kv/pairs storage allowed by 100x by @lukelee-sl in https://github.com/hashgraph/hedera-services/pull/9581
* * Populate evm function result on failing eth transaction (modulatized … by @stoqnkpL in https://github.com/hashgraph/hedera-services/pull/9569
* * old logging API moved to legacy package by @hendrikebbers in https://github.com/hashgraph/hedera-services/pull/8459
* * 09449 Create data consistency validator by @alittley in https://github.com/hashgraph/hedera-services/pull/9549
* * Support fuzzy-matching record snapshots by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/9513
* * 9559 Increased timeout in the assertions to prevent non-deterministic failures. by @imalygin in https://github.com/hashgraph/hedera-services/pull/9560
* * Fix compile breakage in develop following package move of logging. by @jsync-swirlds in https://github.com/hashgraph/hedera-services/pull/9600
* * Cleanup Module patching by @jjohannes in https://github.com/hashgraph/hedera-services/pull/8561
* * Make platform mainnet settings the default by @poulok in https://github.com/hashgraph/hedera-services/pull/9341
* * Measure consensus metrics for all events. by @cody-littley in https://github.com/hashgraph/hedera-services/pull/9604
* * 09543 d remove crypto class by @lpetrovic05 in https://github.com/hashgraph/hedera-services/pull/9544
* * remove static from all the test in MiscCryptoSuite by @povolev15 in https://github.com/hashgraph/hedera-services/pull/9619
* * Bump services version for 0.45 release by @iwsimon in https://github.com/hashgraph/hedera-services/pull/9606
* * Stop nightly regression run for release 0.42 by @JeffreyDallas in https://github.com/hashgraph/hedera-services/pull/9607
* * Make scheduled txn records queryable from `ScheduleCreate` payer account by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/9612
* * Fix TokenInfoHTSSuite tests by @MiroslavGatsanoga in https://github.com/hashgraph/hedera-services/pull/9509
* * Reversible preceding transactions by @netopyr in https://github.com/hashgraph/hedera-services/pull/9594
* * Add a non-daemon thread. by @cody-littley in https://github.com/hashgraph/hedera-services/pull/9642
* * #9626 Move v2 package to main package by @timo0 in https://github.com/hashgraph/hedera-services/pull/9627
* * 08931 d reconnect across ab changes by @lpetrovic05 in https://github.com/hashgraph/hedera-services/pull/9596
* * Support for @Tag in HapiTestEngine by @vtronkov in https://github.com/hashgraph/hedera-services/pull/9490
* * Wiring Framework by @cody-littley in https://github.com/hashgraph/hedera-services/pull/9482
* * Cherry-pick : Fix NPE in `TokenWipe` when using missing alias for an account by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/9644
* * Implement ContractUpdateHandler.handle by @vtronkov in https://github.com/hashgraph/hedera-services/pull/9379
* * Fix More Txn Receipt Tests by @mhess-swl in https://github.com/hashgraph/hedera-services/pull/9621
* * Fix issues related to auto-account creation flows by @rbair23 in https://github.com/hashgraph/hedera-services/pull/9539
* * Implement `LinkedEventIntake` by @alittley in https://github.com/hashgraph/hedera-services/pull/9532
* * Create orphan buffer wiring by @alittley in https://github.com/hashgraph/hedera-services/pull/9668
* * Add comments to failing record regression tests by @mhess-swl in https://github.com/hashgraph/hedera-services/pull/9672
* * Bump shimataro/ssh-key-action from 2.5.1 to 2.6.1 by @dependabot in https://github.com/hashgraph/hedera-services/pull/9252
* * Bump actions/checkout from 4.1.0 to 4.1.1 by @dependabot in https://github.com/hashgraph/hedera-services/pull/9324
* * Create Genesis Blocklist Accounts by @mhess-swl in https://github.com/hashgraph/hedera-services/pull/8802
* * Enable `HollowAccountFinalizationSuite` by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/9535
* * Fixed canUseEip1014AliasesForXfers and updateMaxAutoAssociationsWorks by @iwsimon in https://github.com/hashgraph/hedera-services/pull/9667
* * CryptoGetRecordsRegression Suite by @povolev15 in https://github.com/hashgraph/hedera-services/pull/9673
* * Stabilize fuzzy matching by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/9661
* * chore: enable full feature support for the unit test reporting steps by @nathanklick in https://github.com/hashgraph/hedera-services/pull/9698
* * Create wiring objects for intake components by @alittley in https://github.com/hashgraph/hedera-services/pull/9676
* * Adding JRS Test Meta Data by @edward-swirldslabs in https://github.com/hashgraph/hedera-services/pull/9703
* * fix NPE in FileServiceUtil by @povolev15 in https://github.com/hashgraph/hedera-services/pull/9688
* * chore: publish release artifacts to the public CDN by @nathanklick in https://github.com/hashgraph/hedera-services/pull/9702
* * chore: normalize test output across all Gradle projects by @nathanklick in https://github.com/hashgraph/hedera-services/pull/9709
* * address comments from pr #9519 by @lukelee-sl in https://github.com/hashgraph/hedera-services/pull/9521
* * Enable remaining tests from TokenTransactSpecs by @Ivo-Yankov in https://github.com/hashgraph/hedera-services/pull/9313
* * fix: issue with workflow due to missing brace by @nathanklick in https://github.com/hashgraph/hedera-services/pull/9742
* * 09674 Rework intake components for framework compatibility by @alittley in https://github.com/hashgraph/hedera-services/pull/9706
* * 9559 Improved asserts for latches. by @imalygin in https://github.com/hashgraph/hedera-services/pull/9669
* * Fixed JTR bug. by @cody-littley in https://github.com/hashgraph/hedera-services/pull/9716
* * Added heartbeats to wiring framework. by @cody-littley in https://github.com/hashgraph/hedera-services/pull/9664
* * Fix flaky wiring test. by @cody-littley in https://github.com/hashgraph/hedera-services/pull/9745
* * Fix `AutoAccountCreationSuite` Fees by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/9726
* * Added offer soldering. by @cody-littley in https://github.com/hashgraph/hedera-services/pull/9671
* * Remove stale data from JTR metadata file. by @cody-littley in https://github.com/hashgraph/hedera-services/pull/9753
* * Preserve logic via dependency migration test by @mhess-swl in https://github.com/hashgraph/hedera-services/pull/9723
* * Auto-snapshot management by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/9739
* * chore: enable support for the Gradle build cache node by @nathanklick in https://github.com/hashgraph/hedera-services/pull/9763
* * flatten obsolete components by @lpetrovic05 in https://github.com/hashgraph/hedera-services/pull/9653
* * Support "isolated" flag on HapiTestSuite by @rbair23 in https://github.com/hashgraph/hedera-services/pull/8733
* * ExternalizeResult for AbstractRevertibleTokenViewCall by @mustafauzunn in https://github.com/hashgraph/hedera-services/pull/9737
* * Fix E2E tests in TokenUpdatePrecompileSuite by @petreze in https://github.com/hashgraph/hedera-services/pull/9625
* * Fix test CryptoCreateSuite.syntaxChecksAreAsExpected by @kimbor in https://github.com/hashgraph/hedera-services/pull/9677
* * Fix develop while adding responseCode as the additional required parameter by @petreze in https://github.com/hashgraph/hedera-services/pull/9768
* * Fix PrngSeedOperationSuite HAPI tests by @lukelee-sl in https://github.com/hashgraph/hedera-services/pull/9724
* * Fixed typo in BlockRecordManagerImpl.java comments by @nickpoorman in https://github.com/hashgraph/hedera-services/pull/9718
* * Add support for underscored numerical literals in Configuration Converters by @MrValioBg in https://github.com/hashgraph/hedera-services/pull/9682
* * fixed AllBaseOpFeesSuite.NftMintsScaleLinearlyBasedOnNumberOfSignatures by @iwsimon in https://github.com/hashgraph/hedera-services/pull/9754
* * Fix E2E tests in TokenExpiryInfoSuite by @petreze in https://github.com/hashgraph/hedera-services/pull/9686
* * Add test to confirm preceding child record for HTS transfer by @georgi-l95 in https://github.com/hashgraph/hedera-services/pull/9735
* * Validations for dispatchSyntheticTxn by @mustafauzunn in https://github.com/hashgraph/hedera-services/pull/9308
* * Add gradle cache credential by @JeffreyDallas in https://github.com/hashgraph/hedera-services/pull/9772
* * chore: apply limits to the Gradle parallelism to stabilize the Github runner agent by @nathanklick in https://github.com/hashgraph/hedera-services/pull/9777
* * Dumper for token associations (tokenrels) by @david-bakin-sl in https://github.com/hashgraph/hedera-services/pull/9695
* * Support complex keys in `VerificationStrategy.asSignatureTestIn()` standalone key verifier by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/9765
* * Fix handling of custom fees in token create transaction builder by @MrValioBg in https://github.com/hashgraph/hedera-services/pull/9632
* * Remaining system file updates by @netopyr in https://github.com/hashgraph/hedera-services/pull/9354
* * Fix #8071 Remove SQL dependency by @timo0 in https://github.com/hashgraph/hedera-services/pull/9740
* * Include gas fee in `ContractCreate` and `ContractCall` record `transactionFee` fields by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/9774
* * Fixed AddressAliasIdFuzzing by @iwsimon in https://github.com/hashgraph/hedera-services/pull/9779
* * Adding test flow for ubuntu 2204 by @JeffreyDallas in https://github.com/hashgraph/hedera-services/pull/9655
* * 9477: Direct memory / data source leak if teacher becomes inaccessible during reconnect by @artemananiev in https://github.com/hashgraph/hedera-services/pull/9780
* * Fix ApproveAllowanceSuite tests by @thenswan in https://github.com/hashgraph/hedera-services/pull/9649
* * jmh benchmarks added to swirlds-base by @hendrikebbers in https://github.com/hashgraph/hedera-services/pull/8074
* * Fix cannotUseMoreThanChildContractLimit test by @MiroslavGatsanoga in https://github.com/hashgraph/hedera-services/pull/9707
* * Fix tests from GasLimitThrottlingSuite by @MiroslavGatsanoga in https://github.com/hashgraph/hedera-services/pull/9630
* * Fix `ContractCreate` child record stream items (both top-level and internal) by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/9781
* * move atomic classes from metrics to concurrent classes by @hendrikebbers in https://github.com/hashgraph/hedera-services/pull/9704
* * Documentation moved to platform by @hendrikebbers in https://github.com/hashgraph/hedera-services/pull/9789
* * chore: Enable HapiTest debug via environment variable by @jsync-swirlds in https://github.com/hashgraph/hedera-services/pull/9824
* * 9764: ReconnectNodeRemover.getRecordsToDelete() loops forever by @artemananiev in https://github.com/hashgraph/hedera-services/pull/9800
* * Minor improvements to exception handling and null checks by @lukelee-sl in https://github.com/hashgraph/hedera-services/pull/9813
* * Delete critical quorum. by @cody-littley in https://github.com/hashgraph/hedera-services/pull/9761
* * Update modrun mainClass to correct file by @mhess-swl in https://github.com/hashgraph/hedera-services/pull/9833
* * Metrics api splitted to provide metrics module by @hendrikebbers in https://github.com/hashgraph/hedera-services/pull/9701
* * reconnect end msg by @lpetrovic05 in https://github.com/hashgraph/hedera-services/pull/9818
* * Fix transfer tests for fees in LeakyContractTestsSuite by @MrValioBg in https://github.com/hashgraph/hedera-services/pull/9817
* * Fix ContractHTSSuite tests by @thenswan in https://github.com/hashgraph/hedera-services/pull/9732
* * Copy the PCES into saved state directories. by @cody-littley in https://github.com/hashgraph/hedera-services/pull/9809
* * Throw if gsutil not installed by @alittley in https://github.com/hashgraph/hedera-services/pull/9856
* * 9839 Prevented possible NPE caused by a race condition by @imalygin in https://github.com/hashgraph/hedera-services/pull/9840
* * remove reconnect abort by @lpetrovic05 in https://github.com/hashgraph/hedera-services/pull/9741
* * Fix `updateHappyPath` in `TokenUpdateSpec` by @georgi-l95 in https://github.com/hashgraph/hedera-services/pull/9850
* * TokenAndTypeCheckFix (#9672) by @ilko-iliev-lime in https://github.com/hashgraph/hedera-services/pull/9844
* * Fix `customFeesOnlyUpdatableWithKey` in `TokenUpdateSpec` by @georgi-l95 in https://github.com/hashgraph/hedera-services/pull/9832
* * Ensure all non-daemon threads are shutdown even if `exec()` throws  by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/9871
* * Create2OperationSuite - enable 2 more tests #9394 by @JivkoKelchev in https://github.com/hashgraph/hedera-services/pull/9875
* * 09665 9670 direct scheduler by @cody-littley in https://github.com/hashgraph/hedera-services/pull/9830
* * Fix flaky queue thread pause test by @cody-littley in https://github.com/hashgraph/hedera-services/pull/9866
* * 09562 sync plus plus minus by @cody-littley in https://github.com/hashgraph/hedera-services/pull/9563
* * Add missing gradle cache credential by @JeffreyDallas in https://github.com/hashgraph/hedera-services/pull/9858
* * Enable some tests from ERCPrecompileSuite by @mustafauzunn in https://github.com/hashgraph/hedera-services/pull/9854
* * Fix ContractUpdateSuite and address ContractUpdateHandle comments by @vtronkov in https://github.com/hashgraph/hedera-services/pull/9847
* * Fix records for `CryptoTransferSuite` by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/9771
* * Detect delegated sender authorization in `CustomMessageCallProcessor`  by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/9814
* * Add data on disk dashboard by @beeradb in https://github.com/hashgraph/hedera-services/pull/9714
* * Mirror fractional time usage in phase timer by @alittley in https://github.com/hashgraph/hedera-services/pull/9892
* * Documentation of the Platform Base Scope by @hendrikebbers in https://github.com/hashgraph/hedera-services/pull/9787
* * Enable leftover tests from TokenAssociateSpecs by @Ivo-Yankov in https://github.com/hashgraph/hedera-services/pull/9541
* * Create SEQENTIAL_THREAD scheduler. by @cody-littley in https://github.com/hashgraph/hedera-services/pull/9835
* * Fuzzy match records in `AutoAccountCreationSuite` by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/9864
* * Enable transfer tests from ERCPrecompileSuite by @mustafauzunn in https://github.com/hashgraph/hedera-services/pull/9905
* * Fix `gasLimitOverMaxGasLimitFailsPrecheck` and `createGasLimitOverMaxGasLimitFailsPrecheck`  by @MrValioBg in https://github.com/hashgraph/hedera-services/pull/9877
* * Fix race condition in PCES file copy. by @cody-littley in https://github.com/hashgraph/hedera-services/pull/9890
* * 09837 9578 advanced wire transformers by @cody-littley in https://github.com/hashgraph/hedera-services/pull/9894
* * Atomic double test moved and old AtomicDouble class removed by @hendrikebbers in https://github.com/hashgraph/hedera-services/pull/9900
* * Fix some tests from LazyCreateThroughPrecompileSuite by @MiroslavGatsanoga in https://github.com/hashgraph/hedera-services/pull/9769
* * Support @Tag annotation on a class level by @vtronkov in https://github.com/hashgraph/hedera-services/pull/9927
* * System files reference by @netopyr in https://github.com/hashgraph/hedera-services/pull/9924
* * HIP-796 `HapiSpec`'s by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/9870
* * Fix remaining contract x tests by @stoyanov-st in https://github.com/hashgraph/hedera-services/pull/9930
* * Fix `standardImmutabilitySemanticsHold` in `TokenUpdateSpec` by @georgi-l95 in https://github.com/hashgraph/hedera-services/pull/9913
* * Resolve RedirectPrecompileSuite by @mustafauzunn in https://github.com/hashgraph/hedera-services/pull/9934
* * Adjust the key gathering context methods to translate exceptions from preHandle by @jsync-swirlds in https://github.com/hashgraph/hedera-services/pull/9841
* * Add base team to module-info and swirlds-logging modules by @poulok in https://github.com/hashgraph/hedera-services/pull/9868
* * Cleaner generics for input wires. by @cody-littley in https://github.com/hashgraph/hedera-services/pull/9916
* * #9910 Introduce config-extensions module by @timo0 in https://github.com/hashgraph/hedera-services/pull/9911
* * Allow specifying alternate JRS test directory for JTR report by @alittley in https://github.com/hashgraph/hedera-services/pull/9940
* * Fix ScheduleSignHandler signature trim and verification building by @jsync-swirlds in https://github.com/hashgraph/hedera-services/pull/9920
* * Implement pureChecks for file handler classes by @kimbor in https://github.com/hashgraph/hedera-services/pull/9921
* * Add logic for detection of illegal direct scheduler use. by @cody-littley in https://github.com/hashgraph/hedera-services/pull/9941
* * Fix HAPI tests in LeakyContractTestSuite. by @MrValioBg in https://github.com/hashgraph/hedera-services/pull/9884
* * Disable RecordStreamValidations in CI by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/9948
* * Triple removed from base by @hendrikebbers in https://github.com/hashgraph/hedera-services/pull/9902
* * Remove the check in `FileAppendHandler`  to see contents of the file are empty by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/9960
* * schedule create specs by @povolev15 in https://github.com/hashgraph/hedera-services/pull/9914
* * Move `Hip17UnhappyAccountsSuite` tests for expiry to new suite by @georgi-l95 in https://github.com/hashgraph/hedera-services/pull/9956
* * Set minimum version to run regression as release 0.44 by @JeffreyDallas in https://github.com/hashgraph/hedera-services/pull/9961
* * 09943 9939 detect unbound wires by @cody-littley in https://github.com/hashgraph/hedera-services/pull/9949
* * Fixed HollowAccountCompletionFuzzing by @iwsimon in https://github.com/hashgraph/hedera-services/pull/9947
* * Add migration properties needed for synthetic records by @mhess-swl in https://github.com/hashgraph/hedera-services/pull/9897
* * Validate and fix fuzzy records in `HollowAccountFinalizationSuite` by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/9904
* * #9427: Revert after INVALID_ACCOUNT_ID static call by @ilko-iliev-lime in https://github.com/hashgraph/hedera-services/pull/9931
* * signed state reserver by @lpetrovic05 in https://github.com/hashgraph/hedera-services/pull/9821
* * 9944 Fix record cache handling to remediate "RECORD_NOT_FOUND" responses. by @jsync-swirlds in https://github.com/hashgraph/hedera-services/pull/9946
* * Gradle: set moduleNamePrefix for ModuleDirectivesOrderingCheck (com.swirlds... modules) by @jjohannes in https://github.com/hashgraph/hedera-services/pull/9881
* * Enable Gradle Configuration Cache by @jjohannes in https://github.com/hashgraph/hedera-services/pull/9651
* * fix: run 'releaseEvmMavenCentral' with --no-configuration-cache by @jjohannes in https://github.com/hashgraph/hedera-services/pull/10027
* * signed state file manager component by @lpetrovic05 in https://github.com/hashgraph/hedera-services/pull/9933
* * fix: enable last 2 tests from ContractCreateSuite by @MiroslavGatsanoga in https://github.com/hashgraph/hedera-services/pull/10050
* * chore: simplify Gradle signing setup by @jjohannes in https://github.com/hashgraph/hedera-services/pull/10051
* * 09971 simple timer api by @cody-littley in https://github.com/hashgraph/hedera-services/pull/9972
* * Externalize the generation of child records for view calls by @petreze in https://github.com/hashgraph/hedera-services/pull/9795
* * Always transition to FREEZE_COMPLETE if a freeze state is saved by @alittley in https://github.com/hashgraph/hedera-services/pull/10026
* * Fix PCES copy bugs. by @cody-littley in https://github.com/hashgraph/hedera-services/pull/10057
* * Gradle: fix 'hedera-protobufs' git pull by @jjohannes in https://github.com/hashgraph/hedera-services/pull/10061
* * Update MigrationTestingTool version by @poulok in https://github.com/hashgraph/hedera-services/pull/10033
* * chore: disable Gradle configuration cache and parallelism when releasing to Maven Central by @nathanklick in https://github.com/hashgraph/hedera-services/pull/10066
* * Bump mikefarah/yq from 4.35.2 to 4.40.2 by @dependabot in https://github.com/hashgraph/hedera-services/pull/10037
* * Bump google-github-actions/auth from 1.1.1 to 1.2.0 by @dependabot in https://github.com/hashgraph/hedera-services/pull/10035
* * Bump fjogeleit/http-request-action from 1.14.1 to 1.14.2 by @dependabot in https://github.com/hashgraph/hedera-services/pull/10036
* * Bump docker/build-push-action from 5.0.0 to 5.1.0 by @dependabot in https://github.com/hashgraph/hedera-services/pull/9978
* * chore: adds linux control group support by @nathanklick in https://github.com/hashgraph/hedera-services/pull/10034
* * Fix previewnet deployment workflow to use correct Jenkins pipeline name for validation by @ElijahLynn in https://github.com/hashgraph/hedera-services/pull/10068
* * Add PCLI bootstrap argument. by @cody-littley in https://github.com/hashgraph/hedera-services/pull/10064
* * Split HAPI tests and run them concurrently in CI by @netopyr in https://github.com/hashgraph/hedera-services/pull/9880
* * `CreatePrecompileSuite` fixed E2E tests  by @agadzhalov in https://github.com/hashgraph/hedera-services/pull/9792
* * Enable DelegatePrecompileSuite tests by @mustafauzunn in https://github.com/hashgraph/hedera-services/pull/10071
* * Ensure ETH account creation is not throttled by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/10079
* * 09448 Implement intake with new framework by @alittley in https://github.com/hashgraph/hedera-services/pull/9747
* * 09485 9448 pcli wiring diagram by @cody-littley in https://github.com/hashgraph/hedera-services/pull/10029
* * Fuzzy Match `CryptoUpdateSuite` records by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/9982
* * Use a lock on StreamFileProducerConcurrent properties to prevent race by @nickpoorman in https://github.com/hashgraph/hedera-services/pull/9762
* * Catch UncheckedIOException during PCES file copy. by @cody-littley in https://github.com/hashgraph/hedera-services/pull/10083
* * Enable HRCPrecompileSuite tests by @mustafauzunn in https://github.com/hashgraph/hedera-services/pull/10073
* * Enable passing StakingSuite tests by @MiroslavGatsanoga in https://github.com/hashgraph/hedera-services/pull/9378
* * 09999 09683 remove dump state on iss by @lpetrovic05 in https://github.com/hashgraph/hedera-services/pull/10003
* * #10095 Extend Context as preparation for logging PR by @timo0 in https://github.com/hashgraph/hedera-services/pull/10096
* * cherry picked nexus by @lpetrovic05 in https://github.com/hashgraph/hedera-services/pull/10004
* * Config annotation processor antlr by @hendrikebbers in https://github.com/hashgraph/hedera-services/pull/7920
* * Fix ContractRecordSanityCheckSuite by @stoyanov-st in https://github.com/hashgraph/hedera-services/pull/9042
* * Enable transferErc20TokenFromContractWithApproval HAPI test by @stoyanov-st in https://github.com/hashgraph/hedera-services/pull/9957
* * Add negative X tests scenarios for key verification on token update by @petreze in https://github.com/hashgraph/hedera-services/pull/10094
* * Gradle: Version Upgrades - SnakeYAML and Jackson / Module Name fixes by @jjohannes in https://github.com/hashgraph/hedera-services/pull/9989
* * fix additional 2 tests in FileUpdateSuite by @povolev15 in https://github.com/hashgraph/hedera-services/pull/10032
* * 10090 Upgrade PBJ to 0.7.7 by @imalygin in https://github.com/hashgraph/hedera-services/pull/10091
* * Provide more X test for burnToken key verification by @agadzhalov in https://github.com/hashgraph/hedera-services/pull/10092
* * Provide more Delete X tests for Non-payer key verification by @dikel in https://github.com/hashgraph/hedera-services/pull/10103
* * feat: schedule create throttling by @MiroslavGatsanoga in https://github.com/hashgraph/hedera-services/pull/9994
* * fix: enable tests from Issue2051spec by @Ivo-Yankov in https://github.com/hashgraph/hedera-services/pull/9791
* * Cherry-pick NFT allowance check on auto-creation by @nathanklick in https://github.com/hashgraph/hedera-services/pull/10125
* * documentation & module tests for config by @hendrikebbers in https://github.com/hashgraph/hedera-services/pull/9953
* * Move benchmarks of config to config module by @hendrikebbers in https://github.com/hashgraph/hedera-services/pull/9879
* * moved tests and testFixtures from swirlds-common-testing to swirlds-common by @hendrikebbers in https://github.com/hashgraph/hedera-services/pull/9849
* * Revert PBJ version back `0.7.6` by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/10130
* * Provide more X tests for Non-payer Key verification by @stoyanov-st in https://github.com/hashgraph/hedera-services/pull/9937
* * Fix `whitelistpositivecase` test in LeakyContractTestsSuite by @MrValioBg in https://github.com/hashgraph/hedera-services/pull/9955
* * add additional 2 tests to ScheduleCreateSpecs by @povolev15 in https://github.com/hashgraph/hedera-services/pull/10129
* * Fix inital set of ScheduleExecutionSpecs HapiTest methods. by @jsync-swirlds in https://github.com/hashgraph/hedera-services/pull/9979
* * Use legacy intake pipeline by default by @alittley in https://github.com/hashgraph/hedera-services/pull/10120
* * Transition to RECONNECT_COMPLETE earlier in the process by @alittley in https://github.com/hashgraph/hedera-services/pull/10078
* * Add a spec for Restart test by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/10105
* * 9483 Added metrics for total space consumption by compaction level by @imalygin in https://github.com/hashgraph/hedera-services/pull/10086
* * 9975 Fix ScheduleExecutionSpecs methods that do not execute by @jsync-swirlds in https://github.com/hashgraph/hedera-services/pull/10088
* * Add negative X tests scenarios for key verification on token create by @petreze in https://github.com/hashgraph/hedera-services/pull/10122
* * Use Google AutoService for SPI by @hendrikebbers in https://github.com/hashgraph/hedera-services/pull/10113
* * JMH benchmarks moved to test module to platform-core by @hendrikebbers in https://github.com/hashgraph/hedera-services/pull/10131
* * #9990 Move rest of config related classes from swirlds-common to conf… by @timo0 in https://github.com/hashgraph/hedera-services/pull/9991
* * 10153: Comparator wrapped in lambda generates lots of garbage by @OlegMazurov in https://github.com/hashgraph/hedera-services/pull/10154
* * Fix CongestionPricingSuite by @JivkoKelchev in https://github.com/hashgraph/hedera-services/pull/9965
* * Disable failed upgrade tests by @JeffreyDallas in https://github.com/hashgraph/hedera-services/pull/10169
* * Provide more Mint X tests for Non-payer key verification by @dikel in https://github.com/hashgraph/hedera-services/pull/10077
* * Enable tests from ERCPrecompileSuite by @mustafauzunn in https://github.com/hashgraph/hedera-services/pull/9995
* * 2095 fix redundant unused statements in test code by @mwb-al in https://github.com/hashgraph/hedera-services/pull/10163
* * Add pause unit test by @alittley in https://github.com/hashgraph/hedera-services/pull/10152
* * fix(HapiTest): fixing null pointer exception in hapi in process test node shutdown. by @jsync-swirlds in https://github.com/hashgraph/hedera-services/pull/10156
* * Fix ISS detection. by @cody-littley in https://github.com/hashgraph/hedera-services/pull/10183
* * fix: disable Gradle cache cleanup features by @nathanklick in https://github.com/hashgraph/hedera-services/pull/10203
* * chore: add new pull request formatting check workflow by @nathanklick in https://github.com/hashgraph/hedera-services/pull/10196
* * fix: enable ContractKeysStillWorkAsExpectedSuite tests  by @thenswan in https://github.com/hashgraph/hedera-services/pull/10039
* * fix: 09872: MerkleSynchronizationException: Timed out waiting to supply a new leaf to the hashing iterator buffer by @OlegMazurov in https://github.com/hashgraph/hedera-services/pull/10158
* * chore: Schedule release branch creation for 0.45 by @iwsimon in https://github.com/hashgraph/hedera-services/pull/10208
* * chore: create emergency state nexus separate from the SSM by @lpetrovic05 in https://github.com/hashgraph/hedera-services/pull/10076
* * fix: canMergeCreate2MultipleCreatesWithHollowAccount by @agadzhalov in https://github.com/hashgraph/hedera-services/pull/10141
* * fix: clear expired EventImpls instead of simply discarding by @alittley in https://github.com/hashgraph/hedera-services/pull/10199
* * chore: Fix BLOCKS `migrationRecordsStreamed` flag on restart by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/10213
* * chore: update .gitignore to exclude generated files located in */data/* directory by @mmalik-al in https://github.com/hashgraph/hedera-services/pull/10164
* * chore: use the pull request base branch as a fallback by @nathanklick in https://github.com/hashgraph/hedera-services/pull/10205
* * feat: Stop returning token associations and token balances data in queries as per HIP-367 by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/10149
* * fix: Handle ArithmeticException in safeFractionMultiply() by @iwsimon in https://github.com/hashgraph/hedera-services/pull/10200
* * chore(ci): change the trigger on the PR Formatting workflow by @nathanklick in https://github.com/hashgraph/hedera-services/pull/10270
* * chore: ensure the pull request check workflow properly handles forks by @nathanklick in https://github.com/hashgraph/hedera-services/pull/10271
* * build: do not publish test fixtures (release/0.45) by @jjohannes in https://github.com/hashgraph/hedera-services/pull/10276
* * fix: Compact last PCES file at boot time by @cody-littley in https://github.com/hashgraph/hedera-services/pull/10262
* * chore: Cherry pick #10348 by @lukelee-sl in https://github.com/hashgraph/hedera-services/pull/10368
* * fix: ensure failed `CREATE2` action is finalized w/ proper frame by @tinker-michaelj in https://github.com/hashgraph/hedera-services/pull/10367
* * fix: Consider input bytes when calculating gas cost (#10379) by @stoqnkpL in https://github.com/hashgraph/hedera-services/pull/10420
* * chore: Drop upgrade test support for Ubuntu 18.04 by @JeffreyDallas in https://github.com/hashgraph/hedera-services/pull/10442
* * fix: Add check for empty inline initcode for contract creation by @lukelee-sl in https://github.com/hashgraph/hedera-services/pull/10463
* * chore: Dashboard Updates by @poulok in https://github.com/hashgraph/hedera-services/pull/10412
* * feat: Add test setting to force ignore PCES signatures (#10538) by @alittley in https://github.com/hashgraph/hedera-services/pull/10542
* * chore: update hapi version to 0.45.0 by @iwsimon in https://github.com/hashgraph/hedera-services/pull/10549
* ## New Contributors
* * @ElijahLynn made their first contribution in https://github.com/hashgraph/hedera-services/pull/10068
* * @mwb-al made their first contribution in https://github.com/hashgraph/hedera-services/pull/10163
* **Full Changelog**: https://github.com/hashgraph/hedera-services/compare/v0.44.4...v0.45.0

**Full Changelog**: [v0.45.0...v0.45.0](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.45.0...v0.45.0)

</details>

## Release v0.44

### [Build v0.44.4](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.44.4)

<details>
<summary><strong>What's Changed</strong></summary>

* * Fix ISS detection. by @cody-littley in https://github.com/hashgraph/hedera-services/pull/10182
* **Full Changelog**: https://github.com/hashgraph/hedera-services/compare/v0.44.3...v0.44.4

**Full Changelog**: [v0.44.0...v0.44.4](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.44.0...v0.44.4)

</details>

### [Build v0.44.3](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.44.3)

<details>
<summary><strong>What's Changed</strong></summary>

* * Enforce NFT allowance check on auto-creation by @tinker-michaelj in https://github.com/hashgraph/hedera-services/commit/e69d0a917c1c0a9417a3f335129a74ac3004b7c9
* **Full Changelog**: https://github.com/hashgraph/hedera-services/compare/v0.44.2...v0.44.3

**Full Changelog**: [v0.44.0...v0.44.3](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.44.0...v0.44.3)

</details>

### [Build v0.44.2](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.44.2)

<details>
<summary><strong>What's Changed</strong></summary>

* * Catch UncheckedIOException during PCES file copy. (#10083) by @cody-littley in https://github.com/hashgraph/hedera-services/pull/10087
* **Full Changelog**: https://github.com/hashgraph/hedera-services/compare/v0.44.1...v0.44.2

**Full Changelog**: [v0.44.0...v0.44.2](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.44.0...v0.44.2)

</details>

### [Build v0.44.1](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.44.1)

<details>
<summary><strong>What's Changed</strong></summary>

* ## Bug Fixes
* - Fix PCES copy bugs. (#10057) #10062
* ## Contributors
* We'd like to thank all the contributors who worked on this release!
* @alittley
* @cody-littley
* @poulok
* @nathanklick

**Full Changelog**: [v0.44.0...v0.44.1](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.44.0...v0.44.1)

</details>

### [Build v0.44.0](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.44.0)

<details>
<summary><strong>What's Changed</strong></summary>

* ## Features
* - Re-add bootstrap.properties file to maintain downstream processes and increase accounts.maxNumber=20_000_000 #8915
* - 8815: sort dirty leaves during flush #8981
* - Add setting to disable critical quorum. #8961
* - Add a doc for all system entity numbers #8993
* - 08566 - Validate PCES Events When Loading State On Different Network #8568
* - Differential testing analytic engine: State file file dumper now dumps special files #8991
* - Added improved startup ASCII art. #9028
* - Characterize invalid id failure modes for classic HTS calls #9053
* - Add ordinals to status diagram, and update javadocs #9108
* - 5552: Create a Grafana Data Dashboard to view all existing relevant data metrics #8845
* - Update Besu to version 23.10.0 #9168
* - Move EventDescriptor from Platform-Core to Common Library #9200
* - Add lables to the merkle tree visualziation in the logs. #9206
* - Remove legacy address book stuff. #9204
* - Rename event creation classes. #9167
* - 9072 Enable Hapi Tests - General Improvements #9212
* - Remove obsolete tests as discussed #9219
* - 09162 cleanup ConsensusHashManager #9165
* - Added new metrics for event creation. #9228
* - Consensus changes #6844
* - Write standalone event deduplicator #9247
* - 09162 event creation metrics #9242
* - 08670 Non linking orphan buffer #9241
* - Cleanup platform construction. #9250
* - Add feature that enables us to ignore janky state modification during testing. #9288
* - Tests for new Logging classes #8783
* - Add new tests to JTR metadata. #9315
* - 08461 cli transplant state 2 #9309
* - Change setup to have only one Gradle build #8858
* - Allow build to run without internet connection using --offline #9037
* - Platform Stress Testing Tool #8485
* - update nfts.maxAllowedMints #9464
* - Compress data sent over the network. #9416
* - 07501 Redesign compaction #9060
* - 09285 Create standalone event validator #9360
* - Remove config option to disable event sig verification #9478
* - Add an optional reconnect rate limit. #9522
* - remove deprecated method #9497
* - 09412 Create standalone in-order linker #9417
* - Increase contract kv/pairs storage allowed by 100x #9581 / #9590
* - 9582: Backport the fix for 9479 to release/0.44 #9583
* ## Bug Fixes
* - 08984 reconnect deadlock #8985
* - Fix metadata digest management during PCES replay with old files on disk #8840
* - 07663 sync lifecycle #8569
* - 08816 epoch hash with sig #8998
* - Stop release 0.41 regression #9025
* - 08663 event creation cleanup #9012
* - Sync configs from file 121 in the bootstrap.properties and application.properties for testnet & mainnet #9055
* - Update ledger.id and chain.id in bootstrap.properties #9079
* - #8877 Remove unneeded params from config.txt #8881
* - Fix Hapi client validator, adjust test configuration and test client #9045
* - Small fix to FailureCharacterizationSuite #9062
* - Fix 'swirlds-platform' vs 'platform-sdk' build identity #8529
* - Fix add vs put bug #9103
* - 08629 platform builder #8662
* - 08138 Increased reconnect.asyncStreamTimeout property to prevent genesis reconnect from failure #9132
* - 08138 Increased reconnect.asyncStreamTimeout property to 5 minutes #9153
* - Resolve WalletTestSetup errors #9096
* - 07672 Run Hapi Tests #9197
* - Fix deserializeKeySize method #9203
* - Resolve BlockSuite errors #9101
* - [develop] Remove unrecognized properties from testnet configs #9209
* - Fix contract creation ids, enforce entity limits #9125
* - Fix #9230 genesis schema vmap size hints too small #9231
* - Fix fee calculations to not throw exceptions #9139
* - 09217 d add prev ab to state #9220
* - Use dummy transaction instead of empty bytes for accessor #9239
* - task: Update Dockerfile to reduce failure rates in CI #9232
* - Fix noisy log warnings #9186
* - 9013: Virtual node cache size metric name should be updated to bytes instead of mebibytes #9253
* - removed useless markers #9269
* - Update testnet fee schedules #9290
* - Cleaned up ECDSA verifier and added couple input validation checks #9320
* - Abort html log processing if too many lines exist #9338
* - Remove all direct usages of slf4j / forward slf4j to log4j #8425
* - fix: resolve ci issues and maven central publish issues #9367
* - fix: resolves issues with publishing the EVM module to Maven Central #9370
* - remove clear pces option #9350
* - 08817 iss pces replay #9248
* - fix build #9470
* - Maintain doubly-linked list storage on contact commit #9441
* - Disable post-upgrade stake housekeeping #9474
* - Invoke leakCapacityForNOfUnscaled(numImplicitCreations, CryptoCreate) on failed self-submitted auto-creation #9388
* - 9512 Prevented MerkleDbStatistics from throwing exceptions if its methods called before registerMetrics #9520
* - Remove obsolete tests #9489
* - 08389 d fix flaky qt metric test #9496
* - Remove asyncPrehandle config option #9527
* - Remove EventReceivedObserver #9530
* - Populate evm function result on failing eth transaction (#9453) #9552
* - Disable compression. (#9554) #9579
* - Make scheduled txn records queryable from ScheduleCreate payer account #9615
* - Cherry-pick : Fix NPE in TokenWipe when using missing alias for an account #9646
* - Make platform mainnet settings the default #9341
* - Restore underscores in config values #9605
* - fix: issue with workflow due to missing brace #9743
* - 9477: Direct memory / data source leak if teacher becomes inaccessible during reconnect #9829
* - Copy the PCES into saved state directories. (#9809) #9857
* - Backport reconnect done handshake #9861
* - Remove reconnect abort #9862
* - Mirror fractional time usage in phase timer #9909
* - Fix race condition in PCES file copy. (#9890) #9912
* - Rationalize treatment of auto-create MAX_CHILD_RECORDS_EXCEEDED #9966
* ## Code Modularization
* - Fix TokenCreateSpecs (#8672)
* - Fix ContractGetBytecodeSuite tests #8905
* - Fix ContractCallSuite tests #8890
* - Fix tests from ContractCallLocalSuite #8812
* - Remove hapi test suite annotation from suite that not need to be fixed #8940
* - Fix StaticCallOperationSuite tests #8959
* - Implement backend throttle #8196
* - Change Set to a List in customFeeValidator #8972
* - Fix ExtCodeSizeOperationSuite tests #8957
* - Fix FileUpdateSuite tests #8952
* - Fix BalanceOperationSuite tests #8953
* - Add comments for ContractGetBytecodeHandler #8946
* - Fix GlobalPropertiesSuite tests #8958
* - Fix ExtCodeHashOperationSuite tests #8956
* - Check for deleted accounts in crypto allowances #8834
* - Move burn package inside hts package #8904
* - Fix tests from TokenTransactSpecs #8859
* - Fix Auto Create with Alias #8916
* - NetworkAdmin fee calculations #8844
* - Fix ExtCodeCopyOperationSuite tests #8955
* - Implement calculateFees for crypto handlers #8933
* - Fix failed mixed reconnect tests due to INVALID_TOPIC_ID #8937
* - Fix createContractWithStakingFields() #8986
* - Enable tests from PrivilegedOpsSuite #8942
* - Resolve TraceabilitySuite errors #8919
* - Implement system contract for delete token #8887
* - 7905 Schedule Service Unit Tests - Part 2 #8842
* - implement system contracts for mint #8856
* - Fix TokenFeeScheduleUpdateSpecs tests #8863
* - 08714 Get Allowance system contract #8810
* - Fix SpecialAccountsAreExempted tests #9018
* - Fix UpdateFailuresSpec tests #9021
* - Enable remaining tests from ThrottleDefValidationSuite #9016
* - 08588 Grant Approval system contract #8728
* - Fix TxnRecordRegression #8947
* - Fix TxnReceiptRegression suite #8941
* - Enable tests from TokenPauseSpecs #8658
* - Resolve RecordsSuite errors #8907
* - Fix Ethereum Suites issues #8999
* - Fixed code to enable additional 14 HapiTests in CryptoApproveAllowanceSuite #9032
* - Add Fees for CryptoTransfer #9006
* - Resolve FileQueriesStressTests errors #9082
* - Resolve ConsensusQueriesStressTests errors #9084
* - Resolve InvalidgRPCValuesTest errors #9092
* - Resolve PerpetualTransfers errors #9094
* - Issue 8989 - Design ScheduleGetInfo query handler #9035
* - 09046 Fix Hapi Schedule Create Spec #9106
* - Resolve CryptoQueriesStressTests errors #9086
* - Implement some of the classic HTS view functions #8712
* - Enable more ContractCallLocalSuite tests #9105
* - Fix Misc issues in CryptoTransfer Logic #9034
* - Fix setting of nonce in RecordListBuilder #9118
* - Fix Paid query handler base class to not permit subclasses to be free. #9052
* - Fix TokenManagementSpecs tests #8679
* - Resolve UniqueTokenManagementSpecs errors #9113
* - 9046 Schedule Handlers/Fix Record Builder usage. #9140
* - Use working state in queries #9143
* - Fix duplicateKeysAndSerialsInSameTxnDoesntThrow test #9150
* - Enable tests from CrytoCreateSuiteWithUTF8 #9148
* - Enable tests from HelloWorldSpec #9146
* - Enable tests from TransferWithCustomFees #9123
* - fixed CryptoApproveAllowanceSuite.scheduledCryptoApproveAllowanceWorks #9152
* - Further tuning of token reconnect tests #9128
* - Implement system contract for UPDATE_TOKEN #9144
* - Fix aliasKeysAreValidated test in CryptoTransferSuite #9187
* - Add checks for immutable keys #9171
* - Enable tests from Issue1765Suite #9038
* - Fix UtilScalePricingCheck test #9180
* - Implement token expiry and token key view functions #9141
* - Add fee calculations to TxGetRecordHandler #9173
* - Fix TokenCreate Specs #9170
* - Simulate mono-service custom fee failure codes in mod-service #9227
* - Fix FileRecordsSanityCheckSuite tests #9216
* - Tidy up create method in AutoAccountCreator #9033
* - Fixed code to pass CryptoGetInfoRegression. #9229
* - Fix TokenManagementSpecs KYC Tests #9234
* - Implement frontend throttle #8374
* - Fix unreliable behavior in Unit Test #9251
* - Fix SignedTransactionBytesRecordsSuite #9043
* - Implement system contract for CREATE_TOKEN #9127
* - Implement system contract TOKEN_UPDATE_EXPIRY #9185
* - Resolve KeyExport errors #9093
* - Resolve Replace Alias error in CryptoTransferSuite #9267
* - Resolve RecordFileSuite errors #9099
* - Resolve TogglePayerRecordUse errors #9095
* - Enable ResetThrottleSuite and ResetTokenMaxPerAccount suites #9183
* - Implement getTokenCustomFees HTS view function #9207
* - Fix tests in CryptoTransferSuite #9245
* - Resolve CreateOperationSuite errors #9142
* - Match Get Approved mono behaviour #9263
* - Match mono behaviour for Grant Approval system contract #9235
* - Match mono behaviour for Freeze/Unfreeze System Contract #9256
* - Implement system contract for TOKEN_UPDATE_KEYS #9238
* - Match Grant/Revoke Kyc mono behaviour #9301
* - Match UpdateTokenKeys mono behaviour #9311
* - Enable tests from ContractCallSuite #9316
* - Match Get Allowance mono behaviour #9258
* - Apply latest config changes to modularized code base #9193
* - Implement getTokenInfo, getFungibleTokenInfo and getNonFungibleTokenInfo view functions #9295
* - 09030 save all records #9323
* - Fix failing HAPI tests in mono repo #9329
* - Fix cannotCreateTooLargeContract from ContractCreateSuite #9304
* - Allowance transfers fixes #9334
* - Enable fixed AutoAccountCreation tests #9353
* - Enable tests from LeakyContractTestsSuite #9355
* - 8430 auto account update suite #9342
* - Match TokenCreate mono behaviour #9361
* - Fix JRS schedule test #9380
* - Fix create2 operation suite tests #9151
* - SystemContract gas calculations #9318
* - Disable flaky test #9384
* - Fix handling of complex keys during ingest #9351
* - Fix other CryptoTransfer tests #9390
* - Make all deprecated queries and txs free of charge #9386
* - Ensure Wipe operations match mono behaviour #9298
* - Fix uniqueTokenManagementSpecs leftover tests #9393
* - Fix schedule create test #9395
* - Match UpdateTokenExpiryInfo mono behaviour #9332
* - Ensure SetApprovalForAll system contract matches mono behaviour. #9222
* - Enable AutoAccountUpdateSuite test #9413
* - Resolve part of crypto tests #9359
* - fixed code to pass some tests in HollowAccountFinalizationSuite #9419
* - Match DeleteToken mono behaviour #9331
* - Enable passing tests #9455
* - Match BurnPrecompile mono behaviour #9333
* - Match MintToken mono behaviour #9326
* - Fix remaining tests for CryptoCornerCasesSuite and CryptoGetInfoRegression #9486
* - use Bytes.EMPTY instead of null to indicate empty keys/values #9519
* - enable query payment suite #9523
* - Pure checks for token burn and wipe #9451
* - 9046 Enable ScheduleCreateSpecs HAPI tests #9418
* - Enable token service tests that are passing #9540
* - Enable passing Precompile HAPI tests #9465
* - 09394 fix failing tests in create2 operation suite #9498
* ## Misc
* - Bump actions/upload-artifact from 3.1.2 to 3.1.3 #8753
* - Bump actions/setup-java from 3.12.0 to 3.13.0 #8801
* - Bump mikefarah/yq from 4.35.1 to 4.35.2 #8893
* - Bump com.diffplug.spotless:spotless-plugin-gradle from 6.21.0 to 6.22.0 #8934
* - Bump gradle/gradle-build-action from 2.8.0 to 2.9.0 #8936
* - Bump actions/checkout from 4.0.0 to 4.1.0 #8843
* - chore: fix StatsSigningTestingTool to hash the data for ECDSA signatures #9339
* - Bump actions/setup-node from 3.8.1 to 4.0.0 #9421-
* - Bump org.owasp:dependency-check-gradle from 8.4.0 to 8.4.2 #9422
* - chore: import the production docker image definitions from Node Management Tools #9472
* - chore: add OpenJDK 21 manifests to the production docker image #9488
* - Bump services version number to 0.44.0 #9365
* - Bump hapi version in use to 0.44.0 #9536
* - Schedule release branch creation for 0.44 #9533
* - chore: publish release artifacts to the public CDN #9720
* ## Contributors
* We'd like to thank all the contributors who worked on this release!
* - @agadzhalov
* - @alittley
* - @artemananiev
* - @cody-littley
* - @david-bakin-sl
* - @dikel
* - @edward-swirldslabs
* - @ElijahLynn
* - @georgi-l95
* - @hendrikebbers
* - @imalygin
* - @Ivo-Yankov
* - @iwsimon
* - @jasperpotts
* - @JeffreyDallas
* - @JivkoKelchev
* - @jjohannes
* - @jsync-swirlds
* - @kimbor
* - @lpetrovic05
* - @lukelee-sl
* - @MiroslavGatsanoga
* - @mhess-swl
* - @MrValioBg
* - @mustafauzunn
* - @Nana-EC
* - @natanasow
* - @nathanklick
* - @Neeharika-Sompalli
* - @netopyr
* - @OlegMazurov
* - @petreze
* - @povolev15
* - @poulok
* - @rbair23
* - @shemnon
* - @stoqnkpL
* - @stoyanov-st
* - @thenswan
* - @timo0
* - @tinker-michaelj
* - @vtronkov

**Full Changelog**: [v0.44.0...v0.44.0](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.44.0...v0.44.0)

</details>

## Release v0.43

### [Build v0.43.4](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.43.4)

<details>
<summary><strong>What's Changed</strong></summary>

* * Update to use `0.43.0` tag for protobufs by @Neeharika-Sompalli in https://github.com/hashgraph/hedera-services/pull/9896
* * chore: disable Gradle configuration cache and parallelism when releasing to Maven Central by @nathanklick in https://github.com/hashgraph/hedera-services/pull/10067
* * Enforce NFT allowance check on auto-creation by @tinker-michaelj in https://github.com/hashgraph/hedera-services/commit/8ee1c5dba5df2c758b5d81812465e2ccb8a26f97
* **Full Changelog**: https://github.com/hashgraph/hedera-services/compare/v0.43.3...v0.43.4

**Full Changelog**: [v0.43.0...v0.43.4](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.43.0...v0.43.4)

</details>

### [Build v0.43.3](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.43.3)

<details>
<summary><strong>What's Changed</strong></summary>

* ## Bug Fixes
* * 9584: Backport the fix for 9479 to release/0.43 in https://github.com/hashgraph/hedera-services/pull/9586
* * Fix NPE in `TokenWipe` when using missing alias for an account in https://github.com/hashgraph/hedera-services/pull/9640
* **Full Changelog**: https://github.com/hashgraph/hedera-services/compare/v0.43.2...v0.43.3
* ## Contributors
* We'd like to thank all the contributors who worked on this release!
* @artemananiev
* @Neeharika-Sompalli

**Full Changelog**: [v0.43.0...v0.43.3](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.43.0...v0.43.3)

</details>

### [Build v0.43.2](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.43.2)

<details>
<summary><strong>What's Changed</strong></summary>

* ## Bug Fixes
* - Cherry-pick #9581 into release/0.43 https://github.com/hashgraph/hedera-services/pull/9591
* - Make scheduled txn records queryable from `ScheduleCreate` payer account in https://github.com/hashgraph/hedera-services/pull/9610
* **Full Changelog**: https://github.com/hashgraph/hedera-services/compare/v0.43.1...v0.43.2
* ## Contributors
* We'd like to thank all the contributors who worked on this release!
* @lukelee-sl
* @tinker-michaelj

**Full Changelog**: [v0.43.0...v0.43.2](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.43.0...v0.43.2)

</details>

### [Build v0.43.1](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.43.1)

<details>
<summary><strong>What's Changed</strong></summary>

* ## Bug Fixes
* - chore: backport Gradle build and EVM publish specific fixes from develop in https://github.com/hashgraph/hedera-services/pull/9371
* - update max allowed Mints NFTS  in https://github.com/hashgraph/hedera-services/pull/9466
* - Disable post-upgrade stake housekeeping  in https://github.com/hashgraph/hedera-services/pull/9475
* **Full Changelog**: https://github.com/hashgraph/hedera-services/compare/v0.43.0...v0.43.1
* ## Contributors
* We'd like to thank all the contributors who worked on this release!
* @nathanklick
* @povolev15
* @tinker-michaelj

**Full Changelog**: [v0.43.0...v0.43.1](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.43.0...v0.43.1)

</details>

### [Build v0.43.0](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.43.0)

<details>
<summary><strong>What's Changed</strong></summary>

* ## Features
* Services v0.43.0 adds the following features:
* - HIP-786 (#8620)
* ## Enhancements
* Services v0.43.0 adds the following enhancements:
* - Update Besu to 23.10.0 - cherry pick (#9199)
* - Update the Besu EVM library to version 23.7.2 (#8472)
* - "Productizing" contract disassembler at last (#8563)
* - Auto sidecar validations (#8404)
* - Create fat jar with services CLI so it can be run standalone (#8519)
* ## Code Modularization
* Services v0.43.0 includes the following maintainability enhancements:
* - fix: resolve HapiTestEngine issues preventing test execution (#8351)
* - Add @hapitest annotation to tests that are passing (#8328)
* - Solvency checks (#8362)
* - Adjust block creation to account for freeze times (#8339)
* - Solvency fixes (#8396)
* - Improved ExchangeRateManager (#8282)
* - Implement HtsSystemContract skeleton and balanceOf() view redirect (#8325)
* - Duplicate check (#8375)
* - Add @hapitest annotation to other tests (#8398)
* - Throw on conversion outside long-zero subspace (#8413)
* - Privileges check (#8408)
* - Implement CryptoSignatureWaiversImpl (#8426)
* - Fix hollow accounts signature verification (#8418)
* - fixed code to pass CryptoUpdateSuite test (#8442)
* - Add the modular restart support (#8337)
* - Check transaction node account matches on ingest not on pre-handle (#8454)
* - Implementation of SwirldsPlatformBuilder, sufficient for initial use by services (#8448)
* - Do not preload file 121 with all network properties (#8453)
* - 07905 schedule service unit tests - Part 1 (#8336)
* - Integrate dual state into workflows (#8449)
* - Implement exchange rate system contract (#8324)
* - Cleanup tests (#8468)
* - Complete MiscViewsXTest (#8341)
* - Fix hapi initialization error (#8477)
* - Disable all failing tests (#8490)
* - Store calculated fees in record builder (#8492)
* - Enable HandleContextImpl to work with unknown payer (#8496)
* - Add support for testing with multiple nodes (#8452)
* - Use the DualState from handleRound instead of from initialization for the DualStateUpdateFacility (#8516)
* - ExchangeRateSet at genesis matching FileServiceImpl's GenesisSchema (#8518)
* - Revert "Store calculated fees in record builder (#8492)" (#8522)
* - Implement HTS system contract transfer variants (#8486)
* - Rename the config property names to match what is in `semantic-version.properties` (#8539)
* - Fixed failing tests (#8528)
* - Accommodate due diligence failure records w/ `records.useConsolidatedFcq=true` (#8548)
* - Fix UnsupportedQueriesRegression HapiSuite (#8536)
* - Token Update NPE fix (#8527)
* - Implement associate/dissociate HTS system calls (#8514)
* - Fix Sonar issues for rest of the modules (#8280)
* - pces recovery (#8194)
* - Add ContractInfoQueryHandler (#8576)
* - add fees in the right way to all file services (#8508)
* - Remove ReadableRunningHashLeafStore from network admin (#8632)
* - Fixed code to pass some tests in TopicCreateSuite, CryptoDeleteSuite, CryptoUpdateSuite and CryptoApproveAllowanceSuite (#8630)
* - Enable all passing test (#8657)
* - Make an Executor available to freeze handler via Dagger injection (#8661)
* - Resolve Hip17UnhappyTokensSuite errors (#8614)
* - Fix TokenDeleteSpecs tests (#8560)
* - Fix TokenAssociationSpecs tests (#8562)
* - Disable CryptoTransferThenFreezeTest (#8677)
* - File test passing AppendFailuresSpec, SysDelSysUndelSpec, ExchangeRateControlSuite (#8626)
* - Resolve TokenTotalSupplyAfterMintBurnWipeSuite errors (#8685)
* - Implementation for the HTS wipe operation for fungible and nonfungible tokens (#8656)
* - Error handling for penalty payments (#8692)
* - Fix TokenManagementSpecsStateful tests (#8555)
* - Grant/Revoke kyc system contracts (#8653)
* - Skip 0.0.0 auto-renew account id in synthetic ContractCreate (#8700)
* - Fix ThrottleDefValidationSuite (#8219)
* - Fix tests from ContractCreateSuite (#8713)
* - Stabilize HapiSpec ledger id assertions (#8703)
* - Create genesis records from node startup (#7983)
* - Add hapi test to GitHub pipeline (#8542)
* - Fix fees for some of Token operations (#8708)
* - Fix genesis records creation order (#8749)
* - Fix fee calculation for TokenWipe and TokenBurn (#8761)
* - Implement calculateFees for token service queries (#8752)
* - Implemented calculateFees() in all consensus services (#8750)
* - GetApproved system contract (#8785)
* - Implement ContractDeleteHandler (#8635)
* - Enable some passing tests (#8803)
* - Authorization information in HandleContext (#8787)
* - Fix compile issues on develop (#8819)
* - File test passing ProtectedFilesUpdateSuite, PermissionSemanticsSpec, FileUpdateSuite (#8659)
* - Assorted fee fixes (#8832)
* - Implement calculateFees in other Token operations (#8826)
* - Disable failing HAPI tests (#8822)
* - Burn fungibles and NFTs system contract (#8809)
* - Retry failing queries during HAPI tests (#8879)
* - Query fee calculation (#8807)
* - Fix CallCodeOperationSuite tests (#8853) Resolve Issue1758Suite errors (#8851)
* - Resolve Issue1741Suite errors (#8850)
* - Fix CallOperationSuite tests (#8860)
* - 08581 Freeze/Unfreeze system contracts implementation (#8607)
* - Resolve Hip17UnhappyAccountsSuite errors (#8611)
* - Enable passing tests for crypto transfer (#8872)
* - Fix CreateOperationSuite test (#8902)
* - Fix DelegateCallOperationSuite tests (#8883)
* - Fix SStoreSuite tests (#8891)
* - Fix PushZeroOperationSuite tests (#8888)
* - Fix SelfDestructSuite tests (#8895)
* - Resolve TokenUpdateSpecs errors (#8742)
* - Implementation of SetApprovalForAll system contract (#8723)
* ## Integrate Platform and Services Builds
* Services v0.43.0 includes the following enhancements to the build structure:
* - Further integrate 'hedera-node' and 'platform-sdk' builds (#7875)
* - Update GH gradle-build-action to 2.8.0 (#8353)
* - fix: workaround Gradle assemble hanging during build (#8347)
* - Compile xtest code as part of assemble (#8357)
* - fix: correct the version of the publish-unit-test-result-action to be a valid commit (#8359)
* - fix: correct the version of the ssh-key-action step to be a valid commit (#8360)
* - fix: resolve issues with Hedera JRS tests failing due to changes in #7875
* - fix: ensure the grpc.stub module depends on java.logging (#8391)
* - Re-add runtime only dependency to "com.swirlds.config.impl" (#8407)
* - Update to Gradle 8.3 (#8352)
* - Repair 'gradle showVersion' (#8406)
* - Executions in 'test-client' (main() / tests) should not use --module-path (#8424)
* - Adding the context API (#8423)
* - fix: resolve issues with the Gradle project identifier breaking the Platform release (#8570)
* ## Minor enhancements
* Services v0.43.0 includes the following minor enhancements:
* - Added scratchpad utility. (#8330)
* - Make clearing the PCES a static method. (#8410)
* - Add metrics to various queues. (#8416)
* - Improved state logging. (#8399)
* - 8380: a memory leak in SwirldsPlatform.components (#8434)
* - 07739 jtr (#8401)
* - Saved state metadata improvements (#8393)
* - 06881 e recovery lifecycle (#8206)
* - 07894 Reconnect Teacher - Throttle Logs and New Metric (#8322)
* - 07762 - Treat All SSLExceptions as SOCKET_EXCEPTIONs (#8473)
* - Update block number tool to compare running hash (#8512)
* - 07829 HTML logs (#8307)
* - 08109 - Reconnect Learner Throttled by Configuration. (#8544)
* - 08251 pces origin (#8462)
* - Implement HTS pause/unpause functions (#8628)
* - 8386 add transaction state log (#8633)
* - Elegantly handle when an empty PCES is cleared. (#8627)
* - Reduce number of ops (#8671)
* - Update 'any stat' dashboard to also show merkledb stats (#8682)
* - 08108 phased fractional timer (#8546)
* - 05287 consensus utilities (#8636)
* - Emergency logger + needed dependencies added (#8680)
* - 8751: No data source metrics for accounts, NFTs, or token rels (#8754)
* - 05287 consensus tests (#8759)
* - Update network details dashboard to map all values for platform status (#8161)
* - Create intake phase timer (#8747)
* - 8469: New VirtualMap metric: virtual node cache size, in Mb (#8755)
* - Fix Ecdsa performance, using besu native (#8727)
* - Improved stale event metrics. (#8740)
* - Implement clean option for browse command (#8824)
* - 08299 Selectable logs (#8800)
* - Clean up JTR PCLI commands (#8821)
* - Add a column to JTR summary for logs (#8838)
* - Platform Dashboards (#8825)
* - Add optional path for blocklist config (#8326)
* ## Bug Fixes
* Services v0.43.0 includes the following bug fixes:
* - Fix flaky unit test (#8342)
* - 8260: CongestionPricing-NDReconnect-1-16m has error IllegalArgumentException (#8419)
* - 8170: MixedOps-Interrupted-2NReconnect-6k-41m failed with MerkleSynchronizationException (#8443)
* - 08439 Stabilized VirtualMapTests.testFlushCount (#8441)
* - 08212 - Fix Migrated State Event Validation (#8511)
* - Remove no longer existing property (#8553)
* - 08237 Fixed validation of multiple rounds in VirtualMerkleLeafHasher (#8534)
* - Fix JRS queryable payer record issue (#8617)
* - Updated version if Migration Testing Tool to prevent JRS test failures (#8619)
* - Don't allow the tipset algorithm to create ancient self events. (#8624)
* - 08741 - Disable Failing Bad Local Address Test on Windows and Macs (#8743)
* - Only be a reconnect teacher if platform status is active (#8736)
* - Fix log file search (#8796)
* - Fix JRS account balances test (#8724)
* - Fix account balance test (#8830)
* - Prevent Double ISS in ISS Testing Tool (#8776)
* - Fix failed test Crypto-Perf-Invalid-Accounts-5k-30m (#8880)
* - 08984 reconnect deadlock (#8985) (#8987)
* - Cherry-pick mono changes (#9011)
* - 08816 epoch hash with sig (#8998) (#9044)
* - Sync configs from file 121 in the `bootstrap.properties` and `application.properties` (#9078)
* - 08138 Increased reconnect.asyncStreamTimeout property to prevent genesis reconnect from failure (#9133)
* - 08138 Increased reconnect.asyncStreamTimeout property to 5 minutes (#9154)
* For the full changelist see https://github.com/hashgraph/hedera-services/compare/v0.42.6...v0.43.0-alpha.6
* ## Contributors
* We'd like to thank all the contributors who worked on this release!
* @agadzhalov
* @alittley
* @artemananiev
* @beeradb
* @cody-littley
* @david-bakin-sl
* @edward-swirldslabs
* @ElijahLynn
* @georgi-l95
* @hendrikebbers
* @imalygin
* @Ivo-Yankov
* @iwsimon
* @jasperpotts
* @JeffreyDallas
* @jjohannes
* @jsync-swirlds
* @kimbor
* @lpetrovic05
* @lukelee-sl
* @mhess-swl
* @MiroslavGatsanoga
* @MrValioBg
* @mustafauzunn
* @natanasow
* @nathanklick
* @Neeharika-Sompalli
* @netopyr
* @OlegMazurov
* @poulok
* @povolev15
* @qnswirlds
* @rbair23
* @stoyanov-st
* @thenswan
* @tinker-michaelj
* @vtronkov

**Full Changelog**: [v0.43.0...v0.43.0](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.43.0...v0.43.0)

</details>

## Release v0.42

### [Build v0.42.6](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.42.6)

<details>
<summary><strong>What's Changed</strong></summary>

* This release updates the platform SDK version from `0.42.0` to `0.42.6`, which removes `reconnect.asyncStreamTimeout` from the settings files. Doing so ensures that this property will default to the value specified in code (300 seconds).
* ### Changes
* * Upgrade platform SDK (#9224)
* ### Contributors
* @mhess-swl

**Full Changelog**: [v0.42.0...v0.42.6](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.42.0...v0.42.6)

</details>

### [Build v0.42.5](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.42.5)

<details>
<summary><strong>What's Changed</strong></summary>

* This release removes two deprecated properties in testnet config that prevent the node from starting
* Changes
* * Remove unrecognized properties from config files (#9208)
* Contributors
* @mhess-swl

**Full Changelog**: [v0.42.0...v0.42.5](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.42.0...v0.42.5)

</details>

### [Build v0.42.4](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.42.4)

<details>
<summary><strong>What's Changed</strong></summary>

* This release entails small config changes to prevent a reconnect bug, as well as to sync current overrides to repository config files.
* **NOTE**: `reconnect.asyncStreamTimeoutMilliseconds` has been removed as an alias for `reconnect.asyncStreamTimeout`
* ### Changes
* * Sync configs from file 121 (#9077)
* * Increase `reconnect.asyncStreamTimeout` (#9158)
* ### Contributors
* @ElijahLynn
* @imalygin
* @Neeharika-Sompalli

**Full Changelog**: [v0.42.0...v0.42.4](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.42.0...v0.42.4)

</details>

### [Build v0.42.3](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.42.3)

<details>
<summary><strong>What's Changed</strong></summary>

* This release blocks ContractCreate initcode or EthereumTransaction callcode from referencing system files.
* ### Contributors
* @tinker-michaelj

**Full Changelog**: [v0.42.0...v0.42.3](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.42.0...v0.42.3)

</details>

### [Build v0.42.2](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.42.2)

<details>
<summary><strong>What's Changed</strong></summary>

* This release updates a config property, replaces a missing file for downstream dependencies, and tweaks a few integration tests.
* ### Changes
* * 0.42 account balance test (#8866)
* * Re-add bootstrap.properties file and increase `accounts.maxNumber=20_000_000` (#8928)
* ### Contributors
* @JeffreyDallas
* @mhess-swl
* @Neeharika-Sompalli
* @poulok

**Full Changelog**: [v0.42.0...v0.42.2](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.42.0...v0.42.2)

</details>

### [Build v0.42.1](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.42.1)

<details>
<summary><strong>What's Changed</strong></summary>

* This release contains only minor updates, mostly to standardize configurations between mainnet and the repo properties files. There were also a few tweaks made to platform metrics.
* ### Changes
* * Chore: normalize configuration values (release/0.42) (#8668)
* * 8751: No data source metrics for accounts, NFTs, or token rels (#8798)
* ### Contributors
* @artemananiev
* @mhess-swl
* @nathanklick
* @Neeharika-Sompalli

**Full Changelog**: [v0.42.0...v0.42.1](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.42.0...v0.42.1)

</details>

### [Build v0.42.0](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.42.0)

<details>
<summary><strong>What's Changed</strong></summary>

* ## Features
* ### Add EIP 2930 support to EthTXData (#7696)
* Previously only legacy and type 2 Ethereum transactions were supported. The EIP-2930 transactions can be sent either directly to HAPI via an [EthereumTransaction](https://github.com/hashgraph/hedera-protobufs/blob/main/services/ethereum_transaction.proto) or via the [JSON-RPC Relay](https://swirldslabs.com/hashio/). The transaction type is used by a few tools such as web3 and etherjs in transaction submission flows and allows supports legacy parameters along with the accessList parameter. Notably, Hedera does not utilize access list logic at this point.
* ### Modify config to support state on disk by default (#8510)
* Enables the Data on Disk feature by default. Starting in this release, state will be stored on disk instead of in memory. This is an initial deployment and will enable higher entity maximums in the future.
* ### Disable account balance exports (#8272)
* Disables the creation of account balance files. This change is necessary to allow the state to scale to a larger number of entities enabled by the Data on Disk feature without compromising performance. The Hedera mirror node will now produce equivalent account balance snapshots internally.
* ## Enhancements
* * Enable EIP-2930 transactions by default (#7786)
* * 08208 timed recycle bin (#8217)
* * Provide entity and throttle dashboards (#7774)
* * Use same 'build-logic' for 'hedera-node' and 'platform-sdk' (#7330)
* * 07748 Postconsensus signature gathering (#7776)
* * Write gossip events to PCES (#7793, #7841)
* * 07779 Replace codecs with protobuf (#7900)
* * Differential testing analytical engine: Dump accounts, as text
* * Improved metrics for various queues and the transaction pool (#8087, #8249)
* * A number of updates to documentation, especially documentation for tipset algorithm (#7219) and contract nonces design doc (#7331)
* * Various additions and improvements to tooling and log outputs
* * Various configuration changes (#7837, #7880, #7998, #8567)
* ## Modularization Efforts
* * Implement Staking Period Calculator (#7705)
* * Add deleted account beneficiaries to SingleTransactionRecordBuilder
* * Call staking updater via consensus time hook (#7751)
* * 05519 modularize hedera schedule service (#7664)
* * Special file notifications (#7809)
* * Implement fee logic (#7890)
* * Modularized prng system contract (#7906)
* * Add SavepointStack.commit() (#7935)
* * Implement consensus fees calcuations (#7954)
* * 07992 state logging (#8017)
* * 07960 updating the special files handling for throttles (#8072)
* * Implement frontend throttle (#8183)
* * Finish the ContractCallLocal flow for smart contracts (#8211)
* * Align staking property names with HIPs (#8247)
* * Full implementation of genesis account creations. (#8252)
* * Deduplication check in IngestChecker (#8310)
* * Creation and use of `@HapiTest` and `@HapiTestSuite` (#7710, #7730, #7794, #7808)
* * A number of business logic fixes to get tests to pass
* ### Cleanup
* * 7570: Remove JasperDB (#7803)
* * Remove support for legacy sync gossip. (#8059)
* ## Bug Fixes
* * Consider emergency reconnect in PlatformStatus system (#7725)
* * 07577 - Fix Uncaught Exception In Platform Core Unit Tests (#7753)
* * Fixed an NPE that occurs when starting via modrun gradle command (#7757)
* * Refresh congestion multipliers in config callback (#7780)
* * Avoid unwanted genesis migration records (#7783)
* * Gui fixed (#7846)
* * 7406: Fix benchmark configuration (#7860)
* * Invalidate empty code for contract-finalized hollow accounts (#7867)
* * 07812 41 fix tipset freeze (#7834) (#7884)
* * Tipset Branching Bug (#7883)
* * Fix publishing staking fund account records (#7930)
* * Handle empty PCES files. (#7940)
* * 07926 mismatched sender owner nft (#7964)
* * 07902 d break tipset deadlock v2 (#7977)
* * Fix round 1 replay (#7979)
* * Fix for 7978: exception for null-tabs fixed (#7991)
* * #8002 Fix Hashgraph Demo (#8005)
* * Fix NettyGRPC non linux (#8062)
* * 08034 Fixed index validation after compaction (#8080)
* * Fix regression in PTT. (#8173)
* * Fix return File instead of optional when call getFileLeaf (#8204)
* * Adjust block creation to account for freeze times (#8323)
* * Fix: IllegalAccessException preventing mono local node run (#8199)
* * Throw on conversion outside long-zero subspace (#8431)
* * 8380: a memory leak in SwirldsPlatform.components (#8506)
* * Fix JRS queryable payer record issue (#8618)
* * Fix getFileMetadata and getFileLeaf that the param will be @nonnull
* **Note that a number of miscellaneous fixes, refactors, cleanup, and other minor code changes were also incorporated.**
* See the full changelist for more details: [v0.41.4...v0.42.0](https://github.com/hashgraph/hedera-services/compare/v0.41.4...v0.42.0)
* ### Contributors
* @agadzhalov
* @alittley
* @artemananiev
* @beeradb
* @cody-littley
* @david-bakin-sl
* @edward-swirldslabs
* @hendrikebbers
* @imalygin
* @isavov
* @iwsimon
* @JeffreyDallas
* @jeromy-cannon
* @jjohannes
* @jsync-swirlds
* @kimbor
* @lpetrovic05
* @lukelee-sl
* @mhess-swl
* @MiroslavGatsanoga
* @Nana-EC
* @natanasow
* @nathanklick
* @Neeharika-Sompalli
* @netopyr
* @nikolovyanko
* @OlegMazurov
* @poulok
* @povolev15
* @qnswirlds
* @rbair23
* @stoqnkpL
* @swirlds-automation
* @timo0
* @tinker-michaelj
* @vtronkov

**Full Changelog**: [v0.42.0...v0.42.0](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.42.0...v0.42.0)

</details>

## Release v0.41

### [Build v0.41.4](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.41.4)

<details>
<summary><strong>What's Changed</strong></summary>

* Fixes mismatching record running hashes https://github.com/hashgraph/hedera-services/pull/8444
* **Full Changelog**: https://github.com/hashgraph/hedera-services/compare/v0.41.3...v0.41.4

**Full Changelog**: [v0.41.0...v0.41.4](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.41.0...v0.41.4)

</details>

### [Build v0.41.0-alpha.3](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.41.0-alpha.3)

<details>
<summary><strong>What's Changed</strong></summary>

* - Changes NFT mint pricing to linearly scale based on number of serials minted. Also, minting a single NFT in collection is changed to cost $0.02 from $0.05.  https://github.com/hashgraph/hedera-services/issues/7769
* - Accommodates changes from platform sdk `0.41.0-alpha.3`
* **Full Changelog**: https://github.com/hashgraph/hedera-services/compare/v0.41.0-alpha.2...v0.41.0-alpha.3

**Full Changelog**: [v0.41.0...v0.41.0-alpha.3](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.41.0...v0.41.0-alpha.3)

</details>

### [Build v0.41.0-alpha.2](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.41.0-alpha.2)

<details>
<summary><strong>What's Changed</strong></summary>

* In `v0.41.0-alpha.2` of services the Ethereum transaction type support is expanded to include type 1 transactions (https://github.com/hashgraph/hedera-services/issues/7670) which follow EIP 2930 RLP encoding.
* This increases the number of native EVM tools tools and scenarios the Hedera Smart Contract Service supports.

**Full Changelog**: [v0.41.0...v0.41.0-alpha.2](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.41.0...v0.41.0-alpha.2)

</details>

### [Build v0.41.0](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.41.0)

<details>
<summary><strong>What's Changed</strong></summary>

* - Ethereum transaction type support is expanded to include type 1 transactions (https://github.com/hashgraph/hedera-services/issues/7670) which follow EIP 2930 RLP encoding. This increases the number of native EVM tools and scenarios the Hedera Smart Contract Service supports.
* - NFT mint pricing is changed to linearly scale based on number of serials minted. Also, minting a single NFT in collection is changed to cost $0.02 from $0.05. https://github.com/hashgraph/hedera-services/issues/7769
* Full changelog: https://github.com/hashgraph/hedera-services/compare/v0.40.4...v0.41.0

**Full Changelog**: [v0.41.0...v0.41.0](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.41.0...v0.41.0)

</details>

## Release v0.40

### [Build v0.40.4](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.40.4)

<details>
<summary><strong>What's Changed</strong></summary>

* Fixes https://github.com/hashgraph/hedera-services/issues/7768 and unwanted export of synthetic creations during certain genesis reconnect scenarios.

**Full Changelog**: [v0.40.0...v0.40.4](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.40.0...v0.40.4)

</details>

### [Build v0.40.3](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.40.3)

<details>
<summary><strong>What's Changed</strong></summary>

* Fixes current stake period during upgrade
* * Fix `curStakePeriod` while doing upgrade house keeping in https://github.com/hashgraph/hedera-services/pull/7755
* **Full Changelog**: https://github.com/hashgraph/hedera-services/compare/v0.40.2...v0.40.3

**Full Changelog**: [v0.40.0...v0.40.3](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.40.0...v0.40.3)

</details>

### [Build v0.40.2](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.40.2)

<details>
<summary><strong>What's Changed</strong></summary>

* Adopts `0.40.2` SDK.

**Full Changelog**: [v0.40.0...v0.40.2](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.40.0...v0.40.2)

</details>

### [Build v0.40.1](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.40.1)

<details>
<summary><strong>What's Changed</strong></summary>

* Updates to `v0.40.1` SDK for metric naming update.

**Full Changelog**: [v0.40.0...v0.40.1](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.40.0...v0.40.1)

</details>

### [Build v0.40.0](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.40.0)

<details>
<summary><strong>What's Changed</strong></summary>

* The 0.40 release of Hedera Services delivers [HIP-729 ~ "Contract Accounts Nonce Externalization"](https://hips.hedera.com/hip/hip-729). Smart contract developers using the Hedera public mirror node can now track contract nonces as they would on e.g., Ethereum. Use cases might include troubleshooting failed contract calls or writing unit tests that validate transaction ordering based on `CREATE1` addresses (once these are set by default in release 0.41+).
* Open source contributors to the project will notice major refinements in the Gradle build, thanks to @jjohannes's expert touch.
* ### Minor changes
* - https://github.com/hashgraph/hedera-services/pull/7195 - Adds gradual transition to staking reward rate near boundary conditions of `0.0.800` balance and total hbar staked
* ### Bug fixes
* - https://github.com/hashgraph/hedera-services/pull/7028 - Ensures all fractional fees appear in the `getTokenInfo()` precompile output
* - https://github.com/hashgraph/hedera-services/pull/7030 - Removes existence validation of spender account when an approval is revoked
* - https://github.com/hashgraph/hedera-services/pull/7193 - Makes the genesis block number in a dev network 0 not 1
* ### Contributors
* @nathanklick
* @tinker-michaelj
* @qnswirlds
* @agadzhalov
* @MiroslavGatsanoga
* @mhess-swl
* @cody-littley
* @artemananiev
* @randered
* @edward-swirldslabs
* @lpetrovic05
* @hendrikebbers
* @timo0
* @Neeharika-Sompalli
* @JeffreyDallas
* @stoyan-lime
* @iwsimon
* @povolev15
* @david-bakin-sl
* @alittley
* @kimbor
* @lukelee-sl
* @rbair23
* @OlegMazurov
* @imalygin
* @poulok
* @nickpoorman
* @jjohannes
* @jsync-swirlds
* @agadzhalov
* @netopyr
* @jasperpotts
* @beeradb

**Full Changelog**: [v0.40.0...v0.40.0](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.40.0...v0.40.0)

</details>

## Release v0.39

### [Build v0.39.0](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.39.0)

<details>
<summary><strong>What's Changed</strong></summary>

* ## Features
* Services v0.39.0 adds the following features:
* - VirtualRootNode constructor creates a cache object that doesn't get reused #6321
* - Implement blocklisting of EVM addresses #5799
* - Optimize virtual node cache flush strategy #5568
* - HIP-721: 06026 - add software version to events #6236
* - Implement CryptoCreate handle method #6112
* - UtilPrng handle Implementation #6310
* - Add a PCLI sub command to sign services stream files #6309
* - Implement token freeze handling #6467
* - Implement token unfreeze handle() #6502
* - Combine Admin and Network modules #6511
* - Implement the modular Pre-Handle Workflow #6291
* - Move hashes out of leaves node in VirtualMap #5825
* - TokenFeeScheduleUpdate handle() implementation #6582
* - Basic File service implementation #6522
* - Implement Token Association to Account #6609
* - Implementation of handle workflow #6476
* - Implement the modular record cache #6754
* - CryptoDelete handle implementation #6694
* This release also adds the following minor features:
* - Includes an existing test modified to use https://github.com/hashgraph/hedera-services/pull/6168
* - Only clear memo in TokenUpdateLogic if client code can signal unset vs empty #6322
* - Update AddressBookTestingTool README.md #6330
* - Fuzzing test ethereum transaction LazyCreate #6247
* - Move token revoke verification method to preHandle #6318
* - Increase the TPS for AddressBookTestingTool to 1k #6342
* - updog #6255
* - Add ExportingRecoveredStateListener #6317
* - Refactor CryptoCreate #5878
* - Abbreviate and shorten JDB test asset names #6339
* - AddressBook.forceUseOfAddressBook default setting to false #6405
* - d busy time metric #5798
* - Faster class scan for config records #6274
* - Sync as protocol #5919
* - d ref count debug flag #6431
* - Remove unused properties for parsing config.txt #6110
* - queue thread flush #6406
* - Deleted unused code in platform module #6434
* - organize gossip packages #6436
* - Lay groundwork for ignoring app transactions during pces replay. #6442
* - Add query performance test to nightly test panel #6458
* - EVM version update and optimisations #5962
* - Add fuzz tests for hollow account completion #4855
* - Only com.swirlds is scanned by ConfigurationHolder #6430
* - Add Set support to the Config API #6004
* - Continue sending signature transactions during a freeze. #6474
* - Don't sync slowly in the hashgraph demo. #6462
* - PCES startup lifecycle #6420
* - AddressBookInitializer do not validate state loaded addressbook #6480
* - Flatten SwirldsPlatform.init() #6484
* - Update branch to latest protobufs #6459
* - Increment docker timeout #6495
* - Di services refactoring part 2 #6341
* - Flatten buildEventIntake() #6494
* - Remove HTS performance test from nightly regression #6507
* - Turn off traceability migration in 0.39 and subsequent releases #6382
* - Config API for services: Config instance is provided #6294
* - Remove vestigial Signed State cycle metric intervals #6515
* - Use adjusted account offsets in JRS test #6510
* - Add support back for genesisFreezeTime #6529
* - Accommodate varying sig map sizes in canAutoCreateWithFungibleTokenTransfersToAlias() #6520
* - Remove ChatterSettings and use ChatterConfig instead #6376
* - Extend software version to use configuration #6519
* - flatten build event handlers #6517
* - Config provided by Dagger #6525
* - Add tests for gas utility functions #6537
* - delete platform metrics #6521
* - Add Dockerfile, publish gcr.io/hedera-registry/validation-scenarios:0.1.0 #6485
* - turn NodeId into a record containing a long #6370
* - Only allow positive amounts for transferToken function #6558
* - pcli event stream info command to accept timestamp #6346
* - Skip sending class IDs for virtual leaf records during reconnects #6539
* - Implement getTypicalSerializedSize() method for variable-sized HS virtual map classes #6369
* - Move (some) signatures and decoders of versioned ABIs to a dedicated location #6564
* - Added an extended test work flow for platform function change PRs #6482
* - Export the uptime package to the config package. #6578
* - Export sync config to config impl. #6584
* - Remove FCHashMapSettings and use FCHashMapConfig instead #6378
* - remove getters #6549
* - remove onlyDefaultHapiSpec #6552
* - Remove ReconnectSettings and use configuration instead #6233
* - consistency testing tool #6505
* - remove unsafe state access #6567
* - Remove redundant pause check. #6600
* - Remove zero stake check in submission #6604
* - Update .gitignore for new metricsDoc.tsv spew #6587
* - remove get events #6602
* - Remove unwanted check #6622
* - deprecating long node ids and adding NodeId API to Address #6440
* - ReusableBucketPool synchronization redone #6597
* - Use keccak hash of signed bytes for ECDSA_SECP256K1 message #6610
* - Dagger modules refactored #6590
* - Set ReconnectController state to null after releasing #6626
* - Аdd hollow account finalization doc #5758
* - Updates Metrics to use non-contiguous NodeIds #6632
* - Implement complete SubmissionManager with expiry dedupe cache #6646
* - multinode event stream report #6624
* - Adjust netty keepAlive time/outs to longer interval #6655
* - Adjust netty keepAlive time/outs to longer interval #6655
* - Add checks for token revoke #6658
* - Crypto and State use non contiguous NodeId #6635
* - colorize pcli logs #6668
* - Out of Order Gossip Simulator #6535
* - Added missing rehash for VirtualMap leaves #6653
* - Also log timestamp when ISSTestingToolState provokes an ISS #6662
* - Added comment that hashCode test values must not be changed #6647
* - Add missing migration test panel #6678
* - use busy time metric #6562
* - MigrationTestingTool compatible with v0.38 saved state #6652
* - Add e2e tests for consensus-service #6563
* - Refactor top-level sig check #6679
* - Remove Deprecated SigInfo Class #6634
* - NodeId implements SelfSerializable #6691
* - Enabled leaf rehashing for existing VirtualMap instances. #6685
* - Gradle update and script cleanup #6637
* - gossip encapsulation #6607
* - Add optional keys and optional hollow accounts to pre-handle context #6542
* - Reflect mainnet 0.0.111 (fees) and 0.0.123 (throttles) contents in repo #6665
* - Update HIP-583 design doc and test plan #4818
* - Fuzzing test for LazyCreate through precompiles #6527
* - Add pureChecks() method to TransactionHandler #6697
* - Added contracts.nonces.externalization.enabled feature flag #6721
* - MAX_FULL_REHASHING_BUFFER_TIMEOUT is increased to 60 seconds. #6717
* - Use instantaneous capacity checks for gauges and TraceabilityExportTask #6733
* - PreHandle and QueryContext.configuration #6699
* - AddressBook.toConfigText() Supports Memo #6740
* - Add helpful debug messages for JRS failure #6744
* - updates daily CI tasks to properly handle the release branch names #6753
* - Consolidate all records in single FCQueue #6718
* - Handle old events #6663
* - Create platform status readme #6669
* - Allow queried TransactionID to have deleted payer account #6734
* - file service system file delete and undelete #6707
* - Added script for merging config.txt and currentAddressBook.txt. #6756
* - file service fix the configuration method #6766
* - Revert on-disk, consolidated FCQ dev overrides #6781
* - Config sources for services defined #6743
* - Update zero weights for new nodes #6777
* - AddressBook.toConfigText() updated unit test. #6764
* - FCQueue.getHash() is a hashing bottleneck #6769
* - Browser and Platform support noncontiguous NodeId #6695
* - Teacher should stop teaching if it falls behind while teaching #6557
* - Updated PBJ to 0.6.0 and updated gradle build for new decencies #6793
* - Allow INVALID_SIGNATURE status on EthTx value sent to EOA with receiverSigRequired=true #6779
* - Enable data on disk and MerkleDb for nightly services runs #6795
* - Better handling of failed async hashing #6796
* - MerkleDb compactions are stopped after a snapshot #6808
* - Add extra information to state dump log. #6813
* - Bytes Converter added for Config #6643
* - Always return EIP-1014 address as priority even if not alias #6776
* - Do leaf rehash during VirtualMap deserialization #6807
* - Re-use consensus throttle in HederaWorldState.commit() for following children #6800
* - Adjust burn token amount handling #6805
* - PREVIEWNET, LOCAL: Sunset old security model for smart contracts #6824
* - List of dirty leaves doesn't have to be sorted on VirtualNodeCache flush #6741
* - Fix redirect for token parsing #6819
* - Remove usages of VirtualMap.fullLeafRehash #6815
* - Add stats for platform_degraded and platform_healthyNetworkFraction_fraction to Network Status dashboard #6907
* - Accounts integrity violated with accounts.storeOnDisk enabled #6846
* - Cannot snapshot to disk after MerkleMap to VirtualMap migration w/ MerkleDb #6887
* - Make no-min fractional fees viewable via precompiles #7031
* - Move spender validation only for approvals #7030
* - Enable / disable data on disk and MerkleDb in dev environments #6886
* - Retire old security model for smart contracts by changing HAPI signature-check block limit to LOW #7055
* - Enable MerkleDb in previewnet, testnet, and mainnet in 0.39 #7109
* - MerkleDb metadata file must not be changed in saved states #7066
* - ISS in account store after migration to disk (0.39) #7136
* ## Bug Fixes
* - Fix string formatting bug #6337
* - Fail to read a data item after data source compaction was interrupted #6426
* - Auto-scale from per-node mtps instead of network-wide #6465
* - Fix state loading. #6499
* - Method name in TestConfigBuilder fixed #6526
* - Large reconnect relates tests fail after recent changes #6540
* - extended test lable #6591
* - FCQueue is not properly destroyed #6630
* - Cause pcli.sh to fall back to no color if the color script is missing #6683
* - Inconsistency between VirtualNodeCache and DataSource during snapshots #6681
* - Properly clear pipelines before a reconnect. #6738
* - Fix Hedera so it can start again #6804
* - bug fix in AddressBookTestingToolState #6817
* - Added tests, fixed some bugs #6784
* - IOException during warm() call #6820
* - Fix nextExportTime if time exceeded one exportPeriod #7020
* - Old virtual map copies aren't released during to disk migration #7019
* ## Contributors
* We'd like to thank all the contributors who worked on this release!
* @nathanklick
* @tinker-michaelj
* @qnswirlds
* @agadzhalov
* @MiroslavGatsanoga
* @mhess-swl
* @cody-littley
* @artemananiev
* @randered
* @edward-swirldslabs
* @lpetrovic05
* @hendrikebbers
* @timo0
* @Neeharika-Sompalli
* @JeffreyDallas
* @stoyan-lime
* @iwsimon
* @povolev15
* @david-bakin-sl
* @alittley
* @kimbor
* @lukelee-sl
* @rbair23
* @OlegMazurov
* @imalygin
* @poulok
* @nickpoorman
* @jjohannes
* @jsync-swirlds
* @agadzhalov
* @netopyr
* @jasperpotts
* @beeradb

**Full Changelog**: [v0.39.0...v0.39.0](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.39.0...v0.39.0)

</details>

## Release v0.38

### [Build v0.38.6](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.38.6)

<details>
<summary><strong>What's Changed</strong></summary>

* Updates fee distribution percentage to include 10% to `0.0.800`.

**Full Changelog**: [v0.38.0...v0.38.6](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.38.0...v0.38.6)

</details>

### [Build v0.38.2](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.38.2)

<details>
<summary><strong>What's Changed</strong></summary>

* ## Bug Fixes
* - Re-used EvmSigsVerifier in ContractCallTransitionLogic (#6680)
* ## Contributors
* We'd like to thank the contributor who worked on this release!
* @tinker-michaelj

**Full Changelog**: [v0.38.0...v0.38.2](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.38.0...v0.38.2)

</details>

### [Build v0.38.1](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.38.1)

<details>
<summary><strong>What's Changed</strong></summary>

* # Minor Features
* - Remove zero weight node submission check #6629
* # Contributors
* We'd like to thank all the contributors who worked on this release!
* @kimbor
* @Neeharika-Sompalli
* @poulok
* @tinker-michaelj

**Full Changelog**: [v0.38.0...v0.38.1](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.38.0...v0.38.1)

</details>

### [Build v0.38.0](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.38.0)

<details>
<summary><strong>What's Changed</strong></summary>

* # Features
* - Upgrade EVM to Shanghai https://github.com/hashgraph/hedera-services/pull/5964
* - EVM version update and optimizations #5962
* - Turn on the Shanghai version of the EVM in previewnet #6212
* - Update hedera-protobufs-java version to 0.38.10 #6579
* - Add PCLI command to sign account balance files #6264
* ## Minor Features
* - Update FileSignTool to support compressed rcd file with extension "rcd.gz" #6007
* - Extend software version to use configuration #6519 #6519
* - write human readable state address book during state save #6057
* - misc startup improvements #5790
* - Add signing requirements for transfer of NFT with fallback royalty fee #5997
* - Change the file name for preconsensus event stream files. #6000
* - Enable default services compression properties #6040
* - More robust state dumps #5963
* - Make accounts blocklisting feature flag disabled by default #6069
* - Turn on the contract actions sidecar in mainnet and testnet #5687
* - Parallel bucket reads in HalfDiskHashMap.endWriting() #5993
* - update log rollover configuration #6086
* - if no state is loaded, always use config address book. #6079
* - Add some ascii art to Hedera.java #6270
* - Update `StakingInfo.weight` midnight UTC #6231
* - Create Entity Map Warmer For Performance #6223
* - Introduced MappedConfigSource #6105
* - Debuggable State Reference Counts #6142
* - pces span heuristic #6222
* - AddressBook.forceUseOfAddressBook default setting #6334
* - Add feature flag for state ref count debug feature. #6404
* - Extend software version to use configuration #6519
* # Bug Fixes
* - Implement HRC facade implementation of associate/dissociate functions https://github.com/hashgraph/hedera-services/pull/6053
* - Distinguish auto-approvals in synthetic CryptoTransfer transfer lists #6290
* - Bump JRS spec `0.0.X` ids to `0.0.(X+300)` to account for EVM blocklist accounts #6039
* - Decrement entity numbers (299 not 300 blocklist accounts) #6048
* - HTS precompile clears memo #6033
* - fix address book init on software downgrade #5940
* - Omit auto-renew id if unused in synth `ContractCreateTransactionBody` #6111
* - Fix angry log message when state metadata doesn't record any state signatures #6179
* - Include ownerId in synthetic child createApproveAllowanceForAllNFT txn #6177
* - Ensure complete record files and sidecars are written during event stream recovery #6202
* - SigningTool defined as app #6215
* - Call getNumberOfChildren() less in iterator. #6279
* - Don't require signing keys when doing event stream recovery. #6285
* - Only clear memo in `TokenUpdateLogic` if client code can signal unset vs empty #6322
* - AddressBookInitializer skip validating state loaded addressbook #6481
* - Only allow positive amounts for transferToken function #6573
* - Remove zero stake check in submission #6604
* # Documentation
* - Add design doc for token facade associate/dissociate #5986
* - Added system startup diagram. #6269
* # Test Improvements
* - Fix flaky preconsensus event stream test #5984
* - automating address book initialization tests #5899
* - Assert EVM is set correctly in contract create #5797
* - Added test for autoCreate with transfer to Long Zero Address #5695
* - Add more hollow finalization tests #5918
* - Add fuzzing tests for CryptoTransfer-to-alias, CryptoTransfer-to-EVM-address covering auto/lazy creates and transfers to existing accounts #4943
* - Config API use null annotations and checks #5814
* - Fix AddressBookTestingToolState errors for test scenarios #6182
* - Add new test workflow #6287
* - Add addressBook test panel #6289
* - Add tests for gas calculation utility functions #6551
* # Codebase Improvements
* - Bucket.findEntryOffset() can reduce calls to getKeySize() [[#5949](https://github.com/hashgraph/hedera-services/pull/5949)](https://github.com/hashgraph/hedera-services/pull/5949)
* - Use PBJ with services [[#4856](https://github.com/hashgraph/hedera-services/pull/4856)](https://github.com/hashgraph/hedera-services/pull/4856)
* - transaction metadata becomes pre handle results #5958
* - Create a `VirtualMap` benchmark for remove operations #5966
* - query workflow improvements #5971
* - Implement FreezeService preHandle #5988
* - Remove SessionContext #5974
* - Revert to `v0.35.3` `ContractKey.hashCode()` #6012
* - FileSignTool moved to new module #5972
* - Changed FeeObject to a record #5978
* - 5910: VirtualKey doesn't need to be comparable #6014
* - Implement `TokenPause` and `TokenUnpause` Handlers #5960
* - Change HAPI Jar #6066, #6098
* - Throw PreCheckException instead of setting status in PreHandleContext. #6063
* - query workflow improvements part2 #6080
* - Set the ledger ID for preproduction environments #6087
* - Implement Token Grant KYC Handle #5911
* - renamed `stake` to `weight` throughout the platform #6099
* - Move to PBJ Account #6103
* - Enable writing pcli plugins in `hedera-services` and provide an example plugin #6134
* - Use correct path when loading state. #6181
* - Merge relevant work from `replay-develop` #6102
* - Make readable stores available to all services #6210
* - Lifecycle and Mutable interfaces & functionality moved to base module #5822
* - Config Provider for Services #5996
* - Cross-service stores (TokenService part) #6230
* - Migrated ConsensusService to new design #6239
* - Migrated AdminService to new design #6238
* - Dagger module for token service #6249
* - Migrated FileService to new design #6240
* - Migrated NetworkService to new design #6241
* - Move noop metrics. #6251
* - Migrated SmartContractService to new design #6244
* - Migrated UtilService to new design #6245
* - consensus service & admin service use new DI pattern #6260
* - AppTestBase use simple config #6275
* - ConfigConverter and ConfigSource implementations for the service layer #6107
* - Migrated ScheduleService to new design #6243
* - query workflow improvements part3 #6108
* - Finalize cross service stores #6246
* - Implement token revoke KYC handle #6140
* - update Platform SDK CI/CD release pipelines to support the integrated repository #6315
* - Move (some) signatures and decoders of versioned ABIs to a dedicated location #6569
* # Contributors
* We'd like to thank all the contributors who worked on this release!
* @agadzhalov
* @alittley
* @artemananiev
* @beeradb
* @cody-littley
* @cweagans
* @david-bakin-sl
* @dimitar-dinev
* @edward-swirldslabs
* @hendrikebbers
* @imalygin
* @IvanKavaldzhiev
* @iwsimon
* @JeffreyDallas
* @jsync-swirlds
* @kimbor
* @lpetrovic05
* @lukelee-sl
* @mhess-swl
* @MiroslavGatsanoga
* @mustafauzunn
* @nathanklick
* @Neeharika-Sompalli
* @netopyr
* @OlegMazurov
* @poulok
* @povolev15
* @qnswirlds
* @randered
* @rbair23
* @shemnon
* @stoqnkpL
* @stoyan-lime
* @tannerjfco
* @tdermendzhievv
* @timo0
* @tinker-michaelj

**Full Changelog**: [v0.38.0...v0.38.0](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.38.0...v0.38.0)

</details>

## Release v0.37

### [Build v0.37.1](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.37.1)

<details>
<summary><strong>What's Changed</strong></summary>

* - Traceability migration now gated only on migration feature flag (#6257)
* - Standardize to ledger.maxAutoAssociations property limit (#6258)
* ## CONTRIBUTORS
* @david-bakin-sl
* @Neeharika-Sompalli
* @tinker-michaelj

**Full Changelog**: [v0.37.0...v0.37.1](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.37.0...v0.37.1)

</details>

### [Build v0.37.0](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.37.0)

<details>
<summary><strong>What's Changed</strong></summary>

* ## FEATURES
* - Implement topic deletion prehandle (#5033)
* - Generalize workflows enabled and add workflow ports (#5032)
* - Pre-handle improvements (#5056)
* - Support auto-scheduling operations by type within a suite (#5054)
* - Add SPI and App components supporting TransactionDispatcher for modularized HCS (#5062)
* - added the missing functionality to FileSignTool (#5100)
* - Consensus Message Submission Prehandle (#5059)
* - Add IngestChecker mono adapters for sigs and solvency (#5098)
* - [HIP-583] Finalize hollow accounts via any required signature in a txn (#4990)
* - Remove CryptoCreate capability to create hollow accounts (#4998)
* - Populate EVM Address in CryptoTranscation (#5010)
* - Enable All EVM E2E suites to run with Ethereum Calls (#4375)
* ## PROPERTY CHANGES
* - Enable node software compression of recordstream and account balance for testnet (#5034)
* - Enable node software compression of recordstream and account balance files for mainnet (#5455)
* - Mhs adapter (#5019)
* - Updates the e2e and itest based network log captures and adds a conditional flag (#5063)
* ## BUG FIXES
* - Fix the hash stream log. (#5079)
* - Fix log4j configuration for local tests. (#5085)
* - Fix minGenInfo in signed state. (#5088)
* - Fix action sidecars missing expected fields (#5192)
* - Fix resolves breaking issue with the python virtual env in the JRS pipeline
* - Fix cryptoCreateWithAlias feature flag rename (#5612)
* - Fix formatting issue over strings in logs and concatenation Printf-style format strings should be used correctly (#5704)
* - Fix local TraceabilitySuite configs (#5465)
* - Fix no active payer exception in ContractCallLocal (#5485)
* - Fix the parsing of the version string for FileSignTool (#5467)
* - Port precompile permissions changes and EET fixes (#5656)
* **TEST IMPROVEMENTS:**
* - Minor spec update to reflect current behavior (#5036)
* - Add client.workflow.operations and test with workflows (#5053)
* - Reset account balance on TOKEN_TREASURY to correct a failed itest (#5091)
* - Fix regression test (#5047)
* - Fix flaky test. (#5652)
* ## REPO IMPROVEMENTS
* - Add missing code to TokenPUV test suite cleanup (#5038)
* - Add WritableTopicStore (#5060)
* - Implement ConsensusCreateTopicHandler.handle() (#5076)
* - Provide mono FeeCalculator adapter for ingest and handle workflows (#5228)
* - Disable transThrottle. (#5154)
* - Remove unused code (#5119)
* - Delete SwirldState1. (#5454)
* - Remove trans throttle (#5444)
* - PropertyFileConfigSource supports custom ordinal (#5093)
* - Optimized disk usage for LongListOffHeap and LongListDisk implementations (#5092)
* - Remove CryptoCreate with key alias (#5645)
* - Change the long zero address encoding algorithm (#5048)
* - Add more info on incorrect child records (#5759)
* - Validate all TransactionBody's have an oneof set (#5640)
* ## DOCUMENTATION UPDATES
* - Service modules architecture documentation (#4596)
* - Fix Broken Documentation Link (#5470)
* - Skeleton Mindmap (#5122)
* - Add thread diagram to mindmap (#5489)
* - Expand diagram (#5731)
* ## DEPRECATIONS
* - com.swirlds.platform.event.preconsensus.NoOpPreConsensusEventWriter
* ## CONTRIBUTORS
* @alittley
* @artemananiev
* @beeradb
* @cody-littley
* @david-bakin-sl
* @dimitar-dinev
* @edward-swirldslabs
* @hendrikebbers
* @imalygin
* @IvanKavaldzhiev
* @iwsimon
* @JeffreyDallas
* @kimbor
* @lpetrovic05
* @mhess-swl
* @MiroslavGatsanoga
* @nathanklick
* @Neeharika-Sompalli
* @netopyr
* @OlegMazurov
* @poulok
* @povolev15
* @randered
* @rbair23
* @tannerjfco
* @tinker-michaelj

**Full Changelog**: [v0.37.0...v0.37.0](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.37.0...v0.37.0)

</details>

## Release v0.36

### [Build v0.36.4](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.36.4)

<details>
<summary><strong>What's Changed</strong></summary>

* Updates the `prometheusEndpointEnabled` config property to `true`

**Full Changelog**: [v0.36.0...v0.36.4](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.36.0...v0.36.4)

</details>

### [Build v0.36.2](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.36.2)

<details>
<summary><strong>What's Changed</strong></summary>

* - Add signing requirements for transfers of NFT with fallback royalty fee
* - Enable contract action sidecars
* - Turn on balance and record stream compression to improve performance

**Full Changelog**: [v0.36.0...v0.36.2](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.36.0...v0.36.2)

</details>

### [Build v0.36.1](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.36.1)

<details>
<summary><strong>What's Changed</strong></summary>

* Fixes an accidental change in the `ContractKey.hashCode()` implementation that affected testnet.

**Full Changelog**: [v0.36.0...v0.36.1](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.36.0...v0.36.1)

</details>

### [Build v0.36.0](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.36.0)

<details>
<summary><strong>What's Changed</strong></summary>

* ## Features
* Services v0.36.0 adds the following functionality:
* - Add tracking of property changes for hollow account completion (#4647)
* - Adding support for Redirect Token Calls fro evm-module (#4880)
* - Update FileSignTool (#4988)
* - Adding block number tool (#4997)
* - Add client.workflow.operations and test with workflows (#5053)
* - update hedera-services to use FSTS CLI instead of system properties
* - 6166: Migrate VirtualMap data from JasperDB to MerkleDb data sources
* - Implementation of current network functionality in new, modularized application architecture: consensus operations, query workflow, and various preHandle implementations
* ## Security Updates: Hedera Smart Contract Service Security Model Changes
* Changes from services v0.35.2 have also been ported to v0.36.0.
* - After the security incident on March 9th, the engineers conducted a thorough analysis of the Smart Contract Service and the Hedera Token Service system contracts.
* - As part of this exercise, we did not find any additional vulnerabilities that could result in an attack that that which we witnessed on March 9th.
* - The team also looked for any disparities between the expectations of a typical smart contract developer who is used to working with the Ethereum Virtual Machine (EVM) or ERC token APIs and the behaviors of the Hedera Token Service system contract APIs. Such differences in behavior could be used by a malicious smart contract developer in unexpected ways.
* - In order to eliminate the possibility of these behavioral differences being utilized as attack vectors in the future, the consensus node software will align the behaviors of the Hedera Smart Contract Service token system contracts with those of EVM and typical token APIs such as ERC 20 and ERC 721.
* - As a result, the following changes are made as of the mainnet 0.35.2 release on March 31st:
* - An EOA (externally owned account) will have to provide explicit approval/allowance to a contract if they want the contract to transfer value from their account balance.
* - The behavior of `transferFrom` system contract will be exactly the same as that of the ERC 20 and ERC 721 spec `transferFrom` function.
* - For HTS specific token functionality (e.g. Pause, Freeze, or Grant KYC), a contract will be authorized to perform the associated token management function only if the ContractId is listed as a key on the token (i.e. Pause Key, Freeze Key, KYC Key respectively).
* - The `transferToken` and `transferNFT` APIs will behave as `transfer` in ERC20/721 if the caller owns the value being transferred, otherwise it will rely on approve spender allowances from the token owner.
* - The above model will dictate entity (EOA and contracts) permissions during contract executions when modifying state. Contracts will no longer rely on Hedera transaction signature presence, but will instead be in accordance with EVM, ERC and ContractId key models noted.
* - As part of this release, the network will include logic to grandfather in previous contracts.
* - Any contracts created from this release onwards will utilize the stricter security model and as such will not have considerations for top-level signatures on transactions to provide permissions.
* - Existing contracts deployed prior to this upgrade will be automatically grandfathered in and continue to use the old model that was in place prior to this release for a limited time to allow for DApp/UX modification to work with the new security model.
* - The grandfather logic will be maintained for an approximate period of 3 months from this release. In a future release in July 2023, the network will remove the grandfather logic, and all contracts will follow the new security model.
* - Developers are encouraged to test their DApps with new contracts and UX using the new security model to avoid unintended consequences. If any DApp developers fail to modify their applications or upgrade their contracts (as applicable) to adhere to the new security model, they may experience issues in their applications.
* ## Property Changes
* - Disable chatter on previewnet (#4815)
* - Enable prometheus scrape endpoint in previewnet and testnet (#4813)
* - Update autoRenew.targetTypes=CONTRACT (#4822)
* - Enable HIP-583 features on testnet and mainnet (#4868)
* - Disable contract expiry (#5027)
* ## Bug Fixes
* - Еxplicit redirectForToken call fix (#4752)
* - Fix : Fix nftsOwned for Treasury when NFTs are returned back to treasury
* - Clean up block number/record file relationship (#4924)
* - Fix : Fix SigRequirements for NFT Transfer using alias (#4886)
* - Remove logic that auto assigns alias on CryptoCreate with ECDSA key (#4921)
* - Fix created contract ids after hollow account creation (#4973)
* ## Test Improvements
* - Minimal inline record validator (#4794)
* - Add a test for validating auto-renew behavior (#4882)
* - test: create a smart contract, verify it showed up in the record stream
* - Reduce itest and e2e test logging to ERROR or above (#4977)
* - Add basic validator for validating renewal and expiry records (#4888)
* - Improve RecordStreamAccess and EventualRecordStreamAssertion (#4898)
* - 4838 d contract expiry specs (#4881)
* - Add BlockNoValidator (#4932)
* ## Repository improvements
* - Restructuring of repo, including removing old files and moving `docs/`, `docker/`, `test-clients/` folders underneath `hedera-node`
* - Added Snyk scanning
* - Updated code style enforcement and configuration (#4980)
* - Minor refactorings throughout
* ## Dependency Updates
* - Upgrade platform to v0.36.1 (#5005)
* - Update hedera protobufs, java api to v0.36.1 (#5888)
* ## Documentation Updates
* - Update intellij-quickstart guide #4850 (#4852)
* - (Gradle) Module Documentation (#4992)
* ## Deprecations
* - com.hedera.node.app.config.ConfigurationAdaptor
* ## Contributors
* We'd like to thank all the contributors who worked on this release!
* @artemananiev
* @beeradb
* @david-bakin-sl
* @dimitar-dinev
* @georg-getz
* @hendrikebbers
* @isavov
* @iwsimon
* @JeffreyDallas
* @jeromy-cannon
* @kimbor
* @lukelee-sl
* @mhess-swl
* @MiroslavGatsanoga
* @Nana-EC
* @nathanklick
* @Neeharika-Sompalli
* @netopyr
* @nikolovyanko
* @povolev15
* @qnswirlds
* @randered
* @rbair23
* @stoqnkpL
* @stoyan-lime
* @swirlds-automation
* @tannerjfco
* @tdermendzhievv
* @tinker-michaelj

**Full Changelog**: [v0.36.0...v0.36.0](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.36.0...v0.36.0)

</details>

## Release v0.35

### [Build v0.35.3](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.35.3)

<details>
<summary><strong>What's Changed</strong></summary>

* Royalty fallback fees offer a route to ensure NFT creators are compensated a fee on NFT transfers. For account security the network has added missing logic to ensure these fallback fees go through the appropriate authorization checks.
* Also adds the following property to support management of custom fee debits
* ```
* contracts.precompile.unsupportedCustomFeeReceiverDebits=
* ```

**Full Changelog**: [v0.35.0...v0.35.3](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.35.0...v0.35.3)

</details>

### [Build v0.35.2](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.35.2)

<details>
<summary><strong>What's Changed</strong></summary>

* ## Hedera Smart Contract Service Security Model Changes
* - After the security incident on March 9th, the engineers conducted a thorough analysis of the Smart Contract Service and the Hedera Token Service system contracts.
* - As part of this exercise, we did not find any additional vulnerabilities that could result in an attack that that which we witnessed on March 9th.
* - The team also looked for any disparities between the expectations of a typical smart contract developer who is used to working with the Ethereum Virtual Machine (EVM) or ERC token APIs and the behaviors of the Hedera Token Service system contract APIs. Such differences in behavior could be used by a malicious smart contract developer in unexpected ways.
* - In order to eliminate the possibility of these behavioral differences being utilized as attack vectors in the future, the consensus node software will align the behaviors of the Hedera Smart Contract Service token system contracts with those of EVM and typical token APIs such as ERC 20 and ERC 721.
* - As a result, the following changes are made as of the mainnet 0.35.2 release on March 31st:
* - An EOA (externally owned account) will have to provide explicit approval/allowance to a contract if they want the contract to transfer value from their account balance.
* - The behavior of `transferFrom` system contract will be exactly the same as that of the ERC 20 and ERC 721 spec `transferFrom` function.
* - For HTS specific token functionality (e.g. Pause, Freeze, or Grant KYC), a contract will be authorized to perform the associated token management function only if the ContractId is listed as a key on the token (i.e. Pause Key, Freeze Key, KYC Key respectively).
* - The `transferToken` and `transferNFT` APIs will behave as `transfer` in ERC20/721 if the caller owns the value being transferred, otherwise it will rely on approve spender allowances from the token owner.
* - The above model will dictate entity (EOA and contracts) permissions during contract executions when modifying state. Contracts will no longer rely on Hedera transaction signature presence, but will instead be in accordance with EVM, ERC and ContractId key models noted.
* - As part of this release, the network will include logic to grandfather in previous contracts.
* - Any contracts created from this release onwards will utilize the stricter security model and as such will not have considerations for top-level signatures on transactions to provide permissions.
* - Existing contracts deployed prior to this upgrade will be automatically grandfathered in and continue to use the old model that was in place prior to this release for a limited time to allow for DApp/UX modification to work with the new security model.
* - The grandfather logic will be maintained for an approximate period of 3 months from this release. In a future release in July 2023, the network will remove the grandfather logic, and all contracts will follow the new security model.
* - Developers are encouraged to test their DApps with new contracts and UX using the new security model to avoid unintended consequences. If any DApp developers fail to modify their applications or upgrade their contracts (as applicable) to adhere to the new security model, they may experience issues in their applications.

**Full Changelog**: [v0.35.0...v0.35.2](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.35.0...v0.35.2)

</details>

### [Build v0.35.1](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.35.1)

<details>
<summary><strong>What's Changed</strong></summary>

* Adds limitations on `delegatecall's` to precompile contracts

**Full Changelog**: [v0.35.0...v0.35.1](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.35.0...v0.35.1)

</details>

### [Build v0.35.0](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.35.0)

<details>
<summary><strong>What's Changed</strong></summary>

* ## Features
* - [HIP-583](https://hips.hedera.com/hip/hip-583) to expand alias support in CryptoCreate & CryptoTransfer Transactions.
* This includes,
* - CryptoTransfer to non-existing EVM address alias causing hollow-account creation.
* - Finalizing a hollow account with the payer signature in an incoming transaction
* Use cases for HIP-583 that work in this release :
* 1. As a user with an ECDSA based account from another chain I can have a new Hedera account created based on on my evm-address alias.
* 2. As a developer, I can create a new account using a evm-address alias via the CryptoTransfer transaction.
* 3. As a developer, I can transfer HBAR or tokens to a Hedera account using their evm-address alias.
* 4. As a Hedera user with an Ethereum-native wallet, I can receive HBAR or tokens in my account by sharing only my evm-address alias.
* 5. As a Hedera user with a Hedera-native wallet, I can transfer HBAR or tokens to another account using only the recipient's evm-address alias.
* ## Configuration  Changes
* ```
* autoCreation.enabled=true
* lazyCreation.enabled=true
* cryptoCreateWithAliasAndEvmAddress.enabled=false
* contracts.evm.version=v0.34
* ```

**Full Changelog**: [v0.35.0...v0.35.0](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.35.0...v0.35.0)

</details>

## Release v0.34

### [Build v0.34.5](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.34.5)

<details>
<summary><strong>What's Changed</strong></summary>

* Disallows `delegatecall` to precompiles.

**Full Changelog**: [v0.34.0...v0.34.5](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.34.0...v0.34.5)

</details>

### [Build v0.34.4](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.34.4)

<details>
<summary><strong>What's Changed</strong></summary>

* Disallow `delegatecall` to HTS precompiles.

**Full Changelog**: [v0.34.0...v0.34.4](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.34.0...v0.34.4)

</details>

### [Build v0.34.3](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.34.3)

<details>
<summary><strong>What's Changed</strong></summary>

* Use `v0.34.3` SDK.

**Full Changelog**: [v0.34.0...v0.34.3](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.34.0...v0.34.3)

</details>

### [Build v0.34.2](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.34.2)

<details>
<summary><strong>What's Changed</strong></summary>

* Port patches.

**Full Changelog**: [v0.34.0...v0.34.2](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.34.0...v0.34.2)

</details>

### [Build v0.34.1](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.34.1)

<details>
<summary><strong>What's Changed</strong></summary>

* Cherry-picks several fixes from `develop`:
* - https://github.com/hashgraph/hedera-services/pull/4641
* - https://github.com/hashgraph/hedera-services/pull/4628
* - https://github.com/hashgraph/hedera-services/pull/4654
* - https://github.com/hashgraph/hedera-services/pull/4638
* - https://github.com/hashgraph/hedera-services/pull/4671

**Full Changelog**: [v0.34.0...v0.34.1](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.34.0...v0.34.1)

</details>

### [Build v0.34.0](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.34.0)

<details>
<summary><strong>What's Changed</strong></summary>

* Services v0.34.0 completes the implementation of [HIP-583](https://hips.hedera.com/hip/hip-583).
* To ensure full test coverage of this intricate feature, it will first be enabled **only on previewnet**.
* ➡️  Smart contract rent will not be enabled in this release.

**Full Changelog**: [v0.34.0...v0.34.0](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.34.0...v0.34.0)

</details>

## Release v0.33

### [Build v0.33.3](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.33.3)

<details>
<summary><strong>What's Changed</strong></summary>

* Fixes for `INSUFFICIENT_PAYER_BALANCE` issue.

**Full Changelog**: [v0.33.0...v0.33.3](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.33.0...v0.33.3)

</details>

### [Build v0.33.2](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.33.2)

<details>
<summary><strong>What's Changed</strong></summary>

* Fix issue in post-upgrade staking housekeeping.

**Full Changelog**: [v0.33.0...v0.33.2](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.33.0...v0.33.2)

</details>

### [Build v0.33.0](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.33.0)

<details>
<summary><strong>What's Changed</strong></summary>

* ## Features
* Services v0.33.0 adds the following features:
* - Hyperledger Besu EVM updated to version 22.10.x
* - 'accounts send' subcommand added to yahcli to support sending HTS token units
* - Developer documentation updates
* ## Bug Fixes
* - Fixed class-not-found errors and missing log4j dependency in yahcli tool
* - Mirror nodes now receive correct treasury balances when a node starts from genesis
* - Staking rewards paid under correct conditions
* - When returning an NFT with fallback royalty fee to its treasury, the treasury signature is no longer required
* - The PrngSystemPrecompiledContract sets the op-specific transaction body in its synthetic transaction even if it fails for a reason such as INSUFFICIENT_GAS
* - Zero unit token operations in smart contracts now charge less gas
* ## Contributors
* We'd like to thank all the contributors who worked on this release!
* @mhess-swl
* @rbair23
* @nikolovyanko
* @nathanklick
* @mustafauzunn
* @Neeharika-Sompalli
* @tinker-michaelj
* @lukelee-sl
* @georg-getz
* @david-bakin-sl
* @dimitar-dinev
* @IvanKavaldzhiev
* @hendrikebbers
* @srkswirlds
* @shemnon
* @netopyr
* @kimbor

**Full Changelog**: [v0.33.0...v0.33.0](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.33.0...v0.33.0)

</details>

## Release v0.32

### [Build v0.32.0](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.32.0)

<details>
<summary><strong>What's Changed</strong></summary>

* ## Features
* Services v0.32.0 does not complete any HIPs, but does add the following minor features:
* - Groundwork for contract isApproval flag and precompile transferring hbars
* - Adds support for congestion pricing factors (fees.percentUtilizationScaleFactors)
* - Externalizes system account creations
* - CryptoCreate now works with ECDSA public key aliases
* ## Bug fixes
* - Curve points (r, s) given to native library are now left-padded
* - Transactions with unknown fields are rejected (both in precheck and at consensus)
* - PRNG synth body is always set
* - Total stake always set at start of latest rewarded period when zero rewards earned
* - Balance set on synthetic creation export records
* - Public key lengths validated in auto-creation CryptoTransfers
* - Treasury signature is waived if receiving NFT with a fallback fee
* ## Contributors
* We'd like to thank all the contributors who worked on this release!
* @beeradb
* @dimitar-dinev
* @georg-getz
* @IvanKavaldzhiev
* @JeffreyDallas
* @kimbor
* @lukelee-sl
* @mhess-swl
* @mustafauzunn
* @nathanklick
* @Neeharika-Sompalli
* @nikolovyanko
* @rjuang
* @tdermendzhievv
* @tinker-michaelj

**Full Changelog**: [v0.32.0...v0.32.0](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.32.0...v0.32.0)

</details>

## Release v0.31

### [Build v0.31.6](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.31.6)

<details>
<summary><strong>What's Changed</strong></summary>

* Services v0.31.6 fixes the following bug:
* ## Bug Fix
* -Fix issue in post-upgrade staking housekeeping.

**Full Changelog**: [v0.31.0...v0.31.6](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.31.0...v0.31.6)

</details>

### [Build v0.31.5](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.31.5)

<details>
<summary><strong>What's Changed</strong></summary>

* Adds missing fixes for precompile signing requirements.

**Full Changelog**: [v0.31.0...v0.31.5](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.31.0...v0.31.5)

</details>

### [Build v0.31.2](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.31.2)

<details>
<summary><strong>What's Changed</strong></summary>

* Patches to detect invalid auto-created keys and deal with a couple corner cases in staking rewards and auto-account creation fee charging.

**Full Changelog**: [v0.31.0...v0.31.2](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.31.0...v0.31.2)

</details>

### [Build v0.31.1](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.31.1)

<details>
<summary><strong>What's Changed</strong></summary>

* - Fixes to HTS Precompiles
* **Full Changelog**: https://github.com/hashgraph/hedera-services/compare/v0.31.0...v0.31.1

**Full Changelog**: [v0.31.0...v0.31.1](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.31.0...v0.31.1)

</details>

### [Build v0.31.0](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.31.0)

<details>
<summary><strong>What's Changed</strong></summary>

* ## Features
* Services 0.31 completes the following features:
* - [HIP-542 roadmap](https://hips.hedera.com/hip/hip-542) for making payer of the `CryptoTransfer` sponsor for `auto-creation`. It also enables auto-creation with Token transfers in addition to Hbar transfers.
* - [HIP-564 roadmap](https://hips.hedera.com/hip/hip-564) for allowing zero unit fungible token transfers
* - [HIP-573 roadmap](https://hips.hedera.com/hip/hip-573) for enabling token creators an option to exempt _all_ of their token’s fee collectors from a custom fee.
* In addition to the above features,
* - Adds support of the ERC20/721 `transferFrom` method for HTS precompiles from [HIP-514 roadmap](https://hips.hedera.com/hip/hip-514).
* - Enables Smart Contract Traceability.
* - Adds some changes related to testability improvements.
* ## Bug fixes
* - Adds `transactionID` to the expiration records from the parent transactionID
* - Avoids NullPointerException in case of a contract in state with inconsistent nftsOwned
* ## Contributors
* We'd like to thank all the contributors who worked on this release!
* - @alshapi
* - @bugbytesinc
* - @Daniel-K-Ivanov
* - @dimitar-dinev
* - @ivanparnarev
* - @IvanKavaldzhiev
* - @jasperpotts
* - @JeffreyDallas
* - @joan41868
* - @kimbor
* - @mhess-swl
* - @MiroslavGatsanoga
* - @Neeharika-Sompalli
* - @OlegMazurov
* - @qnswirlds
* - @rbair23
* - @rjuang
* - @rusiboyadjiev
* - @shemnon
* - @SimiHunjan
* - @statop
* - @stoqnkpL
* - @superboo
* - @tdermendzhievv
* - @tinker-michaelj

**Full Changelog**: [v0.31.0...v0.31.0](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.31.0...v0.31.0)

</details>

## Release v0.30

### [Build v0.30.0](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.30.0)

<details>
<summary><strong>What's Changed</strong></summary>

* ## Contract expiration and token management ⏳
* Services 0.30 completes the [HIP-514 roadmap](https://hips.hedera.com/hip/hip-514) for making Hedera native tokens manageable via smart contracts. There are five new system contracts: `getTokenExpiryInfo(address)`, `updateTokenExpiryInfo(address, Expiry)`, `isToken(address token)`, `getTokenType(address token)`, and `updateTokenInfo(address, HederaToken)`.
* The `updateTokenInfo(address, HederaToken)` call is especially powerful. If a token's admin key signs the transaction calling a contract, that contract can now make itself the token's treasury, assume authority to mint or burn units or NFTs, and so on.
* ⚠️  Contract authors should know this release initiates Hedera's [expiration and rent model for contracts](https://hedera.com/blog/smart-contract-rent-on-hedera-is-coming-what-you-need-to-know). There will be two visible effects immediately after the 0.30 upgrade:
* - All non-deleted contracts will have their expiry extended to at least 90 days after the upgrade date.
* - Deleted contracts will start to be purged from state; so a `getContractInfo` query that previously
* returned `CONTRACT_DELETED` may now report `INVALID_CONTRACT_ID`.
* About 90 days after the 0.30 upgrade, some contracts will begin to expire. The network will try to automatically charge the renewal fee (approximately `$0.026` for 90 days) to the expired contract's auto-renew account. If an auto-renew account has zero balance, the network will then try to charge the contract itself.
* A contract unable to pay renewal fees will enter a week-long "grace period" during which it is unusable, unless its expiry is extended via `ContractUpdate` or it receives hbar. After this grace period, the contract will be purged from state.
* ‼️ We **strongly** encourage all contract authors to set an auto-renew account for their contract. This isolates the contract logic from the existence of rent.
* ---
* This release also brings two peripheral improvements:
* 1. It will become possible to schedule a `CryptoApproveAllowance` transaction.
* 2. Mirror node operators will be able to use the daily `NodeStakeUpdate` export to track the current values of [several key staking properties](https://github.com/hashgraph/hedera-protobufs/blob/main/services/node_stake_update.proto#L45). Please review the linked protobuf comments for more details on these properties.
* ## Contributors
* We'd like to thank all the contributors who worked on this release!
* - @alshapi
* - @bugbytesinc
* - @Daniel-K-Ivanov
* - @dimitar-dinev
* - @ivanparnarev
* - @IvanKavaldzhiev
* - @jasperpotts
* - @JeffreyDallas
* - @joan41868
* - @mhess-swl
* - @MiroslavGatsanoga
* - @Neeharika-Sompalli
* - @OlegMazurov
* - @qnswirlds
* - @rbair23
* - @rjuang
* - @rusiboyadjiev
* - @shemnon
* - @SimiHunjan
* - @statop
* - @stoqnkpL
* - @superboo
* - @tdermendzhievv
* - @tinker-michaelj

**Full Changelog**: [v0.30.0...v0.30.0](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.30.0...v0.30.0)

</details>

## Release v0.29

### [Build v0.29.0](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.29.0)

<details>
<summary><strong>What's Changed</strong></summary>

* ## Contract-managed tokens 🪙
* In Services 0.29 we have followed the [HIP-514 roadmap](https://hips.hedera.com/hip/hip-514) to give contract authors many new ways to inspect and manage HTS tokens.
* The HIP enumerates the ways; examples include a contract that revokes an account's KYC for a token, or deletes a token for which it has admin privileges, or even changes a token's supply key based on the metadata in an NFT!
* Note there are four HIP-514 functions that will be part of release 0.30, as follows: `getTokenExpiryInfo(address)`, `updateTokenExpiryInfo(address, Expiry)`, `updateTokenInfo(address, HederaToken)`, `isToken(address token)` and `getTokenType(address token)`.
* ## Deprecations
* Please note this [important deprecation](https://github.com/hashgraph/hedera-protobufs/blob/main/services/crypto_get_info.proto#L141) that will change how clients fetch token associations and balances after the November release in this year. At that time, mirror nodes will become the exclusive source of token association metadata. This is because [HIP-367](https://hips.hedera.com/hip/hip-367) made token associations unlimited, so in the long run it will not be efficient for consensus nodes to serve this information.
* ## Contributors
* We'd like to thank all the contributors who worked on this release!
* - @alshapi
* - @anighanta
* - @bugbytesinc
* - @CordonaCodeCraft
* - @Daniel-K-Ivanov
* - @dimitar-dinev
* - @georgiyazovaliiski
* - @ivanparnarev
* - @IvanKavaldzhiev
* - @jasperpotts
* - @JeffreyDallas
* - @joan41868
* - @MarcKriguerAtHedera
* - @Neeharika-Sompalli
* - @OlegMazurov
* - @qnswirlds
* - @rbair23
* - @rjuang
* - @rusiboyadjiev
* - @shemnon
* - @SimiHunjan
* - @statop
* - @stoqnkpL
* - @superboo
* - @tdermendzhievv
* - @tinker-michaelj

**Full Changelog**: [v0.29.0...v0.29.0](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.29.0...v0.29.0)

</details>

## Release v0.28

### [Build v0.28.0](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.28.0)

<details>
<summary><strong>What's Changed</strong></summary>

* ## Pseudorandom numbers 🎲
* Services 0.28 gives Hedera devs a new dApp building block in [HIP-351 (Pseudorandom Numbers)](https://hips.hedera.com/hip/hip-351). HAPI has a new [`UtilService`](https://hashgraph.github.io/hedera-protobufs/#proto.UtilService) with a `prng` transaction that generates a record with either a pseudorandom 48-byte seed, or an integer in a requested range.
* Smart contracts can also get pseudorandom values by calling a new system contract at address `0x169`, using the interface [here](https://github.com/hashgraph/hedera-services/blob/master/test-clients/src/main/resource/contract/contracts/PrngSystemContract/IPrngSystemContract.sol#L4) as in [this example](https://github.com/hashgraph/hedera-services/blob/master/test-clients/src/main/resource/contract/contracts/PrngSystemContract/PrngSystemContract.sol). Applications might include NFT mint contracts, lotteries, and so on.
* (Please note the HIP-351 text does not yet reflect the name change from `RandomGenerate` to `prng`, or the system contract specification. It does explain in detail how `prng` derives its entropy from the running hash of transaction records generated by the network.)
* This release also includes some bug fixes and smaller improvements; notably, it:
* 1. Extends [`ContractCallLocal` support](https://github.com/hashgraph/hedera-services/issues/3632) to the ERC-20 and ERC-721 functions `allowance`, `getApproved`, and `isApprovedForAll`.
* 2. Permits staking to contract accounts.
* ## Contributors
* We'd like to thank all the contributors who worked on this release!
* - @alshapi
* - @anighanta
* - @bugbytesinc
* - @CordonaCodeCraft
* - @Daniel-K-Ivanov
* - @dimitar-dinev
* - @georgiyazovaliiski
* - @ivanparnarev
* - @IvanKavaldzhiev
* - @jasperpotts
* - @JeffreyDallas
* - @joan41868
* - @MarcKriguerAtHedera
* - @Neeharika-Sompalli
* - @OlegMazurov
* - @qnswirlds
* - @rbair23
* - @rjuang
* - @rusiboyadjiev
* - @shemnon
* - @SimiHunjan
* - @statop
* - @stoqnkpL
* - @superboo
* - @tdermendzhievv
* - @tinker-michaelj

**Full Changelog**: [v0.28.0...v0.28.0](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.28.0...v0.28.0)

</details>

## Release v0.27

### [Build v0.27.0](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.27.0)

<details>
<summary><strong>What's Changed</strong></summary>

* ## Native staking 🎉
* The 0.27 release of Hedera Services initiates the first phase of [HIP-406 (Staking)](https://hips.hedera.com/hip/hip-406). We deeply appreciate the community's feedback on this key feature!
* As wallets and exchanges roll out client support, users will now have the choice to stake their hbar to a node. As nodes accumulate stake, from both individuals and organizations, they will become eligible to pay rewards to their stakers. At this point, once the `0.0.800` account balance has crossed a threshold to be set by the council coin committee, rewards will be permanently activated.
* This will set the stage for the second phase of staking, in which a node's contribution to consensus becomes a direct function of its stake, and community nodes with sufficient stake can begin to participate in consensus. Please note the decentralized nature of this process makes it hard to predict exactly when each milestone and phase will be achieved.
* The one immediately visible consequences of the 0.27 release will be that the consensus nodes handle `CryptoCreate` and `CryptoUpdate` transactions with staking elections. (So once your preferred wallet or exchange supports these transactions, you can elect to stake to a node.)
* 📝 Observant readers might recall that an earlier [alpha release](https://github.com/hashgraph/hedera-services/releases/tag/v0.27.0-alpha.5) of Services 0.27 _also_ enabled [HIP-423 (Long Term Scheduled Transactions)](https://hips.hedera.com/hip/hip-423). This is a complex feature with some deep implications, and we have decided to defer its production arrival for one or two releases.
* ## Contributors
* We'd like to thank all the contributors who worked on this release!
* - @alshapi
* - @anighanta
* - @bugbytesinc
* - @CordonaCodeCraft
* - @Daniel-K-Ivanov
* - @dimitar-dinev
* - @georgiyazovaliiski
* - @ivanparnarev
* - @IvanKavaldzhiev
* - @jasperpotts
* - @JeffreyDallas
* - @joan41868
* - @MarcKriguerAtHedera
* - @Neeharika-Sompalli
* - @OlegMazurov
* - @qnswirlds
* - @rbair23
* - @rjuang
* - @rusiboyadjiev
* - @shemnon
* - @SimiHunjan
* - @statop
* - @stoqnkpL
* - @superboo
* - @tdermendzhievv
* - @tinker-michaelj

**Full Changelog**: [v0.27.0...v0.27.0](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.27.0...v0.27.0)

</details>

## Release v0.26

### [Build v0.26.0](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.26.0)

<details>
<summary><strong>What's Changed</strong></summary>

* In Hedera Services 0.26 we are excited to deliver [HIP-410 (Wrapping Ethereum Transaction Bytes in a Hedera Transaction)](https://hips.hedera.com/hip/hip-410), [HIP-415 (Introduction Of Blocks)](https://hips.hedera.com/hip/hip-415), and [HIP-376 (Support for ERC-20 and ERC-721 Standards)](https://hips.hedera.com/hip/hip-376); plus the mini-[HIP-475 (Exchange Rate System Contract)](https://hips.hedera.com/hip/hip-475).
* - HIP-410 extends the Hedera API (HAPI) with a new `EthereumTransaction`, so that an account [auto-created](https://hips.hedera.com/hip/hip-32) with an [ECDSA(secp256k1) key](https://hips.hedera.com/hip/hip-222) can submit Ethereum transactions directly to Hedera. Standard Ethereum restrictions on the sender's `nonce` apply; please peruse the HIP for details, including a summary of use cases that the `EthereumTransaction` enables---for example, "I want to use MetaMask to create a transaction to transfer HBAR to another account".
* - HIP-415 works in concert toward the same use cases by standardizing the concept of a Hedera "block"; this is important for a full implementation of the [Ethereum JSON-RPC API](https://eth.wiki/json-rpc/API). The definition is simple: One _block_ is all the transactions in a record stream file. The _block hash_ is the 32-byte prefix of the transaction running hash at the end of the file. And the _block number_ is the index of the record file in the full stream history, where the first file had index `0`.
* - HIP-376 allows smart contract developers to use the familiar [EIP-20](https://eips.ethereum.org/EIPS/eip-20) and [EIP-721](https://eips.ethereum.org/EIPS/eip-721) "operator approval" with both fungible and non-fungible HTS tokens. Approved operators can manage an owner's tokens on their behalf; this is necessary for many consignment use cases with third party brokers/wallets/auctioneers. Any permissions granted in a contract through `approve()` or `setApprovalForAll()` have an equivalent HAPI `cryptoApproveAllowance` or `cryptoDeleteAllowance` expression that is externalized as a HAPI `TransactionBody` in the record stream. (That is, the HIP-376 system contracts expose a subset of the native HAPI operations, only within the EVM.)
* - Finally, HIP-475 adds a new system contract so that a "self-funding" smart contract can require exactly the tinybar value needed to cover its Hedera fees, which have a fixed USD price.
* There are two other changes to the smart contract service.
* 1.  Before release 0.26, contract call and create HAPI operations could request up to 5M gas. We have increased this limit to 8M gas.
* 2. As part of a transition to purely gas-based pricing for contract operations, in 0.26 we are also standardizing the `gas` resource price for `ContractCall`, `ContractCreate`, `EthereumTransaction`, and `ContractCallLocal` operations at `$0.000_000_0852` per `gas`; and are removing all other forms of fees from `ContractCall`.
* ## Contributors
* We'd like to thank all the contributors who worked on this release!
* - @alshapi
* - @anighanta
* - @bugbytesinc
* - @CordonaCodeCraft
* - @Daniel-K-Ivanov
* - @dimitar-dinev
* - @georgiyazovaliiski
* - @ivanparnarev
* - @IvanKavaldzhiev
* - @jasperpotts
* - @JeffreyDallas
* - @joan41868
* - @MarcKriguerAtHedera
* - @Neeharika-Sompalli
* - @OlegMazurov
* - @qnswirlds
* - @rbair23
* - @rjuang
* - @rusiboyadjiev
* - @shemnon
* - @SimiHunjan
* - @statop
* - @stoqnkpL
* - @superboo
* - @tdermendzhievv
* - @tinker-michaelj

**Full Changelog**: [v0.26.0...v0.26.0](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.26.0...v0.26.0)

</details>

## Release v0.25

### [Build v0.25.0](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.25.0)

<details>
<summary><strong>What's Changed</strong></summary>

* The Hedera Services 0.25 release brings good news for HTS users who manage large numbers of token types, as it delivers [HIP-367 (Unlimited Token Associations per Account)](https://hips.hedera.com/hip/hip-367). In particular, a single account can now serve as treasury for any number of token types. (Please do note the `CryptoService` HAPI queries still return information for only an account's 1000 most recently associated tokens; mirror nodes remain the best source for full history.)
* We are also very excited to announce support for [HIP-358 (Allow `TokenCreate` through Hedera Token Service Precompiled Contract)](https://hips.hedera.com/hip/hip-358). This HIP supercharges contract integration, making it possible for a smart contract to create a new HTS token---fungible or non-fungible, with or without custom fees. (An interested Solidity developer might consult the examples in [this contract](https://github.com/hashgraph/hedera-services/blob/master/test-clients/src/main/resource/contract/solidity/FeeHelper.sol).)
* In a harbinger of [more upcoming HTS precompile support](https://hips.hedera.com/hip/hip-376), this release will also enable [HIP-336 (Approval and Allowance API for Tokens)](https://github.com/hashgraph/hedera-improvement-proposal/blob/master/HIP/hip-336.md). Token owners can now approve other accounts to manage their HTS tokens or NFTs, in direct analogy to the `approve()` and `transferFrom()` mechanisms in ERC-20 and ERC-721 style tokens.
* ## Enhancements
* - HIP-336 implementation [#2814](https://github.com/hashgraph/hedera-services/issues/2814)
* - HIP-358 implementation [#3015](https://github.com/hashgraph/hedera-services/issues/3015)
* - HIP-367 implementation [#2917](https://github.com/hashgraph/hedera-services/issues/2917)
* ## Contributors
* We'd like to thank all the contributors who worked on this release!
* - @alshapi
* - @anighanta
* - @bugbytesinc
* - @CordonaCodeCraft
* - @Daniel-K-Ivanov
* - @dimitar-dinev
* - @georgiyazovaliiski
* - @IvanKavaldzhiev
* - @jasperpotts
* - @JeffreyDallas
* - @joan41868
* - @MarcKriguerAtHedera
* - @Neeharika-Sompalli
* - @OlegMazurov
* - @qnswirlds
* - @rbair23
* - @rjuang
* - @rusiboyadjiev
* - @shemnon
* - @SimiHunjan
* - @statop
* - @stoqnkpL
* - @superboo
* - @tdermendzhievv
* - @tinker-michaelj

**Full Changelog**: [v0.25.0...v0.25.0](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.25.0...v0.25.0)

</details>

## Release v0.24

### [Build v0.24.2](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.24.2)

<details>
<summary><strong>What's Changed</strong></summary>

* The v0.24.2 patch release changes `ContractCallLocal` to fail with a better response code when ERC-20 and ERC-721 "proxy contracts" are used. (The proxy contract `view` functions [will be enabled](https://github.com/hashgraph/hedera-services/tree/03061-fix-erc-view-redirects) in release 0.25).
* Please see the v0.24.1 [notes](https://github.com/hashgraph/hedera-services/releases/tag/v0.24.1) for an overview of the principal release 0.24 features.

**Full Changelog**: [v0.24.0...v0.24.2](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.24.0...v0.24.2)

</details>

### [Build v0.24.1](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.24.1)

<details>
<summary><strong>What's Changed</strong></summary>

* In the 0.24 release of Hedera Services, we are excited to give smart contract developers a new level of interoperability with native Hedera Token Service (HTS) tokens via [HIP-218 (Smart Contract interactions with Hedera Token Accounts)](https://hips.hedera.com/hip/hip-218). The Hedera EVM now exposes every HTS fungible token as an ERC-20 token at the address of the token's `0.0.X` entity id; and analogously, every HTS non-fungible token appears as an ERC-721 token. This means a smart contract can look up its balance of a fungible HTS token; or change its behavior based on the owner of a particular HTS NFT. Please see the linked HIP for full details.
* This upgrade also creates two new system accounts `0.0.800` and `0.0.801` that will hold reward funds.
* One change to the Hedera API (HAPI) is that we now have enough evidence to conclude the experimental `getAccountNftInfos` and `getTokenNftInfos` queries do not have a favorable cost/benefit ratio, and these queries are now [permanently disabled](https://hashgraph.github.io/hedera-protobufs/#proto.TokenService).
* ## Enhancements
* - HIP-218 implementation [#2793](https://github.com/hashgraph/hedera-services/pull/2793)
* - Enable immutable system accounts [#3015](https://github.com/hashgraph/hedera-services/issues/3015)
* - Docker Compose tooling for local dev node [#2893](https://github.com/hashgraph/hedera-services/issues/2893)
* ## Fixes
* - Storage cost for internal `CONTRACT_CREATION` no longer affected by payer expiry [#2961](https://github.com/hashgraph/hedera-services/issues/2961)
* - Child record of an auto-created account now includes the `CryptoCreate` transaction fee [#2963](https://github.com/hashgraph/hedera-services/issues/2963)
* - Congestion pricing multipliers now stable across reconnect [#2936](https://github.com/hashgraph/hedera-services/issues/2936)
* ## Contributors
* We'd like to thank all the contributors who worked on this release!
* - @alshapi
* - @anighanta
* - @bugbytesinc
* - @CordonaCodeCraft
* - @Daniel-K-Ivanov
* - @georgiyazovaliiski
* - @IvanKavaldzhiev
* - @jasperpotts
* - @joan41868
* - @MarcKriguerAtHedera
* - @Neeharika-Sompalli
* - @OlegMazurov
* - @qnswirlds
* - @rbair23
* - @rjuang
* - @rusiboyadjiev
* - @shemnon
* - @SimiHunjan
* - @statop
* - @stoqnkpL
* - @superboo
* - @tdermendzhievv
* - @tinker-michaelj

**Full Changelog**: [v0.24.0...v0.24.1](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.24.0...v0.24.1)

</details>

## Release v0.23

### [Build v0.23.2](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.23.2)

<details>
<summary><strong>What's Changed</strong></summary>

* The v0.23.2 patch release fixes https://github.com/hashgraph/hedera-services/issues/2925.
* Please see the v0.23.1 [notes](https://github.com/hashgraph/hedera-services/releases/tag/v0.23.1) for preceding patches; and for an overview of the principal features in release 0.23, please review the [headline release notes](https://github.com/hashgraph/hedera-services/releases/tag/v0.23.0).

**Full Changelog**: [v0.23.0...v0.23.2](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.23.0...v0.23.2)

</details>

### [Build v0.23.1](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.23.1)

<details>
<summary><strong>What's Changed</strong></summary>

* The v0.23.1 release fixes two issues with EIP-1014 addresses generated by use of `CREATE2`; please see [here](https://github.com/hashgraph/hedera-services/issues/2922) and [here](https://github.com/hashgraph/hedera-services/issues/2920) for details.
* For an overview of the principal features in release 0.23, please review the notes [here](https://github.com/hashgraph/hedera-services/releases/tag/v0.23.0).

**Full Changelog**: [v0.23.0...v0.23.1](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.23.0...v0.23.1)

</details>

### [Build v0.23.0](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.23.0)

<details>
<summary><strong>What's Changed</strong></summary>

* Hedera Services 0.23 fleshes out our smart contract service via implementation of [HIP-329 (Support `CREATE2` opcode)](https://hips.hedera.com/hip/hip-329). Smart contract developers are now free to use the `CREATE2` EVM opcode. A typical use case is a distributed exchange that wants its pair contracts to have deterministic addresses based on the tokens in the pair.
* Please note two issues fixed in this release. [First](https://github.com/hashgraph/hedera-services/issues/2841), in release 0.22, the nodes returned the `bytes ledger_id` stipulated by [HIP-33](https://hips.hedera.com/hip/hip-33) as a UTF-8 encoding of a hex string. The returned bytes are now the big-endian representation of the ledger's numeric id. [Second](https://github.com/hashgraph/hedera-services/issues/2857), prior to this release, the record of a `dissociateToken` from a deleted token did not list the discarded balance of the dissociated account if the token's treasury was missing. This is now fixed.
* ## Contributors
* We'd like to thank all the contributors who worked on this release!
* - @alshapi
* - @anighanta
* - @bugbytesinc
* - @Daniel-K-Ivanov
* - @georgiyazovaliiski
* - @jasperpotts
* - @joan41868
* - @MarcKriguerAtHedera
* - @Neeharika-Sompalli
* - @OlegMazurov
* - @qnswirlds
* - @rbair23
* - @rusiboyadjiev
* - @shemnon
* - @SimiHunjan
* - @stoqnkpL
* - @superboo
* - @tdermendzhievv
* - @tinker-michaelj

**Full Changelog**: [v0.23.0...v0.23.0](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.23.0...v0.23.0)

</details>

## Release v0.22

### [Build v0.22.5](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.22.5)

<details>
<summary><strong>What's Changed</strong></summary>

* This tag fixes an issue when executing a Solidity contract with inline `create` or `create2`, where the creation reverts and the contract does not revert the parent frame (as in code generated for a Solidity `new` or `new{salt}` operation).
* Please see the [`v0.22.1` release notes](https://github.com/hashgraph/hedera-services/releases/tag/v0.22.1) for full details on the Services 0.22.x release.

**Full Changelog**: [v0.22.0...v0.22.5](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.22.0...v0.22.5)

</details>

### [Build v0.22.1](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.22.1)

<details>
<summary><strong>What's Changed</strong></summary>

* The 0.22 release is a paradigm shift for Hedera Services, as we deliver the next major step in our Smart Contracts 2.0 roadmap on the strength of the protean [HIP-25](https://hips.hedera.com/hip/hip-25), a technical foundation for scaling the world state of our ledger to billions of entities _without_ sacrificing the high TPS enabled by the hashgraph consensus algorithm.
* Highlights of this release include:
* - Network EVM capacity increased to 15M `gas`-per-second. (Please see [HIP-185](https://hips.hedera.com/hip/hip-185) for details.)
* - Gas limit per `ContractCreate` or `ContractCall` raised to 4M.
* - Per-contract storage capacity increased to 10MB.
* - Solidity integration with native HTS tokens. (Please see [HIP-206](https://hips.hedera.com/hip/hip-206) for details.)
* We expect more progress in these directions over the coming releases. Do note that the gas usage of the HTS integrations is still evolving; follow [this issue](https://github.com/hashgraph/hedera-services/issues/2786) to track the finalized gas charges leading up to mainnet release.
* There are two other HIP's included in this release not related to the smart contract service. First, [HIP-33](https://hips.hedera.com/hip/hip-33) enhances queries like `CryptoGetInfo` with a _ledger id_ that marks which Hedera network answered the query. Second, [HIP-31](https://hips.hedera.com/hip/hip-31) allows a client to include the expected decimals for a token in a `CryptoTransfer`. This means a hardware wallet can guarantee its token transactions will have the precision seen by the the user in the device display.
* While we are gaining momentum in our smart contracts roadmap, we are also deeply committed to improving the developer experience, and welcome issues and ideas in our [GitHub repository](https://github.com/hashgraph/hedera-services) and [Discord](https://hedera.com/discord)!
* ## Contributors
* We'd like to thank all the contributors who worked on this release!
* - @alshapi
* - @anighanta
* - @bugbytesinc
* - @Daniel-K-Ivanov
* - @georgiyazovaliiski
* - @jasperpotts
* - @joan41868
* - @MarcKriguerAtHedera
* - @Neeharika-Sompalli
* - @OlegMazurov
* - @qnswirlds
* - @rbair23
* - @rusiboyadjiev
* - @shemnon
* - @SimiHunjan
* - @stoqnkpL
* - @superboo
* - @tdermendzhievv
* - @tinker-michaelj
* - @3Nigma

**Full Changelog**: [v0.22.0...v0.22.1](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.22.0...v0.22.1)

</details>

## Release v0.21

### [Build v0.21.2](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.21.2)

<details>
<summary><strong>What's Changed</strong></summary>

* In Hedera Services 0.21.2 we are pleased to announce support for [ECDSA(secp256k1) keys](https://hips.hedera.com/hip/hip-222) and [auto-account creation](https://hips.hedera.com/hip/hip-32).
* The Ethereum network makes heavy use of ECDSA cryptography with the secp256k1 curve, and by supporting these keys we ease the developer experience of migrating a dApp to Hedera. Anywhere a Ed25519 key can be used in the Hedera API, it is now possible to substitute a ECDSA(secp256k1) key.
* Auto-account creation lets a new user receive ℏ via a `CryptoTransfer` _without_ having already created an `0.0.X` id on the network. The new user only needs to provide their public key, and when a sponsor account sends ℏ "to" their key via a new [`AccountID.alias` field](https://hashgraph.github.io/hedera-protobufs/#proto.AccountID), the network automatically creates an account with their key. Additional transfers to and from an auto-created account may also use its alias instead of the account id.
* An alias may also be used to get the account balance and account info for the account. You will be able to use the alias in all other transactions and queries in a future release.
* 📝  &nbsp; This tag includes fixes for the following issues:
* - #2653 - A `getAccountInfo` response to a query made with an alias now returns the `AccountID` instead of echoing the alias.
* - #2674 - A `getScheduleInfo` query now returns the correct `Key` type for a schedule signed with ECDSA(secp256k1) keys.
* - #2688 - An `updateTopic` transaction that uses an `0.0.<alias>` id for a new auto-renew account is now rejected with `INVALID_ACCOUNT_ID`, instead of this id being interpreted as the `0.0.0` sentinel used to remove a topic's auto-renew account. (Note that in release 0.22, it will be valid to use an `0.0.<alias>` id here.)
* ## Contributors
* We'd like to thank all the contributors who worked on this release!
* - @alshapi
* - @anighanta
* - @bugbytesinc
* - @Daniel-K-Ivanov
* - @georgiyazovaliiski
* - @jasperpotts
* - @joan41868
* - @MarcKriguerAtHedera
* - @Neeharika-Sompalli
* - @OlegMazurov
* - @qnswirlds
* - @rbair23
* - @rusiboyadjiev
* - @shemnon
* - @SimiHunjan
* - @stoqnkpL
* - @superboo
* - @tdermendzhievv
* - @tinker-michaelj

**Full Changelog**: [v0.21.0...v0.21.2](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.21.0...v0.21.2)

</details>

### [Build v0.21.0](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.21.0)

<details>
<summary><strong>What's Changed</strong></summary>

* In Hedera Services 0.21 we are pleased to announce support for [ECDSA(secp256k1) keys](https://hips.hedera.com/hip/hip-222) and [auto-account creation](https://hips.hedera.com/hip/hip-32).
* The Ethereum network makes heavy use of ECDSA cryptography with the secp256k1 curve, and by supporting these keys we ease the developer experience of migrating a dApp to Hedera. Anywhere a Ed25519 key can be used in the Hedera API, it is now possible to substitute a ECDSA(secp256k1) key.
* Auto-account creation lets a new user receive ℏ via a `CryptoTransfer` _without_ having already created an `0.0.X` id on the network. The new user only needs to provide their public key, and when a sponsor account sends ℏ "to" their key via a new [`AccountID.alias` field](https://hashgraph.github.io/hedera-protobufs/#proto.AccountID), the network automatically creates an account with their key. Additional transfers to and from an auto-created account may also use its alias instead of the account id.
* An alias may also be used to get the account balance and account info for the account. (Do note there is a [known issue](https://github.com/hashgraph/hedera-services/issues/2653) that causes the `getAccountInfo` query response to echo back the account alias instead of its `0.0.<num>` id; this will be fixed in the next release. Please use the free `getAccountBalance` query to check the `0.0.<num>` id that corresponds to an alias.) You will be able to use the alias in all other transactions and queries in a future release.
* Meanwhile our team continues exhaustive due diligence for Smart Contracts 2.0... 🚀
* ## Contributors
* We'd like to thank all the contributors who worked on this release!
* - @alshapi
* - @anighanta
* - @bugbytesinc
* - @Daniel-K-Ivanov
* - @georgiyazovaliiski
* - @jasperpotts
* - @joan41868
* - @MarcKriguerAtHedera
* - @Neeharika-Sompalli
* - @OlegMazurov
* - @qnswirlds
* - @rbair23
* - @rusiboyadjiev
* - @shemnon
* - @SimiHunjan
* - @stoqnkpL
* - @superboo
* - @tdermendzhievv
* - @tinker-michaelj

**Full Changelog**: [v0.21.0...v0.21.0](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.21.0...v0.21.0)

</details>

## Release v0.20

### [Build v0.20.0](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.20.0)

<details>
<summary><strong>What's Changed</strong></summary>

* Hedera Services 0.20 is in main a scaffolding release, as our team is working heads-down to deliver the Smart Contract Service refresh with massive new scale and performance; as well as smart contract integration with native tokens created using the Hedera Token Service. The scope of this refresh is significant, and we believe it will be well worth the wait.
* The main deliverables in this release are improved automation for node operators to use in software upgrades; and a handful of bug fixes, including for [#2432](https://github.com/hashgraph/hedera-services/issues/2432) and [#2490](https://github.com/hashgraph/hedera-services/issues/2490).
* Please also note the following deprecations in the Hedera API protobufs:
* - The [`ContractUpdateTransactionBody.fileID` field](https://github.com/hashgraph/hedera-protobufs/blob/main/services/contract_update.proto#L82), which is redundant given existence of the [`ContractGetBytecode` query](https://github.com/hashgraph/hedera-protobufs/blob/main/services/smart_contract_service.proto#L63).
* - The [`ContractCallLocalQuery.maxResultSize` field](https://github.com/hashgraph/hedera-protobufs/blob/main/services/contract_call_local.proto#L136), as this limit is now simply a side-effect of the given gas limit.
* ## Contributors
* We'd like to thank all the contributors who worked on this release!
* - @alshapi
* - @anighanta
* - @bugbytesinc
* - @Daniel-K-Ivanov
* - @georgiyazovaliiski
* - @jasperpotts
* - @joan41868
* - @MarcKriguerAtHedera
* - @Neeharika-Sompalli
* - @OlegMazurov
* - @qnswirlds
* - @rbair23
* - @rusiboyadjiev
* - @shemnon
* - @SimiHunjan
* - @stoqnkpL
* - @superboo
* - @tdermendzhievv
* - @tinker-michaelj

**Full Changelog**: [v0.20.0...v0.20.0](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.20.0...v0.20.0)

</details>

## Release v0.19

### [Build v0.19.4](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.19.4)

<details>
<summary><strong>What's Changed</strong></summary>

* In Hedera Services 0.19, we are thrilled to announce migration of the Hedera smart contract service to the Hyperledger Besu EVM, as laid out in [HIP-26](https://github.com/hashgraph/hedera-improvement-proposal/blob/master/HIP/hip-26.md). This enables support for the latest v0.8.9 Solidity contracts, and harmonizes our gas schedule with that of the "London" hard fork. The Besu migration also sets the stage for a step change in smart contract performance on Hedera.
* Two other HIPs targeting the Hedera Token Service go live in this release. First, the [HIP-23](https://github.com/hashgraph/hedera-improvement-proposal/blob/master/HIP/hip-23.md) feature set is now enabled, so that any account that has been configured with a non-zero `maxAutoAssociations` can receive air-drops (i.e., units or NFTs of a token type without explicit association). Second, we have also implemented [HIP-24](https://github.com/hashgraph/hedera-improvement-proposal/blob/master/HIP/hip-24.md), which provides a safety measure for token types created with a `pauseKey`. If a `TokenPause` is submitted with this key's signature, then all operations on the token will be suspended until a subsequent `TokenUnpause`.
* ## Contributors
* We'd like to thank all the contributors who worked on this release!
* - @anighanta
* - @bugbytesinc
* - @CordonaCodeCraft
* - @Daniel-K-Ivanov
* - @georgiyazovaliiski
* - @jasperpotts
* - @joan41868
* - @MarcKriguerAtHedera
* - @Neeharika-Sompalli
* - @qnswirlds
* - @rbair23
* - @shemnon
* - @SimiHunjan
* - @stoqnkpL
* - @superboo
* - @tinker-michaelj

**Full Changelog**: [v0.19.0...v0.19.4](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.19.0...v0.19.4)

</details>

### [Build v0.19.1](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.19.1)

<details>
<summary><strong>What's Changed</strong></summary>

* In Hedera Services 0.19, we are thrilled to announce migration of the Hedera smart contract service to the Hyperledger Besu EVM, as laid out in [HIP-26](https://github.com/hashgraph/hedera-improvement-proposal/blob/master/HIP/hip-26.md). This enables support for the latest v0.8.9 Solidity contracts, and harmonizes our gas schedule with that of the "London" hard fork. The Besu migration also sets the stage for a step change in smart contract performance on Hedera.
* Two other HIPs targeting the Hedera Token Service go live in this release. First, the [HIP-23](https://github.com/hashgraph/hedera-improvement-proposal/blob/master/HIP/hip-23.md) feature set is now enabled, so that any account that has been configured with a non-zero `maxAutoAssociations` can receive air-drops (i.e., units or NFTs of a token type without explicit association). Second, we have also implemented [HIP-24](https://github.com/hashgraph/hedera-improvement-proposal/blob/master/HIP/hip-24.md), which provides a safety measure for token types created with a `pauseKey`. If a `TokenPause` is submitted with this key's signature, then all operations on the token will be suspended until a subsequent `TokenUnpause`.
* ## Contributors
* We'd like to thank all the contributors who worked on this release!
* - @anighanta
* - @bugbytesinc
* - @CordonaCodeCraft
* - @Daniel-K-Ivanov
* - @georgiyazovaliiski
* - @jasperpotts
* - @joan41868
* - @MarcKriguerAtHedera
* - @Neeharika-Sompalli
* - @qnswirlds
* - @rbair23
* - @shemnon
* - @SimiHunjan
* - @stoqnkpL
* - @superboo
* - @tinker-michaelj

**Full Changelog**: [v0.19.0...v0.19.1](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.19.0...v0.19.1)

</details>

## Release v0.18

### [Build v0.18.1](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.18.1)

<details>
<summary><strong>What's Changed</strong></summary>

* In Hedera Services 0.18.1, we have a new scalability profile for NFTs in the Hedera Token Service (HTS). Up to fifty million (50M) NFTs, each with 100 bytes of metadata, may now be minted. Of course our `CryptoTransfer` and `ConsensusSubmitMessage` operations are still supported at 10k TPS even with this scale.
* In this release we have also enabled automatic reconnect. This feature comes into play when a network partition causes a node to "fall behind" in the consensus protocol. With reconnect enabled, the node can use a special form of gossip to "catch up" and resume participation in the network with no human intervention. This works even when the node has missed many millions of transactions, and the world state is very different from when it was last active.
* We are happy to also announce that accounts can be customized to take advantage of the upcoming [HIP-23 (Opt-in Token Associations)](https://github.com/hashgraph/hedera-improvement-proposal/blob/master/HIP/hip-23.md) feature set. That is, an account owner can now "pre-pay" for token associations via a [`CryptoCreate`](https://hashgraph.github.io/hedera-protobufs/#proto.CryptoCreateTransactionBody) or [`CryptoUpdate`](https://hashgraph.github.io/hedera-protobufs/#proto.CryptoUpdateTransactionBody) transaction, _without_ knowing in advance which specific token types they will use.
* Once HIP-23 is fully enabled in release 0.19, when their account receives units or NFT's of a new token type via a `CryptoTransfer`, the network will automatically create the needed association---no explicit `TokenAssociate` transaction needed. This supports several interesting use cases; please see the linked HIP-23 for more details.
* ---
* There are three other points of interest in this release.
* First, we have removed the HIP-18 limitations noted in the previous release. The `tokenFeeScheduleUpdate` transaction has been re-enabled, and multiple royalty fees can now be charged for a non-fungible token type.
* Second, the address books in system files `0.0.101` and `0.0.102` will now populate their `ServiceEndpoint` fields. (However, the deprecated `ipAddress`, `portno`, and `memo` fields will no longer be populated after the next release.)
* Third, please note that the `TokenService` `getTokenNftInfos` and `getAccountNftInfos` queries are now **deprecated** and will be removed in a future release. The best answers to such queries demand historical context that only Mirror Nodes have; so these and related queries will move to mirror REST APIs.
* ---
* Developers will likely appreciate two other release 0.18.1 items. First, we have migrated to [Dagger2](https://dagger.dev/) for dependency injection. Second, there is a new `getExecutionTime` query in the [`NetworkService`](https://hashgraph.github.io/hedera-protobufs/#proto.NetworkService) that supports granular performance testing in development environments.
* ## Contributors
* We'd like to thank all the contributors who worked on this release!
* - @abhishek-hedera
* - @anighanta
* - @bugbytesinc
* - @CordonaCodeCraft
* - @daniel-danev-limechain
* - @Daniel-K-Ivanov
* - @georgiyazovaliiski
* - @jasperpotts
* - @joan41868
* - @ljianghedera
* - @MarcKriguerAtHedera
* - @Neeharika-Sompalli
* - @qnswirlds
* - @rbair23
* - @shemnon
* - @SimiHunjan
* - @superboo
* - @tinker-michaelj

**Full Changelog**: [v0.18.0...v0.18.1](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.18.0...v0.18.1)

</details>

### [Build v0.18.0](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.18.0)

<details>
<summary><strong>What's Changed</strong></summary>

* In Hedera Services 0.18.0, we are happy to announce support for [HIP-23 (Opt-in Token Associations)](https://github.com/hashgraph/hedera-improvement-proposal/blob/master/HIP/hip-23.md). This feature lets an Hedera account owner "pre-pay" for token associations via a [`CryptoCreate`](https://hashgraph.github.io/hedera-protobufs/#proto.CryptoCreateTransactionBody) or [`CryptoUpdate`](https://hashgraph.github.io/hedera-protobufs/#proto.CryptoUpdateTransactionBody) transaction, _without_ knowing in advance which specific token types they will use.
* When their account receives units or NFT's of a new token type via a `CryptoTransfer`, the network will automatically create the needed association---no explicit `TokenAssociate` transaction needed. This supports several interesting use cases; please see the linked HIP-23 for more details.
* ---
* There are three other points of interest in this release.
* First, we have removed the HIP-18 limitations noted in the previous release. The `tokenFeeScheduleUpdate` transaction has been re-enabled, and multiple royalty fees can now be charged for a non-fungible token type.
* Second, the address books in system files `0.0.101` and `0.0.102` will now populate their `ServiceEndpoint` fields. (However, the deprecated `ipAddress`, `portno`, and `memo` fields will no longer be populated after the next release.)
* Third, please note that the `TokenService` `getTokenNftInfos` and `getAccountNftInfos` queries are now **deprecated** and will be removed in a future release. The best answers to such queries demand historical context that only Mirror Nodes have; so these and related queries will move to mirror REST APIs.
* ---
* Developers will likely appreciate two other release 0.18.0 items. First, we have migrated to [Dagger2](https://dagger.dev/) for dependency injection. Second, there is a new `getExecutionTime` query in the [`NetworkService`](https://hashgraph.github.io/hedera-protobufs/#proto.NetworkService) that supports granular performance testing in development environments.
* ## Contributors
* We'd like to thank all the contributors who worked on this release!
* - @abhishek-hedera
* - @anighanta
* - @bugbytesinc
* - @CordonaCodeCraft
* - @daniel-danev-limechain
* - @Daniel-K-Ivanov
* - @georgiyazovaliiski
* - @jasperpotts
* - @joan41868
* - @ljianghedera
* - @MarcKriguerAtHedera
* - @Neeharika-Sompalli
* - @qnswirlds
* - @rbair23
* - @shemnon
* - @SimiHunjan
* - @superboo
* - @tinker-michaelj

**Full Changelog**: [v0.18.0...v0.18.0](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.18.0...v0.18.0)

</details>

## Release v0.17

### [Build v0.17.4](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.17.4)

<details>
<summary><strong>What's Changed</strong></summary>

* In Hedera Services 0.17.4, we are excited to announce support for  [HIP-17 (Non-fungible Tokens)](https://github.com/hashgraph/hedera-improvement-proposal/blob/master/HIP/hip-17.md), with a complementary extension to [HIP-18 (Custom Hedera Token Service Fees)](https://github.com/hashgraph/hedera-improvement-proposal/blob/master/HIP/hip-18.md) that lets an NFT creator set a royalty fee to be charged when fungible value is exchanged for one of their creations.
* Unique token types and minted NFTs are more natural for many use cases than fungible token types. The Hedera Token Service now supports both natively, so that a single `CryptoTransfer` can perform atomic swaps with any arbitrary combination of fungible, non-fungible, and ℏ transfers. (Please do note that the "paged" `getAccountNftInfos` and `getTokenNftInfos` queries will remain disabled until release 0.18.0, as several large performance improvements are pending.)
* In this release we have made it possible to denominate a fixed fee in the units of the token to which it is attached (assuming the type of this token is `FUNGIBLE_COMMON`). Custom fractional fees may now also be set as "net-of-transfer". In this case the recipient(s) in the transfer list receive the stated amounts, and the assessed fee is charged to the sender.
* There are a few final points of more specialized interest. First, users of the scheduled transaction facility may now also schedule `TokenBurn` and `TokenMint` transactions. Second, network administrators issuing a `CryptoUpdate` to change the treasury account's key must now sign with the new treasury key. Third, the supported TLS cipher suites have been updated to the following list:
* 1. `TLS_DHE_RSA_WITH_AES_256_GCM_SHA384` (TLS v1.2)
* 2. `TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384` (TLS v1.2)
* 3. `TLS_AES_256_GCM_SHA384` (TLS v1.3)
* :warning:&nbsp;There are two temporary limitations to HIP-18 in this release. First, the `tokenFeeScheduleUpdate` transaction is not currently available. Second, only one royalty fee will be charged for a non-fungible token type. Both limitations will be removed in release 0.18.0.
* ## Contributors
* We'd like to thank all the contributors who worked on this release!
* - @abhishek-hedera
* - @amckay7777
* - @anighanta
* - @bugbytesinc
* - @CordonaCodeCraft
* - @daniel-danev-limechain
* - @Daniel-K-Ivanov
* - @georgiyazovaliiski
* - @joan41868
* - @ljianghedera
* - @Neeharika-Sompalli
* - @qnswirlds
* - @SimiHunjan
* - @tinker-michaelj

**Full Changelog**: [v0.17.0...v0.17.4](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.17.0...v0.17.4)

</details>

### [Build v0.17.3](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.17.3)

<details>
<summary><strong>What's Changed</strong></summary>

* In Hedera Services 0.17.3, we are excited to announce support for  [HIP-17 (Non-fungible Tokens)](https://github.com/hashgraph/hedera-improvement-proposal/blob/master/HIP/hip-17.md), with a complementary extension to [HIP-18 (Custom Hedera Token Service Fees)](https://github.com/hashgraph/hedera-improvement-proposal/blob/master/HIP/hip-18.md) that lets an NFT creator set a royalty fee to be charged when fungible value is exchanged for one of their creations.
* Unique token types and minted NFTs are more natural for many use cases than fungible token types. The Hedera Token Service now supports both natively, so that a single `CryptoTransfer` can perform atomic swaps with any arbitrary combination of fungible, non-fungible, and ℏ transfers. (Please do note that the "paged" `getAccountNftInfos` and `getTokenNftInfos` queries will remain disabled until release 0.18.0, as several large performance improvements are pending.)
* In this release we have made it possible to denominate a fixed fee in the units of the token to which it is attached (assuming the type of this token is `FUNGIBLE_COMMON`). Custom fractional fees may now also be set as "net-of-transfer". In this case the recipient(s) in the transfer list receive the stated amounts, and the assessed fee is charged to the sender.
* There are a few final points of more specialized interest. First, users of the scheduled transaction facility may now also schedule `TokenBurn` and `TokenMint` transactions. Second, network administrators issuing a `CryptoUpdate` to change the treasury account's key must now sign with the new treasury key. Third, the supported TLS cipher suites have been updated to the following list:
* 1. `TLS_DHE_RSA_WITH_AES_256_GCM_SHA384` (TLS v1.2)
* 2. `TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384` (TLS v1.2)
* 3. `TLS_AES_256_GCM_SHA384` (TLS v1.3)
* ## Contributors
* We'd like to thank all the contributors who worked on this release!
* - @abhishek-hedera
* - @amckay7777
* - @anighanta
* - @bugbytesinc
* - @CordonaCodeCraft
* - @daniel-danev-limechain
* - @Daniel-K-Ivanov
* - @georgiyazovaliiski
* - @joan41868
* - @ljianghedera
* - @Neeharika-Sompalli
* - @qnswirlds
* - @SimiHunjan
* - @tinker-michaelj

**Full Changelog**: [v0.17.0...v0.17.3](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.17.0...v0.17.3)

</details>

### [Build v0.17.2](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.17.2)

<details>
<summary><strong>What's Changed</strong></summary>

* In Hedera Services 0.17.2, we are excited to announce support for  [HIP-17 (Non-fungible Tokens)](https://github.com/hashgraph/hedera-improvement-proposal/blob/master/HIP/hip-17.md), with a complementary extension to [HIP-18 (Custom Hedera Token Service Fees)](https://github.com/hashgraph/hedera-improvement-proposal/blob/master/HIP/hip-18.md) that lets an NFT creator set a royalty fee to be charged when fungible value is exchanged for one of their creations.
* Unique token types and minted NFTs are more natural for many use cases than fungible token types. The Hedera Token Service now supports both natively, so that a single `CryptoTransfer` can perform atomic swaps with any arbitrary combination of fungible, non-fungible, and ℏ transfers. (Please do note that the "paged" `getAccountNftInfos` and `getTokenNftInfos` queries will remain disabled until release 0.18.0, as several large performance improvements are pending.)
* In this release we have made it possible to denominate a fixed fee in the units of the token to which it is attached (assuming the type of this token is `FUNGIBLE_COMMON`). Custom fractional fees may now also be set as "net-of-transfer". In this case the recipient(s) in the transfer list receive the stated amounts, and the assessed fee is charged to the sender.
* There are a few final points of more specialized interest. First, users of the scheduled transaction facility may now also schedule `TokenBurn` and `TokenMint` transactions. Second, network administrators issuing a `CryptoUpdate` to change the treasury account's key must now sign with the new treasury key. Third, the supported TLS cipher suites have been updated to `TLS_DHE_RSA_WITH_AES_256_GCM_SHA384` and `TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384`.
* ## Contributors
* We'd like to thank all the contributors who worked on this release!
* - @abhishek-hedera
* - @amckay7777
* - @anighanta
* - @bugbytesinc
* - @CordonaCodeCraft
* - @daniel-danev-limechain
* - @Daniel-K-Ivanov
* - @georgiyazovaliiski
* - @joan41868
* - @ljianghedera
* - @Neeharika-Sompalli
* - @qnswirlds
* - @SimiHunjan
* - @tinker-michaelj

**Full Changelog**: [v0.17.0...v0.17.2](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.17.0...v0.17.2)

</details>

### [Build v0.17.1](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.17.1)

<details>
<summary><strong>What's Changed</strong></summary>

* In Hedera Services 0.17.1, we are excited to announce support for  [HIP-17 (Non-fungible Tokens)](https://github.com/hashgraph/hedera-improvement-proposal/blob/master/HIP/hip-17.md), with a complementary extension to [HIP-18 (Custom Hedera Token Service Fees)](https://github.com/hashgraph/hedera-improvement-proposal/blob/master/HIP/hip-18.md) that lets an NFT creator set a royalty fee to be charged when fungible value is exchanged for one of their creations.
* Unique token types and minted NFTs are more natural for many use cases than fungible token types. The Hedera Token Service now supports both natively, so that a single `CryptoTransfer` can perform atomic swaps with any arbitrary combination of fungible, non-fungible, and ℏ transfers. (Please do note that the "paged" `getAccountNftInfos` and `getTokenNftInfos` queries will remain disabled until release 0.18.0, as several large performance improvements are pending.)
* In this release we have made it possible to denominate a fixed fee in the units of the token to which it is attached (assuming the type of this token is `FUNGIBLE_COMMON`). Custom fractional fees may now also be set as "net-of-transfer". In this case the recipient(s) in the transfer list receive the stated amounts, and the assessed fee is charged to the sender.
* There are two final points of more specialized interest. First, users of the scheduled transaction facility may now also schedule `TokenBurn` and `TokenMint` transaction. Second, network administrators issuing a `CryptoUpdate` to change the treasury account's key must now sign with the new treasury key.
* ## Contributors
* We'd like to thank all the contributors who worked on this release!
* - @abhishek-hedera
* - @amckay7777
* - @anighanta
* - @bugbytesinc
* - @CordonaCodeCraft
* - @daniel-danev-limechain
* - @Daniel-K-Ivanov
* - @georgiyazovaliiski
* - @joan41868
* - @ljianghedera
* - @Neeharika-Sompalli
* - @qnswirlds
* - @SimiHunjan
* - @tinker-michaelj

**Full Changelog**: [v0.17.0...v0.17.1](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.17.0...v0.17.1)

</details>

## Release v0.16

### [Build v0.16.1](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.16.1)

<details>
<summary><strong>What's Changed</strong></summary>

* In Hedera Services 0.16.1, we are excited to announce support for  [HIP-18 (Custom Hedera Token Service Fees)](https://github.com/hashgraph/hedera-improvement-proposal/blob/master/HIP/hip-18.md).
* Hedera tokens can now be created with a schedule of up to 10 custom fees, which are either _fixed_ in units of ℏ or another token; or _fractional_ and computed in the units of the owning token.  The ledger automatically charges custom fees to accounts as they send units of a fungible token (or ownership of a NFT, see below) via a `CryptoTransfer`.
* When a custom fee cannot be charged, the `CryptoTransfer` fails atomically, changing no balances other than for the Hedera network fees.
* The five case studies in [this document](https://github.com/hashgraph/hedera-services/blob/master/docs/fees/custom-fees-characterization.md) show the basics of how custom fees are charged, and how they appear in records. Note that at most two "levels" of custom HTS fees are allowed, and custom fee charging cannot require changing more than 20 account balances.
* ⚠️&nbsp; There is one variation on custom fees that requires a work-around in this release. Specifically, if a fixed fee should be collected _in the units of the "parent" token to whose schedule it belongs_, then in Release 0.16.0 this must be accomplished using a `FractionalFee` as described in [this issue](https://github.com/hashgraph/hedera-services/issues/1925). In Release 0.17.0 the more natural `FixedFee` configuration will be available.
* ---
* In this release we have also enabled previewnet support for [HIP-17 (Non-fungible Tokens)](https://github.com/hashgraph/hedera-improvement-proposal/blob/master/HIP/hip-17.md). Unique token types and minted NFTs are more natural for many use cases than fungible token types. The Hedera Token Service will soon support both natively, so that a single `CryptoTransfer` can perform atomic swaps with any arbitrary combination of fungible, non-fungible, and ℏ transfers.
* We are very grateful to the Hedera user community for these interesting and powerful new feature sets.
* ## Contributors
* We'd like to thank all the contributors who worked on this release!
* - @abhishek-hedera
* - @amckay7777
* - @anighanta
* - @bugbytesinc
* - @daniel-danev-limechain
* - @Daniel-K-Ivanov
* - @georgiyazovaliiski
* - @joan41868
* - @ljianghedera
* - @Neeharika-Sompalli
* - @qnswirlds
* - @SimiHunjan
* - @tinker-michaelj

**Full Changelog**: [v0.16.0...v0.16.1](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.16.0...v0.16.1)

</details>

### [Build v0.16.0-rc.1](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.16.0-rc.1)

<details>
<summary><strong>What's Changed</strong></summary>

* In Hedera Services 0.16.0, we are excited to announce support for  [HIP-18 (Custom Hedera Token Service Fees)](https://github.com/hashgraph/hedera-improvement-proposal/blob/master/HIP/hip-18.md).
* Hedera tokens can now be created with a schedule of up to 10 custom fees, which are either _fixed_ in units of ℏ or another token; or _fractional_ and computed in the units of the owning token.  The ledger automatically charges custom fees to accounts as they send units of a fungible token (or ownership of a NFT, see below) via a `CryptoTransfer`.
* When a custom fee cannot be charged, the `CryptoTransfer` fails atomically, changing no balances other than for the Hedera network fees.
* The five case studies in [this document](https://github.com/hashgraph/hedera-services/blob/master/docs/fees/custom-fees-characterization.md) show the basics of how custom fees are charged, and how they appear in records. Note that at most two "levels" of custom HTS fees are allowed, and custom fee charging cannot require changing more than 20 account balances.
* ---
* In this release we have also enabled previewnet support for [HIP-17 (Non-fungible Tokens)](https://github.com/hashgraph/hedera-improvement-proposal/blob/master/HIP/hip-17.md). Unique token types and minted NFTs are more natural for many use cases than fungible token types. The Hedera Token Service will soon support both natively, so that a single `CryptoTransfer` can perform atomic swaps with any arbitrary combination of fungible, non-fungible, and ℏ transfers.
* We are very grateful to the Hedera user community for these interesting and powerful new feature sets.
* ## Contributors
* We'd like to thank all the contributors who worked on this release!
* - @abhishek-hedera
* - @amckay7777
* - @anighanta
* - @bugbytesinc
* - @daniel-danev-limechain
* - @Daniel-K-Ivanov
* - @georgiyazovaliiski
* - @joan41868
* - @ljianghedera
* - @Neeharika-Sompalli
* - @qnswirlds
* - @SimiHunjan
* - @tinker-michaelj

**Full Changelog**: [v0.16.0...v0.16.0-rc.1](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.16.0...v0.16.0-rc.1)

</details>

### [Build v0.16.0](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.16.0)

<details>
<summary><strong>What's Changed</strong></summary>

* In Hedera Services 0.16.0, we are excited to announce support for  [HIP-18 (Custom Hedera Token Service Fees)](https://github.com/hashgraph/hedera-improvement-proposal/blob/master/HIP/hip-18.md).
* Hedera tokens can now be created with a schedule of up to 10 custom fees, which are either _fixed_ in units of ℏ or another token; or _fractional_ and computed in the units of the owning token.  The ledger automatically charges custom fees to accounts as they send units of a fungible token (or ownership of a NFT, see below) via a `CryptoTransfer`.
* When a custom fee cannot be charged, the `CryptoTransfer` fails atomically, changing no balances other than for the Hedera network fees.
* The five case studies in [this document](https://github.com/hashgraph/hedera-services/blob/master/docs/fees/custom-fees-characterization.md) show the basics of how custom fees are charged, and how they appear in records. Note that at most two "levels" of custom HTS fees are allowed, and custom fee charging cannot require changing more than 20 account balances.
* ---
* In this release we have also enabled previewnet support for [HIP-17 (Non-fungible Tokens)](https://github.com/hashgraph/hedera-improvement-proposal/blob/master/HIP/hip-17.md). Unique token types and minted NFTs are more natural for many use cases than fungible token types. The Hedera Token Service will soon support both natively, so that a single `CryptoTransfer` can perform atomic swaps with any arbitrary combination of fungible, non-fungible, and ℏ transfers.
* We are very grateful to the Hedera user community for these interesting and powerful new feature sets.
* ## Contributors
* We'd like to thank all the contributors who worked on this release!
* - @abhishek-hedera
* - @amckay7777
* - @anighanta
* - @bugbytesinc
* - @daniel-danev-limechain
* - @Daniel-K-Ivanov
* - @georgiyazovaliiski
* - @joan41868
* - @ljianghedera
* - @Neeharika-Sompalli
* - @qnswirlds
* - @SimiHunjan
* - @tinker-michaelj

**Full Changelog**: [v0.16.0...v0.16.0](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.16.0...v0.16.0)

</details>

## Release v0.15

### [Build v0.15.2](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.15.2)

<details>
<summary><strong>What's Changed</strong></summary>

* In Hedera Services 0.15.2, we improved performance and integrated with the latest Platform SDK to enable network reconnect.
* The performance gains let us augment the Hedera world state with records of all transactions handled in the three minutes of consensus time, even when handling 10k transactions per second. The `GetAccountRecords` query will now return, from state, the records of all transactions handled in the last 3 minute for which the queried account was the payer.
* In this release we also finalized the design for the non-fungible token (NFT) support to be added to the Hedera Token Service (HTS) in release 0.16.0. The protobufs for new HAPI operations are available in the [`0.15.0` tag](https://github.com/hashgraph/hedera-protobufs/tags) of the official repository, with documentation [here](https://hashgraph.github.io/hedera-protobufs/).
* The CSV format for exported account balances is no longer supported. All mainnet stream file consumers should be fully migrated to the protobuf format of the account balances file.
* To simplify fee calculations, there is now a maximum entity lifetime of a century for any entity whose lifetime is not _already_ constrained by the maximum auto-renew period. A HAPI transaction that tries to set an expiration further than a century from the current consensus time will resolve to `INVALID_EXPIRATION_TIME`.
* ## Enhancements
* - Improve performance, e.g. [#1505](https://github.com/hashgraph/hedera-services/issues/1505), [#1501](https://github.com/hashgraph/hedera-services/issues/1501), [#1500](https://github.com/hashgraph/hedera-services/issues/1500), [#1499](https://github.com/hashgraph/hedera-services/issues/1499), [#1498](https://github.com/hashgraph/hedera-services/issues/1498), [#1461](https://github.com/hashgraph/hedera-services/issues/1461), [#1425](https://github.com/hashgraph/hedera-services/issues/1425), [#1424](https://github.com/hashgraph/hedera-services/issues/1424), [#1423](https://github.com/hashgraph/hedera-services/issues/1423), [#1422](https://github.com/hashgraph/hedera-services/issues/1422), [#1421](https://github.com/hashgraph/hedera-services/issues/1421)
* - Finalize protobufs for NFT support in HTS
* ## Contributors
* We'd like to thank all the contributors who worked on this release!
* - @abhishek-hedera
* - @anighanta
* - @bugbytesinc
* - @cesaragv
* - @Daniel-K-Ivanov
* - @failfmi
* - @georgiyazovaliiski
* - @JeffreyDallas
* - @ljianghedera
* - @Neeharika-Sompalli
* - @QianSwirlds
* - @qnswirlds
* - @SimiHunjan
* - @tinker-michaelj

**Full Changelog**: [v0.15.0...v0.15.2](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.15.0...v0.15.2)

</details>

### [Build v0.15.1](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.15.1)

<details>
<summary><strong>What's Changed</strong></summary>

* In Hedera Services 0.15.1, we improved performance and integrated with the latest Platform SDK to enable network reconnect.
* The performance gains let us augment the Hedera world state with records of all transactions handled in the three minutes of consensus time, even when handling 10k transactions per second. The `GetAccountRecords` query will now return, from state, the records of all transactions handled in the last 3 minute for which the queried account was the payer.
* In this release we also finalized the design for the non-fungible token (NFT) support to be added to the Hedera Token Service (HTS) in release 0.16.0. The protobufs for new HAPI operations are available in the [`0.15.0` tag](https://github.com/hashgraph/hedera-protobufs/tags) of the official repository, with documentation [here](https://hashgraph.github.io/hedera-protobufs/).
* The CSV format for exported account balances is no longer supported. All mainnet stream file consumers should be fully migrated to the protobuf format of the account balances file.
* To simplify fee calculations, there is now a maximum entity lifetime of a century for any entity whose lifetime is not _already_ constrained by the maximum auto-renew period. A HAPI transaction that tries to set an expiration further than a century from the current consensus time will resolve to `INVALID_EXPIRATION_TIME`.
* ## Enhancements
* - Improve performance, e.g. [#1505](https://github.com/hashgraph/hedera-services/issues/1505), [#1501](https://github.com/hashgraph/hedera-services/issues/1501), [#1500](https://github.com/hashgraph/hedera-services/issues/1500), [#1499](https://github.com/hashgraph/hedera-services/issues/1499), [#1498](https://github.com/hashgraph/hedera-services/issues/1498), [#1461](https://github.com/hashgraph/hedera-services/issues/1461), [#1425](https://github.com/hashgraph/hedera-services/issues/1425), [#1424](https://github.com/hashgraph/hedera-services/issues/1424), [#1423](https://github.com/hashgraph/hedera-services/issues/1423), [#1422](https://github.com/hashgraph/hedera-services/issues/1422), [#1421](https://github.com/hashgraph/hedera-services/issues/1421)
* - Finalize protobufs for NFT support in HTS
* ## Contributors
* We'd like to thank all the contributors who worked on this release!
* - @abhishek-hedera
* - @anighanta
* - @bugbytesinc
* - @cesaragv
* - @Daniel-K-Ivanov
* - @failfmi
* - @georgiyazovaliiski
* - @JeffreyDallas
* - @ljianghedera
* - @Neeharika-Sompalli
* - @QianSwirlds
* - @qnswirlds
* - @SimiHunjan
* - @tinker-michaelj

**Full Changelog**: [v0.15.0...v0.15.1](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.15.0...v0.15.1)

</details>

### [Build v0.15.0-rc.1](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.15.0-rc.1)

<details>
<summary><strong>What's Changed</strong></summary>

* In Hedera Services 0.15.0, we improved performance and integrated with the latest Platform SDK to enable network reconnect.
* The performance gains let us augment the Hedera world state with records of all transactions handled in the three minutes of consensus time, even when handling 10k transactions per second. The `GetAccountRecords` query will now return, from state, the records of all transactions handled in the last 3 minute for which the queried account was the payer.
* In this release we also finalized the design for the non-fungible token (NFT) support to be added to the Hedera Token Service (HTS) in release 0.16.0. The protobufs for new HAPI operations are available in the [`0.15.0` tag](https://github.com/hashgraph/hedera-protobufs/tags) of the official repository, with documentation [here](https://hashgraph.github.io/hedera-protobufs/).
* The CSV format for exported account balances is no longer supported. All mainnet stream file consumers should be fully migrated to the protobuf format of the account balances file.
* To simplify fee calculations, there is now a maximum entity lifetime of a century for any entity whose lifetime is not _already_ constrained by the maximum auto-renew period. A HAPI transaction that tries to set an expiration further than a century from the current consensus time will resolve to `INVALID_EXPIRATION_TIME`.
* ## Enhancements
* - Improve performance, e.g. [#1505](https://github.com/hashgraph/hedera-services/issues/1505), [#1501](https://github.com/hashgraph/hedera-services/issues/1501), [#1500](https://github.com/hashgraph/hedera-services/issues/1500), [#1499](https://github.com/hashgraph/hedera-services/issues/1499), [#1498](https://github.com/hashgraph/hedera-services/issues/1498), [#1461](https://github.com/hashgraph/hedera-services/issues/1461), [#1425](https://github.com/hashgraph/hedera-services/issues/1425), [#1424](https://github.com/hashgraph/hedera-services/issues/1424), [#1423](https://github.com/hashgraph/hedera-services/issues/1423), [#1422](https://github.com/hashgraph/hedera-services/issues/1422), [#1421](https://github.com/hashgraph/hedera-services/issues/1421)
* - Finalize protobufs for NFT support in HTS
* ## Contributors
* We'd like to thank all the contributors who worked on this release!
* - @abhishek-hedera
* - @anighanta
* - @bugbytesinc
* - @cesaragv
* - @Daniel-K-Ivanov
* - @failfmi
* - @georgiyazovaliiski
* - @JeffreyDallas
* - @ljianghedera
* - @Neeharika-Sompalli
* - @QianSwirlds
* - @qnswirlds
* - @SimiHunjan
* - @tinker-michaelj

**Full Changelog**: [v0.15.0...v0.15.0-rc.1](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.15.0...v0.15.0-rc.1)

</details>

## Release v0.14

### [Build v0.14.0-rc.1](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.14.0-rc.1)

<details>
<summary><strong>What's Changed</strong></summary>

* In Hedera Services 0.14.0, we have implemented account auto-renewal according to the specifications of [HIP-16](https://github.com/hashgraph/hedera-improvement-proposal/blob/master/HIP/hip-16.md). This feature will not be enabled until a later date, after ensuring universal awareness of its impact in the user community.
* This release also includes notable infrastructure work to enable use of the Platform reconnect feature. Reconnect allows a node that has fallen behind in consensus gossip to catch back up dynamically.
* A minor improvement to the Hedera API is that the GetVersionInfo query now includes the optional pre-release version and build metadata fields from the Semantic Versioning spec (if applicable). In another change to HAPI, to simplify life for system admins who are updating a system account's key, we now waive the signing requirement for the account's new key.
* ## Enhancements
* - Implement HIP-16 :: [#1125](https://github.com/hashgraph/hedera-services/issues/1125), [#1350](https://github.com/hashgraph/hedera-services/issues/1350), [#1371](https://github.com/hashgraph/hedera-services/issues/1371)
* - Waive new key's signature when a privileged payer updates a system account :: [#1164](https://github.com/hashgraph/hedera-services/pull/1164)
* - Refine `GetVersionInfo` to return the Git tag used to build the deployed JAR :: [#1188](https://github.com/hashgraph/hedera-services/issues/1188)
* ## Contributors
* We'd like to thank all the contributors who worked on this release!
* - @abhishek-hedera
* - @anighanta
* - @bugbytesinc
* - @cesaragv
* - @Daniel-K-Ivanov
* - @failfmi
* - @georgiyazovaliiski
* - @JeffreyDallas
* - @ljianghedera
* - @Neeharika-Sompalli
* - @QianSwirlds
* - @qnswirlds
* - @SimiHunjan
* - @tinker-michaelj

**Full Changelog**: [v0.14.0...v0.14.0-rc.1](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.14.0...v0.14.0-rc.1)

</details>

### [Build v0.14.0](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.14.0)

<details>
<summary><strong>What's Changed</strong></summary>

* In Hedera Services 0.14.0, we have implemented account auto-renewal according to the specifications of [HIP-16](https://github.com/hashgraph/hedera-improvement-proposal/blob/master/HIP/hip-16.md). This feature will not be enabled until a later date, after ensuring universal awareness of its impact in the user community.
* This release also includes notable infrastructure work to enable use of the Platform reconnect feature. Reconnect allows a node that has fallen behind in consensus gossip to catch back up dynamically.
* A minor improvement to the Hedera API is that the GetVersionInfo query now includes the optional pre-release version and build metadata fields from the Semantic Versioning spec (if applicable). In another change to HAPI, to simplify life for system admins who are updating a system account's key, we now waive the signing requirement for the account's new key.
* ## Enhancements
* - Implement HIP-16 :: [#1125](https://github.com/hashgraph/hedera-services/issues/1125), [#1350](https://github.com/hashgraph/hedera-services/issues/1350), [#1371](https://github.com/hashgraph/hedera-services/issues/1371)
* - Waive new key's signature when a privileged payer updates a system account :: [#1164](https://github.com/hashgraph/hedera-services/pull/1164)
* - Refine `GetVersionInfo` to return the Git tag used to build the deployed JAR :: [#1188](https://github.com/hashgraph/hedera-services/issues/1188)
* ## Contributors
* We'd like to thank all the contributors who worked on this release!
* - @abhishek-hedera
* - @anighanta
* - @bugbytesinc
* - @cesaragv
* - @Daniel-K-Ivanov
* - @failfmi
* - @georgiyazovaliiski
* - @JeffreyDallas
* - @ljianghedera
* - @Neeharika-Sompalli
* - @QianSwirlds
* - @qnswirlds
* - @SimiHunjan
* - @tinker-michaelj

**Full Changelog**: [v0.14.0...v0.14.0](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.14.0...v0.14.0)

</details>

## Release v0.13

### [Build v0.13.2](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.13.2)

<details>
<summary><strong>What's Changed</strong></summary>

* In Hedera Services v0.13.2, we have [redesigned](https://github.com/hashgraph/hedera-services/blob/master/docs/scheduled-transactions/revised-spec.md) scheduled transactions. The new design gives collaborating nodes a well-defined workflow if they happen to schedule identical transactions, _even if_ they are using different gRPC client libraries (for example, Go and JavaScript). The new design also reduces the number of signatures required to submit a valid `ScheduleSign` transaction in many common use cases. Users will be able to schedule CryptoTransfer and ConsensusSubmitMessage transactions in this release. Other transaction types will be introduced in future releases.
* This release deprecates three fields in the [protobuf](https://hashgraph.github.io/hedera-protobufs/#proto.NodeAddress) for system files `0.0.101` and `0.0.102`. The three deprecated fields are `ipAddress`, `portno`, and `memo`. When we rely on these fields, we cannot concisely represent node with multiple IP addresses. For example, take mainnet node 0 (account `0.0.3`), which as of this writing has proxy IPs `13.82.40.153`, `34.239.82.6`, and `35.237.200.180`. The mainnet `0.0.101` file must include a `NodeAddress` entry for each proxy, which means duplicating fields like `nodeCertHash`.
* The new protobuf avoid this duplication, letting us represent node 0 in a protobuf equivalent of,
* ```json
* {
* "nodeId" : 0,
* "certHash" : "337390d8fea144afc12e81254a28dac6ea82893836ac072effd85e0a7748580ef28096648c5a7f8dbb4ce81476815137",
* "nodeAccount" : "0.0.3",
* "serviceEndpoints" : [ {
* "ipAddressV4" : "13.82.40.153",
* "port" : 50211
* }, {
* "ipAddressV4" : "34.239.82.6",
* "port" : 50211
* }, {
* "ipAddressV4" : "35.237.200.180",
* "port" : 50211
* } ]
* }
* ```
* **However**, Services will continue to populate the deprecated fields in duplicate entries for six months, to give all consumers of files `0.0.101` and `0.0.102` time to prepare for exclusive use of the new format. After six months, we will eliminate the duplication and the `ipAddress`, `portno`, and `memo` fields will be left empty. (The fields will never be removed to ensure it remains possible to parse early versions of these system files.)
* In a minor point, Services now rejects any protobuf `string` field whose UTF-8 encoding includes the zero-byte character; that is, Unicode code point 0, `NUL`. Databases (for example, PostgreSQL) commonly reserve this character as a delimiter in their internal formats, so allowing it to occur in entity fields can make life harder for Mirror Node operators.
* To simplify tasks for network admins, we have also streamlined the signing requirements for updates to system accounts, and introduced a Docker-based utility called "yahcli" for admin actions such as updating system files.
* ## Enhancements
* - Redesign scheduled transactions [#1177](https://github.com/hashgraph/hedera-services/issues/1177)
* - When updating a system account's key, if the account's signature is waived, also waive signing with new key [#1148](https://github.com/hashgraph/hedera-services/issues/1148)
* - Basic implementation of yahcli, e.g. [#1176](https://github.com/hashgraph/hedera-services/issues/1176)
* ## Protobuf deprecations
* - Three `NodeAddress` fields, to be replaced by a richer `ServiceEndpoint` message [#750](https://github.com/hashgraph/hedera-services/issues/750)
* ## Bug fixes
* - Re-institute policy of exporting account balances every 15 minutes since the epoch [#1142](https://github.com/hashgraph/hedera-services/issues/1142)
* - Abort signing of resolved schedules  [#1303](https://github.com/hashgraph/hedera-services/pull/1303)
* - Update default throttles packaged as _throttles.json_ in JAR to desired values [#1312](https://github.com/hashgraph/hedera-services/pull/1312)
* ## Contributors
* We'd like to thank all the contributors who worked on this release!
* - @abhishek-hedera
* - @anighanta
* - @cesaragv
* - @Daniel-K-Ivanov
* - @failfmi
* - @georgiyazovaliiski
* - @JeffreyDallas
* - @ljianghedera
* - @Neeharika-Sompalli
* - @QianSwirlds
* - @qnswirlds
* - @SimiHunjan
* - @tinker-michaelj

**Full Changelog**: [v0.13.0...v0.13.2](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.13.0...v0.13.2)

</details>

### [Build v0.13.1](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.13.1)

<details>
<summary><strong>What's Changed</strong></summary>

* In Hedera Services v0.13.0, we have [redesigned](https://github.com/hashgraph/hedera-services/blob/master/docs/scheduled-transactions/revised-spec.md) schedule transactions. The new design gives collaborating nodes a well-defined workflow if they happen to schedule identical transactions, _even if_ they are using different gRPC client libraries (for example, Go and JavaScript). The new design also reduces the number of signatures required to submit a valid `ScheduleSign` transaction in many common use cases. Users will be able to schedule CryptoTransfer and ConsensusSubmitMessage transactions in this release. Other transaction types will be introduced in future releases.  Note: The schedule transactions feature will not be enabled in this release; it's expected to be enabled on testnet in a subsequent  v0.13.1 update on April 29th. This feature is enabled on previewnet.
* This release deprecates three fields in the [protobuf](https://hashgraph.github.io/hedera-protobufs/#proto.NodeAddress) for system files `0.0.101` and `0.0.102`. The three deprecated fields are `ipAddress`, `portno`, and `memo`. When we rely on these fields, we cannot concisely represent node with multiple IP addresses. For example, take mainnet node 0 (account `0.0.3`), which as of this writing has proxy IPs `13.82.40.153`, `34.239.82.6`, and `35.237.200.180`. The mainnet `0.0.101` file must include a `NodeAddress` entry for each proxy, which means duplicating fields like `nodeCertHash`.
* The new protobuf avoid this duplication, letting us represent node 0 in a protobuf equivalent of,
* ```json
* {
* "nodeId" : 0,
* "certHash" : "337390d8fea144afc12e81254a28dac6ea82893836ac072effd85e0a7748580ef28096648c5a7f8dbb4ce81476815137",
* "nodeAccount" : "0.0.3",
* "serviceEndpoints" : [ {
* "ipAddressV4" : "13.82.40.153",
* "port" : 50211
* }, {
* "ipAddressV4" : "34.239.82.6",
* "port" : 50211
* }, {
* "ipAddressV4" : "35.237.200.180",
* "port" : 50211
* } ]
* }
* ```
* **However**, Services will continue to populate the deprecated fields in duplicate entries for six months, to give all consumers of files `0.0.101` and `0.0.102` time to prepare for exclusive use of the new format. After six months, we will eliminate the duplication and the `ipAddress`, `portno`, and `memo` fields will be left empty. (The fields will never be removed to ensure it remains possible to parse early versions of these system files.)
* In a minor point, Services now rejects any protobuf `string` field whose UTF-8 encoding includes the zero-byte character; that is, Unicode code point 0, `NUL`. Databases (for example, PostgreSQL) commonly reserve this character as a delimiter in their internal formats, so allowing it to occur in entity fields can make life harder for Mirror Node operators.
* To simplify tasks for network admins, we have also streamlined the signing requirements for updates to system accounts, and introduced a Docker-based utility called "yahcli" for admin actions such as updating system files.
* ## Enhancements
* - Redesign scheduled transactions [#1177](https://github.com/hashgraph/hedera-services/issues/1177)
* - When updating a system account's key, if the account's signature is waived, also waive signing with new key [#1148](https://github.com/hashgraph/hedera-services/issues/1148)
* - Basic implementation of yahcli, e.g. [#1176](https://github.com/hashgraph/hedera-services/issues/1176)
* ## Protobuf deprecations
* - Three `NodeAddress` fields, to be replaced by a richer `ServiceEndpoint` message [#750](https://github.com/hashgraph/hedera-services/issues/750)
* ## Bug fixes
* - Re-institute policy of exporting account balances every 15 minutes since the epoch [#1142](https://github.com/hashgraph/hedera-services/issues/1142)
* - Abort signing of resolved schedules  [#1303](https://github.com/hashgraph/hedera-services/pull/1303)
* ## Contributors
* We'd like to thank all the contributors who worked on this release!
* - @abhishek-hedera
* - @anighanta
* - @cesaragv
* - @Daniel-K-Ivanov
* - @failfmi
* - @georgiyazovaliiski
* - @JeffreyDallas
* - @ljianghedera
* - @Neeharika-Sompalli
* - @QianSwirlds
* - @qnswirlds
* - @tinker-michaelj

**Full Changelog**: [v0.13.0...v0.13.1](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.13.0...v0.13.1)

</details>

### [Build v0.13.0-rc.2](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.13.0-rc.2)

<details>
<summary><strong>What's Changed</strong></summary>

* In Hedera Services v0.13.0, we have [redesigned](https://github.com/hashgraph/hedera-services/blob/master/docs/scheduled-transactions/revised-spec.md) scheduled transactions. The new design gives collaborating nodes a well-defined workflow if they happen to schedule identical transactions, _even if_ they are using different gRPC client libraries (for example, Go and JavaScript). The new design also reduces the number of signatures required to submit a valid `ScheduleSign` transaction in many common use cases.
* This release deprecates three fields in the [protobuf](https://hashgraph.github.io/hedera-protobufs/#proto.NodeAddress) for system files `0.0.101` and `0.0.102`. The three deprecated fields are `ipAddress`, `portno`, and `memo`. When we rely on these fields, we cannot concisely represent node with multiple IP addresses. For example, take mainnet node 0 (account `0.0.3`), which as of this writing has proxy IPs `13.82.40.153`, `34.239.82.6`, and `35.237.200.180`. The mainnet `0.0.101` file must include a `NodeAddress` entry for each proxy, which means duplicating fields like `nodeCertHash`.
* The new protobuf avoid this duplication, letting us represent node 0 in a protobuf equivalent of,
* ```json
* {
* "nodeId" : 0,
* "certHash" : "337390d8fea144afc12e81254a28dac6ea82893836ac072effd85e0a7748580ef28096648c5a7f8dbb4ce81476815137",
* "nodeAccount" : "0.0.3",
* "serviceEndpoints" : [ {
* "ipAddressV4" : "13.82.40.153",
* "port" : 50211
* }, {
* "ipAddressV4" : "34.239.82.6",
* "port" : 50211
* }, {
* "ipAddressV4" : "35.237.200.180",
* "port" : 50211
* } ]
* }
* ```
* **However**, Services will continue to populate the deprecated fields in duplicate entries for six months, to give all consumers of files `0.0.101` and `0.0.102` time to prepare for exclusive use of the new format. After six months, we will eliminate the duplication and the `ipAddress`, `portno`, and `memo` fields will be left empty. (The fields will never be removed to ensure it remains possible to parse early versions of these system files.)
* In a minor point, Services now rejects any protobuf `string` field whose UTF-8 encoding includes the zero-byte character; that is, Unicode code point 0, `NUL`. Databases (for example, PostgreSQL) commonly reserve this character as a delimiter in their internal formats, so allowing it to occur in entity fields can make life harder for Mirror Node operators.
* To simplify tasks for network admins, we have also streamlined the signing requirements for updates to system accounts, and introduced a Docker-based utility called "yahcli" for admin actions such as updating system files.
* ## Enhancements
* - Redesign scheduled transactions [#1177](https://github.com/hashgraph/hedera-services/issues/1177)
* - When updating a system account's key, if the account's signature is waived, also waive signing with new key [#1148](https://github.com/hashgraph/hedera-services/issues/1148)
* - Basic implementation of yahcli, e.g. [#1176](https://github.com/hashgraph/hedera-services/issues/1176)
* ## Protobuf deprecations
* - Three `NodeAddress` fields, to be replaced by a richer `ServiceEndpoint` message [#750](https://github.com/hashgraph/hedera-services/issues/750)
* ## Bug fixes
* - Re-institute policy of exporting account balances every 15 minutes since the epoch [#1142](https://github.com/hashgraph/hedera-services/issues/1142)
* ## Contributors
* We'd like to thank all the contributors who worked on this release!
* - @abhishek-hedera
* - @anighanta
* - @cesaragv
* - @Daniel-K-Ivanov
* - @failfmi
* - @georgiyazovaliiski
* - @JeffreyDallas
* - @ljianghedera
* - @Neeharika-Sompalli
* - @QianSwirlds
* - @qnswirlds
* - @tinker-michaelj

**Full Changelog**: [v0.13.0...v0.13.0-rc.2](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.13.0...v0.13.0-rc.2)

</details>

### [Build v0.13.0-rc.1](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.13.0-rc.1)

<details>
<summary><strong>What's Changed</strong></summary>

* In Hedera Services v0.13.0, we have [redesigned](https://github.com/hashgraph/hedera-services/blob/master/docs/scheduled-transactions/revised-spec.md) scheduled transactions. The new design gives collaborating nodes a well-defined workflow if they happen to schedule identical transactions, _even if_ they are using different gRPC client libraries (for example, Go and JavaScript). The new design also reduces the number of signatures required to submit a valid `ScheduleSign` transaction in many common use cases.
* This release deprecates three fields in the [protobuf](https://hashgraph.github.io/hedera-protobufs/#proto.NodeAddress) for system files `0.0.101` and `0.0.102`. The three deprecated fields are `ipAddress`, `portno`, and `memo`. When we rely on these fields, we cannot concisely represent node with multiple IP addresses. For example, take mainnet node 0 (account `0.0.3`), which as of this writing has proxy IPs `13.82.40.153`, `34.239.82.6`, and `35.237.200.180`. The mainnet `0.0.101` file must include a `NodeAddress` entry for each proxy, which means duplicating fields like `nodeCertHash`.
* The new protobuf avoid this duplication, letting us represent node 0 in a protobuf equivalent of,
* ```json
* {
* "nodeId" : 0,
* "certHash" : "337390d8fea144afc12e81254a28dac6ea82893836ac072effd85e0a7748580ef28096648c5a7f8dbb4ce81476815137",
* "nodeAccount" : "0.0.3",
* "serviceEndpoints" : [ {
* "ipAddressV4" : "13.82.40.153",
* "port" : 50211
* }, {
* "ipAddressV4" : "34.239.82.6",
* "port" : 50211
* }, {
* "ipAddressV4" : "35.237.200.180",
* "port" : 50211
* } ]
* }
* ```
* **However**, Services will continue to populate the deprecated fields in duplicate entries for six months, to give all consumers of files `0.0.101` and `0.0.102` time to prepare for exclusive use of the new format. After six months, we will eliminate the duplication and the `ipAddress`, `portno`, and `memo` fields will be left empty. (The fields will never be removed to ensure it remains possible to parse early versions of these system files.)
* In a minor point, Services now rejects any protobuf `string` field whose UTF-8 encoding includes the zero-byte character; that is, Unicode code point 0, `NUL`. Databases (for example, PostgreSQL) commonly reserve this character as a delimiter in their internal formats, so allowing it to occur in entity fields can make life harder for Mirror Node operators.
* To simplify tasks for network admins, we have also streamlined the signing requirements for updates to system accounts, and introduced a Docker-based utility called "yahcli" for admin actions such as updating system files.
* ## Enhancements
* - Redesign scheduled transactions [#1177](https://github.com/hashgraph/hedera-services/issues/1177)
* - When updating a system account's key, if the account's signature is waived, also waive signing with new key [#1148](https://github.com/hashgraph/hedera-services/issues/1148)
* - Basic implementation of yahcli, e.g. [#1176](https://github.com/hashgraph/hedera-services/issues/1176)
* ## Protobuf deprecations
* - Three `NodeAddress` fields, to be replaced by a richer `NodeEndpoint` message [#750](https://github.com/hashgraph/hedera-services/issues/750)
* ## Bug fixes
* - Re-institute policy of exporting account balances every 15 minutes since the epoch [#1142](https://github.com/hashgraph/hedera-services/issues/1142)
* ## Contributors
* We'd like to thank all the contributors who worked on this release!
* - @abhishek-hedera
* - @anighanta
* - @cesaragv
* - @Daniel-K-Ivanov
* - @failfmi
* - @georgiyazovaliiski
* - @JeffreyDallas
* - @ljianghedera
* - @Neeharika-Sompalli
* - @QianSwirlds
* - @qnswirlds
* - @tinker-michaelj

**Full Changelog**: [v0.13.0...v0.13.0-rc.1](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.13.0...v0.13.0-rc.1)

</details>

### [Build v0.13.0](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.13.0)

<details>
<summary><strong>What's Changed</strong></summary>

* In Hedera Services v0.13.0, we have [redesigned](https://github.com/hashgraph/hedera-services/blob/master/docs/scheduled-transactions/revised-spec.md) schedule transactions. The new design gives collaborating nodes a well-defined workflow if they happen to schedule identical transactions, _even if_ they are using different gRPC client libraries (for example, Go and JavaScript). The new design also reduces the number of signatures required to submit a valid `ScheduleSign` transaction in many common use cases. Users will be able to schedule CryptoTransfer and ConsensusSubmitMessage transactions in this release. Other transaction types will be introduced in future releases.  Note: The schedule transactions feature will not be enabled in this release; it's expected to be enabled on testnet in a subsequent  v0.13.1 update on April 29th. This feature is enabled on previewnet.
* This release deprecates three fields in the [protobuf](https://hashgraph.github.io/hedera-protobufs/#proto.NodeAddress) for system files `0.0.101` and `0.0.102`. The three deprecated fields are `ipAddress`, `portno`, and `memo`. When we rely on these fields, we cannot concisely represent node with multiple IP addresses. For example, take mainnet node 0 (account `0.0.3`), which as of this writing has proxy IPs `13.82.40.153`, `34.239.82.6`, and `35.237.200.180`. The mainnet `0.0.101` file must include a `NodeAddress` entry for each proxy, which means duplicating fields like `nodeCertHash`.
* The new protobuf avoid this duplication, letting us represent node 0 in a protobuf equivalent of,
* ```json
* {
* "nodeId" : 0,
* "certHash" : "337390d8fea144afc12e81254a28dac6ea82893836ac072effd85e0a7748580ef28096648c5a7f8dbb4ce81476815137",
* "nodeAccount" : "0.0.3",
* "serviceEndpoints" : [ {
* "ipAddressV4" : "13.82.40.153",
* "port" : 50211
* }, {
* "ipAddressV4" : "34.239.82.6",
* "port" : 50211
* }, {
* "ipAddressV4" : "35.237.200.180",
* "port" : 50211
* } ]
* }
* ```
* **However**, Services will continue to populate the deprecated fields in duplicate entries for six months, to give all consumers of files `0.0.101` and `0.0.102` time to prepare for exclusive use of the new format. After six months, we will eliminate the duplication and the `ipAddress`, `portno`, and `memo` fields will be left empty. (The fields will never be removed to ensure it remains possible to parse early versions of these system files.)
* In a minor point, Services now rejects any protobuf `string` field whose UTF-8 encoding includes the zero-byte character; that is, Unicode code point 0, `NUL`. Databases (for example, PostgreSQL) commonly reserve this character as a delimiter in their internal formats, so allowing it to occur in entity fields can make life harder for Mirror Node operators.
* To simplify tasks for network admins, we have also streamlined the signing requirements for updates to system accounts, and introduced a Docker-based utility called "yahcli" for admin actions such as updating system files.
* ## Enhancements
* - Redesign scheduled transactions [#1177](https://github.com/hashgraph/hedera-services/issues/1177)
* - When updating a system account's key, if the account's signature is waived, also waive signing with new key [#1148](https://github.com/hashgraph/hedera-services/issues/1148)
* - Basic implementation of yahcli, e.g. [#1176](https://github.com/hashgraph/hedera-services/issues/1176)
* ## Protobuf deprecations
* - Three `NodeAddress` fields, to be replaced by a richer `ServiceEndpoint` message [#750](https://github.com/hashgraph/hedera-services/issues/750)
* ## Bug fixes
* - Re-institute policy of exporting account balances every 15 minutes since the epoch [#1142](https://github.com/hashgraph/hedera-services/issues/1142)
* ## Contributors
* We'd like to thank all the contributors who worked on this release!
* - @abhishek-hedera
* - @anighanta
* - @cesaragv
* - @Daniel-K-Ivanov
* - @failfmi
* - @georgiyazovaliiski
* - @JeffreyDallas
* - @ljianghedera
* - @Neeharika-Sompalli
* - @QianSwirlds
* - @qnswirlds
* - @tinker-michaelj

**Full Changelog**: [v0.13.0...v0.13.0](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.13.0...v0.13.0)

</details>

## Release v0.12

### [Build v0.12.0](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.12.0)

<details>
<summary><strong>What's Changed</strong></summary>

* In Hedera Services v0.12.0, we completed the MVP implementation of the scheduled transactions service as detailed in [this](https://github.com/hashgraph/hedera-services/blob/master/docs/scheduled-transactions/spec.md) design document. This service decouples _what_ should execute on the ledger from _when_ it should execute, giving new flexibility and programmability to users. Note the scheduling operations are enabled on Previewnet, but remain disabled on Testnet and Mainnet at this time.
* We have given users of the Hedera Token Service (HTS) more control over the lifecycle of their token associations. In v0.11.0, deleted tokens were immediately dissociated from all accounts. This automatic dissociation no longer occurs. If account `X` is associated with token `Y`, then even if token `Y` is marked for deletion, a `getAccountInfo` query for `X` will continue to show the association with `Y` _until_ it is explicitly removed via a `tokenDissociateFromAccount` transaction. Note that for convenience, queries that return token balances now also return the `decimals` value for the relevant token. This allows a user to interpret e.g. `balance=10050` as `100.50` tokens given `decimals=2`.
* In a final Hedera API (HAPI) change, we have extended the `memo` field present on contract and topic entities to the account, file, token, and scheduled transaction entities. (Note this `memo` is distinct from the short-lived `memo` that may be given to any `TransactionBody` for inclusion in the `TransactionRecord`.) All of these changes to HAPI are now more easily browsed via GitHub pages [here](https://hashgraph.github.io/hedera-protobufs/); the new [`hashgraph/hedera-protobufs` repository](https://github.com/hashgraph/hedera-protobufs) is now the authortative source of the protobuf files defining HAPI.
* Apart from these enhancements to HAPI, the "streams" consumable by mirror node operators now include an alpha version of a protobuf file that contains the same information as the `_Balances.csv` files. The type of this file is [`AllAccountBalances`](https://hashgraph.github.io/hedera-protobufs/#proto.AllAccountBalances).
* ## Enhancements
* - Complete the MVP scheduled transaction service [#1016](https://github.com/hashgraph/hedera-services/issues/1016), etc.
* - Give users full control of dissociating from expired/deleted tokens. [#997](https://github.com/hashgraph/hedera-services/issues/998), [#998](https://github.com/hashgraph/hedera-services/issues/998)
* - Return token decimals in queries that include token balances [#1075](https://github.com/hashgraph/hedera-services/issues/1075)
* - Add memo field for file entity [#962](https://github.com/hashgraph/hedera-services/issues/962)
* - Add memo field for account entity [#961](https://github.com/hashgraph/hedera-services/issues/961)
* - Add memo field for token entity [#960](https://github.com/hashgraph/hedera-services/issues/960)
* - Export a new _Balances.proto file to (eventually) supersede current _Balances.csv [#852](https://github.com/hashgraph/hedera-services/issues/852)
* - Migrate Hedera protobufs to new `hashgraph/hedera-protobufs` repo [#883](https://github.com/hashgraph/hedera-services/issues/883)
* # Contributors
* We'd like to thank all the contributors who worked on this release!
* - @anighanta
* - @cesaragv
* - @Daniel-K-Ivanov
* - @failfmi
* - @georgiyazovaliiski
* - @JeffreyDallas
* - @ljianghedera
* - @Neeharika-Sompalli
* - @QianSwirlds
* - @qnswirlds
* - @tinker-michaelj

**Full Changelog**: [v0.12.0...v0.12.0](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.12.0...v0.12.0)

</details>

## Release v0.11

### [Build v0.11.0](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.11.0)

<details>
<summary><strong>What's Changed</strong></summary>

* In Hedera Services v0.11.0, we upgraded the record stream format from v2 to v5 and the event stream format from v3 to v5. These changes are described in detail in the "Record and Event Stream File Formats" [article](https://docs.hedera.com/guides/docs/record-and-event-stream-file-formats).
* We also updated startup code to make the number of system accounts in development and pre-production networks match the number of system accounts on mainnet, [creating](https://github.com/hashgraph/hedera-services/issues/784) account numbers `900-1000` on startup if they do not exist.
* ## Enhancements
* - Refactor RecordStream and EventStream to v5 [#854](https://github.com/hashgraph/hedera-services/issues/854)
* - Create Crypto accounts from 900 to 1000 if they do not exist. [#784](https://github.com/hashgraph/hedera-services/issues/784)
* ## Contributors
* We'd like to thank all the contributors who worked on this release!
* - @anighanta
* - @cesaragv
* - @Daniel-K-Ivanov
* - @failfmi
* - @georgiyazovaliiski
* - @JeffreyDallas
* - @ljianghedera
* - @mark-hedera
* - @Neeharika-Sompalli
* - @QianSwirlds
* - @qnswirlds
* - @tinker-michaelj

**Full Changelog**: [v0.11.0...v0.11.0](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.11.0...v0.11.0)

</details>

## Release v0.10

### [Build v0.10.0](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.10.0)

<details>
<summary><strong>What's Changed</strong></summary>

* In Hedera Services v0.10.0, we improved the usability of the Hedera Token Service (HTS) with a `newTotalSupply` field in the receipts of `TokenMint` and `TokenBurn` transactions. Without this field, a client must follow the entire record stream of a token's supply changes to be certain of its supply at the consensus timestamp in the receipt. (Note that HTS operations are now enabled on Previewnet and Testnet, but remain disabled on Mainnet at this time. Please consult the [SDK documentation](https://docs.hedera.com/452354233115445331/token-service) for HTS semantics.)
* Also for HTS, we added a property `fees.tokenTransferUsageMultiplier` that scales the resource usage assigned to a `CryptoTransfer` that changes token balances. This scaling factor is expected to be set so that the cost of a `CryptoTransfer` that changes two token balances is roughly 10x the cost of a `CryptoTransfer` that changes only two hbar balances.
* Apart from HTS, this release drops a restriction on what payer accounts can be used for `CryptoUpdate` transactions that target system accounts. (That is, accounts with number not greater than `hedera.numReservedSystemEntities`.) In earlier versions, only three payers were accepted: The target account itself, the system admin account, or the treasury account. Other payers resulted in a status of `AUTHORIZATION_FAILED`. This entire restriction is removed, with one exception---the treasury must pay for a `CryptoUpdate` targeting the treasury.
* Apart from these functional changes, we fixed an unintentional change in the naming of the crypto balances CSV file, and improved the usefulness of clients under _test-clients/_ for testing reconnect scenarios.
* # Enhancements
* - Add `newTotalSupply` field to the receipt of transactions affecting token supply #645
* - Scale resource usage differently for hbar and token balance adjustments #863
* - Relax payer authorization reqs for updates to system accounts  #774
* # Bug fixes
* - Revert unintentional change to balances CSV name #842
* # Contributors
* We'd like to thank all the contributors who worked on this release!
* - @anighanta
* - @cesaragv
* - @Daniel-K-Ivanov
* - @failfmi
* - @georgiyazovaliiski
* - @JeffreyDallas
* - @ljianghedera
* - @Neeharika-Sompalli
* - @QianSwirlds
* - @qnswirlds
* - @tinker-michaelj

**Full Changelog**: [v0.10.0...v0.10.0](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.10.0...v0.10.0)

</details>

## Release v0.9

### [Build v0.9.0-rc.3](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.9.0-rc.3)

<details>
<summary><strong>What's Changed</strong></summary>

* In Hedera Services v0.9.0, we finished the alpha implementation of the Hedera Token Service (HTS). Note that all HTS operations are enabled on Previewnet, but remain disabled on Testnet and Mainnet. Please consult the [SDK documentation](https://docs.hedera.com/452354233115445331/token-service) for HTS semantics.
* We made several changes to the HAPI protobuf. First, we removed the deprecated `SignatureList` message type. Second, we added a top-level `signedTransactionBytes` field to the `Transaction` message to ensure deterministic transaction hashes; the top-level `bodyBytes` and `sigMap` fields are now deprecated and the already-deprecated `body` field is removed. Third, we deprecated all fields related to non-payer records, include account send and receive thresholds. This followed from the effective removal of non-payer records in v0.8.1.
* For the same reason, the semantics of the `CryptoGetRecords` and `ContractGetRecords` queries have also changed. The only queryable records are now those granted to the effective payer of a transaction that was handled while the network property `ledger.keepRecordsInState=true`. Such records have an expiry of 180 seconds. It is important to note that because a contract account can never be the effective payer for a transaction, any `ContractGetRecords` query will always return an empty record list, and we have deprecated the query.
* # Enhancements
* - Complete alpha implementation of HTS, e.g. #646 #703 #751
* - Ensure deterministic transaction hashes via the `Transaction#signedTransactionBytes` field #611
* - Drop some artificial constraints on the form of a `CryptoTransfer` used for a query payment #581
* # Deprecations
* - Remove all code involved with non-payer records; deprecate all associated protobuf elements #548
* # Bug fixes
* - Consolidate fees for variable-size transaction records to ensure the payer's max `transactionFee` is respected #502
* - Fix issues with pre-alpha HTS implementation, e.g. #698
* # Contributors
* We'd like to thank all the contributors who worked on this release!
* - @anighanta
* - @cesaragv
* - @Daniel-K-Ivanov
* - @failfmi
* - @georgiyazovaliiski
* - @JeffreyDallas
* - @ljianghedera
* - @Neeharika-Sompalli
* - @QianSwirlds
* - @qnswirlds
* - @tinker-michaelj

**Full Changelog**: [v0.9.0...v0.9.0-rc.3](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.9.0...v0.9.0-rc.3)

</details>

### [Build v0.9.0-rc.1](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.9.0-rc.1)

<details>
<summary><strong>What's Changed</strong></summary>

* In Hedera Services v0.9.0, we finished the alpha implementation of the Hedera Token Service (HTS). Note that all HTS operations are enabled on Previewnet, but remain disabled on Testnet and Mainnet. Please consult the [SDK documentation](https://docs.hedera.com/452354233115445331/token-service) for HTS semantics.
* We made several changes to the HAPI protobuf. First, we removed the deprecated `SignatureList` message type. Second, we added a top-level `signedTransactionBytes` field to the `Transaction` message to ensure deterministic transaction hashes; the top-level `bodyBytes` and `sigMap` fields are now deprecated and the already-deprecated `body` field is removed. Third, we deprecated all fields related to non-payer records, include account send and receive thresholds. This followed from the effective removal of non-payer records in v0.8.1.
* For the same reason, the semantics of the `CryptoGetRecords` and `ContractGetRecords` queries have also changed. The only queryable records are now those granted to the effective payer of a transaction that was handled while the network property `ledger.keepRecordsInState=true`. Such records have an expiry of 180 seconds. It is important to note that because a contract account can never be the effective payer for a transaction, any `ContractGetRecords` query will always return an empty record list, and we have deprecated the query.
* # Enhancements
* - Complete alpha implementation of HTS, e.g. #646 #703 #751
* - Ensure deterministic transaction hashes via the `Transaction#signedTransactionBytes` field #611
* - Drop some artificial constraints on the form of a `CryptoTransfer` used for a query payment #581
* # Deprecations
* - Remove all code involved with non-payer records; deprecate all associated protobuf elements #548
* # Bug fixes
* - Consolidate fees for variable-size transaction records to ensure the payer's max `transactionFee` is respected #502
* - Fix issues with pre-alpha HTS implementation, e.g. #698
* # Contributors
* We'd like to thank all the contributors who worked on this release!
* - @anighanta
* - @cesaragv
* - @Daniel-K-Ivanov
* - @failfmi
* - @georgiyazovaliiski
* - @JeffreyDallas
* - @ljianghedera
* - @Neeharika-Sompalli
* - @QianSwirlds
* - @qnswirlds
* - @tinker-michaelj

**Full Changelog**: [v0.9.0...v0.9.0-rc.1](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.9.0...v0.9.0-rc.1)

</details>

### [Build v0.9.0](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.9.0)

<details>
<summary><strong>What's Changed</strong></summary>

* In Hedera Services v0.9.0, we finished the alpha implementation of the Hedera Token Service (HTS). Note that all HTS operations are enabled on Previewnet, but remain disabled on Testnet and Mainnet. Please consult the [SDK documentation](https://docs.hedera.com/452354233115445331/token-service) for HTS semantics.
* We made several changes to the HAPI protobuf. First, we removed the deprecated `SignatureList` message type. Second, we added a top-level `signedTransactionBytes` field to the `Transaction` message to ensure deterministic transaction hashes; the top-level `bodyBytes` and `sigMap` fields are now deprecated and the already-deprecated `body` field is removed. Third, we deprecated all fields related to non-payer records, include account send and receive thresholds. This followed from the effective removal of non-payer records in v0.8.1.
* For the same reason, the semantics of the `CryptoGetRecords` and `ContractGetRecords` queries have also changed. The only queryable records are now those granted to the effective payer of a transaction that was handled while the network property `ledger.keepRecordsInState=true`. Such records have an expiry of 180 seconds. It is important to note that because a contract account can never be the effective payer for a transaction, any `ContractGetRecords` query will always return an empty record list, and we have deprecated the query.
* # Enhancements
* - Complete alpha implementation of HTS, e.g. #646 #703 #751
* - Ensure deterministic transaction hashes via the `Transaction#signedTransactionBytes` field #611
* - Drop some artificial constraints on the form of a `CryptoTransfer` used for a query payment #581
* # Deprecations
* - Remove all code involved with non-payer records; deprecate all associated protobuf elements #548
* # Bug fixes
* - Consolidate fees for variable-size transaction records to ensure the payer's max `transactionFee` is respected #502
* - Fix issues with pre-alpha HTS implementation, e.g. #698
* # Contributors
* We'd like to thank all the contributors who worked on this release!
* - @anighanta
* - @cesaragv
* - @Daniel-K-Ivanov
* - @failfmi
* - @georgiyazovaliiski
* - @JeffreyDallas
* - @ljianghedera
* - @Neeharika-Sompalli
* - @QianSwirlds
* - @qnswirlds
* - @tinker-michaelj

**Full Changelog**: [v0.9.0...v0.9.0](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.9.0...v0.9.0)

</details>

## Release v0.8

### [Build v0.8.0](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.8.0)

<details>
<summary><strong>What's Changed</strong></summary>

* In Hedera Services v0.8.0, we made several minor fixes and improvements. This tag also includes pre-release implementations of several operations for an incipient Hedera Token Service (HTS).
* **NOTE:** HTS operations will remain disabled in non-development environments for some time. These operations are under active development; please consult `master` for up-to-date semantics.
* # Enhancements
* - Deprecated fields related to threshold records in HAPI protobuf  #506
* - Update Receipt proto to pair each Status with NodeID - Receipt is deleted only when the latest (duplicate) transaction expires. `getTxRecord` API  will continue to return ALL records with the transaction ID.
* - First drafts of `tokenCreate`, `tokenUpdate`, `tokenDelete`, `tokenTransfer`, `tokenFreeze`, `tokenUnfreeze`, `tokenGrantKyc`, `tokenRevokeYc`, `tokenWipe`, and `getTokenInfo` HAPI operations. #505 and #522
* # Documentation changes
* - None
* # Bug fixes
* - None
* # Contributors
* We'd like to thank all the contributors who worked on this release!
* - @qnswirlds
* - @tinker-michaelj
* - @ljianghedera
* - @anighanta
* - @JeffreyDallas
* - @Neeharika-Sompalli

**Full Changelog**: [v0.8.0...v0.8.0](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.8.0...v0.8.0)

</details>

## Release v0.7

### [Build v0.7.0-rc2](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.7.0-rc2)

<details>
<summary><strong>What's Changed</strong></summary>

* In Hedera Services v0.7.0, we’ve moved to Swirlds SDK release `0.7.3` which enables zero-stake nodes to be part of a network without affecting consensus. Hedera Services v0.7.0 migrated to new interfaces and methods provided in this version of the Swirlds SDK.
* HCS topic running hashes are now calculated including the payer account id. The release includes other minor fixes and improvements.
* # Enhancements
* - Migrate to Swirlds SDK release `0.7.3` with appropriate settings and logging configurations #347, #427
* - Update HCS topic running hash to include the payer account id #88
* - Add zero-stake node functionality #274
* - Add new stats for the average size of HCS submit message transactions that got handled and for counting the number of platform transactions not created per second #316, #334
* - Change gRPC CipherSuite to be CNSA compliant #215
* - Make recordLogPeriod dynamic with a default of 2 seconds #315
* - Add record with 3-min expiry to effective payer account after handling transaction #348
* - Enhancements for going open source #378, #379
* # Documentation changes
* - Clarify interpretation of response codes `UNKNOWN` and `PLATFORM_TRANSACTION_NOT_CREATED`  #314, #394
* # Bug fixes
* - Prevent `CryptoCreate` and `CryptoUpdate` transactions from giving an account an empty key #58, #60
* - Fix incorrect submitted smart contract transactions count #371
* - Validate total ledger balance before starting up Services #258
* - Add a new rolling file to log all queries with controlled maximum rate #59
* - Other minor bugs #373
* # Contributors
* We'd like to thank all the contributors who worked on this release!
* - @qnswirlds
* - @tinker-michaelj
* - @ljianghedera
* - @anighanta
* - @JeffreyDallas
* - @Neeharika-Sompalli

**Full Changelog**: [v0.7.0...v0.7.0-rc2](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.7.0...v0.7.0-rc2)

</details>

### [Build v0.7.0](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.7.0)

<details>
<summary><strong>What's Changed</strong></summary>

* In Hedera Services v0.7.0, we’ve moved to Swirlds SDK release `0.7.3` which enables zero-stake nodes to be part of a network without affecting consensus. Hedera Services v0.7.0 migrated to new interfaces and methods provided in this version of the Swirlds SDK.
* HCS topic running hashes are now calculated including the payer account id. The release includes other minor fixes and improvements.
* # Enhancements
* - Migrate to Swirlds SDK release `0.7.3` with appropriate settings and logging configurations #347, #427
* - Update HCS topic running hash to include the payer account id #88
* - Add zero-stake node functionality #274
* - Add new stats for the average size of HCS submit message transactions that got handled and for counting the number of platform transactions not created per second #316, #334
* - Change gRPC CipherSuite to be CNSA compliant #215
* - Make recordLogPeriod dynamic with a default of 2 seconds #315
* - Add record with 3-min expiry to effective payer account after handling transaction #348
* - Enhancements for going open source #378, #379
* # Documentation changes
* - Clarify interpretation of response codes `UNKNOWN` and `PLATFORM_TRANSACTION_NOT_CREATED`  #314, #394
* # Bug fixes
* - Prevent `CryptoCreate` and `CryptoUpdate` transactions from giving an account an empty key #58, #60
* - Fix incorrect submitted smart contract transactions count #371
* - Validate total ledger balance before starting up Services #258
* - Add a new rolling file to log all queries with controlled maximum rate #59
* - Other minor bugs #373
* # Contributors
* We'd like to thank all the contributors who worked on this release!
* - @qnswirlds
* - @tinker-michaelj
* - @ljianghedera
* - @anighanta
* - @JeffreyDallas
* - @Neeharika-Sompalli

**Full Changelog**: [v0.7.0...v0.7.0](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.7.0...v0.7.0)

</details>

## Release v0.6

### [Build v0.6.0](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/v0.6.0)

<details>
<summary><strong>What's Changed</strong></summary>

* In Hedera Services v0.6.0, we’ve enhanced the Hedera Consensus Service by supporting [HCS Topic Fragmentation](https://github.com/hashgraph/hedera-services/issues/53). We added, into the `ConsensusSubmitMessageTransactionBody`, an optional field for the current chunk information. For every chunk, the payer account that is part of the `initialTransactionID` must match the Payer Account of this transaction. The entire `initialTransactionID` should match the `transactionID` of the first chunk, but this is not checked or enforced by Hedera except when the chunk number is 1.
* # Enhancements
* - Add support for HCS Topic Fragmentation #53
* # Documentation changes
* - Protobuf v0.6.0 with HAPI doc update to support HCS Topic Fragmentation #53
* # Contributors
* We'd like to thank all the contributors who worked on this release!
* - @qnswirlds
* - @tinker-michaelj
* - @ljianghedera
* - @anighanta
* - @JeffreyDallas
* - @Neeharika-Sompalli

**Full Changelog**: [v0.6.0...v0.6.0](https://github.com/hiero-ledger/hiero-consensus-node/compare/v0.6.0...v0.6.0)

</details>

## Release voa-release-r5-rc8.undefined

### [Build oa-release-r5-rc8](https://github.com/hiero-ledger/hiero-consensus-node/releases/tag/oa-release-r5-rc8)

<details>
<summary><strong>What's Changed</strong></summary>

* In Hedera Services v0.5.0, we've [added TLS](https://github.com/hashgraph/hedera-services/issues/29) for trusted communication with nodes on the Hedera network. For better security, only TLS v1.2 and v1.3 with TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384 and TLS_RSA_WITH_AES_256_GCM_SHA384 cipher suites are allowed. We've added [new metadata](https://github.com/hashgraph/hedera-services/issues/30) in the Hedera `NodeAddressBook`, accessible in system file `0.0.101`. The versions of the node software and gRPC Hedera API (HAPI) are now queryable via [`GetVersionInfo`](https://github.com/hashgraph/hedera-services/issues/32) under the new `NetworkService` for node- and network-scoped operations.
* For Hedera Consensus Service, we've updated the topic running hash calculation to use the [SHA-384 hash](https://github.com/hashgraph/hedera-services/issues/36) of the submitted message, rather than the message itself. This reduces the storage requirements needed to validate the hash of a topic. The record of a `ConsensusSubmitMessage` transaction that uses the new hashing scheme will have a new `topicRunningHashVersion` field in its receipt. The value of the field will be `2`.
* Hedera File Service also has several fixes of note. First, we enabled [immutable files](https://github.com/hashgraph/hedera-services/issues/37). Second, we relaxed the [signing requirements](https://github.com/hashgraph/hedera-services/issues/38) for a `FileDelete` transaction to match the semantics of a revocation service. Third, we fixed a [fee calculation](https://github.com/hashgraph/hedera-services/issues/39) bug that overcharged certain `FileUpdate` transactions.
* For Hedera Smart Contract Service, we've improved visibility into transactions that create child contracts using the new keyword by putting created ids in the record of the transaction; and we now [propagate parent contract metadata](https://github.com/hashgraph/hedera-services/issues/31) to created children.
* Finally, if you use the throttle properties in system file `0.0.121` to estimate network performance limits, you will also be interested in a new [standardized format](https://github.com/hashgraph/hedera-services/issues/33) of those properties. The lists below contain these and other minor updates, bug fixes, and documentation changes.
* # Enhancements
* - Add support for TLS #29
* - Expand address book metadata #30
* - Return all created contract ids #31
* - Propagate creator contract metadata #31
* - Introduce GetVersionInfo query #32
* - Standardize throttle configuration #33
* - Enforce file.encoding=utf-8 on startup #34
* - Make duration properties inclusive for readability #35
* # Bug fixes
* - Use message SHA-384 hash in running hash #36
* - Enable immutable files #37
* - Relax FileDelete signing requirements #38
* - Fix sbh calculation in FileUpdate #39
* - Return metadata for deleted files #40
* - Enforce receiver signing requirements during contract execution #41
* - Reject invalid CryptoGetInfo #42
* - Reject CryptoCreate with empty key #43
* - Return NOT_SUPPORTED for state proof queries
* - Waive fees for 0.0.57 updating 0.0.111 #44
* - Waive signing requirements for 0.0.55 updating 0.0.121/0.0.122 #45
* - Waive all fees for 0.0.2 #46
* - Do not throttle system accounts #47
* # Documentation changes
* - Replace "claim" with "livehash" as appropriate #48
* - Standardize and clarify HAPI doc #49

**Full Changelog**: [voa-release-r5-rc8.undefined.0...oa-release-r5-rc8](https://github.com/hiero-ledger/hiero-consensus-node/compare/voa-release-r5-rc8.undefined.0...oa-release-r5-rc8)

</details>