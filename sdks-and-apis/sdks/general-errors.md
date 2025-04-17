# General Network Response Messages

General network response messages and their descriptions.

| Error                                          | Description                                                                                                                                          |
| ---------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| `AUTORENEW_DURATION_NOT_IN_RANGE`              | The duration is not a subset of \[MINIMUM\_AUTORENEW\_DURATION, MAXIMUM\_AUTORENEW\_DURATION]                                                        |
| `ACCOUNT_IS_NOT_GENESIS_ACCOUNT`               | Special Account Operations should be performed by only Genesis account, return this code if it is not Genesis Account                                |
| `BATCH_LIST_EMPTY (388)`                       | The list of batch transactions is empty                                                                                                              |
| `BATCH_LIST_CONTAINS_DUPLICATES (389)`         | The list of batch transactions contains duplicated transactions                                                                                      |
| `BATCH_TRANSACTION_IN_BLACKLIST (390)`         | The transaction has been blacklisted                                                                                                                 |
| `BATCH_KEY_SET_ON_NON_INNER_TRANSACTION (393)` | There is a batch key set on an outer (non-inner) transaction                                                                                         |
| `DUPLICATE_TRANSACTION`                        | This transaction ID is a duplicate of one that was submitted to this node or reached consensus in the last 180 seconds (receipt period)              |
| `ENTITY_NOT_ALLOWED_TO_DELETE`                 | Entities with Entity ID below 1000 are not allowed to be deleted                                                                                     |
| `EMPTY_QUERY_BODY`                             | The query body is empty                                                                                                                              |
| `EMPTY_TRANSACTION_BODY`                       | Transaction body provided is empty                                                                                                                   |
| `FAIL_INVALID`                                 | There was a system error and the transaction failed because of invalid request parameters.                                                           |
| `FREEZE_TRANSACTION_BODY_NOT_FOUND`            | FreezeTransactionBody does not exist                                                                                                                 |
| `INNER_TRANSACTION_FAILED (391)`               | An inner transaction within the batch failed                                                                                                         |
| `INSUFFICIENT_PAYER_BALANCE`                   | The payer account has insufficient cryptocurrency to pay the transaction fee                                                                         |
| `INSUFFICIENT_TX_FEE`                          | The fee provided in the transaction is insufficient for this type of transaction                                                                     |
| `INVALID_BATCH_KEY (394)`                      | Batch key submitted with the transaction is not valid.                                                                                               |
| `INVALID_FEE_SUBMITTED`                        | Invalid fee submitted                                                                                                                                |
| `INVALID_FREEZE_TRANSACTION_BODY`              | FreezeTransactionBody is invalid                                                                                                                     |
| `INVALID_NODE_ACCOUNT`                         | Node Account provided does not match the node account of the node the transaction was submitted to.                                                  |
| `INVALID_PAYER_SIGNATURE`                      | Payer signature is invalid                                                                                                                           |
| `INVALID_RECEIVING_NODE_ACCOUNT`               | In Query validation, an account with +ve(amount) value should be Receiving node account, the receiver account should be only one account in the list |
| `INVALID_RENEWAL_PERIOD`                       | Auto-renewal period is not a positive number of seconds                                                                                              |
| `INVALID_TRANSACTION`                          | For any error not handled by specific error codes listed below                                                                                       |
| `INVALID_TRANSACTION_BODY`                     | Invalid transaction body provided                                                                                                                    |
| `INVALID_TRANSACTION_ID`                       | The transaction id is not valid                                                                                                                      |
| `INVALID_TRANSACTION_DURATION`                 | Valid transaction duration is a positive non zero number that does not exceed 120 seconds                                                            |
| `INVALID_TRANSACTION_START`                    | Transaction start time is greater than the current consensus time                                                                                    |
| `INVALID_SIGNATURE`                            | The transaction signature is not valid                                                                                                               |
| `OK`                                           | The transaction passed the precheck validations.                                                                                                     |
| `MEMO_TOO_LONG`                                | Transaction memo size exceeded 100 bytes                                                                                                             |
| `MISSING_QUERY_HEADER`                         | Header is missing in Query request                                                                                                                   |
| `NOT_SUPPORTED`                                | The API is not currently supported                                                                                                                   |
| `PAYER_ACCOUNT_NOT_FOUND`                      | Payer account does not exist.                                                                                                                        |
| `PAYER_ACCOUNT_UNAUTHORIZED`                   | The fee payer account doesn't have permission to submit such Transaction                                                                             |
| `PLATFORM_NOT_ACTIVE`                          | The platform node is either disconnected or lagging behind                                                                                           |
| `PLATFORM_TRANSACTION_NOT_CREATED`             | Transaction not created by platform due to large backlog                                                                                             |
| `RECEIPT_NOT_FOUND`                            | Receipt for given transaction id does not exist                                                                                                      |
| `RECORD_NOT_FOUND`                             | Record for given transaction id does not exist                                                                                                       |
| `SUCCESS`                                      | The transaction succeeded                                                                                                                            |
| `TRANSACTION_EXPIRED`                          | Pre-Check error when TransactionValidStart + transactionValidDuration is less than current consensus time.                                           |
| `TRANSACTION_OVERSIZE`                         | The size of the Transaction is greater than transactionMaxBytes                                                                                      |
| `TRANSACTION_TOO_MANY_LAYERS`                  | The Transaction has more than 50 levels                                                                                                              |
| `UNKNOWN`                                      | This node has submitted this transaction to the network. Status of the transaction is currently unknown.                                             |

## Keys

| Error                                     | Description                                                                                                                                                                                                                          |
| ----------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `BAD_ENCODING`                            | Unsupported algorithm/encoding used for keys in the transaction                                                                                                                                                                      |
| `INVALID_KEY_ENCODING`                    | Provided key encoding was not supported by the system                                                                                                                                                                                |
| `INVALID_SIGNATURE_COUNT_MISMATCHING_KEY` | The number of key (KeyList, or ThresholdKey) does not match that of signature (SignatureList, or ThresholdKeySignature). e.g. if a keyList has 3 base keys, then the corresponding signatureList should also have 3 base signatures. |
| `INVALIDSIGNATURE_TYPE_MISMATCHING`       | The type of key (base ed25519 key, KeyList, or ThresholdKey) does not match the type of signature (base ed25519 signature, SignatureList, or ThresholdKeySignature)                                                                  |
| `KEY_NOT_PROVIDED`                        | The keys were not provided in the request.                                                                                                                                                                                           |
| `KEY_PREFIX_MISMATCH`                     | One public key matches more than one prefixes on the signature map                                                                                                                                                                   |
| `KEY_REQUIRED`                            | Key not provided in the transaction body                                                                                                                                                                                             |
