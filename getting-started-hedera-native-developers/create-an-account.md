# Create an Account

Learn how to create a new Hedera **account** on _testnet_ using the JavaScript, Java, or Go SDK. A [`Hedera account`](../core-concepts/accounts/) is your identity on‑chain. It holds your HBAR (the network’s currency) and lets you sign transactions.

***

## Prerequisites

* A Hedera testnet **operator account ID** and **ECDSA** **DER-encoded private key** (from the [Quickstart](quickstart.md)).
* A small amount of testnet **HBAR (ℏ)** to pay the `$0.05` account‑creation fee.

> ### _**Note**_&#x20;
>
> _You can always check the "_✅ [_Code Check_](create-an-account.md#code-check)_" section at the bottom of each page to view the entire code if you run into issues. You can also post your issue to the respective SDK channel in our Discord community_ [_here_](http://hedera.com/discord)_._

***

## Install the SDK

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
</strong>  "main": "createAccountDemo.js",
  "scripts": {
    "start": "node createAccountDemo.js"
  },
  "keywords": [],
  "author": "",
  "license": "ISC",
  "dependencies": {
    "@hashgraph/sdk": "^2.69.0"
  }
}
</code></pre>

Create a `createAccountDemo.js` file and add the following imports:

```javascript
import {
  Client,
  PrivateKey,
  AccountCreateTransaction,
  Hbar
} from "@hashgraph/sdk";
```
{% endtab %}

{% tab title="Java" %}
Add the[ Java SDK](https://github.com/hiero-ledger/hiero-sdk-java) dependency to your Maven project's `pom.xml` and create your source file:

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
    mainClass = 'CreateAccountDemo' 
    // or 'com.example.CreateAccountDemo' if it's in a package
}
```

Create a `CreateAccountDemo.java` class in `src/main/java/` with the following imports:

```java
import com.hedera.hashgraph.sdk.*;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.net.URI;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonArray;

public class CreateAccountDemo {
    public static void main(String[] args) throws Exception {
        // Your account creation code will go here
    }
}
```
{% endtab %}

{% tab title="Go" %}
Create a new file `create_account_demo.go` and import the following packages to your file:

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
go mod init create_account_demo
go get github.com/hiero-ledger/hiero-sdk-go/v2@latest
go mod tidy
```
{% endtab %}

{% tab title="Python" %}
**Before you start:** Ensure you have Python 3.10+ installed on your machine. Run this command to verify.

```bash
python --version
```

