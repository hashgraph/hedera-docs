# Create a Topic

Learn how to create a new topic and submit your first message on Hedera testnet using the JavaScript, Java, Go SDK, or Python. A **topic** on the **Hedera Consensus Service (HCS)** is like a public channel: anyone who knows the topic ID can publish timestamped messages, and anyone can subscribe to the stream from a mirror node.

***

## **Prerequisites**

* A Hedera testnet **operator account ID** and **DER-encoded private key** (from the [Quickstart](quickstart.md)).
* A small amount of testnet **HBAR (ℏ)** to cover the fees
  * Topic creation: ≈ `$0.01`
  * Each message: < `$0.001`

> #### _**Note**_
>
> _You can always check the "_✅ [_Code Check_](create-a-topic.md#code-check)_" section at the bottom of each page to view the entire code if you run into issues. You can also post your issue to the respective SDK channel in our Discord community_ [_here_](http://hedera.com/discord)_._

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
</strong>  "main": "createTopicDemo.js",
  "scripts": {
    "start": "node createTopicDemo.js"
  },
  "keywords": [],
  "author": "",
  "license": "ISC",
  "dependencies": {
    "@hashgraph/sdk": "^2.69.0"
  }
}
</code></pre>

Create a `createTopicDemo.js` file and add the following imports:

```javascript
import {
  Client,
  TopicCreateTransaction,
  TopicMessageSubmitTransaction
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
    mainClass = 'CreateTopicDemo' 
    // or 'com.example.CreateTopicDemo' if it's in a package
}
```

Create a `CreateTopicDemo.java` class in `src/main/java/` with the following imports:

```java
import com.hedera.hashgraph.sdk.*;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.net.URI;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonArray;

public class CreateTopicDemo {
    public static void main(String[] args) throws Exception {
        // Your topic creation code will go here
    }
}
```
{% endtab %}

{% tab title="Go" %}
Create a new file `create_topic_demo.go` and import the following packages to your file:

```go
import ( 
    "encoding/base64" 
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
go mod init create_topic_demo
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

Create a file named `CreateTopicDemo.py` and add the following imports:

```python
import os
import time
import base64
import requests

