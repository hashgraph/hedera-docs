# HTS x EVM - Part 3: How to Pause, Freeze, Wipe, and Delete NFTs

In [HTS x EVM - Part 2](hts-x-evm-part-2-kyc-and-update.md), you learned how to grant / revoke KYC and manage a token using the [Hedera Token Service (HTS) System Smart Contract](../../../core-concepts/smart-contracts/system-smart-contracts/#hedera-token-service). But those aren't all the token operations you can do!

In this guide, you will learn how to:

* **Pause** a token (stop all operations)
* **Freeze** a token for a specific account
* **Wipe** NFTs from a specific account
* **Delete** a token

***

## Prerequisites

* ECDSA account from the [Hedera Portal](https://portal.hedera.com/).
* Basic understanding of Solidity.

***

## Table of Contents <a href="#table-of-contents" id="table-of-contents"></a>

1. [Project Setup](hts-x-evm-part-3-how-to-pause-freeze-wipe-and-delete-nfts.md#step-1-project-setup)
2. [Creating, minting, and transferring an NFT](hts-x-evm-part-3-how-to-pause-freeze-wipe-and-delete-nfts.md#step-2.-creating-minting-and-transferring-an-nft)
3. [Pause a Token](hts-x-evm-part-3-how-to-pause-freeze-wipe-and-delete-nfts.md#step-3.-pause-a-token)
4. [Unpause a Token](hts-x-evm-part-3-how-to-pause-freeze-wipe-and-delete-nfts.md#step-4.-unpause-a-token)
5. [Freeze a Token for a Specific Account](hts-x-evm-part-3-how-to-pause-freeze-wipe-and-delete-nfts.md#step-5.-freeze-a-token-for-a-specific-account)
6. [Unfreeze a Token for a Specific Account](hts-x-evm-part-3-how-to-pause-freeze-wipe-and-delete-nfts.md#step-6.-unfreeze-a-token-for-a-specific-account)
7. [Wipe a Token](hts-x-evm-part-3-how-to-pause-freeze-wipe-and-delete-nfts.md#step-7.-wipe-a-token)
8. [Delete a Token](hts-x-evm-part-3-how-to-pause-freeze-wipe-and-delete-nfts.md#step-8.-delete-a-token)
9. [Conclusion](hts-x-evm-part-3-how-to-pause-freeze-wipe-and-delete-nfts.md#conclusion)
10. [Additional Resources](hts-x-evm-part-3-how-to-pause-freeze-wipe-and-delete-nfts.md#additional-resources)

***

## Step 1: Project Setup

1. Clone the repository

```bash
git clone https://github.com/hedera-dev/hts-evm-hybrid-mint-nfts.git
cd hts-evm-hybrid-mint-nfts
```

2. Install dependencies

```bash
npm install
```

3. Create `.env` file set up environment variables

```bash
cp .env.example .env
```

Edit the `.env` file to include your Hedera Testnet account's private key. **Use your ECDSA Hex Encoded Private Key** when interacting with Hedera's EVM via the JSON-RPC relay.

```
PRIVATE_KEY=0x
```

{% hint style="info" %}
Make sure to use an ECDSA account with [Unlimited Auto-Associations](../../../core-concepts/accounts/account-properties.md#maximum-auto-associations) for the test script to run successfully.
{% endhint %}

4. Run the test script

```bash
npx hardhat test test/3-PauseFreezeWipeDelete.ts
```

This script deploys and tests all of the functionality inside of the `PauseFreezeWipeDelete` Smart Contract. We'll deep dive into the Smart Contract's functions and corresponding tests below!

***

## Step 2. Creating, minting, and transferring an NFT

These steps of the flow have been covered in the [Part 1](hts-x-evm-part-1-how-to-mint-nfts.md#id-2.-minting-an-nft) and [Part 2](hts-x-evm-part-2-kyc-and-update.md). The only difference here is that we set a few different keys to handle pausing, freezing, and wiping.

Check out those tutorials for specific details or the `contracts/3-PauseFreezeWipeDelete.ts` to see the code for adding the new keys.

***

## Step 3. Pause a Token

#### **Function:** `pauseToken()`

**Purpose:** Stops **all** operations (e.g., mint, transfer, burn, etc.) for the token, across every account.

#### **Key Code Snippet:**

{% code title="contracts/3-PauseFreezeWipeDelete.sol" overflow="wrap" %}
```solidity
function pauseToken() external onlyOwner {
    require(tokenAddress != address(0), "Token not created yet");
    int response = pauseToken(tokenAddress);
    require(response == HederaResponseCodes.SUCCESS, "Failed to pause token");
    emit TokenPaused();
}
```
{% endcode %}

#### **Test Implementation:**

{% code title="test/3-PauseFreezeWipeDelete.ts" %}
```typescript
it("should pause the token", async () => {
    const pauseTx = await nftContract.pauseToken({
        gasLimit: 350_000
    });

    await expect(pauseTx)
        .to.emit(nftContract, "TokenPaused");

    // Try to transfer while paused - should fail
    const serialNumber = 2n;
    await expect(
        nftContract.transferNFT(owner.address, serialNumber)
    ).to.be.reverted;
});
```
{% endcode %}

After pausing, we attempt a transfer. The test expects a revert (the transfer fails) because the token is paused.

***

## Step 4. Unpause a Token

#### **Function:** `unpauseToken()`

**Purpose:** Reenables actions to be performed on and with the token

#### **Key Code Snippet:**

{% code title="contracts/3-PauseFreezeWipeDelete.sol" overflow="wrap" %}
```solidity
function unpauseToken() external onlyOwner {
    require(tokenAddress != address(0), "Token not created yet");
    int response = unpauseToken(tokenAddress);
    require(response == HederaResponseCodes.SUCCESS, "Failed to unpause token");
    emit TokenUnpaused();
}
```
{% endcode %}

#### **Test Implementation:**

{% code title="test/3-PauseFreezeWipeDelete.ts" overflow="wrap" %}
```typescript
it("should unpause the token", async () => {
    const unpauseTx = await nftContract.unpauseToken({
        gasLimit: 350_000
    });

    await expect(unpauseTx)
        .to.emit(nftContract, "TokenUnpaused");

    // Transfer should work now
    const serialNumber = 2n;
    const transferTx = await nftContract.transferNFT(owner.address, serialNumber);
    await expect(transferTx)
        .to.emit(nftContract, "NFTTransferred")
        .withArgs(owner.address, serialNumber);
});
```
{% endcode %}

We confirm that normal token operations (e.g., transfers) resume after the `unpause`.

***

## Step 5. Freeze a Token for a Specific Account

#### **Function:** `freezeAccount(address account)`

**Purpose:** Freezes a specific account, meaning it can neither send nor receive the token. Freezing is more granular than pausing; it only affects a specific account. This is useful for making soul-bound tokens.

#### **Key Code Snippet:**

{% code title="contracts/3-PauseFreezeWipeDelete.sol" overflow="wrap" %}
```solidity
function freezeAccount(address account) external onlyOwner {
    require(tokenAddress != address(0), "Token not created yet");
    int response = freezeToken(tokenAddress, account);
    require(response == HederaResponseCodes.SUCCESS, "Failed to freeze account");
    emit AccountFrozen(account);
}
```
{% endcode %}

#### **Test Implementation:**

{% code title="test/3-PauseFreezeWipeDelete.ts" %}
```typescript
it("should freeze owner", async () => {
    const freezeTx = await nftContract.freezeAccount(owner.address, {
        gasLimit: 350_000
    });

    await expect(freezeTx)
        .to.emit(nftContract, "AccountFrozen")
        .withArgs(owner.address);

    // Try to transfer to frozen account - should fail
    const serialNumber = 3n;
    await expect(
        nftContract.transferNFT(owner.address, serialNumber)
    ).to.be.reverted;
});
```
{% endcode %}

* We freeze the `owner` account.
* The test ensures that transferring an NFT to or from this frozen account reverts.

***

## Step 6. Unfreeze a Token for a Specific Account

#### **Function:** `unfreezeAccount(address account)`

**Purpose:** Unfreezes the token for a specific account.

#### **Key Code Snippet:**

{% code title="contracts/3-PauseFreezeWipeDelete.sol" overflow="wrap" %}
```solidity
function unfreezeAccount(address account) external onlyOwner {
    require(tokenAddress != address(0), "Token not created yet");
    int response = unfreezeToken(tokenAddress, account);
    require(response == HederaResponseCodes.SUCCESS, "Failed to unfreeze account");
    emit AccountUnfrozen(account);
}
```
{% endcode %}

**Test Implementation:**

{% code title="test/3-PauseFreezeWipeDelete.ts" overflow="wrap" %}
```typescript
it("should unfreeze owner", async () => {
    const unfreezeTx = await nftContract.unfreezeAccount(owner.address, {
        gasLimit: 350_000
    });

    await expect(unfreezeTx)
        .to.emit(nftContract, "AccountUnfrozen")
        .withArgs(owner.address);
});
```
{% endcode %}

After unfreezing, the `owner` account can transact freely again.

***

## Step 7. Wipe a Token

#### **Function:** `wipeTokenFromAccount(address account, int64[] serialNumbers)`

**Purpose:** Wiping effectively burns that token (i.e., reduces the total supply) from a non-treasury account.

For [**fungible tokens**](../../../support-and-community/glossary.md#fungible-token), specify an amount to wipe; for [**non-fungible tokens (NFTs)**](../../../support-and-community/glossary.md#non-fungible-token-nft), we specify the serial numbers to be wiped.

#### **Key Code Snippet:**

{% code title="contracts/3-PauseFreezeWipeDelete.sol" %}
```solidity
function wipeTokenFromAccount(
    address account,
    int64[] memory serialNumbers
) external onlyOwner {
    require(tokenAddress != address(0), "Token not created yet");
    int response = wipeTokenAccountNFT(tokenAddress, account, serialNumbers);
    require(response == HederaResponseCodes.SUCCESS, "Failed to wipe token");
    emit TokenWiped(account, serialNumbers);
}
```
{% endcode %}

#### **Test Implementation:**

{% code title="test/3-PauseFreezeWipeDelete.ts" %}
```typescript
it("should wipe NFT from owner", async () => {
    const serialNumbers = [1n];
    const wipeTx = await nftContract.wipeTokenFromAccount(
        owner.address,
        serialNumbers,
        {
            gasLimit: 350_000
        }
    );

    await expect(wipeTx)
        .to.emit(nftContract, "TokenWiped")
        .withArgs(owner.address, serialNumbers);
});
```
{% endcode %}

We specify which serial numbers we want to wipe. The test confirms the `TokenWiped` event is emitted upon success.

***

## Step 8. Delete a Token

#### **Function:** `deleteToken()`

**Purpose:** Renders a token completely unusable for future operations. The token still exists on the ledger (you can query it), but all transactions (e.g., minting, transfers, etc.) will fail. The **ADMIN** key is required to delete.

#### **Key Code Snippet**:

{% code title="contracts/3-PauseFreezeWipeDelete.sol" %}
```solidity
deleteToken() external onlyOwner {
    require(tokenAddress != address(0), "Token not created yet");
    int response = deleteToken(tokenAddress);
    require(response == HederaResponseCodes.SUCCESS, "Failed to delete token");
    emit TokenDeleted();
}
```
{% endcode %}

**Test Implementation:**

{% code title="test/3-PauseFreezeWipeDelete.ts" %}
```typescript
it("should delete the token", async () => {
    const deleteTx = await nftContract.deleteToken({
        gasLimit: 350_000
    });

    await expect(deleteTx)
        .to.emit(nftContract, "TokenDeleted");

    // Try to mint after deletion - should fail
    const metadata = [ethers.toUtf8Bytes("ipfs://metadata3")];
    await expect(
        nftContract.mintNFT(metadata)
    ).to.be.reverted;
});
```
{% endcode %}

Once deleted, attempting further operations like minting will fail.

***

## Conclusion

In this guide, you saw how to replicate key HTS operations (pause, freeze, wipe, delete) **directly in a Solidity contract** by calling the HTS System Contract functions on Hedera. This approach provides fine-grained control via the contract’s ownership and key management, which is especially useful if you need all relevant HTS functionality in a single deployable smart contract.

**Key Takeaways:**

* If you want to perform the respective operations later, you must set the **ADMIN**, **FREEZE**, **PAUSE**, **WIPE**, and **SUPPLY** keys when creating a token via a contract.
* Any account that needs to receive or send the token must be associated with it.
* Pausing affects **all** operations globally while freezing targets a **single** account.
* Wiping NFTs effectively burns them, reducing total supply.
* Deleting a token makes it unusable for future operations but remains queryable on the ledger.

***

## Additional Resources

Check out our GitHub repo to find the full contract and Hardhat test scripts, along with the configuration files you need to deploy and test on Hedera!

* [Full Contract and Hardhat Test Scripts Repository](https://github.com/hedera-dev/hts-evm-hybrid-mint-nfts)

<table data-card-size="large" data-view="cards"><thead><tr><th align="center"></th><th data-hidden data-card-target data-type="content-ref"></th></tr></thead><tbody><tr><td align="center"><p>Writer: Jake, Developer Relations Engineer</p><p><a href="https://github.com/jaycoolh">GitHub</a> | <a href="https://x.com/jaycoolh">X</a></p></td><td><a href="https://github.com/jaycoolh">https://github.com/jaycoolh</a></td></tr><tr><td align="center"><p>Editor: Michiel, Developer Relations Engineer</p><p><a href="https://github.com/michielmulders">GitHub</a> | <a href="https://www.linkedin.com/in/michielmulders/">LinkedIn</a></p></td><td><a href="https://www.linkedin.com/in/michielmulders/">https://www.linkedin.com/in/michielmulders/</a></td></tr><tr><td align="center"><p>Editor: Krystal, Technical Writer</p><p><a href="https://github.com/theekrystallee">GitHub</a> | <a href="https://x.com/theekrystallee">X</a></p></td><td><a href="https://x.com/theekrystallee">https://x.com/theekrystallee</a></td></tr></tbody></table>
