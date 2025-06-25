# Ethereum transaction

An `EthereumTransaction` lets you execute a raw, RLP-encoded (type 0, 1, or 2) Ethereum transaction on the Hedera network. This enables developers familiar with EVM tooling to leverage their existing knowledge and infrastructure when interacting with the [Hedera Smart Contract Service (HSCS)](../../../tutorials/smart-contracts/).

{% hint style="warning" %}
#### **Important**

Hedera interprets HBAR decimals differently depending on the context:

* The lowest denomination of HBAR when used within a the `value` field in the `EthereumTransaction` is `weibars` meaning with `18` decimals
* The lowest denomination of hbar when used within `data` or the Hedera EVM is `tinybars` meaning with `8` decimals.
* Gas Price information is in `weibars` denomination.\
  \
  Reference: [HIP-410](https://hips.hedera.com/hip/hip-410)
{% endhint %}

<table><thead><tr><th width="204.27520751953125">Field</th><th>Description</th></tr></thead><tbody><tr><td><strong>Ethereum Data</strong></td><td>An RLP-encoded (type 0, 1, or 2) Ethereum transaction to execute on the Hedera network. This enables developers to leverage existing EVM tooling and workflows with the Hedera Smart Contract Service (HSCS).</td></tr><tr><td><strong>Call Data File ID</strong></td><td>An optional field referencing a file on the Hedera File Service (HFS) containing the <code>callData</code>. When set, the network ignores the <code>callData</code> in <code>ethereumData</code> during execution and instead loads the data from the referenced file. However, the full <code>callData</code> must still be present in the originally signed <code>ethereumData</code> for signature validation. In this case, <code>ethereumData</code> will contain a placeholder where <code>callData</code> normally resides, and the transaction must be "rehydrated" with the HFS content during validation.<br><br><em><strong>Note:</strong> With</em> <a href="https://hips.hedera.com/hip/hip-1086"><em>HIP-1086</em></a><em>, jumbo <code>ethereumData</code> is the preferred approach for large payloads, but <code>callDataFileId</code> remains supported for oversized payloads or legacy workflows.</em></td></tr><tr><td><strong>Max Allowance</strong></td><td><p>The maximum amount of HBAR (specified in <strong>tinybars</strong>) the payer is willing to cover for the gas consumed during transaction execution. This value acts as a ceiling if the actual gas cost (determined by <code>gasLimit</code> in the RLP-encoded transaction and the network's gas price) exceeds this amount, the transaction fails.<br></p><p>Ordinarily, the account with the ECDSA alias extracted from the <code>ethereumData</code> signature covers the execution fees. If insufficient fees are authorized by that account, the payer can be charged up to but not exceeding <code>maxGasAllowance</code>. If the authorized fee is zero, the payer is charged the full amount.</p></td></tr></tbody></table>

## Handling Large callData Payloads

[**HIP-1086**](https://hips.hedera.com/hip/hip-1086) introduced support for **jumbo Ethereum transactions**, allowing `ethereumData` to directly include `callData` up to **24KB** for contract creation and **128KB** for contract calls. This removes the need to use `callDataFileId` for many large payloads. The rest of the protobuf wrapper (signatures, node account ID, etc.) must still fit within **2KB**.

#### Gas Calculation for callData

The gas cost for the `callData` in jumbo EthereumTransaction is calculated as:

```
callData gas = 4 × zero bytes + 16 × non-zero bytes
```

This is added to base gas and execution gas. Developers must ensure both `gasLimit` (in the RLP-encoded transaction) and `maxGasAllowance` (in the wrapper) are set high enough.

_📣 For detailed gas and fee calculation, refer to the_ [_Gas and Fees page_](../../../core-concepts/smart-contracts/gas-and-fees.md#gas-for-jumbo-transactions)_._&#x20;

#### **Quick reference: Jumbo vs Standard Transactions**

{% include "../../../.gitbook/includes/jumbo-vs-standard-ethereum-transaction-table.md" %}

📣 _See_ [_HIP-1086_](https://hips.hedera.com/hip/hip-1086) _and the_ [_Gas and Fees page_](../../../core-concepts/smart-contracts/gas-and-fees.md#gas-schedule-and-fee-calculation) _for complete technical details._

***

## **Transaction Signing Requirements**

The transaction must be signed by the key of the **fee-paying account**. For `EthereumTransaction`, this is:

* The account with the **ECDSA alias** derived from the public key in `ethereumData`, if sufficient gas and fees are authorized.
* If the authorized fee from the Ethereum sender is **insufficient**, the payer of the transaction is charged up to the **`maxGasAllowance`**.
* For jumbo transactions, ensure the payer’s key is included and `maxGasAllowance` is set high enough to cover potential gas and fees.

## **Transaction Fees**

The total transaction cost includes:

* Base transaction fee
* Gas for `callData`, (calculated as: `4 × zero bytes + 16 × non-zero bytes`)
* Execution gas determined by EVM smart contract logic

_📣 See the_ [_transaction and query fees table_](../../../networks/mainnet/fees/#transaction-and-query-fees) _and the smart contracts_ [_gas and fees page_](../../../core-concepts/smart-contracts/gas-and-fees.md) _for details._

| Method                                          | Type     |
| ----------------------------------------------- | -------- |
| `setEthereumData(<ethereumData>)`               | byte \[] |
| `setCallDataFileId(<fileId>)`                   | FileID   |
| `setMaxGasAllowanceHbar(<maxGasAllowanceHbar>)` | Hbar     |

{% tabs %}
{% tab title="Java" %}
```java
//Create the transaction
EthereumTransaction transaction = new EthereumTransaction()
     .setEthereumData(ethereumData)
     .setMaxGasAllowanceHbar(allowance);

//Sign with the client operator private key to pay for the transaction and submit the query to a Hedera network
TransactionResponse txResponse = transaction.execute(client);

//Request the receipt of the transaction
TransactionReceipt receipt = txResponse.getReceipt(client);

//Get the transaction consensus status
Status transactionStatus = receipt.status;

System.out.println("The transaction consensus status is " +transactionStatus);

//v2.14
```
{% endtab %}

{% tab title="JavaScript" %}
```javascript
//Create the transaction
const transaction = new EthereumTransaction()
     .setEthereumData(ethereumData)
     .setMaxGasAllowance(allowance);

//Sign with the client operator private key to pay for the transaction and submit the query to a Hedera network
const txResponse = await transaction.execute(client);

//Request the receipt of the transaction
const receipt = await txResponse.getReceipt(client);

//Get the transaction consensus status
const transactionStatus = receipt.status;

console.log("The transaction consensus status is " +transactionStatus);

//v2.14
```
{% endtab %}

{% tab title="Go" %}
```go
//Create the transaction
transaction, err := hedera.NewEthereumTransaction().
     SetEthereumData(ethereumData)
     SetGasAllowed(allowance)

//Sign with the client operator private key to pay for the transaction and submit the query to a Hedera network
txResponse, err := transaction.Execute(client)
if err != nil {
	panic(err)
}

//Request the receipt of the transaction
receipt, err := txResponse.GetReceipt(client)
if err != nil {the 
	panic(err)
}

//Get the transaction consensus status
transactionStatus := receipt.Status

fmt.Printf("The transaction consensus status %v\n", transactionStatus)

//v2.14
```
{% endtab %}
{% endtabs %}
