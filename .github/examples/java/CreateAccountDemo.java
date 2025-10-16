import com.hedera.hashgraph.sdk.*;
import java.net.http.*;
import java.net.URI;
import com.google.gson.*;

public class CreateAccountDemo {
    public static void main(String[] args) throws Exception {
        // .env-provided
        AccountId operatorId = AccountId.fromString(System.getenv("OPERATOR_ID"));
        PrivateKey operatorKey = PrivateKey.fromString(System.getenv("OPERATOR_KEY"));
        String network = System.getenv().getOrDefault("HEDERA_NETWORK", "local"); 
        String mirrorNodeUrl = System.getenv().getOrDefault(
            "MIRROR_NODE_URL",
            "http://localhost:8080/api/v1" 
        );

        if (operatorId == null || operatorKey == null) {
            throw new IllegalStateException("OPERATOR_ID / OPERATOR_KEY not set");
        }

        Client client =
            "local".equalsIgnoreCase(network)
                ? Client.forNetwork(java.util.Map.of("127.0.0.1:50211", new AccountId(3))) 
                : Client.forTestnet();

        client.setOperator(operatorId, operatorKey);

        PrivateKey newPrivateKey = PrivateKey.generateECDSA();
        PublicKey newPublicKey = newPrivateKey.getPublicKey();

        AccountCreateTransaction transaction = new AccountCreateTransaction()
            .setKeyWithAlias(newPublicKey)
            .setInitialBalance(new Hbar(20));

        TransactionResponse txResponse = transaction.execute(client);
        TransactionReceipt receipt = txResponse.getReceipt(client);
        AccountId newAccountId = receipt.accountId;

        System.out.println("\nHedera account created: " + newAccountId);
        System.out.println("EVM Address: 0x" + newPublicKey.toEvmAddress() + "\n");

        System.out.println("\nWaiting for Mirror Node to update...\n");
        Thread.sleep(10000);

        String url = mirrorNodeUrl + "/balances?account.id=" + newAccountId;
            
        HttpClient httpClient = HttpClient.newHttpClient();
        HttpRequest request = HttpRequest.newBuilder().uri(URI.create(url)).build();
        HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());

        Gson gson = new Gson();
        JsonObject data = gson.fromJson(response.body(), JsonObject.class);

        if (data.has("balances") && data.getAsJsonArray("balances").size() > 0) {
            JsonArray balances = data.getAsJsonArray("balances");
            JsonObject accountBalance = balances.get(0).getAsJsonObject();
            long tinybars = accountBalance.get("balance").getAsLong();
            double hbar = tinybars / 100_000_000.0;
            System.out.println("Account balance: " + hbar + " ℏ\n");
        } else {
            System.out.println("Account balance not yet available in Mirror Node");
        }

        client.close();
    }
}
