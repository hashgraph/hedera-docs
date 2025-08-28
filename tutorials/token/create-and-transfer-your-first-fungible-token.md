# Create and Transfer Your First Fungible Token

## Summary

Fungible tokens share a single set of properties and have interchangeable value with one another. Use cases for fungible tokens include applications like stablecoins, in-game rewards systems, crypto tokens, loyalty program points, and much more.

***

## Prerequisites

We recommend you complete the following introduction to get a basic understanding of Hedera transactions. This example does not build upon the previous examples.

1. Get a [Hedera testnet account](../more-tutorials/create-and-fund-your-hedera-testnet-account.md).
2. Set up your environment [here](../../getting-started-hedera-native-developers/quickstart.md).
3. [Getting Started: Create a Token](../../getting-started-hedera-native-developers/create-a-token.md).

***

## 1. Create a Fungible Token

Use _<mark style="color:purple;">**`TokenCreateTransaction()`**</mark>_ to create a fungible token and configure its properties. At a minimum, this constructor requires setting a name, symbol, and treasury account ID. All other fields are optional, so if they’re not specified then default values are used. For instance, not specifying an _admin key_, makes a token immutable (can’t change or add properties); not specifying a _supply key_, makes a token supply fixed (can’t mint new or burn existing tokens); not specifying a _token type_, makes a token fungible.

After submitting the transaction to the Hedera network, you can obtain the new token ID by requesting the receipt.

Unlike NFTs, fungible tokens do not require the decimals and initial supply to be set to zero during creation. In this case, we set the initial supply to 100 units, which is shown in the code as 10000 to account to 2 decimals.

{% tabs %}
{% tab title="Java" %}
```java
// CREATE FUNGIBLE TOKEN (STABLECOIN)
TokenCreateTransaction tokenCreateTx = new TokenCreateTransaction()
        .setTokenName("USD Bar")
        .setTokenSymbol("USDB")
        .setTokenType(TokenType.FUNGIBLE_COMMON)
        .setDecimals(2)
        .setInitialSupply(10000)
        .setTreasuryAccountId(treasuryId)
        .setSupplyType(TokenSupplyType.INFINITE)
        .setSupplyKey(supplyKey)
        .freezeWith(client);

//SIGN WITH TREASURY KEY
TokenCreateTransaction tokenCreateSign = tokenCreateTx.sign(treasuryKey);

//SUBMIT THE TRANSACTION
TransactionResponse tokenCreateSubmit = tokenCreateSign.execute(client);

//GET THE TRANSACTION RECEIPT
TransactionReceipt tokenCreateRx = tokenCreateSubmit.getReceipt(client);

//GET THE TOKEN ID
TokenId tokenId = tokenCreateRx.tokenId;

//LOG THE TOKEN ID TO THE CONSOLE
System.out.println("Created token with ID: " +tokenId);
```
{% endtab %}

{% tab title="JavaScript" %}
```javascript
// CREATE FUNGIBLE TOKEN (STABLECOIN)
let tokenCreateTx = new TokenCreateTransaction()
	.setTokenName("USD Bar")
	.setTokenSymbol("USDB")
	.setTokenType(TokenType.FungibleCommon)
	.setDecimals(2)
	.setInitialSupply(10000)
	.setTreasuryAccountId(treasuryId)
	.setSupplyType(TokenSupplyType.Infinite)
	.setSupplyKey(supplyKey)
	.freezeWith(client);

//SIGN WITH TREASURY KEY
const tokenCreateSign = await tokenCreateTx.sign(treasuryKey);

//SUBMIT THE TRANSACTION
const tokenCreateSubmit = await tokenCreateSign.execute(client);

//GET THE TRANSACTION RECEIPT
const tokenId = (await tokenCreateSubmit.getReceipt(client)).tokenId;

//LOG THE TOKEN ID TO THE CONSOLE
console.log(`\nCreated fungible token with token ID ${tokenId}\n`);
```
{% endtab %}

