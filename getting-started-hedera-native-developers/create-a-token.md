# Create a Token

Learn how to launch a simple fungible token on Hedera testnet. A fungible token is a divisible digital asset (think loyalty points, stablecoins, or stocks) created by the **Hedera Token Service (HTS)**.

***

## **Prerequisites**

* A Hedera testnet **operator account ID** and **DER-encoded private key** (from the [Quickstart](quickstart.md))
* A few testnet **HBAR (ℏ)** to cover the ≈ `$1` token-creation fee &#x20;

We will use the operator account as the token’s **treasury** (the account that initially holds the supply).

> ### _**Note**_
>
> _You can always check the "_ ✅ [_Code Check_](create-a-token.md#code-check)_" section at the bottom of each page to view the entire code if you run into issues. You can also post your issue to the respective SDK channel in our Discord community_ [_here_](http://hedera.com/discord)_._

***

## Project Setup and SDK Installation

{% tabs %}
{% tab title="JavaScript" %}
Open your terminal and create a directory `hedera-examples` directory. Then change into the newly created directory:

```bash
mkdir hedera-examples && cd hedera-examples
```

Initialize a `node.js` project in this new directory:

```bash
npm init -y
```

Ensure you have [**Node.js**](https://nodejs.org/en/download) `v18` or later installed on your machine. Then, install the[ JavaScript SDK](https://github.com/hiero-ledger/hiero-sdk-js).

```bash
npm install --save @hashgraph/sdk
```

Update your `package.json` file to enable ES6 modules and configure the project:

<pre class="language-json"><code class="lang-json">{
  "name": "hedera-examples",
  "version": "1.0.0",
<strong>  "type": "module",
</strong>  "main": "createTokenDemo.js",
  "scripts": {
    "start": "node createTokenDemo.js"
  },
  "keywords": [],
  "author": "",
  "license": "ISC",
  "dependencies": {
    "@hashgraph/sdk": "^2.69.0"
  }
}
</code></pre>

Create a `createTokenDemo.js` file and add the following imports:

```javascript
import {
  Client,
  PrivateKey,
  TokenCreateTransaction,
  TokenSupplyType
} from "@hashgraph/sdk";
```
{% endtab %}

{% tab title="Java" %}
Add the[ Java SDK](https://github.com/hiero-ledger/hiero-sdk-java) depenency to your Maven project's `pom.xml` and create your source file:

Create a new **Maven** project and name it `HederaExamples`. Add the following dependencies to your `pom.xml` file:

```xml
<dependencies>
    <dependency>
        <groupId>com.hedera.hashgraph</groupId>
        <artifactId>sdk</artifactId>
        <version>2.61.0</version>
    </dependency>
    <dependency>
        <groupId>com.google.code.gson</groupId>
        <artifactId>gson</artifactId>
        <version>2.10.1</version>
    </dependency>
    <dependency>
        <groupId>io.grpc</groupId>
        <artifactId>grpc-netty-shaded</artifactId>
        <version>1.73.0</version>
    </dependency>
</dependencies>
```

Or for **Gradle** projects using the Groovy DSL, add these dependencies to your `build.gradle` file and install the dependencies using `./gradlew build`

```gradle
plugins {
    id 'java'
    id 'application'
}

repositories {
    mavenCentral()
}

dependencies {
    implementation 'com.hedera.hashgraph:sdk:2.60.0'
    implementation 'com.google.code.gson:gson:2.10.1'
    implementation 'io.grpc:grpc-netty-shaded:1.61.0'
}

application {
    mainClass = 'CreateTokenDemo' 
    // or 'com.example.CreateTokenDemo' if it's in a package
}
```

Create a `CreateTokenDemo.java` class in `src/main/java/` with the following imports:

```java
import com.hedera.hashgraph.sdk.*;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.net.URI;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonArray;

public class CreateTokenDemo {
    public static void main(String[] args ) throws Exception {
        // Your token creation code will go here
    }
}/
```
{% endtab %}

{% tab title="Go" %}
Create a new file `create_token_demo.go`  and import the following packages to your file:

```go
import (
    "encoding/json"
    "fmt"
    "io"
    "net/http"
    "os"
    "time"

    hedera "github.com/hiero-ledger/hiero-sdk-go/v2/sdk"
)
```

In your project's root directory, initialize modules and pull in the [Go SDK](https://github.com/hiero-ledger/hiero-sdk-go):

{% code overflow="wrap" %}
```go-module
go mod init create_token_demo
go get github.com/hiero-ledger/hiero-sdk-go/v2@latest
go mod tidy
```
{% endcode %}
{% endtab %}

{% tab title="Python" %}
**Before you start:** Ensure you have Python 3.10+ installed on your machine. Run this command to verify.

```bash
python --version
```

If the `python --version` command is not found or shows a version lower than 3.10, install or upgrade Python from [Python Install](https://www.python.org/downloads/).

**Note:** On some systems, you may need to use `python3` instead of `python` for initial setup commands. If `python --version` doesn't work, try `python3 --version` and use `python3` for the virtual environment creation. After activating the virtual environment, always use `python` for all commands.

Open your terminal and create a working directory for your Hedera project. Then navigate into the new directory:

```bash
mkdir hedera-examples && cd hedera-examples
```

**Verify Python and pip:** Ensure you have Python 3.10+ and pip installed on your machine. Run these commands to check:

```bash
python --version
```

```bash
python -m pip --version
```

Create a virtual environment to isolate your project dependencies (Python best practice):

```bash
python -m venv .venv
```

Activate the virtual environment to use the isolated Python installation:

{% tabs %}
{% tab title="Mac/Linux" %}
```bash
source .venv/bin/activate
```
{% endtab %}

{% tab title="Windows" %}
```bash
.venv\Scripts\activate
```
{% endtab %}
{% endtabs %}

Upgrade pip to ensure you have the latest package installer (recommended):

```bash
python -m pip install --upgrade pip
```

Install the [Python SDK](https://github.com/hiero-ledger/hiero-sdk-python):

```bash
python -m pip install hiero_sdk_python
```

Create a file named `CreateTokenDemo.py` and add the following imports:

```python
import os
import time
import requests

from hiero_sdk_python import (
    Client,
    AccountId,
    PrivateKey,
    TokenCreateTransaction,
    TokenType,
    SupplyType,
)
```
{% endtab %}
{% endtabs %}

***

## Environment Variables

Set your operator credentials as environment variables. Your `OPERATOR_ID` is your testnet account ID. Your `OPERATOR_KEY` is your testnet account's corresponding ECDSA private key.

```bash
export OPERATOR_ID="0.0.1234"
export OPERATOR_KEY="3030020100300506032b657004220420..."
```

***

## Step 1: Initialize Hedera client

Load your operator credentials from environment variables and initialize your Hedera testnet client. This client will connect to the Hedera test network and use your operator account to sign transactions and pay transaction fees.

{% tabs %}
{% tab title="JavaScript" %}
{% code overflow="wrap" %}
```js
// Load your operator credentials
const operatorId  = process.env.OPERATOR_ID;
const operatorKey = process.env.OPERATOR_KEY;

// Initialize your testnet client and set operator
const client = Client.forTestnet()
    .setOperator(operatorId, operatorKey);
```
{% endcode %}
{% endtab %}

{% tab title="Java" %}
```java
// Load your operator credentials 
AccountId operatorId = AccountId.fromString(System.getenv("OPERATOR_ID"));
PrivateKey operatorKey = PrivateKey.fromString(System.getenv("OPERATOR_KEY"));

// Initialize your testnet client and set operator
Client client = Client.forTestnet().setOperator(operatorId, operatorKey);
```
{% endtab %}

{% tab title="Go" %}
```go
// Load your operator credentials
operatorId, _ := hedera.AccountIDFromString(os.Getenv("OPERATOR_ID"))
operatorKey, _ := hedera.PrivateKeyFromString(os.Getenv("OPERATOR_KEY"))

// Initialize the client for testnet
client := hedera.ClientForTestnet()
client.SetOperator(operatorId, operatorKey)
```
{% endtab %}

{% tab title="Python" %}
```python
# Load your operator credentials
operatorId = AccountId.from_string(os.getenv("OPERATOR_ID", ""))
operatorKey = PrivateKey.from_string(os.getenv("OPERATOR_KEY", ""))

# Initialize your testnet client and set operator
client = Client()
client.set_operator(operatorId, operatorKey)
```
{% endtab %}
{% endtabs %}

***

## Step 2: Generate Token Keys

Generate an ECDSA key and use it for both admin and supply operations.

### Why keys?

**adminKey** lets you update or delete the token; **supplyKey** authorizes mint and burn operations.  We use the same key for both roles to keep this tutorial simple.

{% tabs %}
{% tab title="JavaScript" %}
{% code overflow="wrap" %}
```js
// Generate keys that control your token
const supplyKey = PrivateKey.generateECDSA();   // can mint/burn
const adminKey  = supplyKey;    // can update and delete (reuse for simplicity)
```
{% endcode %}
{% endtab %}

{% tab title="Java" %}
```java
// Generate keys that control your token
PrivateKey supplyKey = PrivateKey.generateECDSA(); // can mint/burn
PrivateKey adminKey = supplyKey; // can update/delete (reuse for simplicity)
```
{% endtab %}

{% tab title="Go" %}
```go
// Generate keys that control your token
supplyKey, _ := hedera.PrivateKeyGenerateEcdsa() // can mint/burn
adminKey := supplyKey // can update/delete (reuse for simplicity)
```
{% endtab %}

{% tab title="Python" %}
```python
# Generate keys that control your token
supply_key = PrivateKey.generate_ecdsa()  # can mint/burn
admin_key = supply_key  # can update/delete (reuse for simplicity)
```
{% endtab %}
{% endtabs %}

**‼️ Security reminder**: Keep your private keys secure - anyone with access can control your token.

***

## Step 3: Create Your First Token on Hedera

Build a `TokenCreateTransaction` with your token properties like name, symbol, and initial supply. Sign the transaction with your **admin key**, submit it to the network, and Hedera returns a unique **token ID** that identifies your token.

{% tabs %}
{% tab title="JavaScript" %}
```js
// Build the transaction
const transaction = new TokenCreateTransaction()
  .setTokenName("Demo Token")        // readable name
  .setTokenSymbol("DEMO")
  .setDecimals(2)                    // 100 = 1.00 token
  .setInitialSupply(100_000)         // 1 000.00 DEMO in treasury
  .setSupplyType(TokenSupplyType.Finite)
  .setMaxSupply(100_000)             // cap equals initial supply
  .setTreasuryAccountId(operatorId)
  .setAdminKey(adminKey.publicKey)   // optional
  .setSupplyKey(supplyKey.publicKey) // optional for fungible tokens
  .setTokenMemo("Created via tutorial")
  .freezeWith(client);

// Sign with the admin key, execute with the operator, and get receipt
const signedTx = await transaction.sign(adminKey);
const txResponse = await signedTx.execute(client);
const receipt = await txResponse.getReceipt(client);
const tokenId = receipt.tokenId;

console.log(`\nFungible token created: ${tokenId.toString()}`)
```
{% endtab %}

{% tab title="Java" %}
```java
// Build the transaction
TokenCreateTransaction transaction = new TokenCreateTransaction()
    .setTokenName("Demo Token")
    .setTokenSymbol("DEMO")
    .setDecimals(2)
    .setInitialSupply(100_000)
    .setSupplyType(TokenSupplyType.FINITE)
    .setMaxSupply(100_000)
    .setTreasuryAccountId(operatorId)
    .setAdminKey(adminKey.getPublicKey())
    .setSupplyKey(supplyKey.getPublicKey())
    .setTokenMemo("Created via tutorial")
    .freezeWith(client);

// Sign with the admin key, execute with the operator, and get receipt
TokenCreateTransaction signedTx = transaction.sign(adminKey);
TransactionResponse txResponse = signedTx.execute(client);
TransactionReceipt receipt = txResponse.getReceipt(client);
TokenId tokenId = receipt.tokenId;

System.out.println("\nFungible token created: " + tokenId);
```
{% endtab %}

{% tab title="Go" %}
```go
// Build the transaction
transaction, _ := hedera.NewTokenCreateTransaction().
        SetTokenName("Demo Token").
        SetTokenSymbol("DEMO").
        SetDecimals(2).
        SetInitialSupply(100_000).
        SetSupplyType(hedera.TokenSupplyTypeFinite).
        SetMaxSupply(100_000).
        SetTreasuryAccountID(operatorId).
        SetAdminKey(adminKey.PublicKey()).
        SetSupplyKey(supplyKey.PublicKey()).
        SetTokenMemo("Created via tutorial").
        FreezeWith(client)

// Sign with the admin key, execute with the operator, and get receipt
signedTx := transaction.Sign(adminKey)
txResponse, _ := signedTx.Execute(client)
receipt, _ := txResponse.GetReceipt(client)
tokenId := *receipt.TokenID

fmt.Printf("Token created: %s\n", tokenId.String())
```
{% endtab %}

{% tab title="Python" %}
```python
# Build the transaction
transaction = (
    TokenCreateTransaction()
    .set_token_name("Demo Token")
    .set_token_symbol("DEMO")
    .set_decimals(2)
    .set_initial_supply(100_000)
    .set_token_type(TokenType.FUNGIBLE_COMMON)
    .set_supply_type(SupplyType.FINITE)
    .set_max_supply(100_000)
    .set_treasury_account_id(operatorId)
    .freeze_with(client)
)

# Sign with the admin key and execute
signed_tx = transaction.sign(admin_key)
receipt = signed_tx.execute(client)
token_id = receipt.token_id

print(f"\nFungible token created: {token_id}")
```
{% endtab %}
{% endtabs %}

## Step 4: Query the Treasury Balance Using Mirror Node API

Use the Mirror Node REST API to check your treasury account's token balance. Mirror nodes provide free access to network data without transaction fees.

**API endpoint:**

```
/api/v1/accounts/{accountId}/tokens?token.id={tokenId}
```

**Replace the placeholders:**

* `{accountId}` - Your treasury account (operator account)
* `{tokenId}` - Token ID from the creation transaction

> #### _Why this endpoint?_
>
> _This endpoint queries the account's token balances, filtered by the specific token ID. It returns detailed information including the balance and token metadata, making it ideal for verifying the treasury account holds the expected initial supply._

**Example URLs:**

{% tabs %}
{% tab title="JavaScript" %}
{% code overflow="wrap" %}
```js
const mirrorNodeUrl =`https://testnet.mirrornode.hedera.com/api/v1/accounts/${operatorId}/tokens?token.id=${tokenId}`;
```
{% endcode %}
{% endtab %}

{% tab title="Java" %}
{% code overflow="wrap" %}
```java
String mirrorNodeUrl = "https://testnet.mirrornode.hedera.com/api/v1/accounts/" + operatorId + "/tokens?token.id=" + tokenId;
```
{% endcode %}
{% endtab %}

{% tab title="Go" %}
{% code overflow="wrap" %}
```go
mirrorNodeUrl := "https://testnet.mirrornode.hedera.com/api/v1/accounts/" + operatorId.String( ) + "/tokens?token.id=" + tokenId.String()
```
{% endcode %}
{% endtab %}

{% tab title="Python" %}
{% code overflow="wrap" %}
```python
mirror_node_url = f"https://testnet.mirrornode.hedera.com/api/v1/accounts/{operatorId}/tokens?token.id={token_id}"
```
{% endcode %}
{% endtab %}
{% endtabs %}

**Complete Implementation:**

{% tabs %}
{% tab title="JavaScript" %}
```javascript
// Wait for Mirror Node to populate data
console.log("\nWaiting for Mirror Node to update...");
await new Promise(resolve => setTimeout(resolve, 3000));

// Query balance using Mirror Node
const mirrorNodeUrl = `https://testnet.mirrornode.hedera.com/api/v1/accounts/${operatorId}/tokens?token.id=${tokenId}`;

const response = await fetch(mirrorNodeUrl);
const data = await response.json();

if (data.tokens && data.tokens.length > 0) {
  const balance = data.tokens[0].balance;
  console.log(`\nTreasury holds: ${balance} DEMO\n`);
} else {
  console.log("Token balance not yet available in Mirror Node");
}

client.close();
```
{% endtab %}

{% tab title="Java" %}
```java
// Wait for Mirror Node to populate data
System.out.println("\nWaiting for Mirror Node to update...");
Thread.sleep(3000);

// Query balance using Mirror Node
String mirrorNodeUrl = "https://testnet.mirrornode.hedera.com/api/v1/accounts/" + 
                       operatorId + "/tokens?token.id=" + tokenId;

HttpClient httpClient = HttpClient.newHttpClient();
HttpRequest request = HttpRequest.newBuilder().uri(URI.create(mirrorNodeUrl)).build();
HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());

JsonObject data = new Gson().fromJson(response.body(), JsonObject.class);
JsonArray tokens = data.getAsJsonArray("tokens");

if (tokens.size() > 0) {
    long balance = tokens.get(0).getAsJsonObject().get("balance").getAsLong();
    System.out.println("\nTreasury holds: " + balance + " DEMO\n");
} else {
    System.out.println("Token balance not yet available in Mirror Node");
}

client.close();
```
{% endtab %}

{% tab title="Go" %}
```go
// wait for Mirror Node to populate data
fmt.Println("Waiting for Mirror Node to update...")
time.Sleep(3 * time.Second)

// query balance using Mirror Node
mirrorNodeUrl := "https://testnet.mirrornode.hedera.com/api/v1/accounts/" + 
                 operatorId.String() + "/tokens?token.id=" + tokenId.String()

response, _ := http.Get(mirrorNodeUrl)
defer response.Body.Close()

body, _ := io.ReadAll(response.Body)

var data struct {
    Tokens []struct {
        Balance int64 `json:"balance"`
    } `json:"tokens"`
}

json.Unmarshal(body, &data)

if len(data.Tokens) > 0 {
    balance := data.Tokens[0].Balance
    fmt.Printf("Treasury holds: %d DEMO\n", balance)
} else {
    fmt.Println("Token balance not yet available in Mirror Node")
}

client.Close()
```
{% endtab %}
{% tab title="Python" %}
```python
# Wait for Mirror Node to populate data
print("\nWaiting for Mirror Node to update...")
time.sleep(3)

# Query balance using Mirror Node
mirror_node_url = f"https://testnet.mirrornode.hedera.com/api/v1/accounts/{operatorId}/tokens?token.id={token_id}"

response = requests.get(mirror_node_url, timeout=10)
response.raise_for_status()
data = response.json()

tokens = data.get("tokens", [])
if tokens:
    balance = tokens[0].get("balance", 0)
    print(f"\nTreasury holds: {balance} DEMO\n")
else:
    print("Token balance not yet available in Mirror Node")

client.close()
```
{% endtab %}
{% endtabs %}

***

## ✅ Code check

Before running your project, verify your code matches the complete example:

<details>

<summary><strong>JavaScript</strong></summary>

{% code overflow="wrap" %}
```javascript
import {
  Client,
  PrivateKey,
  TokenCreateTransaction,
  TokenSupplyType
} from "@hashgraph/sdk";

async function createTokenDemo() {
  // load your operator credentials
  const operatorId = process.env.OPERATOR_ID;
  const operatorKey = process.env.OPERATOR_KEY;

  // initialize the client for testnet
  const client = Client.forTestnet()
    .setOperator(operatorId, operatorKey);

  // generate token keys
  const supplyKey = PrivateKey.generateECDSA();
  const adminKey = supplyKey;

  // build & execute the token creation transaction
  const transaction = new TokenCreateTransaction()
    .setTokenName("Demo Token")
    .setTokenSymbol("DEMO")
    .setDecimals(2)
    .setInitialSupply(100_000)
    .setSupplyType(TokenSupplyType.Finite)
    .setMaxSupply(100_000)
    .setTreasuryAccountId(operatorId)
    .setAdminKey(adminKey.publicKey)
    .setSupplyKey(supplyKey.publicKey)
    .setTokenMemo("Created via tutorial")
    .freezeWith(client);

  const signedTx = await transaction.sign(adminKey);
  const txResponse = await signedTx.execute(client);
  const receipt = await txResponse.getReceipt(client);
  const tokenId = receipt.tokenId;

  console.log(`\nFungible token created: ${tokenId}`);

  // Wait for Mirror Node to populate data
  console.log("\nWaiting for Mirror Node to update...");
  await new Promise(resolve => setTimeout(resolve, 3000));

  // query balance using Mirror Node
  const mirrorNodeUrl = `https://testnet.mirrornode.hedera.com/api/v1/accounts/${operatorId}/tokens?token.id=${tokenId}`;

  const response = await fetch(mirrorNodeUrl);
  const data = await response.json();
  
  if (data.tokens && data.tokens.length > 0) {
    const balance = data.tokens[0].balance;
    console.log(`\nTreasury holds: ${balance} DEMO\n`);
  } else {
    console.log("Token balance not yet available in Mirror Node");
  }

  client.close();
}

createTokenDemo().catch(console.error);
```
{% endcode %}

</details>

<details>

<summary><strong>Java</strong> </summary>

{% code overflow="wrap" %}
```java
import com.hedera.hashgraph.sdk.*;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.net.URI;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonArray; 

public class CreateTokenDemo {
    public static void main(String[] args ) throws Exception {
        // load your operator credentials
        AccountId operatorId = AccountId.fromString(System.getenv("OPERATOR_ID"));
        PrivateKey operatorKey = PrivateKey.fromString(System.getenv("OPERATOR_KEY"));

        // initialize the client for testnet
        Client client = Client.forTestnet().setOperator(operatorId, operatorKey);

        // generate token keys
        PrivateKey supplyKey = PrivateKey.generateECDSA();
        PrivateKey adminKey = supplyKey;

        // build & execute the token creation transaction
        TokenCreateTransaction transaction = new TokenCreateTransaction()
            .setTokenName("Demo Token")
            .setTokenSymbol("DEMO")
            .setDecimals(2)
            .setInitialSupply(100_000)
            .setSupplyType(TokenSupplyType.FINITE)
            .setMaxSupply(100_000)
            .setTreasuryAccountId(operatorId)
            .setAdminKey(adminKey.getPublicKey())
            .setSupplyKey(supplyKey.getPublicKey())
            .setTokenMemo("Created via tutorial")
            .freezeWith(client);

        TokenCreateTransaction signedTx = transaction.sign(adminKey);
        TransactionResponse txResponse = signedTx.execute(client);
        TransactionReceipt receipt = txResponse.getReceipt(client);
        TokenId tokenId = receipt.tokenId;

        System.out.println("\nFungible token created: " + tokenId );

        // Wait for Mirror Node to populate data
        System.out.println("\nWaiting for Mirror Node to update...");
        Thread.sleep(3000);

        // query balance using Mirror Node
        String mirrorNodeUrl = "https://testnet.mirrornode.hedera.com/api/v1/accounts/" + 
                               operatorId + "/tokens?token.id=" + tokenId;
        
        HttpClient httpClient = HttpClient.newHttpClient( );
        HttpRequest request = HttpRequest.newBuilder().uri(URI.create(mirrorNodeUrl)).build();
        HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString( ));
        
        JsonObject data = new Gson().fromJson(response.body(), JsonObject.class);
        JsonArray tokens = data.getAsJsonArray("tokens");
        
        if (tokens.size() > 0) {
            long balance = tokens.get(0).getAsJsonObject().get("balance").getAsLong();
            System.out.println("\nTreasury holds: " + balance + " DEMO\n");
        } else {
            System.out.println("Token balance not yet available in Mirror Node");
        }

        client.close();
    }
}

```
{% endcode %}

</details>

<details>

<summary><strong>Go</strong> </summary>

{% code overflow="wrap" %}
```go
package main

import (
    "encoding/json"
    "fmt"
    "io"
    "net/http"
    "os"
    "time"

    hedera "github.com/hiero-ledger/hiero-sdk-go/v2/sdk"
)

func main() {
	// load your operator credentials
	operatorId, _ := hedera.AccountIDFromString(os.Getenv("OPERATOR_ID"))
	operatorKey, _ := hedera.PrivateKeyFromString(os.Getenv("OPERATOR_KEY"))

	// initialize the client for testnet
	client := hedera.ClientForTestnet()
	client.SetOperator(operatorId, operatorKey)

	// generate token keys
	supplyKey, _ := hedera.PrivateKeyGenerateEcdsa()
	adminKey := supplyKey

	// build & execute the token creation transaction
	transaction, _ := hedera.NewTokenCreateTransaction().
		SetTokenName("Demo Token").
		SetTokenSymbol("DEMO").
		SetDecimals(2).
		SetInitialSupply(100_000).
		SetSupplyType(hedera.TokenSupplyTypeFinite).
		SetMaxSupply(100_000).
		SetTreasuryAccountID(operatorId).
		SetAdminKey(adminKey.PublicKey()).
		SetSupplyKey(supplyKey.PublicKey()).
		SetTokenMemo("Created via tutorial").
		FreezeWith(client)

	signedTx := transaction.Sign(adminKey)
	txResponse, _ := signedTx.Execute(client)
	receipt, _ := txResponse.GetReceipt(client)
	tokenId := *receipt.TokenID

	fmt.Printf("\nToken created: %s\n", tokenId.String())

	// Wait for Mirror Node to populate data
	fmt.Println("\nWaiting for Mirror Node to update...")
	time.Sleep(3 * time.Second)

	// query balance using Mirror Node
	mirrorNodeUrl := "https://testnet.mirrornode.hedera.com/api/v1/accounts/" +
		operatorId.String() + "/tokens?token.id=" + tokenId.String()

	response, _ := http.Get(mirrorNodeUrl)
	defer response.Body.Close()

	body, _ := io.ReadAll(response.Body)

	var data struct {
		Tokens []struct {
			Balance int64 `json:"balance"`
		} `json:"tokens"`
	}

	json.Unmarshal(body, &data)

	if len(data.Tokens) > 0 {
		balance := data.Tokens[0].Balance
		fmt.Printf("\nTreasury holds: %d DEMO\n\n", balance)
	} else {
		fmt.Println("Token balance not yet available in Mirror Node")
	}

	client.Close()
}
```
{% endcode %}

</details>

<details>

<summary><strong>Python</strong></summary>

{% code overflow="wrap" %}
```python
import os
import time
import requests

from hiero_sdk_python import (
    Client,
    AccountId,
    PrivateKey,
    TokenCreateTransaction,
    TokenType,
    SupplyType,
)

def create_token_demo():
    # Load your operator credentials
    operatorId = AccountId.from_string(os.getenv("OPERATOR_ID", ""))
    operatorKey = PrivateKey.from_string(os.getenv("OPERATOR_KEY", ""))
    
    # Initialize the client for testnet
    client = Client()
    client.set_operator(operatorId, operatorKey)
    
    # Generate token keys
    supply_key = PrivateKey.generate_ecdsa()
    admin_key = supply_key
    
    # Build & execute the token creation transaction
    transaction = (
        TokenCreateTransaction()
        .set_token_name("Demo Token")
        .set_token_symbol("DEMO")
        .set_decimals(2)
        .set_initial_supply(100_000)
        .set_token_type(TokenType.FUNGIBLE_COMMON)
        .set_supply_type(SupplyType.FINITE)
        .set_max_supply(100_000)
        .set_treasury_account_id(operatorId)
        .freeze_with(client)
    )
    
    signed_tx = transaction.sign(admin_key)
    receipt = signed_tx.execute(client)
    token_id = receipt.token_id
    
    print(f"\nFungible token created: {token_id}")
    
    # Wait for Mirror Node to populate data
    print("\nWaiting for Mirror Node to update...")
    time.sleep(3)
    
    # Query balance using Mirror Node
    mirror_node_url = f"https://testnet.mirrornode.hedera.com/api/v1/accounts/{operatorId}/tokens?token.id={token_id}"
    
    response = requests.get(mirror_node_url, timeout=10)
    response.raise_for_status()
    data = response.json()
    
    tokens = data.get("tokens", [])
    if tokens:
        balance = tokens[0].get("balance", 0)
        print(f"\nTreasury holds: {balance} DEMO\n")
    else:
        print("Token balance not yet available in Mirror Node")
    
    client.close()
```
{% endcode %}

</details>

***

## Run Your Project

Ensure your environment variables are set:

```bash
export OPERATOR_ID="0.0.1234"
export OPERATOR_KEY="3030020100300506032b657004220420..."
```

{% tabs %}
{% tab title="JavaScript" %}
```bash
node createTokenDemo.js
```
{% endtab %}

{% tab title="Java Maven" %}
```bash
mvn compile exec:java -Dexec.mainClass="com.example.CreateTokenDemo"
```
{% endtab %}

{% tab title="Java Gradle" %}
```gradle
./gradlew run
```
{% endtab %}

{% tab title="Go" %}
```bash
go run create_token_demo.go
```
{% endtab %}

{% tab title="Python" %}
```bash
python CreateTokenDemo.py
```

**When finished, deactivate the virtual environment:**

```bash
deactivate
```

{% endtab %}
{% endtabs %}

#### **Expected sample output:**

```
Fungible token created: 0.0.12345

Waiting for Mirror Node to update...

Treasury holds: 100000 DEMO
```

### ‼️ Troubleshooting&#x20;

<details>

<summary><strong>Common ERROR messages and solutions ⬇️</strong></summary>

<table><thead><tr><th width="334.36199951171875">Symptom</th><th>Likely cause</th><th>Fix</th></tr></thead><tbody><tr><td><code>INSUFFICIENT_PAYER_BALANCE</code></td><td>Not enough HBAR for transaction fees</td><td>Top up your operator account on the testnet faucet</td></tr><tr><td><code>INVALID_SIGNATURE</code></td><td>Not signing the transaction with the admin key or treasury account</td><td>Add <code>.sign(privateKey)</code>to the transaction before executing it </td></tr><tr><td><code>TOKEN_ALREADY_ASSOCIATED_TO_ACCOUNT</code></td><td>Account already associated with token</td><td>This is normal for treasury accounts - ignore this error</td></tr><tr><td><code>INVALID_ACCOUNT_ID</code></td><td>Malformed account ID in environment variables</td><td>Verify <code>OPERATOR_ID</code> format is <strong><code>0.0.1234</code></strong></td></tr><tr><td><code>INVALID_PRIVATE_KEY</code></td><td>Malformed private key in environment variables</td><td>Verify OPERATOR_KEY is a valid DER-encoded private key string</td></tr></tbody></table>

### Environment Issues:

* Environment variables not set or accessible
* Wrong network (mainnet vs testnet) configuration
* SDK version compatibility issues

</details>

***

## What just happened?

1. The SDK built a `TokenCreateTransaction` and signed it with every required key.
2. A consensus node validated signatures and attached the fee.
3. After network consensus, HTS registered your token and returned its **token ID**.
4. The full initial supply now sits in your treasury account and is ready to transfer.
5. The Mirror Node API confirmed your treasury account holds the token balance.

***

## Next steps

* [Create a Topic](create-a-topic.md)
* Try out our [3-part NFT tutorial](../tutorials/token/hedera-token-service-part-1-how-to-mint-nfts.md)
* Explore more examples in the SDK repos ([JavaScript](https://github.com/hiero-ledger/hiero-sdk-js), [Java](https://github.com/hiero-ledger/hiero-sdk-java), [Go](https://github.com/hiero-ledger/hiero-sdk-go))

***

🎉 **Great work!** You've successfully created your first fungible token on Hedera and verified its balance using the Mirror Node API. Guard your private keys and happy building!

## Additional Resources

{% embed url="https://docs.hedera.com/hedera/core-concepts/tokens" %}