from hiero_sdk_python import (
    Client,
    AccountId,
    PrivateKey,
    TopicCreateTransaction,
    TopicMessageSubmitTransaction,
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

## Step 1: Initialize Hedera Client

Load your operator credentials from environment variables and configure your Hedera testnet client. The client manages your connection to the Hedera test network and uses your operator account to sign transactions and pay transaction fees.

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

## Step 2: Create a new topic

`TopicCreateTransaction` builds and sends the transaction to register a new HCS topic with the provided memo, and once it reaches consensus you retrieve the transaction receipt to extract the new `topicId`.

### Why messages?

Messages on HCS are consensus-timestamped and immutable. Once published, they become part of the permanent record that anyone can verify and subscribe to in real-time.

{% tabs %}
{% tab title="JavaScript" %}
```js
// Build and send the transaction
const txResponse = await new TopicCreateTransaction()
  .setTopicMemo("My first HCS topic")   // optional description
  .execute(client);

const receipt = await txResponse.getReceipt(client);
const topicId = receipt.topicId;

console.log(`\nTopic created: ${topicId.toString()}`);
```
{% endtab %}

{% tab title="Java" %}
```java
// Build and send the create‐topic transaction
TransactionResponse txResponse = new TopicCreateTransaction()
    .setTopicMemo("My first HCS topic")   // optional description
    .execute(client);

// Fetch the receipt to get the new topic ID
TransactionReceipt receipt = txResponse.getReceipt(client);
TopicId topicId = receipt.topicId;

System.out.println("Topic created: " + topicId);
```
{% endtab %}

{% tab title="Go" %}
```go
// build & execute the topic creation transaction
transaction := hedera.NewTopicCreateTransaction().
    SetTopicMemo("My first HCS topic")

txResponse, err := transaction.Execute(client)
if err != nil {
	panic(err)
}

receipt, err := txResponse.GetReceipt(client)
if err != nil {
	panic(err)
}

topicID := *receipt.TopicID

fmt.Println("\nTopic created:", topicID.String())
```
{% endtab %}

{% tab title="Python" %}
```python
# build & execute the topic creation transaction
transaction = (
    TopicCreateTransaction(
        memo="My first HCS topic",
        admin_key=operatorKey.public_key()
    )
    .freeze_with(client)
    .sign(operatorKey)
)

receipt = transaction.execute(client)
topicId = receipt.topic_id

print(f"\nTopic created: {topicId}")
```
{% endtab %}
{% endtabs %}

## What just happened?

1. The SDK built a **TopicCreateTransaction**.
2. Your operator key signed and paid the fee.
3. Hedera nodes reached consensus and returned a unique topic ID (`shard.realm.num`).

***

## Step 3: Submit Message to Topic

`TopicMessageSubmitTransaction` constructs and sends a transaction that submits your payload (string, bytes, or `Uint8Array`) as a message to a specified HCS topic. Once it reaches consensus, the message becomes part of that topic’s immutable record.

{% tabs %}
{% tab title="JavaScript" %}
```js
// Build & execute the message submission transaction
const message = "Hello, Hedera!";

const messageTransaction = new TopicMessageSubmitTransaction()
  .setTopicId(topicId)
  .setMessage(message);

await messageTransaction.execute(client);

console.log(`\nMessage submitted: ${message}\n`);
```
{% endtab %}

{% tab title="Java" %}
```java
// build & execute the message submission transaction
String message = "Hello, Hedera!";

TopicMessageSubmitTransaction messageTransaction = new TopicMessageSubmitTransaction()
    .setTopicId(topicId)
    .setMessage(message);

messageTransaction.execute(client);

System.out.println("\nMessage submitted: " + message);
```
{% endtab %}

{% tab title="Go" %}
```go
// build & execute the message submission transaction
message := "Hello, Hedera!"

messageTransaction := hedera.NewTopicMessageSubmitTransaction().
    SetTopicID(topicID).
    SetMessage([]byte(message))

_, err = messageTransaction.Execute(client)
if err != nil {
    panic(err)
}

fmt.Printf("\nMessage submitted: %s\n", message)
```
{% endtab %}

{% tab title="Python" %}
```python
# build & execute the message submission transaction
message = "Hello, Hedera!"

message_transaction = (
    TopicMessageSubmitTransaction()
    .set_topic_id(topicId)
    .set_message(message)
    .freeze_with(client)
    .sign(operatorKey)
)

message_transaction.execute(client)

print(f"\nMessage submitted: {message}")
```
{% endtab %}
{% endtabs %}

{% hint style="info" %}
**Note**

Messages can be up to **1 KiB** each. Larger payloads must be chunked automatically by the SDK or split manually
{% endhint %}

***

## Step 4: Query Messages Using Mirror Node API

Use the Mirror Node REST API to verify your message was published to the topic. Mirror nodes provide free access to network data without transaction fees. Mirror nodes stream every consensus-timestamped message in order, letting your app react in real time.

**API endpoint:**

```
/api/v1/topics/{topicId}/messages
```

**Replace the placeholder:**

* <sub>**{topicId}**</sub> - Your topic ID from the creation transaction

> _**Why this endpoint?**_
>
> _This endpoint retrieves all messages published to a specific topic, ordered by consensus timestamp. It returns detailed information including message content, timestamp, and sequence number, making it ideal for verifying your message was published successfully._

**Example URLs:**

{% tabs %}
{% tab title="JavaScript" %}
{% code overflow="wrap" %}
```javascript
const mirrorNodeUrl = `https://testnet.mirrornode.hedera.com/api/v1/topics/${topicId}/messages`;
```
{% endcode %}
{% endtab %}

{% tab title="Java" %}
{% code overflow="wrap" %}
```java
String mirrorNodeUrl = "https://testnet.mirrornode.hedera.com/api/v1/topics/" + topicId + "/messages";
```
{% endcode %}
{% endtab %}

{% tab title="Go" %}
{% code overflow="wrap" %}
```ruby
mirrorNodeUrl := "https://testnet.mirrornode.hedera.com/api/v1/topics/" + topicID.String() + "/messages"
```
{% endcode %}
{% endtab %}

{% tab title="Python" %}
{% code overflow="wrap" %}
```python
mirror_node_url = f"https://testnet.mirrornode.hedera.com/api/v1/topics/{topicId}/messages"
```
{% endcode %}
{% endtab %}
{% endtabs %}

**Complete Implementation:**

{% tabs %}
{% tab title="JavaScript" %}
```javascript
// wait for Mirror Node to populate data
console.log("\nWaiting for Mirror Node to update...");
await new Promise((resolve) => setTimeout(resolve, 6000));

// query messages using Mirror Node
const mirrorNodeUrl = `https://testnet.mirrornode.hedera.com/api/v1/topics/${topicId}/messages`;

const response = await fetch(mirrorNodeUrl);
const data = await response.json();

if (data.messages && data.messages.length > 0) {
  const latestMessage = data.messages[data.messages.length - 1];
  const messageContent = Buffer.from(latestMessage.message, "base64")
    .toString("utf8")
    .trim();

  console.log(`\nLatest message: ${messageContent}\n`);
} else {
  console.log("No messages found yet in Mirror Node");
}

client.close();
```
{% endtab %}

{% tab title="Java" %}
{% code overflow="wrap" %}
```java
// wait for Mirror Node to populate data
System.out.println("\nWaiting for Mirror Node to update...");
Thread.sleep(6000);

// query messages using Mirror Node
String mirrorNodeUrl = "https://testnet.mirrornode.hedera.com/api/v1/topics/" + topicId + "/messages";

HttpClient httpClient = HttpClient.newHttpClient( );
HttpRequest request = HttpRequest.newBuilder()
    .uri(URI.create(mirrorNodeUrl))
    .build();

HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString( ));
Gson gson = new Gson();
JsonObject data = gson.fromJson(response.body(), JsonObject.class);

