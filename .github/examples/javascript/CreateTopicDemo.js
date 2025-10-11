import {
  Client,
  TopicCreateTransaction,
  TopicMessageSubmitTransaction,
  AccountId
} from "@hashgraph/sdk";

async function createTopicDemo() {
  // load your operator credentials
  const operatorId = process.env.OPERATOR_ID;
  const operatorKey = process.env.OPERATOR_KEY;

  // initialize the client for Solo
  const client = Client.forNetwork(
    {"127.0.0.1:50211": new AccountId(3)}
  ).setOperator(operatorId, operatorKey);

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
  const mirrorNodeUrl = `http://localhost:5551/api/v1/topics/${topicId}/messages`;

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