## ✅ Java example passed
- Timestamp (UTC): 2025-09-02 17:27:50Z
- Network: local

<details><summary>Output</summary>
=== Java Examples Runner ===
Timestamp (UTC): 2025-09-02 17:27:02Z
Network: local
Mirror:  http://localhost:5551/api/v1

▶️  Running all examples…

Hedera account created: 0.0.1004
EVM Address: 0xb0f493f813171ee220382db59681334fd32cca0c


Waiting for Mirror Node to update...

RequestURL: http://localhost:5551/api/v1/balances?account.id=0.0.1004
{"timestamp":"1756834035.592551431","balances":[{"account":"0.0.1004","balance":2000000000,"tokens":[]}],"links":{"next":null}}
200
Account balance: 20.0 ℏ

0.0.1002

Fungible token created: 0.0.1005

Waiting for Mirror Node to update...
http://localhost:5551/api/v1/accounts/0.0.1002/tokens?token.id=0.0.1005
{"tokens":[{"automatic_association":false,"balance":100000,"created_timestamp":"1756834047.832762668","decimals":2,"token_id":"0.0.1005","freeze_status":"NOT_APPLICABLE","kyc_status":"NOT_APPLICABLE"}],"links":{"next":null}}
200

Treasury holds: 100000 DEMO


Topic created: 0.0.1006

Message submitted: Hello, Hedera!

Waiting for Mirror Node to update...
http://localhost:5551/api/v1/topics/0.0.1006/messages
{"messages":[{"chunk_info":null,"consensus_timestamp":"1756834060.133091847","message":"SGVsbG8sIEhlZGVyYSE=","payer_account_id":"0.0.1002","running_hash":"1kAO3dRmyRRtusmJJDZf3078ac3XjOwjoHTBOWa0cYGedp4RQE068VE8FUU6RwTA","running_hash_version":3,"sequence_number":1,"topic_id":"0.0.1006"}],"links":{"next":null}}
200

Latest message: Hello, Hedera!


✅ All examples passed.
0.0.1006"}],"links":{"next":null}}
200

Latest message: Hello, Hedera!


✅ All examples passed.
</details>