if (data.has("messages") && data.getAsJsonArray("messages").size() > 0) {
    JsonArray messages = data.getAsJsonArray("messages");
    JsonObject latestMessage = messages.get(messages.size() - 1).getAsJsonObject();
    String encodedMessage = latestMessage.get("message").getAsString();
    String messageContent = new String(java.util.Base64.getDecoder().decode(encodedMessage)).trim();
            
    System.out.println("\nLatest message: " + messageContent + "\n");
  } else {
    System.out.println("No messages found yet in Mirror Node");
  }

client.close();
```
{% endcode %}
{% endtab %}

{% tab title="Go" %}
```go
// wait for Mirror Node to populate data
fmt.Println("Waiting for Mirror Node to update...")
time.Sleep(6 * time.Second)

// query messages using Mirror Node
mirrorNodeUrl := "https://testnet.mirrornode.hedera.com/api/v1/topics/" + topicID.String() + "/messages"

resp, err := http.Get(mirrorNodeUrl)
if err != nil {
	panic(err)
}
defer resp.Body.Close()

body, err := io.ReadAll(resp.Body)
if err != nil {
	panic(err)
}

var data struct {
	Messages []struct {
		Message string `json:"message"`
	} `json:"messages"`
}

err = json.Unmarshal(body, &data)
if err != nil {
	panic(err)
}

if len(data.Messages) > 0 {
	latestMessage := data.Messages[len(data.Messages)-1]
	decodedMessage, _ := base64.StdEncoding.DecodeString(latestMessage.Message)

	fmt.Println("\nLatest message:", strings.TrimSpace(string(decodedMessage)))
} else {
	fmt.Println("No messages found yet in Mirror Node")
}

