import {
  Client,
  PrivateKey,
  TokenCreateTransaction,
  TokenSupplyType,
  AccountId
} from "@hashgraph/sdk";

async function createTokenDemo() {
  // load your operator credentials
  const operatorId = process.env.OPERATOR_ID;
  const operatorKey = process.env.OPERATOR_KEY;

  // initialize the client for Solo
  const client = Client.forNetwork(
    {"127.0.0.1:50211": new AccountId(3)}
  ).setOperator(operatorId, operatorKey);

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
  const mirrorNodeUrl = `http://localhost:5551/api/v1/accounts/${operatorId}/tokens?token.id=${tokenId}`;

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