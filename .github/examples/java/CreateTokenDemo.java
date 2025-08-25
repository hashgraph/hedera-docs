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