{% tab title="Go" %}
```go
//CREATE FUNGIBLE TOKEN (STABLECOIN)
tokenCreateTx, err := hedera.NewTokenCreateTransaction().
	SetTokenName("USD Bar").
	SetTokenSymbol("USDB").
	SetTokenType(hedera.TokenTypeFungibleCommon).
	SetDecimals(2).
	SetInitialSupply(10000).
	SetTreasuryAccountID(treasuryAccountId).
	SetSupplyType(hedera.TokenSupplyTypeInfinite).
	SetSupplyKey(supplyKey).
	FreezeWith(client)

//SIGN WITH TREASURY KEY
tokenCreateSign := tokenCreateTx.Sign(treasuryKey)

//SUBMIT THE TRANSACTION
tokenCreateSubmit, err := tokenCreateSign.Execute(client)

//GET THE TRANSACTION RECEIPT
tokenCreateRx, err := tokenCreateSubmit.GetReceipt(client)

//GET THE TOKEN ID
tokenId := *tokenCreateRx.TokenID

//LOG THE TOKEN ID TO THE CONSOLE
fmt.Println("Created fungible token with token ID", tokenId)
```
{% endtab %}
{% endtabs %}

***

## 2. Associate User Accounts with Token

Before an account that is not the treasury for a token can receive or send this specific token ID, the account must become “associated” with the token.

{% tabs %}
{% tab title="Java" %}
```java
// TOKEN ASSOCIATION WITH ALICE's ACCOUNT
TokenAssociateTransaction associateAliceTx = new TokenAssociateTransaction()
        .setAccountId(aliceAccountId)
        .setTokenIds(Collections.singletonList(tokenId))
	.freezeWith(client)
        .sign(aliceKey);
        
//SUBMIT THE TRANSACTION
TransactionResponse associateAliceTxSubmit = associateAliceTx.execute(client);
        
//GET THE RECEIPT OF THE TRANSACTION
TransactionReceipt associateAliceRx = associateAliceTxSubmit.getReceipt(client);
        
//LOG THE TRANSACTION STATUS
System.out.println(
        "STABLECOIN token association with Alice's account: " 
                + associateAliceRx.status + " ✅");
```
{% endtab %}

{% tab title="JavaScript" %}
```javascript
// TOKEN ASSOCIATION WITH ALICE's ACCOUNT
const associateAliceTx = await new TokenAssociateTransaction()
    .setAccountId(aliceId)
    .setTokenIds([tokenId])
    .freezeWith(client)
    .sign(aliceKey);
    
//SUBMIT and GET THE RECEIPT OF THE TRANSACTION
const associateAliceRx = await (
    await associateAliceTx.execute(client)
  ).getReceipt(client);
  
//LOG THE TRANSACTION STATUS
console.log(
    `STABLECOIN token association with Alice's account: 
        ${associateAliceRx.status} ✅`);
```
{% endtab %}

{% tab title="Go" %}
```go
//TOKEN ASSOCIATION WITH ALICE's ACCOUNT
associateAliceTx, err := hedera.NewTokenAssociateTransaction().
	SetAccountID(aliceAccountId).
	SetTokenIDs(tokenId).
	FreezeWith(client)

//SIGN WITH ALICE'S KEY TO AUTHORIZE THE ASSOCIATION
signTx := associateAliceTx.Sign(aliceKey)

//SUBMIT THE TRANSACTION
associateAliceTxSubmit, err := signTx.Execute(client)

//GET THE RECEIPT OF THE TRANSACTION
associateAliceRx, err := associateAliceTxSubmit.GetReceipt(client)

//LOG THE TRANSACTION STATUS
fmt.Println(
	"STABLECOIN token association with Alice's account:", 
		associateAliceRx.Status, "✅")
```
{% endtab %}
{% endtabs %}

***

## 3. Transfer the Token

Now, transfer 5 units of the token from the Treasury to Alice and check the account balances before and after the transfer.