client.Close()
```
{% endtab %}

{% tab title="Python" %}
```python
# wait for Mirror Node to populate data
print("\nWaiting for Mirror Node to update...")
time.sleep(6)

# query messages using Mirror Node
mirror_node_url = f"https://testnet.mirrornode.hedera.com/api/v1/topics/{topicId}/messages"

response = requests.get(mirror_node_url, timeout=10)
response.raise_for_status()
data = response.json()

messages = data.get("messages", [])
if messages:
    latest_message = messages[-1]
    encoded_message = latest_message.get("message", "")
    message_content = base64.b64decode(encoded_message).decode("utf-8").strip()
    
    print(f"\nLatest message: {message_content}\n")
else:
    print("No messages found yet in Mirror Node")
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
  TopicCreateTransaction,
  TopicMessageSubmitTransaction,
} from "@hashgraph/sdk";

async function createTopicDemo() {
  // load your operator credentials
  const operatorId = process.env.OPERATOR_ID;
  const operatorKey = process.env.OPERATOR_KEY;

  // initialize the client for testnet
  const client = Client.forTestnet().setOperator(operatorId, operatorKey);

  // build & execute the topic creation transaction
  const transaction = new TopicCreateTransaction().setTopicMemo(
    "My first HCS topic"
  );

  const txResponse = await transaction.execute(client);
  const receipt = await txResponse.getReceipt(client);
  const topicId = receipt.topicId;

  console.log(`\nTopic created: ${topicId}`);

  // build & execute the message submission transaction
  const message = "Hello, Hedera!";

  const messageTransaction = new TopicMessageSubmitTransaction()
    .setTopicId(topicId)
    .setMessage(message);

  await messageTransaction.execute(client);

  console.log(`\nMessage submitted: ${message}`);

  // wait for Mirror Node to populate data
  console.log("\nWaiting for Mirror Node to update...");
  await new Promise((resolve) => setTimeout(resolve, 6000));

  // query messages using Mirror Node
  const mirrorNodeUrl = `https://testnet.mirrornode.hedera.com/api/v1/topics/${topicId}/messages`;

  const response = await fetch(mirrorNodeUrl);
  const data = await response.json();

  if (data.messages && data.messages.length > 0) {
    const latestMessage = data.messages[data.messages.length - 1];
    const messageContent = Buffer.from(latestMessage.message, "base64")
      .toString("utf8")
      .trim();

    console.log(`\nLatest message: ${messageContent}\n`);
  } else {
    console.log("No messages found yet in Mirror Node");
  }

  client.close();
}

createTopicDemo().catch(console.error);
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

public class CreateTopicDemo {
    public static void main(String[] args ) throws Exception {
        // load your operator credentials
        String operatorId = System.getenv("OPERATOR_ID");
        String operatorKey = System.getenv("OPERATOR_KEY");

        // initialize the client for testnet
        Client client = Client.forTestnet()
            .setOperator(AccountId.fromString(operatorId), PrivateKey.fromString(operatorKey));

        // build & execute the topic creation transaction
        TopicCreateTransaction transaction = new TopicCreateTransaction()
            .setTopicMemo("My first HCS topic");

        TransactionResponse txResponse = transaction.execute(client);
        TransactionReceipt receipt = txResponse.getReceipt(client);
        TopicId topicId = receipt.topicId;

        System.out.println("\nTopic created: " + topicId);

        // build & execute the message submission transaction
        String message = "Hello, Hedera!";

        TopicMessageSubmitTransaction messageTransaction = new TopicMessageSubmitTransaction()
            .setTopicId(topicId)
            .setMessage(message);

        messageTransaction.execute(client);

        System.out.println("\nMessage submitted: " + message);

        // wait for Mirror Node to populate data
        System.out.println("\nWaiting for Mirror Node to update...");
        Thread.sleep(6000);

        // query messages using Mirror Node
        String mirrorNodeUrl = "https://testnet.mirrornode.hedera.com/api/v1/topics/" + topicId + "/messages";

        HttpClient httpClient = HttpClient.newHttpClient( );
        HttpRequest request = HttpRequest.newBuilder()
            .uri(URI.create(mirrorNodeUrl))
            .build();

        HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString( ));
        Gson gson = new Gson();
        JsonObject data = gson.fromJson(response.body(), JsonObject.class);

