import {
  Client,
  PrivateKey,
  AccountCreateTransaction,
  Hbar,
  AccountId
} from "@hashgraph/sdk";

async function createAccountDemo() {
  // load your operator credentials
  const operatorId = process.env.OPERATOR_ID;
  const operatorKey = process.env.OPERATOR_KEY;

  // initialize the client for Solo
  const client = Client.forNetwork(
    {"127.0.0.1:50211": new AccountId(3)}
  ).setOperator(operatorId, operatorKey);

  // generate a new key pair
  const newPrivateKey = PrivateKey.generateECDSA();
  const newPublicKey = newPrivateKey.publicKey;

  // build & execute the account creation transaction
  const transaction = new AccountCreateTransaction()
    .setECDSAKeyWithAlias(newPublicKey) // set the account key with alias
    .setInitialBalance(new Hbar(20)); // fund with 20 HBAR

  const txResponse = await transaction.execute(client);
  const receipt = await txResponse.getReceipt(client);
  const newAccountId = receipt.accountId;

  console.log(`\nHedera account created: ${newAccountId}`);
  console.log(`EVM Address: 0x${newPublicKey.toEvmAddress()}`);

  // Wait for Mirror Node to populate data
  console.log("\nWaiting for Mirror Node to update...");
  await new Promise(resolve => setTimeout(resolve, 6000));

  // query balance using Mirror Node
  const mirrorNodeUrl = `http://localhost:5551/api/v1/balances?account.id=${newAccountId}`;

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