{% tabs %}
{% tab title="Java" %}
```java
// BALANCE CHECK BEFORE TRANSFER
AccountBalance balanceCheckTreasury = new AccountBalanceQuery()
        .setAccountId(treasuryId)
        .execute(client);
System.out.println(
        "- Treasury balance: " + balanceCheckTreasury.tokens.get(tokenId) +
                " units of token ID " + tokenId);

AccountBalance balanceCheckAlice = new AccountBalanceQuery()
        .setAccountId(aliceAccountId)
        .execute(client);
System.out.println(
        "- Alice's balance: " + balanceCheckAlice.tokens.get(tokenId) +
                " units of token ID " + tokenId + "\n");

// TRANSFER 5 STABLECOIN FROM TREASURY TO ALICE
TransferTransaction tokenTransferTx = new TransferTransaction()
        .addTokenTransfer(tokenId, treasuryId, -5)
        .addTokenTransfer(tokenId, aliceAccountId, 5)
        .freezeWith(client)
        .sign(treasuryKey);
        
//SUBMIT THE TRANSACTION
TransactionResponse tokenTransferSubmit = tokenTransferTx.execute(client);
        
//GET THE RECEIPT OF THE TRANSACTION
TransactionReceipt tokenTransferRx = tokenTransferSubmit.getReceipt(client);
        
//LOG THE TRANSACTION STATUS
System.out.println(
        "Stablecoin transfer from Treasury to Alice: " 
                + tokenTransferRx.status + " ✅");

// BALANCE CHECK AFTER TRANSFER
AccountBalance balanceCheckTreasury2 = new AccountBalanceQuery()
        .setAccountId(treasuryId)
        .execute(client);
System.out.println(
        "- Treasury balance: " + balanceCheckTreasury2.tokens.get(tokenId) +
                " units of token ID " + tokenId);

AccountBalance balanceCheckAlice2 = new AccountBalanceQuery()
        .setAccountId(aliceAccountId)
        .execute(client);
System.out.println(
        "- Alice's balance: " + balanceCheckAlice2.tokens.get(tokenId) +
                " units of token ID " + tokenId + "\n");
        
```
{% endtab %}

{% tab title="JavaScript" %}
```javascript
//BALANCE CHECK
const balanceCheckTreasury = await new AccountBalanceQuery()
    .setAccountId(treasuryId)
    .execute(client);
  console.log(
    `- Treasury balance: ${getTokenBalance(
      balanceCheckTreasury,
      tokenId
    )} units of token ID ${tokenId}`
  );

  const balanceCheckAlice = await new AccountBalanceQuery()
    .setAccountId(aliceId)
    .execute(client);
  console.log(
    `- Alice's balance: ${getTokenBalance(
      balanceCheckAlice,
      tokenId
    )} units of token ID ${tokenId}\n`
  );


// TRANSFER STABLECOIN FROM TREASURY TO ALICE
const tokenTransferTx = await new TransferTransaction()
    .addTokenTransfer(tokenId, treasuryId, -5)
    .addTokenTransfer(tokenId, aliceId, 5)
    .freezeWith(client)
    .sign(treasuryKey);
    
//SUBMIT and GET THE RECEIPT OF THE TRANSACTION
const tokenTransferRx = await (
  await tokenTransferTx.execute(client)
).getReceipt(client);
  
//LOG THE TRANSACTION STATUS
console.log(
  `Stablecoin transfer from Treasury to Alice: ${tokenTransferRx.status} ✅`
);

// BALANCE CHECK
const balanceCheckTreasury2 = await new AccountBalanceQuery()
    .setAccountId(treasuryId)
    .execute(client);

console.log(
    `- Treasury balance: ${getTokenBalance(
      balanceCheckTreasury2,
      tokenId
    )} units of token ID ${tokenId}`
  );

const balanceCheckAlice2 = await new AccountBalanceQuery()
  .setAccountId(aliceId)
  .execute(client);
console.log(
  `- Alice's balance: ${getTokenBalance(
    balanceCheckAlice2,
    tokenId
  )} units of token ID ${tokenId}\n`
);
```
{% endtab %}

