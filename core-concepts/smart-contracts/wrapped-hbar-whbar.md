# Wrapped HBAR (WHBAR)

## WHBAR (ERC) in the Hedera Ecosystem

Wrapped HBAR (WHAR) is an ERC-compatible wrapper that follows the ERC20 standard for Hedera's native HBAR token. Built on widely adopted wrapper contract principles, WHBAR makes it easier for developers and users to integrate Hedera’s native token into decentralized applications (dApps). This contract enables users to seamlessly convert HBAR into an ERC20 token and vice versa, making it easier to integrate with the broader web3 and DeFi ecosystems.

***

## Core Functionalities

*   **Deposit & Mint:**

    When you call the `deposit()` function and send HBAR, the contract mints an equivalent amount of WHBAR. Each unit of HBAR (represented in tinybars with 8 decimals) is matched with one unit of WHBAR. This ensures that the wrapped token maintains parity with the native token.
*   **Withdraw & Burn:**

    To redeem your underlying HBAR, you call the `withdraw(amount)` function. The contract burns the specified WHBAR tokens and releases the corresponding HBAR back to your wallet. This burn mechanism is crucial for maintaining the correct token supply and preserving the peg between HBAR and WHBAR.
*   **ERC20 Standard Compliance:**

    WHBAR implements all standard ERC20 functions (e.g., `transfer`, `approve`, `transferFrom`), ensuring seamless interaction with wallets, exchanges, and various DeFi protocols that support ERC20 tokens.

<figure><img src="../../.gitbook/assets/unwrapping-hbar-mermaid.png" alt=""><figcaption><p>HBAR wrapping/unwrapping flow from user wallet</p></figcaption></figure>

***

## Implementation Guide

Developers can integrate WHBAR into their applications by leveraging the following functions.&#x20;

### Wrapping HBAR

To convert HBAR into its ERC20 representation (WHBAR), use the `deposit()` function. Keep in mind that:

* **Native HBAR:** Uses **8** decimal places (**tinybars**).
* **WHBAR (ERC20):** Uses **8** decimal places (**tinybars**)and _ONLY for deposits_ (wrapping) uses 18 decimal places (weibars).

The conversion from HBAR to WHBAR involves adjusting for these decimal differences. For example, to wrap native HBAR into WHBAR, call `deposit()` and send your HBAR as `msg.value` in weibars (10¹⁸ per HBAR):

{% code overflow="wrap" %}
```solidity
/**
 * @notice Deposits HBAR and mints an equivalent amount of WHBAR
 * @dev This is the only supported method for obtaining WHBAR
 */
function deposit() public payable {
    // To wrap 10 HBAR into WHBAR
    // Note: 1 HBAR = 10^18 weibars; conversion handles the decimal difference.
    whbarContract.deposit{value: 10 * 10**18}();
}
```
{% endcode %}

### Unwrapping WHBAR

When you want to convert back to redeem WHBAR for native HBAR, call the `withdraw()` function with `amount` in **tinybars** (10⁸ per HBAR). The value in WHBAR is directly mapped back to HBAR with the same 8 decimal places:

{% code overflow="wrap" %}
```solidity
/**
 * @notice Burns WHBAR tokens and returns the equivalent HBAR
 * @param amount The amount of WHBAR to burn
 */
function withdraw(uint256 amount) public {
    // To unwrap 5 WHBAR back to HBAR
    whbarContract.withdraw(5 * 10**8);
}
```
{% endcode %}

This burns 5 WHBAR and sends back 5 HBAR to the wallet.

{% hint style="success" %}
#### **Important Note: Decimal Nuance**

When depositing HBAR, remember the conversion nuances between decimal places.

* **Native HBAR & WHBAR Token:** 8 decimals (tinybars).&#x20;
* **RPC `msg.value`:** 18 decimals (weibars).&#x20;

Although the `deposit()` function requires input in 18 decimal weibars, WHBAR tokens and all related transfers and balances use 8 decimals, identical to native HBAR in tinybars.
{% endhint %}

***

## Standard ERC20 Functions

WHBAR supports all standard ERC20 operations:

<table><thead><tr><th width="145.08203125">Function</th><th width="205.3828125">Description</th><th>Example</th></tr></thead><tbody><tr><td><code>transfer</code></td><td>Send WHBAR directly to another address</td><td><code>whbar.transfer(recipient, amount)</code></td></tr><tr><td><code>approve</code></td><td>Authorize a third party to spend your WHBAR</td><td><code>whbar.approve(spender, amount)</code></td></tr><tr><td><code>transferFrom</code></td><td>Transfer WHBAR as an authorized spender</td><td><code>whbar.transferFrom(owner, recipient, amount)</code></td></tr><tr><td><code>balanceOf</code></td><td>Check WHBAR balance of an address</td><td><code>whbar.balanceOf(address)</code></td></tr><tr><td><code>totalSupply</code></td><td>Get the total amount of WHBAR in circulation</td><td><code>whbar.totalSupply()</code></td></tr></tbody></table>

***

## Contract Deployments

The WHBAR contract implementation is available on GitHub in the [Hedera Smart Contracts repository](https://github.com/hashgraph/hedera-smart-contracts/blob/main/contracts/wrapped-tokens/WHBAR.sol).

<table><thead><tr><th width="173.6015625">Network</th><th width="146.49609375">Contract ID</th><th>EVM Address</th></tr></thead><tbody><tr><td><strong>✅ Hedera Mainnet</strong></td><td><a href="https://hashscan.io/mainnet/contract/0.0.8840785">0.0.8840785</a></td><td>0xb1F616b8134F602c3Bb465fB5b5e6565cCAd37Ed</td></tr><tr><td><strong>✅ Hedera Testnet</strong></td><td><a href="https://hashscan.io/testnet/contract/0.0.5816542?pa=1&#x26;pr=1&#x26;ps=1&#x26;pf=1">0.0.5816542</a></td><td>0xb1F616b8134F602c3Bb465fB5b5e6565cCAd37Ed</td></tr><tr><td>🔜 <strong>Other Networks</strong></td><td>Coming soon</td><td>Coming soon</td></tr></tbody></table>

_**Source Code:**_ [_WHBAR.sol_](https://github.com/hashgraph/hedera-smart-contracts/blob/main/contracts/wrapped-tokens/WHBAR.sol)

***

## **Security Considerations:&#x20;**_**Audit and Testing**_

* **Audit and Review:**\
  Although the WHBAR contract has been independently reviewed, developers and users should conduct their own security assessments. Even small oversights in smart contracts may lead to vulnerabilities.
* **Test in a Sandbox:**\
  Always test interactions in a testnet environment before deploying or integrating with mainnet contracts. This helps ensure the behavior matches expectations.
* **Follow Best Practices:**\
  Double-check function inputs and transaction amounts. Always use the designated functions (`deposit()` and `withdraw()`) to prevent unintended fund loss.

***

## Integration Best Practices

* **Check allowances**: Before attempting `transferFrom` operations, verify that sufficient allowance has been granted.
* **Verify contract addresses**: Always double-check you're interacting with the official WHBAR contract addresses listed in the documentation.
* **Handle decimals properly**: Since both HBAR and WHBAR use 8 decimals, calculations are straightforward. Only for deposits, use 18 decimals to represent weibars.

{% hint style="danger" %}
**Critical**: HBAR sent directly to the contract address through methods other than the **`deposit()`** function will be permanently locked in the contract due to Hedera’s CryptoTransfer mechanics.
{% endhint %}