If the `python --version` command is not found or shows a version lower than 3.10, install or upgrade Python from [Python Install](https://www.python.org/downloads/).

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

Create a file named `CreateAccountDemo.py` and add the following imports:

```python
import os
import time
import requests

from hiero_sdk_python import (
    Client,
    AccountId,
    PrivateKey,
    AccountCreateTransaction,
    Hbar,
)

# Used to print the EVM address for the new ECDSA public key
from hiero_sdk_python.utils.crypto_utils import keccak256
```
{% endtab %}
{% endtabs %}

***

## Environment Variables

Set your testnet operator credentials as environment variables. Your `OPERATOR_ID` is your testnet account ID. Your `OPERATOR_KEY` is your testnet account's corresponding ECDSA private key.&#x20;

```bash
export OPERATOR_ID="0.0.1234"
export OPERATOR_KEY="3030020100300506032b657004220420..."
```

***

## Step 1: Initialize Hedera Client

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
<pre class="language-go"><code class="lang-go"><strong>// load your operator credentials
</strong>operatorId, _ := hedera.AccountIDFromString(os.Getenv("OPERATOR_ID"))
operatorKey, _ := hedera.PrivateKeyFromString(os.Getenv("OPERATOR_KEY"))

// initialize the client for testnet
client := hedera.ClientForTestnet()
client.SetOperator(operatorId, operatorKey)
</code></pre>
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

## Step 2: Generate a New Key Pair

Generate a new ECDSA private/public key pair for the account you'll create.&#x20;

### **Why keys?**

On the Hedera network, a **private key** allows you to sign transactions, ensuring only you control your assets, while a **public key**, shared on-chain, verifies your identity. This key pair is essential for account security.

{% tabs %}
{% tab title="JavaScript" %}
```js
// generates a new ECDSA key pair in memory
const newPrivateKey = PrivateKey.generateECDSA();
const newPublicKey = newPrivateKey.publicKey;
```
{% endtab %}

{% tab title="Java" %}
```java
// generate an ECDSA key pair in memory
PrivateKey newPrivateKey = PrivateKey.generateECDSA();
PublicKey newPublicKey   = newPrivateKey.getPublicKey();
```
{% endtab %}

{% tab title="Go" %}
```go
// generate a new key pair
newPrivateKey, _ := hedera.PrivateKeyGenerateEcdsa()
newPublicKey := newPrivateKey.PublicKey()
```
{% endtab %}

{% tab title="Python" %}
```python
# generate a new ECDSA key pair in memory
newPrivateKey = PrivateKey.generate_ecdsa()
newPublicKey = newPrivateKey.public_key()
```
{% endtab %}
{% endtabs %}

**‼️ Security reminder**: Keep your private keys secure - anyone with access can control your account and funds.

***

## Step 3: Create Your First Account on Hedera

Build an `AccountCreateTransaction` with the _new public key_ and initial balance, then execute it. Specify the public key , an optional initial HBAR balance, and once you execute it, the network creates the account and returns the new `AccountId` in the receipt.

{% tabs %}
{% tab title="JavaScript" %}
```js
// Build & execute the account creation transaction
const transaction = new AccountCreateTransaction()
  .setECDSAKeyWithAlias(newPublicKey)  // set the account key
  .setInitialBalance(new Hbar(20));    // fund with 20 HBAR

const txResponse = await transaction.execute(client);
const receipt = await txResponse.getReceipt(client);
const newAccountId = receipt.accountId;

console.log(`\nHedera Account created: ${newAccountId}`);
console.log(`EVM Address: 0x${newPublicKey.toEvmAddress()}`);
```
{% endtab %}

{% tab title="Java" %}
```java
// Build & execute the account creation transaction
AccountCreateTransaction transaction = new AccountCreateTransaction()
    .setKeyWithAlias(newPublicKey) // set the account key
    .setInitialBalance(new Hbar(20)); // fund with 20 HBAR

TransactionResponse txResponse = transaction.execute(client);
TransactionReceipt receipt = txResponse.getReceipt(client);
AccountId newAccountId = receipt.accountId;

System.out.println("\nHedera Account created: " + newAccountId);
System.out.println("EVM Address: 0x" + newPublicKey.toEvmAddress());
```
{% endtab %}

{% tab title="Go" %}
```go
// build & execute the account creation transaction
transaction := hedera.NewAccountCreateTransaction().
    SetECDSAKeyWithAlias(newPublicKey).     // set the account key
    SetInitialBalance(hedera.NewHbar(20))   // fund with 20 HBAR

// execute the transaction and get response
txResponse, err := transaction.Execute(client)
if err != nil {
    panic(err)
}

// get the receipt to extract the new account ID
receipt, err := txResponse.GetReceipt(client)
if err != nil {
    panic(err)
}

newAccountId := *receipt.AccountID

fmt.Printf("Hedera Account created: %s\n", newAccountId.String())
fmt.Printf("EVM Address: 0x%s\n", newPublicKey.ToEvmAddress())
```
{% endtab %}

{% tab title="Python" %}
```python
# Build & execute the account creation transaction
transaction = (
    AccountCreateTransaction()
      .set_key(newPublicKey)            # set the account key
      .set_initial_balance(Hbar(20))    # fund with 20 HBAR
)

# Get the receipt to extract the new account ID
receipt = transaction.execute(client)
newAccountId = receipt.account_id

evm_address = keccak256(newPublicKey.to_bytes_ecdsa(compressed=False)[1:])[-20:].hex()

print(f"\nHedera account created: {newAccountId}")
print(f"EVM Address: 0x{evm_address}")
```
{% endtab %}
{% endtabs %}

***

## Step 4: Query the Account Balance Using Mirror Node API

Use the Mirror Node REST API to check your new account's HBAR balance. Mirror nodes provide free access to network data without transaction fees.

**API endpoint:**

```
/api/v1/balances?account.id={accountId}
```

**Replace the placeholder:**

* **`{accountId}`** - Your new account ID from the creation transaction

> #### _Why this endpoint?_
>
> _This endpoint queries account balances directly by account ID. It returns detailed information including HBAR balance in tinybars, making it ideal for verifying the new account was funded with the expected initial balance._

**Example URLs:**

{% tabs %}
{% tab title="JavaScript" %}
{% code overflow="wrap" %}
```javascript
const mirrorNodeUrl = `https://testnet.mirrornode.hedera.com/api/v1/balances?account.id=${newAccountId}`;
```
{% endcode %}
{% endtab %}

{% tab title="Java" %}
{% code overflow="wrap" %}
```java
String mirrorNodeUrl = "https://testnet.mirrornode.hedera.com/api/v1/balances?account.id=" + newAccountId;
```
{% endcode %}
{% endtab %}

{% tab title="Go" %}
{% code overflow="wrap" %}
```go
mirrorNodeUrl := "https://testnet.mirrornode.hedera.com/api/v1/balances?account.id=" + newAccountId.String( )
```
{% endcode %}
{% endtab %}

{% tab title="Python" %}
{% code overflow="wrap" %}
```python
mirror_node_url = f"https://testnet.mirrornode.hedera.com/api/v1/balances?account.id={newAccountId}"
```
{% endcode %}
{% endtab %}
{% endtabs %}

#### Complete  Implementation:

{% tabs %}
{% tab title="JavaScript" %}
```js
// Wait for Mirror Node to populate data
console.log("\nWaiting for Mirror Node to update...");
await new Promise(resolve => setTimeout(resolve, 6000));

// Query balance using Mirror Node
const mirrorNodeUrl = `https://testnet.mirrornode.hedera.com/api/v1/balances?account.id=${newAccountId}`;

const response = await fetch(mirrorNodeUrl );
const data = await response.json();

if (data.balances && data.balances.length > 0) {
  const balanceInTinybars = data.balances[0].balance;
  const balanceInHbar = balanceInTinybars / 100000000;
  console.log(`\nAccount balance: ${balanceInHbar} ℏ\n`);
} else {
  console.log("Account balance not yet available in Mirror Node");
}

client.close();
```
{% endtab %}

{% tab title="Java" %}
```java
// Wait for Mirror Node to populate data
System.out.println("\nWaiting for Mirror Node to update...");
Thread.sleep(6000);

// Query balance using Mirror Node
String mirrorNodeUrl = "https://testnet.mirrornode.hedera.com/api/v1/balances?account.id=" + newAccountId;

HttpClient httpClient = HttpClient.newHttpClient( );
HttpRequest request = HttpRequest.newBuilder().uri(URI.create(mirrorNodeUrl)).build();
HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString( ));