{% tab title="Go" %}
```go
//CHECK THE BALANCE BEFORE THE TRANSFER FROM THE TREASURY ACCOUNT
balanceCheckTreasury, err := hedera.NewAccountBalanceQuery().
	SetAccountID(treasuryAccountId).
	Execute(client)
treasuryBalance := balanceCheckTreasury.Tokens.Get(tokenId)
fmt.Printf("Treasury balance: %d units of token %s\n", treasuryBalance, tokenId)

//CHECK THE BALANCE BEFORE THE TRANSFER FOR ALICE'S ACCOUNT
balanceCheckAlice, err := hedera.NewAccountBalanceQuery().
	SetAccountID(aliceAccountId).
	Execute(client)
aliceBalance := balanceCheckAlice.Tokens.Get(tokenId)
fmt.Printf("Alice's balance: %d units of token %s\n\n", aliceBalance, tokenId)

//TRANSFER THE STABLECOIN FROM TREASURY TO ALICE
tokenTransferTx, err := hedera.NewTransferTransaction().
	AddTokenTransfer(tokenId, treasuryAccountId, -5).
	AddTokenTransfer(tokenId, aliceAccountId, 5).
	FreezeWith(client)

//SIGN WITH THE TREASURY KEY TO AUTHORIZE THE TRANSFER
signTransferTx := tokenTransferTx.Sign(treasuryKey)

//SUBMIT THE TRANSACTION
tokenTransferSubmit, err := signTransferTx.Execute(client)

//GET THE TRANSACTION RECEIPT
tokenTransferRx, err := tokenTransferSubmit.GetReceipt(client)

fmt.Println("\nToken transfer from Treasury to Alice:", tokenTransferRx.Status, "✅")

//CHECK THE BALANCE AFTER THE TRANSFER FOR THE TREASURY ACCOUNT
balanceCheckTreasury2, err := hedera.NewAccountBalanceQuery().
	SetAccountID(treasuryAccountId).
	Execute(client)
treasuryBalance2 := balanceCheckTreasury2.Tokens.Get(tokenId)
fmt.Printf("Treasury balance: %d units of token %s\n", treasuryBalance2, tokenId)

//CHECK THE BALANCE AFTER THE TRANSFER FOR ALICE'S ACCOUNT
balanceCheckAlice2, err := hedera.NewAccountBalanceQuery().
	SetAccountID(aliceAccountId).
	Execute(client)
aliceBalance2 := balanceCheckAlice2.Tokens.Get(tokenId)
fmt.Printf("Alice's balance: %d units of token %s\n\n", aliceBalance2, tokenId)
```
{% endtab %}
{% endtabs %}

***

## Code Check ✅

<details>

<summary>Java</summary>

