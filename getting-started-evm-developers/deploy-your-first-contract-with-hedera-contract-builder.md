# Deploy your First Contract with Hedera Contract Builder

## Hedera Contract Builder Quickstart

The Hedera Contract Builder allows you to deploy smart contracts on the Hedera testnet quickly. The tool is provided through the Hedera Developer Portal.

{% stepper %}
{% step %}
#### Step 1: Visit the Hedera Contract Builder

Head over to the [Hedera Smart Contract Builder](https://portal.hedera.com/contract-builder), a powerful web-based IDE for compiling and deploying contracts.

<figure><img src="../.gitbook/assets/Untitled design (12).png" alt=""><figcaption></figcaption></figure>
{% endstep %}

{% step %}
#### Step 2: Create and Compile an ERC-20 Smart Contract

Select the ERC20 option at the top and modify its settings. Let's create a token with the "Mintable" feature and set access control to "Ownable." Once you've done that, click the "Compile" button at the bottom left of the page.

<figure><img src="../.gitbook/assets/Screenshot 2025-06-30 at 6.05.23 PM.png" alt=""><figcaption></figcaption></figure>

{% hint style="warning" %}
**Please note**

These smart contracts are not audited and are intended for learning purposes only. By accepting this disclaimer, you acknowledge that you understand the risks involved in deploying unaudited contracts. For more information, please see our terms of service: [https://hedera.com/terms](https://hedera.com/terms)
{% endhint %}
{% endstep %}

{% step %}
#### Step 3: Deploy ERC-20 Smart Contract

Finally, you can deploy your contract. First, copy your EVM account address at the top right of your profile information.

<figure><img src="../.gitbook/assets/Untitled design (13) (1).png" alt=""><figcaption></figcaption></figure>

Next, let's paste the address in the constructor argument `initialOwner` for our ERC-20 contract. This address will be assigned the role of minting new tokens.

<figure><img src="../.gitbook/assets/Untitled design (14).png" alt=""><figcaption></figcaption></figure>

Click the "Deploy" button to deploy the contract. Once your contract is deployed, you get an interface where you can interact with your smart contract.
{% endstep %}

{% step %}
#### Step 4: Mint an ERC-20 Token

Let's use the interface to mint a new token. Expand the mint function, and let's mint a token for ourselves. Paste your EVM address in the `to` field and set the amount equal to 1.

<figure><img src="../.gitbook/assets/Untitled design (15).png" alt=""><figcaption></figcaption></figure>

**Expanding the output area allows you to check the status of your function call. If you see a status message "SUCCESS," you've successfully minted an ERC-20 token on Hedera.**

<figure><img src="../.gitbook/assets/Screenshot 2025-06-30 at 6.46.47 PM.png" alt=""><figcaption></figcaption></figure>
{% endstep %}
{% endstepper %}