        if (data.has("messages") && data.getAsJsonArray("messages").size() > 0) {
            JsonArray messages = data.getAsJsonArray("messages");
            JsonObject latestMessage = messages.get(messages.size() - 1).getAsJsonObject();
            String encodedMessage = latestMessage.get("message").getAsString();
            String messageContent = new String(java.util.Base64.getDecoder().decode(encodedMessage)).trim();
            
            System.out.println("\nLatest message: " + messageContent + "\n");
        } else {
            System.out.println("No messages found yet in Mirror Node");
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
	"encoding/base64"
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"os"
	"strings"
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

	// build & execute the topic creation transaction
	transaction := hedera.NewTopicCreateTransaction().
		SetTopicMemo("My first HCS topic")

	txResponse, err := transaction.Execute(client)
	if err != nil {
		panic(err)
	}

	receipt, err := txResponse.GetReceipt(client)
	if err != nil {
		panic(err)
	}

	topicID := *receipt.TopicID

	fmt.Println("\nTopic created:", topicID.String())

	// build & execute the message submission transaction
	message := "Hello, Hedera!"

	messageTransaction := hedera.NewTopicMessageSubmitTransaction().
		SetTopicID(topicID).
		SetMessage([]byte(message))

	_, err = messageTransaction.Execute(client)
	if err != nil {
		panic(err)
	}

	fmt.Printf("\nMessage submitted: %s\n", message)

	// Wait for Mirror Node to populate data
	fmt.Println("\nWaiting for Mirror Node to update...")
	time.Sleep(6 * time.Second)

	// query messages using Mirror Node
	mirrorNodeUrl := "https://testnet.mirrornode.hedera.com/api/v1/topics/" + topicID.String() + "/messages"

	resp, err := http.Get(mirrorNodeUrl)
	if err != nil {
		panic(err)
	}
	defer resp.Body.Close()

	body, err := io.ReadAll(resp.Body)
	if err != nil {
		panic(err)
	}

	var data struct {
		Messages []struct {
			Message string `json:"message"`
		} `json:"messages"`
	}

	err = json.Unmarshal(body, &data)
	if err != nil {
		panic(err)
	}

	if len(data.Messages) > 0 {
		latestMessage := data.Messages[len(data.Messages)-1]
		decodedMessage, _ := base64.StdEncoding.DecodeString(latestMessage.Message)

		fmt.Println("\nLatest message:", strings.TrimSpace(string(decodedMessage)))
	} else {
		fmt.Println("No messages found yet in Mirror Node")
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
import base64
import requests

from hiero_sdk_python import (
    Client,
    AccountId,
    PrivateKey,
    TopicCreateTransaction,
    TopicMessageSubmitTransaction,
)

# load your operator credentials
operatorId = AccountId.from_string(os.getenv("OPERATOR_ID", ""))
operatorKey = PrivateKey.from_string(os.getenv("OPERATOR_KEY", ""))

# initialize the client for testnet
client = Client()
client.set_operator(operatorId, operatorKey)

# build & execute the topic creation transaction
transaction = (
    TopicCreateTransaction(
        memo="My first HCS topic",
        admin_key=operatorKey.public_key()
    )
    .freeze_with(client)
    .sign(operatorKey)
)

receipt = transaction.execute(client)
topicId = receipt.topic_id

print(f"\nTopic created: {topicId}")

# build & execute the message submission transaction
message = "Hello, Hedera!"

message_transaction = (
    TopicMessageSubmitTransaction()
    .set_topic_id(topicId)
    .set_message(message)
    .freeze_with(client)
    .sign(operatorKey)
)

message_transaction.execute(client)

print(f"\nMessage submitted: {message}")

# wait for Mirror Node to populate data
print("\nWaiting for Mirror Node to update...")
time.sleep(6)

# query messages using Mirror Node
mirror_node_url = f"https://testnet.mirrornode.hedera.com/api/v1/topics/{topicId}/messages"

response = requests.get(mirror_node_url, timeout=10)
response.raise_for_status()
data = response.json()

messages = data.get("messages", [])
if messages:
    latest_message = messages[-1]
    encoded_message = latest_message.get("message", "")
    message_content = base64.b64decode(encoded_message).decode("utf-8").strip()
    
    print(f"\nLatest message: {message_content}\n")
else:
    print("No messages found yet in Mirror Node")

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
node createTopicDemo.js
```
{% endtab %}

{% tab title="Java Maven" %}
```bash
mvn compile exec:java -Dexec.mainClass="com.example.CreateTopicDemo"
```
{% endtab %}

{% tab title="Java Gradle" %}
```gradle
./gradlew run
```
{% endtab %}

{% tab title="Go" %}
```bash
go run create_topic_demo.go
```
{% endtab %}

{% tab title="Python" %}
```bash
python CreateTopicDemo.py
```

**When finished, deactivate the virtual environment:**

```bash
deactivate
```
{% endtab %}
{% endtabs %}

#### **Expected sample output:**

```
Topic created: 0.0.1234567

Message submitted: Hello, Hedera!

Waiting for Mirror Node to update...

Latest message: Hello, Hedera!
```

### ‼️ Troubleshooting

<details>

<summary><strong>Common ERROR messages and solutions ⬇️</strong></summary>

| Error message                | Likely cause                                   | Fix                                                            |
| ---------------------------- | ---------------------------------------------- | -------------------------------------------------------------- |
| `INSUFFICIENT_PAYER_BALANCE` | Not enough HBAR for topic creation fee         | Top up your operator account on the testnet faucet             |
| `INVALID_SIGNATURE`          | Operator key doesn't match operator account    | Verify OPERATOR\_KEY matches your OPERATOR\_ID                 |
| `INVALID_ACCOUNT_ID`         | Malformed account ID in environment variables  | Verify OPERATOR\_ID format is 0.0.1234                         |
| `INVALID_PRIVATE_KEY`        | Malformed private key in environment variables | Verify OPERATOR\_KEY is a valid DER-encoded private key string |
| `INVALID_TOPIC_ID`           | Topic ID not found or malformed                | Ensure topic was created successfully and ID is correct        |
| `No messages found yet`      | Mirror Node sync delay                         | Wait a few more seconds and try again - this is normal         |

</details>

***

## What Just Happened?

1. The SDK built a `TopicCreateTransaction` and signed it with your operator key.
2. A consensus node validated the signature and charged the topic creation fee.
3. After network consensus, a unique topic ID was assigned and returned in the receipt.
4. Your message was submitted to the topic and became part of the immutable record.
5. The Mirror Node API confirmed your message was published with consensus timestamp

***

## Next steps

* Subscribe to the topic from your backend or front-end to process messages as they come in
* Encrypt messages if you need privacy before publishing
* Explore more examples in the SDK repos ([JavaScript](https://github.com/hiero-ledger/hiero-sdk-js), [Java](https://github.com/hiero-ledger/hiero-sdk-java), [Go](https://github.com/hiero-ledger/hiero-sdk-go))

***

🎉 **Great work**! You have created a new topic and broadcasted your first message on Hedera testnet. Keep building!

## Additional Resources

{% embed url="https://docs.hedera.com/hedera/tutorials/consensus" %}
