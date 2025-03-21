# Token Airdrops

## Overview

Token airdrops are commonly used to distribute tokens to multiple accounts, often as a promotional or reward mechanism. Hedera introduced "frictionless" airdrops in HIP-904 that simplify token distribution by handling token associations automatically and allowing recipients to accept or reject tokens as they choose. The Hedera SDKs provide dedicated transaction types (e.g., `TokenAirdropTransaction`, `TokenClaimAirdropTransaction`, `TokenRejectTransaction`) to support these flows. Let's break down how exactly token airdrops work on Hedera below.&#x20;

***

## Token Airdrop

The `TokenAirdropTransaction` allows senders to distribute tokens to multiple recipients in a single transaction, even if the receiving accounts haven't previously associated with the token. This transaction type handles different recipient states:

* **Direct Airdrop**: If the recipient has an available auto-association slot or has pre-associated with the token, the token is transferred immediately.
* **Pending Airdrop**: If the recipient lacks an available association slot, the network creates a pending airdrop instead of failing the transaction.&#x20;

The sender pays all associated fees, including transfer costs, association fees (if auto-associating a new token), first auto-renewal period rent for any new token associations and airdrop-specific spam deterrent fee. By balancing seamless token distribution with user control, this transaction type is valuable for token issuers, marketers, and airdrop campaigns.

<figure><img src="../../../.gitbook/assets/TokenAirdropWorkflow.webp" alt=""><figcaption><p>Token Airdrop Workflow</p></figcaption></figure>

***

## Claim Airdrop

The `TokenClaimAirdropTransaction` enables recipients to claim pending airdrops that were created when a TokenAirdropTransaction couldn’t complete due to a lack of available association slots. This ensures that users have the final say in which tokens enter their accounts.

The claim transaction integrates token association and transfer to avoid additional steps. At the moment of claim, the sender's balance is verified—if insufficient, the claim doesn’t proceed. The transaction requires the recipient's signature, enhancing security. The recipient must actively claim the airdrop, ensuring that token acceptance is consent-based. Key features include streamlined processing and enhanced security through recipient consent



<figure><img src="../../../.gitbook/assets/TokenClaimWorkflow.webp" alt=""><figcaption><p>Token Claim Airdrop Workflow</p></figcaption></figure>



***

## Cancel Airdrop

The TokenCancelAirdropTransaction allows senders to manage unclaimed pending airdrops, enabling them to cancel token distributions that haven't been accepted. This feature is particularly useful when a mistake is made in the airdrop, the sender needs to reallocate tokens elsewhere, or the sender wants to reclaim tokens from inactive recipients. Although the sender incurs a small cancellation fee to prevent misuse, they can effectively remove unclaimed airdrops from the network state. Only the original sender can initiate this process, and airdrops that have already been claimed cannot be canceled

<figure><img src="../../../.gitbook/assets/TokenCancelWorkflow.webp" alt=""><figcaption><p>Token Cancel Airdrop Workflow</p></figcaption></figure>

***

## **Reject Token**&#x20;

The `TokenRejectFlow` streamlines the process of returning unwanted tokens to the token's treasury account and dissociating the account from the token, effectively preventing spam and unwanted tokens. This flow can only be initiated if the token is not frozen and the recipient's account is active (i.e., not paused) for that token. The process allows recipients to reject tokens without requiring treasury consent, and all custom fees and royalties are waived so that users aren’t penalized for rejecting a token.

The process begins when a recipient initiates a `TokenRejectTransaction` for a specific token. The network then verifies the transaction by checking the token's state and the account's eligibility. Once the request is approved, the recipient's balance for that token is updated to zero, and the tokens are transferred back to the treasury and dissociated from the account. This entire sequence is executed seamlessly with a single `execute()` call, ensuring an efficient and user-friendly experience.

<figure><img src="../../../.gitbook/assets/TokenRejectWorkflow.webp" alt=""><figcaption><p>Token Reject Airdrop Workflow</p></figcaption></figure>

***

## Token Associations

When transferring tokens on Hedera, recipients must first link (associate) it to a smart contract or account before any token transfers can occur. This is called **token association**. Without it, token transfers will fail. If a token isn’t pre-associated or lacks an auto-association slot, transfers cannot proceed.

You can associate with a token in the following ways:

* Using the Hedera SDK with a `TokenAssociationTransaction`&#x20;
* Using the `associateToken()` and `associateTokens()` as described in HIP-206.&#x20;

{% hint style="info" %}
**Note:** `Token association` is for HTS tokens only.
{% endhint %}

### Auto-Associations and Fees

Hedera introduced frictionless airdrops through HIP-904, enabling automatic token associations for recipients who haven't pre-associated, within auto-association limits. Each account has a `maxAutoAssociations` property that specifies the maximum number of allowed auto-associations. The sender covers the `maxAutoAssociations` fee and the rent for the association's first auto-renewal period, on top of the usual transfer fees. This setup ensures recipients can receive tokens without prior association, streamlining the transfer process. The properties are as follows:

<table><thead><tr><th width="162" align="center">Property Value</th><th>Description</th></tr></thead><tbody><tr><td align="center"><code>0</code></td><td>Automatic token associations or <a data-footnote-ref href="#user-content-fn-1">token airdrops</a> are not allowed, and the account must be manually associated with a token. This also applies if the value is less than or equal to <code>usedAutoAssociations</code>.</td></tr><tr><td align="center"><code>-1</code></td><td>The number of automatic token associations an account can have is unlimited. <code>-1</code> is the default value for new automatically-created accounts.</td></tr><tr><td align="center"><code>> 0</code></td><td>If the value is a positive number (number greater than 0), the number of automatic token associations an account can have is limited to that number. </td></tr></tbody></table>

This enhancement removes friction from token transfers, making it easier to onboard users and distribute tokens efficiently.

**Reference**: [HIP-904](https://hips.hedera.com/hip/hip-904)

***

## Examples

<details>

<summary><strong>Token airdrop</strong></summary>

* [Java](https://github.com/hashgraph/hedera-sdk-java/blob/main/examples/src/main/java/com/hedera/hashgraph/sdk/examples/TokenAirdropExample.java)
* [JavaScript](https://github.com/hashgraph/hedera-sdk-js/blob/main/examples/token-airdrop-example.js)
* [Go](https://github.com/hiero-ledger/hiero-sdk-go/blob/main/examples/token_airdrop/main.go)

</details>

<details>

<summary>Token reject </summary>

* [Java](https://github.com/hiero-ledger/hiero-sdk-java/blob/main/examples/src/main/java/com/hedera/hashgraph/sdk/examples/TokenRejectExample.java)
* [JavaScript](https://github.com/hiero-ledger/hiero-sdk-js/blob/main/examples/token-airdrop-example.js)
* [Go](https://github.com/hiero-ledger/hiero-sdk-go/blob/main/examples/token_airdrop/main.go)

</details>

[^1]: 