```java
import com.hedera.hashgraph.sdk.*;
import io.github.cdimascio.dotenv.Dotenv;

import java.util.Collections;
import java.util.concurrent.TimeoutException;

public class CreateFungibleTutorial {
        public static void main(String[] args)
                        throws TimeoutException, PrecheckStatusException, ReceiptStatusException {

                // LOADS THE .ENV FILE
                Dotenv dotenv = Dotenv.load();
                AccountId operatorId = AccountId.fromString(dotenv.get("OPERATOR_ID"));
                PrivateKey operatorKey = PrivateKey.fromStringDER(dotenv.get("OPERATOR_KEY"));
     
                // CREATE TESTNET CLIENT
                Client client = Client.forTestnet();
                client.setOperator(operatorId, operatorKey);

                try {
                        // Generate Treasury key
                        PrivateKey treasuryKey = PrivateKey.generateECDSA();
                        PublicKey treasuryPublicKey = treasuryKey.getPublicKey();

                        // Generate Treasury account
                        TransactionResponse treasuryAccount = new AccountCreateTransaction()
                                        .setKeyWithAlias(treasuryPublicKey)
                                        .setInitialBalance(new Hbar(1))
                                        .execute(client);

                        AccountId treasuryId = treasuryAccount.getReceipt(client).accountId;

                        // Generate Alice's key
                        PrivateKey aliceKey = PrivateKey.generateECDSA();
                        PublicKey alicePublicKey = aliceKey.getPublicKey();

                        // Create Alice's account
                        TransactionResponse aliceAccount = new AccountCreateTransaction()
                                        .setKeyWithAlias(alicePublicKey)
                                        .setInitialBalance(new Hbar(1))
                                        .execute(client);

                        AccountId aliceAccountId = aliceAccount.getReceipt(client).accountId;

                        // Generate supply key
                        PrivateKey supplyKey = PrivateKey.generateECDSA();

                        // Create fungible token (stablecoin)
                        TokenCreateTransaction tokenCreateTx = new TokenCreateTransaction()
                                        .setTokenName("USD Bar")
                                        .setTokenSymbol("USDB")
                                        .setTokenType(TokenType.FUNGIBLE_COMMON)
                                        .setDecimals(2)
                                        .setInitialSupply(10000)
                                        .setTreasuryAccountId(treasuryId)
                                        .setSupplyType(TokenSupplyType.INFINITE)
                                        .setSupplyKey(supplyKey)
                                        .freezeWith(client);

                        TokenCreateTransaction tokenCreateSign = tokenCreateTx.sign(treasuryKey);
                        TransactionResponse tokenCreateSubmit = tokenCreateSign.execute(client);
                        TransactionReceipt tokenCreateRx = tokenCreateSubmit.getReceipt(client);
                        TokenId tokenId = tokenCreateRx.tokenId;

                        System.out.println("\nCreated token with ID: " + tokenId + "\n");

                        // TOKEN ASSOCIATION WITH ALICE'S ACCOUNT
                        TokenAssociateTransaction associateAliceTx = new TokenAssociateTransaction()
                                        .setAccountId(aliceAccountId)
                                        .setTokenIds(Collections.singletonList(tokenId))
                                        .freezeWith(client)
                                        .sign(aliceKey);

                        TransactionResponse associateAliceTxSubmit = associateAliceTx.execute(client);
                        TransactionReceipt associateAliceRx = associateAliceTxSubmit.getReceipt(client);
                        System.out.println("STABLECOIN token association with Alice's account: " + associateAliceRx.status + " ✅");

                        // BALANCE CHECK BEFORE TRANSFER
                        AccountBalance balanceCheckTreasury = new AccountBalanceQuery()
                                        .setAccountId(treasuryId)
                                        .execute(client);
                        System.out.println("- Treasury balance: " +
                                        balanceCheckTreasury.tokens.get(tokenId) +
                                        " units of token ID " + tokenId);

                        AccountBalance balanceCheckAlice = new AccountBalanceQuery()
                                        .setAccountId(aliceAccountId)
                                        .execute(client);
                        System.out.println("- Alice's balance: " +
                                        balanceCheckAlice.tokens.get(tokenId) +
                                        " units of token ID " + tokenId + "\n");

                        // TRANSFER 5 STABLECOIN FROM TREASURY TO ALICE
                        TransferTransaction tokenTransferTx = new TransferTransaction()
                                        .addTokenTransfer(tokenId, treasuryId, -5)
                                        .addTokenTransfer(tokenId, aliceAccountId, 5)
                                        .freezeWith(client)
                                        .sign(treasuryKey);

                        TransactionResponse tokenTransferSubmit = tokenTransferTx.execute(client);
                        TransactionReceipt tokenTransferRx = tokenTransferSubmit.getReceipt(client);
                        System.out.println(
                                        "Stablecoin transfer from Treasury to Alice: " + tokenTransferRx.status + " ✅");

                        // BALANCE CHECK AFTER TRANSFER
                        AccountBalance balanceCheckTreasury2 = new AccountBalanceQuery()
                                        .setAccountId(treasuryId)
                                        .execute(client);
                        System.out.println("- Treasury balance: " +
                                        balanceCheckTreasury2.tokens.get(tokenId) +
                                        " units of token ID " + tokenId);

                        AccountBalance balanceCheckAlice2 = new AccountBalanceQuery()
                                        .setAccountId(aliceAccountId)
                                        .execute(client);
                        System.out.println("- Alice's balance: " +
                                        balanceCheckAlice2.tokens.get(tokenId) +
                                        " units of token ID " + tokenId + "\n");

                } finally {
                        client.close();
                }
        }
}
```

</details>

<details>

<summary>JavaScript</summary>