JsonObject data = new Gson().fromJson(response.body(), JsonObject.class);
JsonArray balances = data.getAsJsonArray("balances");

if (balances.size() > 0) {
    long balanceInTinybars = balances.get(0).getAsJsonObject().get("balance").getAsLong();
    double balanceInHbar = balanceInTinybars / 100000000.0;
    System.out.println("\nAccount balance: " + balanceInHbar + " ℏ\n");
} else {
    System.out.println("Account balance not yet available in Mirror Node");
}

client.close();
```
{% endtab %}

{% tab title="Go" %}
```go
// wait for Mirror Node to populate data
fmt.Println("\nWaiting for Mirror Node to update...")
time.Sleep(6 * time.Second)

// query balance using Mirror Node
mirrorNodeUrl := "https://testnet.mirrornode.hedera.com/api/v1/balances?account.id=" + newAccountId.String()
resp, _ := http.Get(mirrorNodeUrl)
defer resp.Body.Close()

body, _ := io.ReadAll(resp.Body)

var data struct {
	Balances []struct {
		Balance int64 `json:"balance"`
	} `json:"balances"`
}

json.Unmarshal(body, &data)

if len(data.Balances) > 0 {
	balanceInTinybars := data.Balances[0].Balance
	balanceInHbar := float64(balanceInTinybars) / 100000000.0
	fmt.Printf("\nAccount balance: %g ℏ\n\n", balanceInHbar)
} else {
	fmt.Println("\nAccount balance not yet available in Mirror Node")
}

