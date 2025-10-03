# How to Fork the Hedera Network for Local Testing

In this tutorial, you’ll fork Hedera mainnet using Foundry and interact with a live Hedera NFT (ERC-721) on the fork and also run tests on this local forked network.&#x20;

This guide shows how to:

* Fork Hedera mainnet using Foundry
* Run Foundry tests on a fork of Hedera mainnet
* Read and interact with an existing NFT (ERC-721) contract by its EVM address (e.g., `ownerOf`, `name`, `symbol`, `tokenURI`), with minimal setup.

References:

* Repo: [hashgraph/hedera-forking](https://github.com/hashgraph/hedera-forking)
* Readme sections: Foundry library, Running your Tests/Scripts, Hardhat plugin (if you prefer Hardhat)
* Examples: [`examples/foundry-hts/test/NFT.t.sol`](https://github.com/hashgraph/hedera-forking/blob/main/examples/foundry-hts/test/NFT.t.sol), scripts under [`examples/foundry-hts/script/`](https://github.com/hashgraph/hedera-forking/tree/main/examples/foundry-hts/script)

{% hint style="info" %}
You can take a look at the **complete code** in the [**Hedera-Code-Snippets repository**](https://github.com/hedera-dev/hedera-code-snippets/tree/main/foundry-mainnet-fork-tutorial).
{% endhint %}

***

## Prerequisites

* Foundry installed (forge, cast, anvil, chisel):
  * `curl -L https://foundry.paradigm.xyz | bash`
    * `forge-std` >= v1.8.0
  * `foundryup`
* curl (Unix) or PowerShell (Windows), so ffi can call Mirror Node
* A Hedera JSON-RPC endpoint:
  * mainnet: `https://mainnet.hashio.io/api`
  * testnet: `https://testnet.hashio.io/api`
* ECDSA account and 0x‑prefixed private key for Hedera Testnet (create/fund via the [Hedera Portal](https://portal.hedera.com/))
* Basic Solidity / CLI familiarity
* If you want to learn how to deploy an ERC-721 token using Foundry, you can read more about that [here](how-to-mint-and-burn-an-erc-721-token-using-foundry-part-1.md).

***

## Table of Contents

1. [Step 1: Project Setup](how-to-fork-the-hedera-network-for-local-testing.md#step-1-project-setup)
2. [Step 2: Create the contract and scripts and deploy to mainnet](how-to-fork-the-hedera-network-for-local-testing.md#step-2-create-the-contract-and-scripts-and-deploy-to-mainnet)
3. [Step 3: Run tests on the forked network](how-to-fork-the-hedera-network-for-local-testing.md#step-4-run-tests-on-the-forked-network)

***

## Step 1: Project Setup

#### **Initialize Project**&#x20;

Set up your project by initializing the hardhat project:

```bash
forge init foundry-mainnet-fork-tutorial
cd foundry-mainnet-fork-tutorial
```

This creates a new directory with a standard Foundry project structure, including `src`, `test`, and `script` folders.

#### Install Dependencies

Foundry uses git submodules to manage dependencies.&#x20;

We'll install the required dependency that will let us fork the Hedera mainnet for our local testing.&#x20;

```bash
forge install hashgraph/hedera-forking
```

We'll also install the OpenZeppelin Contracts library, which provides a standard and secure implementation of the ERC20 token.

```bash
forge install OpenZeppelin/openzeppelin-contracts
```

**Create `.env` File**

Create an `.env` for your RPC URL and private key.&#x20;

```bash
touch .env
```

Put the following into your environment file.

{% code title=".env" %}
```bash
HEDERA_RPC_URL="https://mainnet.hashio.io/api"
HEDERA_PRIVATE_KEY=0x-your-private-key
```
{% endcode %}

Now, let's also load these to the terminal:

```bash
source .env
```

{% hint style="warning" %}
Replace the `0x-your-private-key` environment variable with the **HEX Encoded Private Key** for your **ECDSA** **account.** Note that this account **MUST** exist on **mainnet** as we're dealing with the mainnet for this exercise.
{% endhint %}

#### Configure Foundry

Update your `foundry.toml` file in the root directory of your project. Open it and add profiles for the Hedera RPC endpoints.

<pre class="language-toml" data-title="foundry.toml"><code class="lang-toml">[profile.default]
src = "src"
out = "out"
libs = ["lib"]
remappings = [
  "@openzeppelin/contracts/=lib/openzeppelin-contracts/contracts/",
  "forge-std/=lib/forge-std/src/"
]
ffi = true
gas_reports = ["MyToken", "MyTokenTest"]

# Add this section for Hedera testnet
[rpc_endpoints]
mainnet = "${HEDERA_RPC_URL}"

<strong>[profile.default.fuzz]
</strong>runs = 10
max_test_rejects = 65536
</code></pre>

Some things to keep in mind:

* Note the values in `remappings` field. We need this to import prefix to a filesystem path so both Foundry(forge) and our editor can resolve short, package-like imports instead of long relative paths.
* We have `ffi` to be true because on forked tests, the library uses curl (or PowerShell) to query Hedera Mirror Node for token state so that EVM calls like `IERC721.ownerOf()` can work as if the token were a normal EVM contract.
* If we run fuzz tests, they may hit our RPC's rate limit so in order to get around that issue, we need to lower the runs so we don't run into any errors that have nothing to do with our contract at all. We are using `10` here but you could technically go much higher before you hit the rate limit.
* We are adding the field `gas_reports` here so we can do some cool things while testing such as&#x20;

We will be removing the default contracts that comes with foundry default project:

```bash
rm -rf script/* src/* test/*
```

***

## Step 2: Create the contract and scripts and deploy to mainnet

Please follow the guide on "How to Mint & Burn an ERC-721 Token using Foundry" to learn how to create an ERC-721 contract, various scripts for deployment, minting and burning and various other things.&#x20;

You can also refer to the code in the [**Hedera-Code-Snippets repository**](https://github.com/hedera-dev/hedera-code-snippets/tree/main/foundry-erc-721-mint-burn)**.**

We have already deployed this ERC-721 contract on mainnet at [https://hashscan.io/mainnet/contract/0x07F6D65f9454EA2dff99bF8C2C1De918Fcd27416](https://hashscan.io/mainnet/contract/0x07F6D65f9454EA2dff99bF8C2C1De918Fcd27416) so we will be using this for the remainder of this exercise.

***

## Step 3: Run tests on the forked network

Since we want to interact with our deployed ERC-721 token on the mainnet (which is then forked for our testing), we will need to make some changes to our `test/MyToken.t.sol` file:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "forge-std/Test.sol";
import {MyToken} from "../src/MyToken.sol";
import {IERC721} from "@openzeppelin/contracts/token/ERC721/IERC721.sol";

contract MyTokenTest is Test {
    // Your deployed mainnet contract:
    // https://hashscan.io/mainnet/contract/0x07F6D65f9454EA2dff99bF8C2C1De918Fcd27416
    address internal constant DEPLOYED =
        0x07F6D65f9454EA2dff99bF8C2C1De918Fcd27416; // Please update this value to your 
                                                    // deployed contract on mainnet

    MyToken internal token;

    address internal owner;
    address internal alice;
    address internal bob;

    function setUp() public {
        // Bind to deployed contract
        token = MyToken(DEPLOYED);

        // Discover real on-chain owner (Ownable)
        owner = token.owner();

        // Locally create EOAs with labeled traces
        alice = makeAddr("alice");
        bob = makeAddr("bob");

        // Fund/initialize accounts locally to avoid remote eth_getBalance calls
        // (Helps prevent 429 rate limits when running on a fork)
        vm.deal(owner, 100 ether);
        vm.deal(alice, 0);
        vm.deal(bob, 0);

        // For nicer traces
        vm.label(address(token), "MyToken");
        vm.label(owner, "Owner");
        vm.label(alice, "Alice");
        vm.label(bob, "Bob");
    }

    /* =========================
                Basics
       ========================= */

    function test_NameAndSymbol() public view {
        assertEq(token.name(), "MyToken");
        assertEq(token.symbol(), "MTK");
    }

    function test_SupportsERC721Interface() public view {
        // IERC721 interfaceId = 0x80ac58cd
        assertTrue(
            IERC721(address(token)).supportsInterface(type(IERC721).interfaceId)
        );
    }

    /* =========================
               Ownership
       ========================= */

    function test_OnlyOwnerCanMint() public {
        // Non-owner tries to mint → revert with OwnableUnauthorizedAccount(address)
        vm.prank(alice);
        vm.expectRevert(
            abi.encodeWithSignature(
                "OwnableUnauthorizedAccount(address)",
                alice
            )
        );
        token.safeMint(alice);
    }

    function test_MintByOwner_IncrementsBalanceAndReturnsTokenId() public {
        // Use real owner from chain
        uint256 beforeBal = token.balanceOf(alice);

        vm.prank(owner);
        uint256 id0 = token.safeMint(alice);
        assertEq(token.ownerOf(id0), alice);
        assertEq(token.balanceOf(alice), beforeBal + 1);

        vm.prank(owner);
        uint256 id1 = token.safeMint(alice);
        assertEq(token.ownerOf(id1), alice);
        assertEq(token.balanceOf(alice), beforeBal + 2);

        // Do not assume sequential IDs starting at 0 on a fork; just ensure distinct IDs
        assertTrue(id1 != id0);
    }

    /* =========================
                 Burn
       ========================= */

    function test_BurnByOwner_RemovesTokenAndDecrementsBalance() public {
        // Mint to Alice using the real owner
        vm.startPrank(owner);
        uint256 id0 = token.safeMint(alice);
        vm.stopPrank();

        uint256 beforeBal = token.balanceOf(alice);
        assertEq(token.ownerOf(id0), alice);

        // Alice (owner of token) burns tokenId
        vm.prank(alice);
        token.burn(id0);

        // After burn: token no longer exists → ownerOf(id0) should revert
        vm.expectRevert(
            abi.encodeWithSignature("ERC721NonexistentToken(uint256)", id0)
        );
        token.ownerOf(id0);

        // Balance drops by 1
        assertEq(token.balanceOf(alice), beforeBal - 1);
    }

    function test_BurnRequiresOwnerOrApproved() public {
        // Mint tokenId to Alice
        vm.prank(owner);
        uint256 id0 = token.safeMint(alice);

        // Bob (not owner/approved) tries to burn → revert with ERC721InsufficientApproval(address,uint256)
        vm.prank(bob);
        vm.expectRevert(
            abi.encodeWithSignature(
                "ERC721InsufficientApproval(address,uint256)",
                bob,
                id0
            )
        );
        token.burn(id0);
    }

    function test_BurnByApprovedOperator_Succeeds() public {
        // Mint tokenId to Alice
        vm.prank(owner);
        uint256 id0 = token.safeMint(alice);

        // Alice approves Bob for tokenId
        vm.prank(alice);
        token.approve(bob, id0);

        // Bob can now burn that tokenId
        vm.prank(bob);
        token.burn(id0);

        vm.expectRevert(
            abi.encodeWithSignature("ERC721NonexistentToken(uint256)", id0)
        );
        token.ownerOf(id0);
        // Balance of Alice decreased
        // (we don't assert exact value; just ensure the token is gone)
        // Optionally: assertEq(token.balanceOf(alice), prev - 1);
    }

    function test_BurnByOperatorApprovedForAll_Succeeds() public {
        // Mint tokenId to Alice
        vm.prank(owner);
        uint256 id0 = token.safeMint(alice);

        // Approve Bob for all of Alice's tokens
        vm.prank(alice);
        token.setApprovalForAll(bob, true);

        // Bob can burn that tokenId
        vm.prank(bob);
        token.burn(id0);

        vm.expectRevert(
            abi.encodeWithSignature("ERC721NonexistentToken(uint256)", id0)
        );
        token.ownerOf(id0);
        // Optionally check balance decrease as above
    }

    /* =========================
               Fuzzing
       ========================= */

    function testFuzz_MintToAnyNonZeroAddress(address to) public {
        vm.assume(to != address(0));

        // Avoid remote eth_getBalance lookups for every fuzz input
        vm.deal(to, 0);

        vm.prank(owner);
        uint256 id = token.safeMint(to);

        // id should be valid
        assertEq(token.ownerOf(id), to);
        assertEq(token.balanceOf(to), 1);
    }
}

```

Some things to note:

* Use the deployed contract address instead of deploying a new one.
* Automatically read the real owner from chain and impersonate it for owner-only actions.
* Pre-deal balances to addresses to avoid `eth_getBalance` calls on the RPC.
* Fuzz test no longer checks `to.code.length` (which would trigger an `eth_getCode` per iteration) and pre-deals the target address to avoid RPC balance lookups.
* Removes assumptions that depend on a freshly deployed local contract (like token IDs starting at 0)

### Run tests

Now, we're ready to run some tests.

```bash
forge test --fork-url https://mainnet.hashio.io/api
```

We can also pin a specific block for reproducibility:

```bash
forge test --fork-url https://mainnet.hashio.io/api --fork-block-number 84800456
```

We are using block number `84800456` for this testing because the contract from above(i.e. `0x07F6D65f9454EA2dff99bF8C2C1De918Fcd27416` was deployed on block `84800456`. If we tried to run our tests with block below this, it would fail such as:

```bash
forge test --fork-url https://mainnet.hashio.io/api --fork-block-number 84800455
```

This would fail with something like:

```bash
Ran 1 test for test/MyToken.t.sol:MyTokenTest
[FAIL: EvmError: Revert] setUp() (gas: 0)
Suite result: FAILED. 0 passed; 1 failed; 0 skipped; finished in 5.22ms (0.00ns CPU time)

Ran 1 test suite in 330.90ms (5.22ms CPU time): 0 tests passed, 1 failed, 0 skipped (1 total tests)

Failing tests:
Encountered 1 failing test in test/MyToken.t.sol:MyTokenTest
[FAIL: EvmError: Revert] setUp() (gas: 0)

Encountered a total of 1 failing tests, 0 tests succeeded
```

## Further Learning & Next Steps

Want to take your local development setup even further? Here are some excellent references to help you dive deeper into Foundry:

1. [**How to Mint and Burn an ERC-721 Token (Part 1)**](how-to-mint-and-burn-an-erc-721-token-using-foundry-part-1.md)\
   Learn how to create a basic ERC-721 NFT, mint it, and burn it on Hedera.
2. [How to Write Tests in Solidity (Part 2)](how-to-write-tests-in-solidity-part-2.md)\
   Learn how to start writing tests in Foundry using Solidity
3. [Learn more about Hedera Forking repo](https://github.com/hashgraph/hedera-forking)
4. [Learn more about advanced testing with Foundry](https://getfoundry.sh/forge/advanced-testing/overview)

<table data-card-size="large" data-view="cards"><thead><tr><th align="center"></th><th data-hidden data-card-target data-type="content-ref"></th></tr></thead><tbody><tr><td align="center"><p>Writer: Kiran, Developer Advocate</p><p><a href="https://github.com/kpachhai">GitHub</a> | <a href="https://www.linkedin.com/in/kiranpachhai/">LinkedIn</a></p></td><td><a href="https://www.linkedin.com/in/kiranpachhai/">https://www.linkedin.com/in/kiranpachhai/</a></td></tr><tr><td align="center"><p>Editor: Krystal, Technical Writer</p><p><a href="https://github.com/theekrystallee">GitHub</a> | <a href="https://x.com/theekrystallee">X</a></p></td><td><a href="https://x.com/theekrystallee">https://x.com/theekrystallee</a></td></tr></tbody></table>
