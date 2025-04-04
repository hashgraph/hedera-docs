# HTS x EVM - Part 2: KYC & Update

In [Part 1](hts-x-evm-part-1-how-to-mint-nfts.md) of the series, you saw how to mint, transfer, and burn an NFT using Hedera'a EVM and [Hedera Token Service (HTS) System Smart Contracts](../../core-concepts/smart-contracts/system-smart-contracts/). In this guide, you’ll learn the basics of how to configure / permission native Hedera Tokens via a Smart Contract. Specifically, you will learn how to:

* **Create** and **configure** an NFT.
* **Grant** and **revoke** a Know Your Customer (KYC) flag.
* **Update** the KYC key with an Admin (to rotate compliance keys, for example)

***

## Prerequisites

* ECDSA account from the [Hedera Portal](https://portal.hedera.com/).
* Basic understanding of Solidity.

***

## Table of Contents <a href="#table-of-contents" id="table-of-contents"></a>

1. [Project Setup](hts-x-evm-part-2-kyc-and-update.md#step-1-project-setup)
2. [Creating an NFT](hts-x-evm-part-2-kyc-and-update.md#step-2.-creating-an-nft)
3. [Minting an NFT](hts-x-evm-part-2-kyc-and-update.md#step-3.-minting-an-nft)
4. [Granting KYC](hts-x-evm-part-2-kyc-and-update.md#step-4.-granting-kyc)
5. [Revoking KYC](hts-x-evm-part-2-kyc-and-update.md#step-5.-revoking-kyc)
6. [Transferring NFTs and Enforcing KYC](hts-x-evm-part-2-kyc-and-update.md#step-6.-transferring-nfts-and-enforcing-kyc)
7. [Updating the KYC Key](hts-x-evm-part-2-kyc-and-update.md#step-7.-updating-the-kyc-key)
8. [Conclusion](hts-x-evm-part-2-kyc-and-update.md#conclusion)
9. [Additional Resources](hts-x-evm-part-2-kyc-and-update.md#additional-resources)

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
Make sure to use an ECDSA account with [Unlimited Auto-Associations](../../core-concepts/accounts/account-properties.md#maximum-auto-associations) for the test script to run successfully.
{% endhint %}

4. Run the test script

```bash
npx hardhat test test/2-KYCandUpdateNFT.ts
```

This script deploys and tests all of the functionality inside the `KYCandUpdateNFT` Smart Contract. We'll deep dive into the Smart Contract's functions and corresponding tests below!

***

## Step 2. Creating an NFT

#### **Function:** `createNFT(string memory name, string memory symbol, string memory memo)`

**Purpose:** Deploy an HTS non-fungible token (NFT) via a Solidity contract call to `HederaTokenService.createNonFungibleToken`.&#x20;

#### **Key Code Snippet:**

{% code title="contracts/2-KYCandUpdateNFT.sol" overflow="wrap" %}
```solidity
function createNFT(
    string memory name,
    string memory symbol,
    string memory memo
) external payable onlyOwner {
    IHederaTokenService.HederaToken memory token;
    token.name = name;
    token.symbol = symbol;
    token.memo = memo;
    token.treasury = address(this);

    // 3 keys: Admin, Supply, KYC
    IHederaTokenService.TokenKey[] memory keys = new IHederaTokenService.TokenKey[](3);
    keys[0] = getSingleKey(KeyType.ADMIN, KeyValueType.CONTRACT_ID, address(this));
    keys[1] = getSingleKey(KeyType.SUPPLY, KeyValueType.CONTRACT_ID, address(this));
    keys[2] = getSingleKey(KeyType.KYC, KeyValueType.CONTRACT_ID, address(this));

    token.tokenKeys = keys;

    (int responseCode, address createdToken) = createNonFungibleToken(token);
    require(responseCode == HederaResponseCodes.SUCCESS, "Failed to create NFT");

    tokenAddress = createdToken;
    emit NFTCreated(createdToken);
}
```
{% endcode %}

{% hint style="info" %}
#### **How It Works**

1. **Define Token Details** – Provide `name`, `symbol`, and an optional `memo`.
2. **Set Keys** – We generate three token keys:
   * **AdminKey**: Grants permission to update token-level properties later.
   * **SupplyKey**: Permits minting and burning of tokens.
   * **KYCKey**: Allows the contract (acting as the KYC authority) to grant or revoke KYC on specific accounts.
3. **Create the NFT** – Call the HTS System Contract's `createNonFungibleToken` function from within the contract. If successful, store the resulting HTS token address in `tokenAddress`.
{% endhint %}

#### **Test Implementation:**

{% code title="test/2-KYCandUpdateNFT.ts" %}
```typescript
it("should create an NFT", async () => {
    const createTx = await kycNftContract.createNFT(
        "KYC Test NFT",
        "KYCNFT",
        "NFT with KYC",
        {
            gasLimit: 250_000,
            value: ethers.parseEther("7") // sending HBAR needed to pay for tx fee
        }
    );

    await expect(createTx)
        .to.emit(kycNftContract, "NFTCreated")
        .withArgs(ethers.isAddress);
});
```
{% endcode %}

We call `createNFT(...)` and expect it to emit an `NFTCreated` event with a valid token address.

***

## Step 3. Minting an NFT

The [previous tutorial](hts-x-evm-part-1-how-to-mint-nfts.md#id-2.-minting-an-nft) covered minting NFTs. Nothing's changed, but if you want a deep dive into how it's done, check it out there!

{% content-ref url="hts-x-evm-part-1-how-to-mint-nfts.md" %}
[hts-x-evm-part-1-how-to-mint-nfts.md](hts-x-evm-part-1-how-to-mint-nfts.md)
{% endcontent-ref %}

***

## Step 4. Granting KYC

#### **Function:** `grantKYC(address account)`

**Purpose:** Enable KYC for a specific account. If a token is configured to enforce KYC, that account must be “granted” KYC before it can receive or send the token.

#### **Key Code Snippet:**

{% code title="test/2-KYCandUpdateNFT.ts" overflow="wrap" %}
```solidity
grantKYC(address account) external {
    require(tokenAddress != address(0), "Token not created yet");
    int response = grantTokenKyc(tokenAddress, account);
    require(response == HederaResponseCodes.SUCCESS, "Failed to grant KYC");
    emit KYCGranted(account);
}
```
{% endcode %}

#### **Test Implementation:**

{% code title="test/2-KYCandUpdateNFT.ts" %}
```typescript
it("should grant KYC to account1", async () => {
    const grantKycTx = await kycNftContract.grantKYC(account1.address, {
        gasLimit: 350_000
    });

    await expect(grantKycTx)
        .to.emit(kycNftContract, "KYCGranted")
        .withArgs(account1.address);
});
```
{% endcode %}

{% hint style="warning" %}
Without this step, the account won’t be able to receive or transact the NFT.
{% endhint %}

***

## Step 5. Revoking KYC

#### **Function:** `revokeKYC(address account)`

**Purpose:** Disable KYC for a specific account. After revocation, that account can no longer receive or transfer the token.

#### **Key Code Snippet:**

{% code title="test/2-KYCandUpdateNFT.ts" overflow="wrap" %}
```solidity
function revokeKYC(address account) external {
    require(tokenAddress != address(0), "Token not created yet");
    int response = revokeTokenKyc(tokenAddress, account);
    require(response == HederaResponseCodes.SUCCESS, "Failed to revoke KYC");
    emit KYCRevoked(account);
}
```
{% endcode %}

#### **Test Implementation:**

{% code title="test/2-KYCandUpdateNFT.ts" %}
```typescript
it("should revoke KYC from account1 (example)", async () => {
    const revokeTx = await kycNftContract.revokeKYC(account1.address, {
        gasLimit: 350_000
    });

    await expect(revokeTx)
        .to.emit(kycNftContract, "KYCRevoked")
        .withArgs(account1.address);
});
```
{% endcode %}

***

## Step 6. Transferring NFTs and Enforcing KYC

**Function:** `transferNFT(address receiver, uint256 serialNumber)`

**Purpose:** Transfer an NFT from the treasury (`address(this)`) to another account. The receiving account must have KYC because this token has a KYC key.&#x20;

#### **Key Code Snippet:**

{% code title="test/2-KYCandUpdateNFT.ts" overflow="wrap" %}
```solidity
function transferNFT(address receiver, uint256 serialNumber) external {
    require(tokenAddress != address(0), "Token not created yet");
    IERC721(tokenAddress).transferFrom(address(this), receiver, serialNumber);
    emit NFTTransferred(receiver, serialNumber);
}
```
{% endcode %}

#### **Test Implementation:**

{% code title="test/2-KYCandUpdateNFT.ts" %}
```typescript
it("should fail to transfer NFT to account without KYC", async () => {
    const serialNumber = 1n; // First minted NFT

    await expect(
        kycNftContract.transferNFT(account1.address, serialNumber, {
            gasLimit: 350_000
        })
    ).to.be.reverted;
});

it("should successfully transfer NFT to account with KYC", async () => {
    const serialNumber = 1n;

    // first, grant KYC
    const grantKycTx = await kycNftContract.grantKYC(account1.address);
    await grantKycTx.wait();

    // then transfer
    const transferTx = await kycNftContract.transferNFT(account1.address, serialNumber);
    await expect(transferTx)
        .to.emit(kycNftContract, "NFTTransferred")
        .withArgs(account1.address, serialNumber);

    // Verify ownership
    const tokenAddress = await kycNftContract.getTokenAddress();
    const nftContract = await ethers.getContractAt("IERC721", tokenAddress);
    expect(await nftContract.ownerOf(serialNumber)).to.equal(account1.address);
});
```
{% endcode %}

The first test expects the transfer to fail when KYC hasn’t been granted.

The second test demonstrates a successful transfer once `grantKYC(...)` has been called.

***

## Step 7. Updating the KYC Key

**Function:** `updateKYCKey(bytes memory newKYCKey)`

**Purpose:** Change the KYC key on the token. This could be a “key rotation” to maintain compliance or to assign another entity control over KYC status.

#### **Key Code Snippet:**

{% code title="" overflow="wrap" %}
```solidity
function updateKYCKey(bytes memory newKYCKey) external onlyOwner {
    require(tokenAddress != address(0), "Token not created yet");

    // Create a new TokenKey array with just the KYC key
    IHederaTokenService.TokenKey[] memory keys = new IHederaTokenService.TokenKey[](1);
    keys[0] = getSingleKey(KeyType.KYC, KeyValueType.SECP256K1, newKYCKey);

    int responseCode = updateTokenKeys(tokenAddress, keys);
    require(responseCode == HederaResponseCodes.SUCCESS, "Failed to update KYC key");

    emit KYCKeyUpdated(newKYCKey);
}
```
{% endcode %}

#### **Test Implementation:**

{% code title="test/2-KYCandUpdateNFT.ts" overflow="wrap" %}
```typescript
it("should successfully update KYC key to account1", async () => {
    const account1CompressedPublicKey = getSignerCompressedPublicKey(0);
    const updateKycTx = await kycNftContract.updateKYCKey(account1CompressedPublicKey, {
        gasLimit: 350_000
    });

    await expect(updateKycTx)
        .to.emit(kycNftContract, "KYCKeyUpdated")
        .withArgs(account1CompressedPublicKey);
});

it("should fail to grant KYC to account2 after KYC key update", async () => {
    await expect(
        kycNftContract.grantKYC(account2.address, {
            gasLimit: 350_000
        })
    ).to.be.revertedWith("Failed to grant KYC");
});

function getSignerCompressedPublicKey(
    index = 0,
    asBuffer = true,
    prune0x = true
) {
    const wallet = new ethers.Wallet(config.networks[network.name].accounts[index]);
    const cpk = prune0x
        ? wallet.signingKey.compressedPublicKey.replace('0x', '')
        : wallet.signingKey.compressedPublicKey;

    return asBuffer ? Buffer.from(cpk, 'hex') : cpk;
}
```
{% endcode %}

{% hint style="info" %}
The `compressedPublicKey` , **not** the EVM address, must be passed as the address argument for the `updateKeys`function to work. The `getSignerCompressedPublicKey` utility function shows how you can get the compressed key using hardat and ethers.
{% endhint %}

After this key rotation, the contract's key is no longer able to perform KYC operations. In the snippet above, we immediately demonstrate that KYC attempts signed by the contract itself will revert.

Account 1 will now be able to grant/revoke KYC [using the SDK](../../sdks-and-apis/sdks/token-service/enable-kyc-account-flag.md).

***

## Token Association in the Tests

Because we’re using a hybrid approach of EVM and the Native Hedera Token Service, you’ll see special logic to:

* **Associate** the newly created token with the signers’ accounts (via `TokenAssociateTransaction`).
* **Fetch** the signers’ Hedera account IDs from EVM addresses with `AccountId.fromEvmAddress(...)`.
* Use the `PrivateKey.fromStringECDSA` call to instantiate a Hedera client for executing SDK transactions.

{% code title="test/2-KYCandUpdateNFT.ts" overflow="wrap" %}
```typescript
it("should associate NFT to account 1 and 2", async () => {
    const tokenAddress = await kycNftContract.getTokenAddress();
    const client = Client.forTestnet();

    const accountId1 = await AccountId.fromEvmAddress(0, 0, account1.address).populateAccountNum(client);
    accountId1.evmAddress = null; // ensures we use the Hedera account ID for transactions
    const privateKey = PrivateKey.fromStringECDSA(process.env.PRIVATE_KEY as string);
    client.setOperator(accountId1, privateKey);

    // Repeat for account2...
    // Then call new TokenAssociateTransaction()...
});
```
{% endcode %}

This is due to a nuance: In order to grant KYC to an account, it must have the token associated with it. This is the case even if the account has unlimited auto associations.

***

## Conclusion

Using a Solidity Smart Contract on Hedera, you can replicate many of the native HTS functionalities—granting and revoking KYC, updating token keys, minting and transferring NFTs—while retaining the benefit of contract-driven logic and on-chain state. This approach may be preferable if:

* **You want advanced business logic** in a self-contained contract.
* **You prefer standard Solidity patterns** and tooling for your Web3 workflows.
* **You plan** to modularize or integrate your token behavior with other smart contracts.

Check out [Part 3: How to Pause, Freeze, Wipe, and Delete NFTs](hts-x-evm-part-3-how-to-pause-freeze-wipe-and-delete-nfts.md) to learn more about configuring Native Tokens with Smart Contracts.

{% content-ref url="hts-x-evm-part-3-how-to-pause-freeze-wipe-and-delete-nfts.md" %}
[hts-x-evm-part-3-how-to-pause-freeze-wipe-and-delete-nfts.md](hts-x-evm-part-3-how-to-pause-freeze-wipe-and-delete-nfts.md)
{% endcontent-ref %}

***

## Additional Resources

Check out our GitHub repo to find the full contract and Hardhat test scripts, along with the configuration files you need to deploy and test on Hedera!

* [Full Contract and Hardhat Test Scripts Repository](https://github.com/hedera-dev/hts-evm-hybrid-mint-nfts)

<table data-view="cards"><thead><tr><th align="center"></th><th data-hidden data-card-target data-type="content-ref"></th></tr></thead><tbody><tr><td align="center"><p>Writer: Jake, Developer Relations Engineer</p><p><a href="https://github.com/jaycoolh">GitHub</a> | <a href="https://x.com/jaycoolh">X</a></p></td><td><a href="https://github.com/jaycoolh">https://github.com/jaycoolh</a></td></tr><tr><td align="center"><p>Editor: Michiel, Developer Relations Engineer</p><p><a href="https://github.com/michielmulders">GitHub</a> | <a href="https://www.linkedin.com/in/michielmulders/">LinkedIn</a></p></td><td><a href="https://www.linkedin.com/in/michielmulders/">https://www.linkedin.com/in/michielmulders/</a></td></tr><tr><td align="center"><p>Editor: Krystal, Technical Writer</p><p><a href="https://github.com/theekrystallee">GitHub</a> | <a href="https://x.com/theekrystallee">X</a></p></td><td><a href="https://x.com/theekrystallee">https://x.com/theekrystallee</a></td></tr></tbody></table>
