# Transactions

Transactions are requests submitted by a client to a node in the Hedera network. Every transaction has a fee that will be paid for processing the transaction. The following table lists the transaction type requests for each service.

{% hint style="info" %}
Transactions have a 6,144-byte size limit. This includes the signatures on the transaction. The estimated single signature size is about 80-100 bytes.
{% endhint %}

{% hint style="info" %}
### **Transfers**

The R4 release introduces an updated method for displaying HBAR balance changes for accounts participating in a transaction, whether directly or as a node. Previously, each HBAR transfer—payments between accounts or fees to a Hedera node or Hedera itself—was listed separately. This included separate entries for the payer's main payment, network fees, and node fees. The new approach consolidates these transfers, showing only the net transfer value for each account involved in the transaction.
{% endhint %}

<table data-header-hidden><thead><tr><th width="374"></th><th></th></tr></thead><tbody><tr><td><h4>Accounts</h4></td><td><h4>Consensus</h4></td></tr><tr><td><a href="../accounts-and-hbar/create-an-account.md">AccountCreateTransaction</a></td><td><a href="../consensus-service/create-a-topic.md">TopicCreateTransaction</a></td></tr><tr><td><a href="../accounts-and-hbar/update-an-account.md">AccountUpdateTransaction</a></td><td><a href="../consensus-service/update-a-topic.md">TopicUpdateTransaction</a></td></tr><tr><td><a href="../accounts-and-hbar/transfer-cryptocurrency.md">TransferTransaction</a></td><td><a href="../consensus-service/submit-a-message.md">TopicMessageSubmitTransaction</a></td></tr><tr><td><a href="../accounts-and-hbar/delete-an-account.md">AccountDeleteTransaction</a></td><td><a href="../consensus-service/delete-a-topic.md">TopicDeleteTransaction</a></td></tr><tr><td><a href="../accounts-and-hbar/approve-an-allowance.md">AccountAllowanceApprovalTransaction</a></td><td></td></tr></tbody></table>

| <h4>File Service</h4>                                        | <h4>Smart Contracts</h4>                                                   |
| ------------------------------------------------------------ | -------------------------------------------------------------------------- |
| [FileCreateTransaction](../file-service/create-a-file.md)    | [ContractCreateTransaction](../smart-contracts/create-a-smart-contract.md) |
| [FileAppendTransaction](../file-service/append-to-a-file.md) | [ContractUpdateTransaction](../smart-contracts/update-a-smart-contract.md) |
| [FileUpdateTransaction](../file-service/update-a-file.md)    | [ContractDeleteTransaction](../smart-contracts/delete-a-smart-contract.md) |
| [FileDeleteTransaction](../file-service/delete-a-file.md)    | [EthereumTransaction](../smart-contracts/ethereum-transaction.md)          |

| <h4>Tokens</h4>                                                                     |                                                                                |
| ----------------------------------------------------------------------------------- | ------------------------------------------------------------------------------ |
| [TokenCreateTransaction](../token-service/define-a-token.md)                        | [TokenFeeScheduleUpdateTransaction](../token-service/update-a-fee-schedule.md) |
| [TokenUpdateTransaction](../token-service/update-a-token.md)                        | [TokenUnfreezeTransaction](../token-service/unfreeze-an-account.md)            |
| [TokenDeleteTransaction](../token-service/delete-a-token.md)                        | [TokenGrantKycTransaction](../token-service/enable-kyc-account-flag.md)        |
| [TokenAssociateTransaction](../token-service/associate-tokens-to-an-account.md)     | [TokenRevokeKycTransaction](../token-service/disable-kyc-account-flag.md)      |
| [TokenDissociateTransaction](../token-service/dissociate-tokens-from-an-account.md) | [TokenPauseTransaction](../token-service/pause-a-token.md)                     |
| [TokenMintTransaction](../token-service/mint-a-token.md)                            | [TokenUnpauseTransaction](../token-service/unpause-a-token.md)                 |
| [TokenBurnTransaction](../token-service/burn-a-token.md)                            | [TokenWipeTransaction](../token-service/wipe-a-token.md)                       |
| [TokenFreezeTransaction](../token-service/freeze-an-account.md)                     |                                                                                |