client.Close()
```
{% endtab %}

{% tab title="Python" %}
```python
# Wait for Mirror Node to populate data
print("\nWaiting for Mirror Node to update...\n")
time.sleep(6)

# Query balance using Mirror Node
mirrorNodeUrl = f"https://testnet.mirrornode.hedera.com/api/v1/balances?account.id={newAccountId}"
response = requests.get(mirrorNodeUrl, timeout=10)
response.raise_for_status()
data = response.json()
balances = data.get("balances", [])

if balances:
    balanceInTinybars = balances[0].get("balance", 0)
    balanceInHbar = balanceInTinybars / 100_000_000
    print(f"Account balance: {balanceInHbar:g} ℏ\n")
else:
    print("Account balance not yet available in Mirror Node")
```

{% endtab %}
{% endtabs %}

***

## ✅ Code check&#x20;

Before running your project, verify your code matches the complete example:

<details>

<summary><strong>JavaScript</strong></summary>

{% code overflow="wrap" %}
```javascript
import {
  Client,
  PrivateKey,
  AccountCreateTransaction,
  Hbar
} from "@hashgraph/sdk";

async function createAccountDemo() {
  // load your operator credentials
  const operatorId = process.env.OPERATOR_ID;
  const operatorKey = process.env.OPERATOR_KEY;

  // initialize the client for testnet
  const client = Client.forTestnet()
    .setOperator(operatorId, operatorKey);

  // generate a new key pair
  const newPrivateKey = PrivateKey.generateECDSA();
  const newPublicKey = newPrivateKey.publicKey;

  // build & execute the account creation transaction
  const transaction = new AccountCreateTransaction()
    .setECDSAKeyWithAlias(newPublicKey)          // set the account key with alias
    .setInitialBalance(new Hbar(20));           // fund with 20 HBAR

  const txResponse = await transaction.execute(client);
  const receipt = await txResponse.getReceipt(client);
  const newAccountId = receipt.accountId;

  console.log(`\nHedera account created: ${newAccountId}`);
  console.log(`EVM Address: 0x${newPublicKey.toEvmAddress()}`);

  // Wait for Mirror Node to populate data
  console.log("\nWaiting for Mirror Node to update...");
  await new Promise(resolve => setTimeout(resolve, 6000));

  // query balance using Mirror Node
  const mirrorNodeUrl = `https://testnet.mirrornode.hedera.com/api/v1/balances?account.id=${newAccountId}`;

  const response = await fetch(mirrorNodeUrl);
  const data = await response.json();

  if (data.balances && data.balances.length > 0) {
    const balanceInTinybars = data.balances[0].balance;
    const balanceInHbar = balanceInTinybars / 100000000;
    
    console.log(`\nAccount balance: ${balanceInHbar} ℏ\n`);
  } else {
    console.log("Account balance not yet available in Mirror Node");
  }

  client.close();
}

createAccountDemo().catch(console.error);
```
{% endcode %}

</details>

<details>

<summary><strong>Java</strong></summary>

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

public class CreateAccountDemo {
    public static void main(String[] args) throws Exception {
        // load your operator credentials
        String operatorId = System.getenv("OPERATOR_ID");
        String operatorKey = System.getenv("OPERATOR_KEY");

        // initialize the client for testnet
        Client client = Client.forTestnet()
            .setOperator(AccountId.fromString(operatorId),         PrivateKey.fromString(operatorKey));

        // generate a new key pair
        PrivateKey newPrivateKey = PrivateKey.generateECDSA();
        PublicKey newPublicKey = newPrivateKey.getPublicKey();

        // build & execute the account creation transaction
        AccountCreateTransaction transaction = new AccountCreateTransaction()
            // set the account key with alias
            .setKeyWithAlias(newPublicKey)          
            .setInitialBalance(new Hbar(20)); // fund with 20 HBAR           

        TransactionResponse txResponse = transaction.execute(client);
        TransactionReceipt receipt = txResponse.getReceipt(client);
        AccountId newAccountId = receipt.accountId;

        System.out.println("\nHedera account created: " + newAccountId);
        System.out.println("EVM Address: 0x" + newPublicKey.toEvmAddress() + "\n");

        // Wait for Mirror Node to populate data
        System.out.println("\nWaiting for Mirror Node to update...\n");
        Thread.sleep(6000);

        // query balance using Mirror Node
        String mirrorNodeUrl = "https://testnet.mirrornode.hedera.com/api/v1/balances?account.id=" + newAccountId;

        HttpClient httpClient = HttpClient.newHttpClient();
        HttpRequest request = HttpRequest.newBuilder()
            .uri(URI.create(mirrorNodeUrl))
            .build();

        HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
        Gson gson = new Gson();
        JsonObject data = gson.fromJson(response.body(), JsonObject.class);

        if (data.has("balances") && data.getAsJsonArray("balances").size() > 0) {
            JsonArray balances = data.getAsJsonArray("balances");
            JsonObject accountBalance = balances.get(0).getAsJsonObject();
            long balanceInTinybars = accountBalance.get("balance").getAsLong();
            double balanceInHbar = balanceInTinybars / 100000000.0;
            
            System.out.println("Account balance: " + balanceInHbar + " ℏ\n");
        } else {
            System.out.println("Account balance not yet available in Mirror Node");
        }

        client.close();
    }
}
```
{% endcode %}

