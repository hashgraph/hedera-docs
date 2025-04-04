# HTS x EVM - Part 1: How to Mint NFTs

In [Hedera Token Service - Part 1: How to Mint NFTs](../token/hedera-token-service-part-1-how-to-mint-nfts.md), we showed how to create, mint, burn, and transfer non-fungible tokens (NFTs) on Hedera **without** deploying any smart contracts—using only the Hedera Token Service (HTS) and official SDKs.

It's possible to create a token on Hedera using a **smart contract** and still benefit from the native Hedera Token Service. However, the contract needs to interact with the [HTS System Contract](../../core-concepts/smart-contracts/system-smart-contracts/), which provides Hedera-specific token operations. By combining **HTS** and **Solidity**, you:

* Get all the performance, cost-efficiency, and security of native HTS tokens.
* Can embed custom, decentralized logic in your contract for advanced use cases.

In this tutorial, you’ll:

* **Create** an NFT collection with a royalty fee schedule.
* **Mint** new NFTs with metadata pointing to IPFS.
* **Transfer** NFTs.
* **Burn** an existing NFT.

***

## Prerequisites

* ECDSA account from the [Hedera Portal](https://portal.hedera.com/).
* Basic understanding of Solidity.

***

## Table of Contents <a href="#table-of-contents" id="table-of-contents"></a>

1. [Project Setup](hts-x-evm-part-1-how-to-mint-nfts.md#step-1-project-setup)
2. [Creating an NFT](hts-x-evm-part-1-how-to-mint-nfts.md#step-2.-creating-an-nft)
3. [Minting an NFT](hts-x-evm-part-1-how-to-mint-nfts.md#step-3.-minting-an-nft)
4. [Transferring an NFT](hts-x-evm-part-1-how-to-mint-nfts.md#step-4.-transfering-nfts)
5. [Burning an NFT](hts-x-evm-part-1-how-to-mint-nfts.md#step-5.-burning-an-nft)
6. [Conclusion](hts-x-evm-part-1-how-to-mint-nfts.md#conclusion)
7. [Additional Resources](hts-x-evm-part-1-how-to-mint-nfts.md#additional-resources)

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
npx hardhat test test/1-MintNFT.ts
```

This script deploys and tests all of the functionality inside of the `MintNFT` Smart Contract. We'll deep dive into the Smart Contract's functions and corresponding tests below!

***

## Step 2. Creating an NFT

#### **Function**: `createNFT(string memory name, string memory symbol, string memory memo)`

**Purpose**: Deploy a Hedera NFT using Solidity. This involves specifying key token details (name, symbol, and memo), as well as setting up any custom fees (such as royalty fees).

#### **Key Code Snippet**:

{% code title="contracts/1-MintNFT.sol" %}
```solidity
function createNFT(
    string memory name,
    string memory symbol,
    string memory memo
) external payable onlyOwner {
    // Create the royalty fee
    IHederaTokenService.RoyaltyFee[] memory royaltyFees =
        new IHederaTokenService.RoyaltyFee[](1);
    royaltyFees[0] = IHederaTokenService.RoyaltyFee({
        numerator: 1,
        denominator: 10,
        amount: 100000000,  // Fallback fee of 1 HBAR in tinybars (1 HBAR = 1e8 tinybars)
        tokenId: address(0),
        useHbarsForPayment: true,
        feeCollector: owner
    });

    // Create fixed fees array (empty for this example)
    IHederaTokenService.FixedFee[] memory fixedFees =
        new IHederaTokenService.FixedFee[](0);

    // Create the token definition
    IHederaTokenService.HederaToken memory token;
    token.name = name;
    token.symbol = symbol;
    token.memo = memo;
    token.treasury = address(this);

    // Set the supply key (the contract itself)
    IHederaTokenService.TokenKey[] memory keys =
        new IHederaTokenService.TokenKey[](1);
    keys[0] = getSingleKey(
        KeyType.SUPPLY,
        KeyValueType.CONTRACT_ID,
        address(this)
    );
    token.tokenKeys = keys;

    (int responseCode, address createdToken) =
        createNonFungibleTokenWithCustomFees(token, fixedFees, royaltyFees);

    require(
        responseCode == HederaResponseCodes.SUCCESS,
        "Failed to create NFT"
    );

    tokenAddress = createdToken;
    emit NFTCreated(createdToken);
}
```
{% endcode %}

{% hint style="info" %}
#### **How It Works**

1. **Prepare a Royalty Fee**:\
   We define a single royalty fee in `royaltyFees[0]` to collect 1/10th (10%) of the value exchanged in any subsequent NFT transfer. If there is no fungible value in the transfer, a **fallback fee** of 1 HBAR is charged.
2. **Build the Token Definition**:\
   The token name, symbol, memo, and treasury address are assembled into a `HederaToken` struct. Since this token is a non-fungible token, decimals default to zero.
3. **Set the Supply Key**:\
   By assigning the contract’s address (`address(this)`) as the `SUPPLY` key, only this contract can mint or burn new tokens.
4. **Create the NFT**:\
   Calling `createNonFungibleTokenWithCustomFees(...)` triggers the [HTS System Smart Contract.](../../core-concepts/smart-contracts/system-smart-contracts/#hedera-token-service) The call returns a response code and the **token address** (unique ID for the NFT class).
5. **Emit `NFTCreated`**:\
   On success, we store the `tokenAddress` for later use and emit an event for off-chain indexing or debugging.
{% endhint %}

#### Test Implementation

{% code title="" overflow="wrap" %}
```typescript
it("should create an NFT", async () => {
  // Deploy the MintNFT contract earlier, then call createNFT:
  const mintTx = await mintNftContract.createNFT("Test NFT", "TST", "Test NFT", {
    gasLimit: 250_000,
    value: ethers.parseEther("7") // HBAR needed to pay for token creation fee
  });

  await expect(mintTx)
    .to.emit(mintNftContract, "NFTCreated")
    .withArgs(ethers.isAddress);
});
```
{% endcode %}

Here, we pass `"Test NFT"`, `"TST"`, and `"Test NFT"` as arguments. We also send some HBAR (in this case, 7 HBAR) to cover the creation costs on the Hedera network. We expect the `NFTCreated` event to have a valid token address to confirm success.

{% hint style="info" %}
#### **Note**

For most HTS [System Smart Contract](../../core-concepts/smart-contracts/system-smart-contracts/) calls, an HBAR value **is not** required to be sent in the contract call; the gas fee will cover it. However, for expensive transactions, like [Create Token Transactions](../../sdks-and-apis/sdks/token-service/define-a-token.md), the gas fee is reduced, and the transaction cost is covered by the payable amount. This is to reduce the gas consumed by the contract call.
{% endhint %}

***

## Step 3. Minting an NFT

**Function**: `mintNFT(bytes[] memory metadata)`

**Purpose**:\
Add new tokens to the existing **NFT collection**. Each minted token includes a unique piece of metadata (for instance, an IPFS URI).

**Key Code Snippet**:

{% code title="contracts/1-MintNft.sol" %}
```solidity
function mintNFT(bytes[] memory metadata) external onlyOwner {
    require(tokenAddress != address(0), "Token not created yet");

    (
        int responseCode,
        int64 newTotalSupply,
        int64[] memory serialNumbers
    ) = mintToken(tokenAddress, 0, metadata);

    require(responseCode == HederaResponseCodes.SUCCESS, "Failed to mint NFT");
    emit NFTMinted(newTotalSupply, serialNumbers);
}
```
{% endcode %}

{% hint style="info" %}
#### **How It Works**

1. **Call `mintToken`**:\
   This HTS System Contract function creates new NFT serial numbers for each entry in the `metadata` array. For example, if you pass three metadata values, you will mint three (3) unique NFTs.
2. **Emit `NFTMinted`**:\
   Returns the `newTotalSupply` and the array of `serialNumbers` corresponding to the newly minted tokens.
{% endhint %}

#### Test Implementation

{% code title="test/1-MintNFT.ts" %}
```typescript
it("should mint an NFT with metadata", async () => {
  // Example single metadata entry (an IPFS URI)
  const metadata = [
    ethers.toUtf8Bytes("ipfs://bafkreibr7cyxmy4iyc...") 
  ];

  const mintTx = await mintNftContract.mintNFT(metadata, {
    gasLimit: 350_000
  });

  await expect(mintTx)
    .to.emit(mintNftContract, "NFTMinted");
});
```
{% endcode %}

We pass an array with one IPFS URI (encoded as `bytes`). The test expects an `NFTMinted` event on success, indicating new tokens are now part of our NFT supply.

***

## Step 4. Transferring NFTs

#### **Function**: `transferNFT(address receiver, uint256 serialNumber)`

**Purpose**: Transfer an existing NFT from the contract’s treasury (in this case, `address(this)`) to another address. This leverages the standard ERC-721 transfer pattern.

#### **Key Code Snippet**:

{% code title="contracts/1-MintNft.sol" %}
```solidity
function transferNFT(address receiver, uint256 serialNumber) external {
    require(tokenAddress != address(0), "Token not created yet");
    IERC721(tokenAddress).transferFrom(
        address(this),
        receiver,
        serialNumber
    );
    emit NFTTransferred(receiver, serialNumber);
}
```
{% endcode %}

{% hint style="info" %}
#### **How it Works**

1. **Checks Token Address**:\
   Again, ensure the contract has already created the token.
2. **ERC-721 `transferFrom`**:\
   Since Native Hedera Tokens can be treated as though they are ERC-721, we call `transferFrom(this, receiver, serialNumber)` to move the NFT from the contract to the specified address.
3. **Emit `NFTTransferred`**:\
   Logs the receiving address and the token’s `serialNumber`.
{% endhint %}

#### Test Implementation

{% code title="test /1-MintNFT.ts" %}
```typescript
it("should transfer the NFT to owner", async () => {
  const [owner] = await ethers.getSigners();
  const serialNumber = 1n; // the 'n' notation is shorthand to declare a BigInt type. This represents the first minted NFT

  const transferTx = await mintNftContract.transferNFT(owner.address, serialNumber, {
    gasLimit: 350_000
  });

  await expect(transferTx)
    .to.emit(mintNftContract, "NFTTransferred")
    .withArgs(owner.address, serialNumber);
});
```
{% endcode %}

Here, we transfer **serial #1** from the contract to the `owner` address. On success, we expect the `NFTTransferred` event. We can also verify ownership using the standard `IERC721(tokenAddress).ownerOf(serialNumber)` call.

{% hint style="info" %}
Hedera Native Tokens are highly interoperable with their corresponding ERC Contracts. In the code snippet below we show that Hedera Accounts are able to transfer native NFTs as though they are ERC-721 Smart Contracts!
{% endhint %}

{% code title="test /1-MintNFT.ts" %}
```typescript
it("should transfer the NFT back to contract before burning", async () => {
    const [owner] = await ethers.getSigners();
    const serialNumber = 1n;
    const tokenAddress = await mintNftContract.getTokenAddress();

    // Get the NFT contract interface
    const nftContract = await ethers.getContractAt("IERC721", tokenAddress);

    // Then transfer from owner back to contract
    await nftContract.transferFrom(
      owner.address,
      mintNftContract.target,
      serialNumber,
      {
        gasLimit: 350_000
      }
    );

    // Verify the NFT is now owned by the contract
    expect(await nftContract.ownerOf(serialNumber))
      .to.equal(mintNftContract.target);
  });
```
{% endcode %}

As you can see, despite our NFT not actually being an ERC-721 (it is a Native Token; not a Smart Contract), we can treat it as though it is one. The same goes for Native Fungible Tokens and ERC-20 interfaces. Find out more [here](../../core-concepts/smart-contracts/tokens-managed-by-smart-contracts/).

***

## Step 5. Burning an NFT

#### **Function**: `burnNFT(int64[] memory serialNumbers)`

**Purpose**: Burn (permanently remove) existing NFTs from circulation. This is helpful if you need to remove misprints, decommission tokens, or reduce supply to increase rarity. The serials must be in the Treasury account in order to burn them.

#### **Key Code Snippet**:

{% code title="contracts/1-MintNft.sol" %}
```solidity
function burnNFT(int64[] memory serialNumbers) external onlyOwner {
    require(tokenAddress != address(0), "Token not created yet");

    (int responseCode, int64 newTotalSupply) =
        burnToken(tokenAddress, 0, serialNumbers);

    require(responseCode == HederaResponseCodes.SUCCESS, "Failed to burn NFT");
    emit NFTBurned(responseCode, newTotalSupply);
}
```
{% endcode %}

#### Test Implementation

{% code title="test /1-MintNFT.ts" %}
```typescript
it("should burn the minted NFT", async () => {
  // Assume serial 1 NFT has been returned to the Contract
  const serialNumbers = [1n];

  const burnTx = await mintNftContract.burnNFT(serialNumbers, {
    gasLimit: 60_000
  });

  await expect(burnTx)
    .to.emit(mintNftContract, "NFTBurned");
});
```
{% endcode %}

We pass an array of serial numbers—in this case, `[1n]` for the first minted NFT. The test ensures that `NFTBurned` fires, confirming the token is removed from the supply.

***

## Conclusion

Using Solidity on Hedera, you can **create**, **mint**, **burn**, and **transfer** native NFTs with minimal code thanks to the **HTS System Contract**. In this tutorial, you saw how to:

* **Create** a new NFT class with royalty fees (`createNFT`).
* **Mint** new tokens (`mintNFT`).
* **Burn** tokens when they are no longer needed (`burnNFT`).
* **Transfer** NFTs via standard ERC-721 calls (`transferNFT`).

Continue exploring our [Part 2: KYC & Update](hts-x-evm-part-2-kyc-and-update.md) to see how advanced compliance flags (e.g., KYC) or updating tokens can be handled natively.

{% content-ref url="hts-x-evm-part-2-kyc-and-update.md" %}
[hts-x-evm-part-2-kyc-and-update.md](hts-x-evm-part-2-kyc-and-update.md)
{% endcontent-ref %}

***

## Additional Resources

Check out our GitHub repo to find the full contract and Hardhat test scripts, along with the configuration files you need to deploy and test on Hedera!

* [Full Contract and Hardhat Test Scripts Repository](https://github.com/hedera-dev/hts-evm-hybrid-mint-nfts)

<table data-view="cards"><thead><tr><th align="center"></th><th data-hidden data-card-target data-type="content-ref"></th></tr></thead><tbody><tr><td align="center"><p>Writer: Jake, Developer Relations Engineer</p><p><a href="https://github.com/jaycoolh">GitHub</a> | <a href="https://x.com/jaycoolh">X</a></p></td><td><a href="https://github.com/jaycoolh">https://github.com/jaycoolh</a></td></tr><tr><td align="center"><p>Editor: Michiel, Developer Relations Engineer</p><p><a href="https://github.com/michielmulders">GitHub</a> | <a href="https://www.linkedin.com/in/michielmulders/">LinkedIn</a></p></td><td><a href="https://www.linkedin.com/in/michielmulders/">https://www.linkedin.com/in/michielmulders/</a></td></tr><tr><td align="center"><p>Editor: Krystal, Technical Writer</p><p><a href="https://github.com/theekrystallee">GitHub</a> | <a href="https://x.com/theekrystallee">X</a></p></td><td><a href="https://x.com/theekrystallee">https://x.com/theekrystallee</a></td></tr></tbody></table>
