# Generate a new key pair

## ED25519

Create a new _**ED25519**_ key pair used to sign transactions and queries on the Hedera network. The private key is kept confidential and is used to sign transactions that modify the state of an account, topic, token, smart contract, or file entity on the network. The public key can be shared with other users on the network.

| **Method**                                                              | **Type**   | **Description**                                              |
| ----------------------------------------------------------------------- | ---------- | ------------------------------------------------------------ |
| `PrivateKey.generateED25519()`                                          | PrivateKey | Generates an Ed25519 private key                             |
| `PrivateKey.generateED25519().getPublicKey()`                           | PublicKey  | Derive a public key from this Ed25519 private key            |
| `PrivateKey.generateED25519().publicKey()`                              | PublicKey  | Derive a public key from this Ed25519 private key            |
| `PrivateKey.generateED25519().publicKey().toAccountId(<shard>,<realm>)` | long, long | Contruct an alias account ID from a alias public key address |
| **`[DEPRECATED]`**`PrivateKey.generate()`                               | PrivateKey | Generates an Ed25519 private key                             |

{% tabs %}
{% tab title="Java" %}
```java
PrivateKey privateKey = PrivateKey.generateED25519();
PublicKey publicKey = privateKey.getPublicKey();

System.out.println("private key = " + privateKey);
System.out.println("public key = " + publicKey);
```
{% endtab %}

{% tab title="JavaScript" %}
```javascript
const privateKey = await PrivateKey.generateED25519Async();
const publicKey = privateKey.publicKey;

console.log("private key = " + privateKey);
console.log("public key = " + publicKey);
```
{% endtab %}

{% tab title="Go" %}
```go
privateKey, err := hedera.GenerateEd25519PrivateKey()
if err != nil {
    panic(err)
}

publicKey := privateKey.PublicKey()

fmt.Printf("private key = %v\n", privateKey)
fmt.Printf("public key = %v\n", publicKey)
```
{% endtab %}

{% tab title="Rust" %}
```rust
// Generate ED25519 key pair
let private_key = PrivateKey::generate_ed25519()?;
let public_key = private_key.public_key();

println!("private key = {:?}", private_key);
println!("public key = {:?}", public_key);

// Generate ECDSA key pair
let private_key = PrivateKey::generate_ecdsa()?;
let public_key = private_key.public_key();

println!("private key = {:?}", private_key);
println!("public key = {:?}", public_key);

// v0.34.0
```
{% endtab %}
{% endtabs %}

**Sample Output:**

```bash
private key = 302e020100300506032b657004220420b9c3ebac81a72aafa5490cc78111643d016d311e60869436fbb91c73307ed35a
public key = 302a300506032b65700321001a5a62bb9f35990d3fea1a5bb7ef6f1df0a297697adef1e04510c9d4ecc5db3f
```

## ECDSA (secp256k1\_)

Create a new _**ECDSA**_ (secp256k1) key pair used to sign transactions and queries on a Hedera network. The private key is kept confidential and is used to sign transactions that modify the state of an account, topic, token, smart contract, or file entity on the network. The public key can be shared with other users on the network.

| **Method**                                                             | **Type**   | **Description**                                          |
| ---------------------------------------------------------------------- | ---------- | -------------------------------------------------------- |
| `PrivateKey.generateECDSA()`                                           | PrivateKey | Generates an ECSDA private key                           |
| `PrivateKey.generateECDSA().getPublicKey()`                            | PublicKey  | Derive a public key from this ECDSA private key          |
| `PrivateKey.generateECDSA().publicKey()`                               | PublicKey  | Derive a public key from this ECDSA private key          |
| `PrivateKey.generateECDSA().publicKey().toAccountId(<shard>, <realm>)` | long, long | Contructs an account ID from an account alias public key |

{% tabs %}
{% tab title="Java" %}
```java
PrivateKey privateKey = PrivateKey.generateECDSA();
PublicKey publicKey = privateKey.getPublicKey();

System.out.println("private key = " + privateKey);
System.out.println("public key = " + publicKey);
```
{% endtab %}

{% tab title="JavaScript" %}
```javascript
const privateKey = PrivateKey.generateECDSA();
const publicKey = privateKey.publicKey;

console.log("private key = " + privateKey);
console.log("public key = " + publicKey);
```
{% endtab %}

{% tab title="Go" %}
```go
privateKey, err := hedera.GenerateEcdsaPrivateKey()
if err != nil {
    panic(err)
}

publicKey := privateKey.PublicKey()

fmt.Printf("private key = %v\n", privateKey)
fmt.Printf("public key = %v\n", publicKey)
```
{% endtab %}

{% tab title="Rust" %}
```rust
// Generate ED25519 key pair
let private_key = PrivateKey::generate_ed25519()?;
let public_key = private_key.public_key();

println!("private key = {:?}", private_key);
println!("public key = {:?}", public_key);

// Generate ECDSA key pair
let private_key = PrivateKey::generate_ecdsa()?;
let public_key = private_key.public_key();

println!("private key = {:?}", private_key);
println!("public key = {:?}", public_key);

// v0.34.0
```
{% endtab %}
{% endtabs %}

**Sample Output:**

```