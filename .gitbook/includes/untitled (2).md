---
title: Untitled
---

<details>

<summary><strong>What's Changed</strong></summary>

### Features

* remove shard/realm negative check in asTokenId ([#19355](https://github.com/hiero-ledger/hiero-consensus-node/pull/19355))
* 8841: Need a way to change the number of object key buckets in MerkleDb ([#18910](https://github.com/hiero-ledger/hiero-consensus-node/pull/18910))
* Support nonzero shard/realm in yahcli sys commands ([#19297](https://github.com/hiero-ledger/hiero-consensus-node/pull/19297))
* remove genesis freeze time ([#19298](https://github.com/hiero-ledger/hiero-consensus-node/pull/19298))
* Bump PBJ version and use Block Stream Publish Service ([#19290](https://github.com/hiero-ledger/hiero-consensus-node/pull/19290))
* overwrite default config converters ([#18617](https://github.com/hiero-ledger/hiero-consensus-node/pull/18617))
* Support nonzero shard/realm in fee and schedule commands ([#19279](https://github.com/hiero-ledger/hiero-consensus-node/pull/19279))
* add throttle for ops duration ([#19053](https://github.com/hiero-ledger/hiero-consensus-node/pull/19053))
* UnitTest of BirthRound Ancient Mode ([#11560](https://github.com/hiero-ledger/hiero-consensus-node/issues/11560)) ([#19252](https://github.com/hiero-ledger/hiero-consensus-node/pull/19252))
* Support accepting/declining rewards in yahcli DAB transactions ([#19255](https://github.com/hiero-ledger/hiero-consensus-node/pull/19255))
* Add ops duration ([#18921](https://github.com/hiero-ledger/hiero-consensus-node/pull/18921))
* limit birth round when freezing ([#19193](https://github.com/hiero-ledger/hiero-consensus-node/pull/19193))
* Enable Birth Rounds as Ancient Threshold ([#19208](https://github.com/hiero-ledger/hiero-consensus-node/pull/19208))
* Implement nonzero shard/realm for yahcli DAB transactions ([#19166](https://github.com/hiero-ledger/hiero-consensus-node/pull/19166))
* Migrate logging validation to `assertThat` for OtterTests ([#19159](https://github.com/hiero-ledger/hiero-consensus-node/pull/19159))
* **18458** Guarantee events are written on pces before handling that round ([#18811](https://github.com/hiero-ledger/hiero-consensus-node/pull/18811))
* stop consensus on freeze ([#18937](https://github.com/hiero-ledger/hiero-consensus-node/pull/18937))
* Yahcli nonzero shard/realm implementations for crypto transfers and sys file updates ([#19063](https://github.com/hiero-ledger/hiero-consensus-node/pull/19063))
* Implement feature flag for gRPC web proxy endpoint ([#19051](https://github.com/hiero-ledger/hiero-consensus-node/pull/19051))
* Implement staking activation with nonzero shard/realm ([#19010](https://github.com/hiero-ledger/hiero-consensus-node/pull/19010))
* Implement fee changes for HIP-991 ([#18991](https://github.com/hiero-ledger/hiero-consensus-node/pull/18991))
* add proper handling for unknown function calls in system contracts ([#18733](https://github.com/hiero-ledger/hiero-consensus-node/pull/18733))
* Capture GRPC/SDK usage metrics ([#18469](https://github.com/hiero-ledger/hiero-consensus-node/pull/18469))
* enable the jumbo transaction feature flag ([#18969](https://github.com/hiero-ledger/hiero-consensus-node/pull/18969))
* enhance logging validation for otter tests ([#18897](https://github.com/hiero-ledger/hiero-consensus-node/pull/18897))
* local deterministic generation ([#18930](https://github.com/hiero-ledger/hiero-consensus-node/pull/18930))
* add debug logs on key places ([#18890](https://github.com/hiero-ledger/hiero-consensus-node/pull/18890))
* Limit the callData field instead of ethereumData ([#18647](https://github.com/hiero-ledger/hiero-consensus-node/pull/18647))

### Bug Fixes

* Keep node weights in `HintsConstruction` ([#19344](https://github.com/hiero-ledger/hiero-consensus-node/pull/19344))
* Improve error handling when setting auto renew period ([#19303](https://github.com/hiero-ledger/hiero-consensus-node/pull/19303))
* 19319: Improve MerkleDb reconnect / compaction synchronization ([#19321](https://github.com/hiero-ledger/hiero-consensus-node/pull/19321))
* 19301 Updated `StateIdentifier` enum ([#19302](https://github.com/hiero-ledger/hiero-consensus-node/pull/19302))
* **19259** Fix race condition when setting freeze round value ([#19299](https://github.com/hiero-ledger/hiero-consensus-node/pull/19299))
* Fix batch transaction fees ([#19101](https://github.com/hiero-ledger/hiero-consensus-node/pull/19101))
* Correct HapiCryptoCreate staked account ID parsing ([#19283](https://github.com/hiero-ledger/hiero-consensus-node/pull/19283))
* ConcurrentModificationException in InMemoryAppender ([#19266](https://github.com/hiero-ledger/hiero-consensus-node/pull/19266))
* Fix the transactionFee in the record for ConsensusSubmitMessage with custom fees ([#19201](https://github.com/hiero-ledger/hiero-consensus-node/pull/19201))
* Move jumbo transaction size check only at ingest ([#19118](https://github.com/hiero-ledger/hiero-consensus-node/pull/19118))
* Remove default shard and realm constants ([#19123](https://github.com/hiero-ledger/hiero-consensus-node/pull/19123))
* Only use inner results for `BATCH_INNER` dispatches ([#19157](https://github.com/hiero-ledger/hiero-consensus-node/pull/19157))
* Use `CompositeFilter` for console logging ([#19171](https://github.com/hiero-ledger/hiero-consensus-node/pull/19171))
* **19162** Open clause for JMS runtime for junit-extensions ([#19163](https://github.com/hiero-ledger/hiero-consensus-node/pull/19163))
* Decouple shard/realm from hapiTestMisc ([#19083](https://github.com/hiero-ledger/hiero-consensus-node/pull/19083))
* Inner transaction node setting in test-clients ([#19150](https://github.com/hiero-ledger/hiero-consensus-node/pull/19150))
* asTokenId can generate TokenId with negative shard and realm ([#18997](https://github.com/hiero-ledger/hiero-consensus-node/pull/18997))
* Fix error in `TipsetEventCreatorTests` ([#19120](https://github.com/hiero-ledger/hiero-consensus-node/pull/19120))
* Decouple hapiTestSmartContracts shard and realm ([#19077](https://github.com/hiero-ledger/hiero-consensus-node/pull/19077))
* Update to respect 0.2.3-SNAPSHOT max CRS parties ([#19106](https://github.com/hiero-ledger/hiero-consensus-node/pull/19106))
* 19054: Need a way to check if a MerkleDb compaction tasks are running ([#19069](https://github.com/hiero-ledger/hiero-consensus-node/pull/19069))
* Change default `decline_reward` to true for nodes created during genesis ([#19086](https://github.com/hiero-ledger/hiero-consensus-node/pull/19086))
* NoArgsConstructor has duplicated get() method ([#19089](https://github.com/hiero-ledger/hiero-consensus-node/pull/19089))
* Decouple hapiTestToken ([#18985](https://github.com/hiero-ledger/hiero-consensus-node/pull/18985))
* Update Roster Schema isUpgrade check ([#19006](https://github.com/hiero-ledger/hiero-consensus-node/pull/19006))
* add required module to Otter tests test fixtures module info ([#19024](https://github.com/hiero-ledger/hiero-consensus-node/pull/19024))
* Flaky Jumbo transactions tests ([#19015](https://github.com/hiero-ledger/hiero-consensus-node/pull/19015))
* Improve exception handling when payer account is not meeting the specifications ([#18995](https://github.com/hiero-ledger/hiero-consensus-node/pull/18995))
* migrate judge hashes on birth rounds ([#19000](https://github.com/hiero-ledger/hiero-consensus-node/pull/19000))
* Assign nGen for GUI generated events ([#18986](https://github.com/hiero-ledger/hiero-consensus-node/pull/18986))

</details>