```javascript
console.clear();
import "dotenv/config";
import {
  Client,
  Hbar,
  PrivateKey,
  AccountCreateTransaction,
  AccountBalanceQuery,
  TokenCreateTransaction,
  TokenAssociateTransaction,
  TransferTransaction,
  TokenType,
  TokenSupplyType,
} from "@hashgraph/sdk";

// LOADS THE .ENV FILE
const operatorId = process.env.OPERATOR_ID;
const operatorKey = process.env.OPERATOR_KEY;

// CREATE TESTNET CLIENT
const client = Client.forTestnet().setOperator(operatorId, operatorKey);

function getTokenBalance(accountBalance, tokenId) {
  return (
    accountBalance.tokens.get(tokenId) ??
    accountBalance.tokens.get(tokenId.toString()) ??
    0
  );
}

async function run() {
  // Generate Treasury key and account
  const treasuryKey = PrivateKey.generateECDSA();
  const treasuryPub = treasuryKey.publicKey;
  const treasuryCreateTx = await new AccountCreateTransaction()
    .setECDSAKeyWithAlias(treasuryPub) 
    .setInitialBalance(new Hbar(20))
    .execute(client);
  const treasuryId = (await treasuryCreateTx.getReceipt(client)).accountId;

  // Generate Alice key and account
  const aliceKey = PrivateKey.generateECDSA();
  const alicePub = aliceKey.publicKey;
  const aliceCreateTx = await new AccountCreateTransaction()
    .setECDSAKeyWithAlias(alicePub)
    .setInitialBalance(new Hbar(20))
    .execute(client);
  const aliceId = (await aliceCreateTx.getReceipt(client)).accountId;

  // Generate supply key
  const supplyKey = PrivateKey.generateECDSA();

  // CREATE FUNGIBLE TOKEN (STABLECOIN)token
  let tokenCreateTx = new TokenCreateTransaction()
    .setTokenName("USD Bar")
    .setTokenSymbol("USDB")
    .setTokenType(TokenType.FungibleCommon)
    .setDecimals(2)
    .setInitialSupply(10000)
    .setTreasuryAccountId(treasuryId)
    .setSupplyType(TokenSupplyType.Infinite)
    .setSupplyKey(supplyKey.publicKey)
    .freezeWith(client);

  //SIGN WITH TREASURY KEY
  const tokenCreateSign = await tokenCreateTx.sign(treasuryKey);
  
  //SUBMIT THE TRANSACTION
  const tokenCreateSubmit = await tokenCreateSign.execute(client);
  
  //GET THE TRANSACTION RECEIPT
  const tokenId = (await tokenCreateSubmit.getReceipt(client)).tokenId;

  //LOG THE TOKEN ID TO THE CONSOLE
  console.log(`\nCreated fungible token with token ID ${tokenId}\n`);

  // TOKEN ASSOCIATION WITH ALICE's ACCOUNT
  const associateAliceTx = await new TokenAssociateTransaction()
    .setAccountId(aliceId)
    .setTokenIds([tokenId])
    .freezeWith(client)
    .sign(aliceKey);
    
  //SUBMIT AND GET THE RECEIPT OF THE TRANSACTION
  const associateAliceRx = await (
    await associateAliceTx.execute(client)
  ).getReceipt(client);
  
  //LOG THE TRANSACTION STATUS
  console.log(
    `STABLECOIN token association with Alice's account: ${associateAliceRx.status} ✅`
  );

  // BALANCE CHECK BEFORE TRANSFER
  const balanceCheckTreasury = await new AccountBalanceQuery()
    .setAccountId(treasuryId)
    .execute(client);
  console.log(
    `- Treasury balance: ${getTokenBalance(
      balanceCheckTreasury,
      tokenId
    )} units of token ID ${tokenId}`
  );

  const balanceCheckAlice = await new AccountBalanceQuery()
    .setAccountId(aliceId)
    .execute(client);
  console.log(
    `- Alice's balance: ${getTokenBalance(
      balanceCheckAlice,
      tokenId
    )} units of token ID ${tokenId}\n`
  );

  // TRANSFER 5 STABLECOIN FROM TREASURY TO ALICE
  const tokenTransferTx = await new TransferTransaction()
    .addTokenTransfer(tokenId, treasuryId, -5)
    .addTokenTransfer(tokenId, aliceId, 5)
    .freezeWith(client)
    .sign(treasuryKey);
    
  //SUBMIT AND GET THE RECEIPT OF THE TRANSACTION
  const tokenTransferRx = await (
    await tokenTransferTx.execute(client)
  ).getReceipt(client);
  
  //LOG THE TRANSACTION STATUS
  console.log(
    `Stablecoin transfer from Treasury to Alice: ${tokenTransferRx.status} ✅`
  );

  // BALANCE CHECK AFTER TRANSFER
  const balanceCheckTreasury2 = await new AccountBalanceQuery()
    .setAccountId(treasuryId)
    .execute(client);
  console.log(
    `- Treasury balance: ${getTokenBalance(
      balanceCheckTreasury2,
      tokenId
    )} units of token ID ${tokenId}`
  );

  const balanceCheckAlice2 = await new AccountBalanceQuery()
    .setAccountId(aliceId)
    .execute(client);
  console.log(
    `- Alice's balance: ${getTokenBalance(
      balanceCheckAlice2,
      tokenId
    )} units of token ID ${tokenId}\n`
  );
}

