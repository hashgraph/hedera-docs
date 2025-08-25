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