</details>

<details>

<summary><strong>Go</strong></summary>

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

	// generate a new key pair
	newPrivateKey, _ := hedera.PrivateKeyGenerateEcdsa()
	newPublicKey := newPrivateKey.PublicKey()

	// build & execute the account creation transaction
	transaction := hedera.NewAccountCreateTransaction().
		SetECDSAKeyWithAlias(newPublicKey).   // set the account key with alias
		SetInitialBalance(hedera.NewHbar(20)) // fund with 20 HBAR

	txResponse, _ := transaction.Execute(client)
	receipt, _ := txResponse.GetReceipt(client)
	newAccountId := *receipt.AccountID

	fmt.Printf("\nHedera account created: %s\n", newAccountId.String())
	fmt.Printf("EVM Address: 0x%s\n", newPublicKey.ToEvmAddress())

	// wait for Mirror Node to populate data
	fmt.Println("\nWaiting for Mirror Node to update...")
	time.Sleep(6 * time.Second)

	// query balance using Mirror Node
	mirrorNodeUrl := "https://testnet.mirrornode.hedera.com/api/v1/balances?account.id=" + newAccountId.String()
	resp, _ := http.Get(mirrorNodeUrl)
	defer resp.Body.Close()

	body, _ := io.ReadAll(resp.Body)

	var data struct {
		Balances []struct {
			Balance int64 `json:"balance"`
		} `json:"balances"`
	}

	json.Unmarshal(body, &data)

	if len(data.Balances) > 0 {
		balanceInTinybars := data.Balances[0].Balance
		balanceInHbar := float64(balanceInTinybars) / 100000000.0
		fmt.Printf("\nAccount balance: %g ℏ\n\n", balanceInHbar)
	} else {
		fmt.Println("\nAccount balance not yet available in Mirror Node")
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
# CreateAccountDemo.py

import os
import time
import requests
from hiero_sdk_python import (
    Client, AccountId, PrivateKey, AccountCreateTransaction, Hbar
)
from hiero_sdk_python.utils.crypto_utils import keccak256

# load your operator credentials
operatorId = AccountId.from_string(os.getenv("OPERATOR_ID", ""))
operatorKey = PrivateKey.from_string(os.getenv("OPERATOR_KEY", ""))

# initialize the client for testnet
client = Client()
client.set_operator(operatorId, operatorKey)

# generate a new key pair
newPrivateKey = PrivateKey.generate_ecdsa()
newPublicKey = newPrivateKey.public_key()

# build & execute the account creation transaction
transaction = (
    AccountCreateTransaction()
      .set_key(newPublicKey)            # set the account key
      .set_initial_balance(Hbar(20))    # fund with 20 HBAR
)
receipt = transaction.execute(client)
newAccountId = receipt.account_id
evm_address = keccak256(newPublicKey.to_bytes_ecdsa(compressed=False)[1:])[-20:].hex()

print(f"\nHedera account created: {newAccountId}")
print(f"EVM Address: 0x{evm_address}")

# wait for Mirror Node to populate data
print("\nWaiting for Mirror Node to update...\n")
time.sleep(6)

# query balance using Mirror Node
mirrorNodeUrl = f"https://testnet.mirrornode.hedera.com/api/v1/balances?account.id={newAccountId}"
response = requests.get(mirrorNodeUrl, timeout=10)
response.raise_for_status()
data = response.json()
balances = data.get("balances", [])

if balances:
    balanceInTinybars = balances[0].get("balance", 0)
    balanceInHbar = balanceInTinybars / 100_000_000
    print(f"Account balance: {balanceInHbar:g} ℏ\n")
else:
    print("Account balance not yet available in Mirror Node")

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
node createAccountDemo.js
```
{% endtab %}

{% tab title="Java Maven" %}
```bash
mvn compile exec:java -Dexec.mainClass="com.example.CreateAccountDemo"
```
{% endtab %}

{% tab title="Java Gradle" %}
```gradle
./gradlew run
```
{% endtab %}

{% tab title="Go" %}
```bash
go run create_account_demo.go
```
{% endtab %}

{% tab title="Python" %}
```bash
python CreateAccountDemo.py
```

**When finished, deactivate the virtual environment:**

```bash
deactivate
```

{% endtab %}
{% endtabs %}

#### **Expected sample output:**

```
Hedera account created: 0.0.12345
EVM Address: 0xabcdef0123456789abcdef0123456789abcdef01

Waiting for Mirror Node to update...

Account balance: 20 ℏ
```

### ‼️ Troubleshooting&#x20;

<details>

<summary><strong>Common ERROR messages and solutions ⬇️</strong></summary>

<table><thead><tr><th width="252.6632080078125">Error message</th><th>Likely cause</th><th>Fix</th></tr></thead><tbody><tr><td><code>INSUFFICIENT_PAYER_BALANCE</code></td><td>Operator account lacks enough ℏ for the fee.</td><td>Top‑up your testnet account with the <a href="https://portal.hedera.com/signup">HBAR faucet</a>.</td></tr><tr><td><code>INVALID_SIGNATURE</code></td><td>Operator key doesn't match operator account</td><td>Verify OPERATOR_KEY matches your OPERATOR_ID</td></tr><tr><td><code>INVALID_ACCOUNT_ID</code></td><td>Malformed account ID in environment variables</td><td>Verify OPERATOR_ID format is <code>0.0.1234</code></td></tr><tr><td><code>INVALID_PRIVATE_KEY</code></td><td>Malformed private key in environment variables</td><td>Verify OPERATOR_KEY is a valid DER-encoded private key string</td></tr><tr><td><code>KEY_REQUIRED</code></td><td>Missing key in AccountCreateTransaction</td><td>Ensure you call <code>.setECDSAKeyWithAlias(newPublicKey)</code></td></tr><tr><td><code>OPERATOR_ID and OPERATOR_KEY must be set</code></td><td>Environment variables not accessible</td><td>Check environment variables are set and accessible to your application</td></tr><tr><td><code>Cannot read properties of undefined</code></td><td>Missing imports or undefined variables</td><td>Verify all imports are included and variables are defined</td></tr></tbody></table>



</details>

***

## What just happened?

1. The SDK built an **`AccountCreateTransaction`** and signed it with your operator key.
2. A consensus node validated the signature and charged the account creation fee.
3. After network consensus, a unique **account ID** and **EVM address** were assigned and returned in the receipt.
4. The account was funded with **20 HBAR** from your operator account.
5. The Mirror Node API confirmed your new account exists with the expected balance.

***

## Next steps

* [Learn more about accounts](https://docs.hedera.com/hedera/core-concepts/accounts)
* [Create a Token](create-a-token.md)
* Explore more examples in the SDK repos ([JavaScript](https://github.com/hiero-ledger/hiero-sdk-js), [Java](https://github.com/hiero-ledger/hiero-sdk-java), [Go](https://github.com/hiero-ledger/hiero-sdk-go))

***

***

🎉 **Great work!** You now control a brand new Hedera account secured by your fresh key pair. Keep the private key safe and never commit it to source control.

{% hint style="info" %}
Have a question? [Ask it on StackOverflow](https://stackoverflow.com/questions/tagged/hedera-hashgraph)
{% endhint %}

## Additional resources

{% embed url="https://docs.hedera.com/hedera/core-concepts/accounts" %}