(async () => {
  try {
    await run();
  } catch (err) {
    console.error(err);
    process.exitCode = 1;
  } finally {
    await client.close();
  }
})();
```

</details>

<details>

<summary>Go</summary>

```go
package main

import (
	"fmt"
	"os"

	hedera "github.com/hiero-ledger/hiero-sdk-go/v2/sdk"
	"github.com/joho/godotenv"
)

func main() {

	// LOADS THE .ENV FILE AND THROWS AN EROOR IF IT CANNOT LOAD THE VARIABLES
	err := godotenv.Load(".env")
	if err != nil {
		panic(fmt.Errorf("Unable to load environment variables from .env file. Error:\n%v\n", err))
	}

	// GRAB YOUR TESTNET ACCOUNT ID AND KEY FROM THE .ENV FILE
	operatorId, err := hedera.AccountIDFromString(os.Getenv("OPERATOR_ID"))
	if err != nil {
		panic(err)
	}

	operatorKey, err := hedera.PrivateKeyFromString(os.Getenv("OPERATOR_KEY"))
	if err != nil {
		panic(err)
	}

	// CREATE TESTNET CLIENT
	client := hedera.ClientForTestnet()
	client.SetOperator(operatorId, operatorKey)

	// GENERATE TREASURY KEY
	treasuryKey, err := hedera.PrivateKeyGenerateEcdsa()
	treasuryPublicKey := treasuryKey.PublicKey()

	// CREATE TREASURY ACCOUNT
	treasuryAccount, err := hedera.NewAccountCreateTransaction().
		SetECDSAKeyWithAlias(treasuryPublicKey).
		SetInitialBalance(hedera.NewHbar(20)).
		Execute(client)
	if err != nil {
		panic(err)
	}

	// GET THE RECEIPT OF THE TRANSACTION
	receipt, err := treasuryAccount.GetReceipt(client)
	if err != nil {
		panic(err)
	}

	// GET THE ACCOUNT ID
	treasuryAccountId := *receipt.AccountID

	// GENERATE ALICE'S KEY
	aliceKey, err := hedera.PrivateKeyGenerateEcdsa()
	alicePublicKey := aliceKey.PublicKey()

	// CREATE AILICE'S ACCOUNT
	aliceAccount, err := hedera.NewAccountCreateTransaction().
		SetECDSAKeyWithAlias(alicePublicKey).
		SetInitialBalance(hedera.NewHbar(20)).
		Execute(client)
	if err != nil {
		panic(err)
	}

	// GET THE RECEIPT OF THE TRANSACTION
	receipt2, err := aliceAccount.GetReceipt(client)
	if err != nil {
		panic(err)
	}

	// GET ALICE'S ACCOUNT ID
	aliceAccountId := *receipt2.AccountID

	//CREATE SUPPLY KEY
	supplyKey, err := hedera.PrivateKeyGenerateEcdsa()
	if err != nil {
		panic(err)
	}

	// CREATE FUNGIBLE TOKEN (STABLECOIN)
	tokenCreateTx, err := hedera.NewTokenCreateTransaction().
		SetTokenName("USD Bar").
		SetTokenSymbol("USDB").
		SetTokenType(hedera.TokenTypeFungibleCommon).
		SetDecimals(2).
		SetInitialSupply(10000).
		SetTreasuryAccountID(treasuryAccountId).
		SetSupplyType(hedera.TokenSupplyTypeInfinite).
		SetSupplyKey(supplyKey).
		FreezeWith(client)
	if err != nil {
		panic(err)
	}

	// SIGN WITH TREASURY KEY
	tokenCreateSign := tokenCreateTx.Sign(treasuryKey)

	// SUBMIT THE TRANSACTION
	tokenCreateSubmit, err := tokenCreateSign.Execute(client)
	if err != nil {
		panic(err)
	}

	// GET THE TRANSACTION RECEIPT
	tokenCreateRx, err := tokenCreateSubmit.GetReceipt(client)
	if err != nil {
		panic(err)
	}

	// GET THE TOKEN ID
	tokenId := *tokenCreateRx.TokenID

	// LOG THE TOKEN ID TO THE CONSOLE
	fmt.Println("\nCreated fungible token with token ID", tokenId, "\n")

	// TOKEN ASSOCIATION WITH ALICE'S ACCOUNT
	associateAliceTx, err := hedera.NewTokenAssociateTransaction().
		SetAccountID(aliceAccountId).
		SetTokenIDs(tokenId).
		FreezeWith(client)
	if err != nil {
		panic(err)
	}

	// SIGN WITH ALICE'S KEY TO AUTHORIZE THE ASSOCIATION
	signTx := associateAliceTx.Sign(aliceKey)

	// SUBMIT THE TRANSACTION
	associateAliceTxSubmit, err := signTx.Execute(client)
	if err != nil {
		panic(err)
	}

	// GET THE RECEIPT OF THE TRANSACTION
	associateAliceRx, err := associateAliceTxSubmit.GetReceipt(client)
	if err != nil {
		panic(err)
	}

	// LOG THE TRANSACTION STATUS
	fmt.Println("STABLECOIN token association with Alice's account:", associateAliceRx.Status, "✅")

	//CHECK THE BALANCE BEFORE THE TRANSFER FROM THE TREASURY ACCOUNTt
	balanceCheckTreasury, err := hedera.NewAccountBalanceQuery().SetAccountID(treasuryAccountId).Execute(client)
	if err != nil {
		panic(err)
	}
	treasuryBalance := balanceCheckTreasury.Tokens.Get(tokenId)
	fmt.Printf("Treasury balance: %d units of token %s\n", treasuryBalance, tokenId)

	// Check the balance before the transfer for Alice's account
	balanceCheckAlice, err := hedera.NewAccountBalanceQuery().SetAccountID(aliceAccountId).Execute(client)
	if err != nil {
		panic(err)
	}
	aliceBalance := balanceCheckAlice.Tokens.Get(tokenId)
	fmt.Printf("Alice's balance: %d units of token %s\n\n", aliceBalance, tokenId)

	// Transfer the STABLECOIN from treasury to Alice
	tokenTransferTx, err := hedera.NewTransferTransaction().
		AddTokenTransfer(tokenId, treasuryAccountId, -5).
		AddTokenTransfer(tokenId, aliceAccountId, 5).
		FreezeWith(client)
	if err != nil {
		panic(err)
	}

	// SIGN WITH THE TREASURY KEY TO AUTHORIZE THE TRANSFER
	signTransferTx := tokenTransferTx.Sign(treasuryKey)

	// SUBMIT THE TRANSACTION
	tokenTransferSubmit, err := signTransferTx.Execute(client)
	if err != nil {
		panic(err)
	}

	// GET THE TRANSACTION RECEIPT
	tokenTransferRx, err := tokenTransferSubmit.GetReceipt(client)
	if err != nil {
		panic(err)
	}

	fmt.Println("\nToken transfer from Treasury to Alice:", tokenTransferRx.Status, "✅")

	// CHECK THE BALANCE AFTER THE TRANSFER FOR THE TREASURY ACCOUNT
	balanceCheckTreasury2, err := hedera.NewAccountBalanceQuery().SetAccountID(treasuryAccountId).Execute(client)
	if err != nil {
		panic(err)
	}
	treasuryBalance2 := balanceCheckTreasury2.Tokens.Get(tokenId)
	fmt.Printf("Treasury balance: %d units of token %s\n", treasuryBalance2, tokenId)

	// CHECK THE BALANCE AFTER THE TRANSFER FOR ALICE'S ACCOUNT
	balanceCheckAlice2, err := hedera.NewAccountBalanceQuery().SetAccountID(aliceAccountId).Execute(client)
	if err != nil {
		panic(err)
	}
	aliceBalance2 := balanceCheckAlice2.Tokens.Get(tokenId)
	fmt.Printf("Alice's balance: %d units of token %s\n\n", aliceBalance2, tokenId)
}
```

</details>

{% hint style="info" %}
Have a question? [Ask it on StackOverflow](https://stackoverflow.com/questions/tagged/hedera-hashgraph)
{% endhint %}
