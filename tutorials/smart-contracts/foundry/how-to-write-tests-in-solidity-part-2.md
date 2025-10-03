# How to Write Tests in Solidity(Part 2)

In this tutorial, you’ll learn how to write Solidity unit tests with Foundry for an ERC‑721 (NFT) contract that supports minting and burning. We’ll cover:

* Using cheatcodes like prank, startPrank/stopPrank, expectRevert, label, and fuzzing
* Testing ownership-gated minting
* Testing ERC‑721 burn behavior (owner/approved)
* Common gotchas with OpenZeppelin v5 custom errors

This guide stands on its own, but continues from [Part 1](how-to-mint-and-burn-an-erc-721-token-using-foundry-part-1.md) where we created the ERC‑721 contract and deploy/mint/burn scripts. Here, we focus exclusively on defining and writing tests.

Note: Foundry tests run locally on an in‑memory EVM; they do not use Hedera RPC. That makes them fast and deterministic. You’ll still deploy to Hedera when you run your scripts from Part 1.

{% hint style="info" %}
You can take a look at the **complete code** in the [**Hedera-Code-Snippets repository**](https://github.com/hedera-dev/hedera-code-snippets/tree/main/foundry-erc-721-mint-burn).
{% endhint %}

***

## Prerequisites

* ⚠️ **Complete** [**tutorial part 1**](how-to-mint-and-burn-an-erc-721-token-using-foundry-part-1.md) **as we continue from this example.**
* Foundry installed:
  * `curl -L https://foundry.paradigm.xyz | bash`
  * `foundryup`
* OpenZeppelin Contracts installed for the ERC‑721 implementation:
  * `forge install OpenZeppelin/openzeppelin-contracts`
* Basic familiarity with Solidity and ERC‑721

***

## Table of Contents

1. [The Contract under Test](how-to-write-tests-in-solidity-part-2.md#the-contract-under-test)
2. [Writing tests in Solidity for Foundry](how-to-write-tests-in-solidity-part-2.md#writing-tests-in-solidity-for-foundry)
3. [Understanding each test and concept](how-to-write-tests-in-solidity-part-2.md#understanding-each-test-and-concept)
4. [Running tests](how-to-write-tests-in-solidity-part-2.md#running-tests)
5. [Common gotchas](how-to-write-tests-in-solidity-part-2.md#common-gotchas)
6. [Where tests fit with Hedera](how-to-write-tests-in-solidity-part-2.md#where-tests-fit-with-hedera)

***

## The Contract under Test

We’ll test the ERC‑721 contract that supports mint and burn. If you don’t already have it, create it:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {ERC721Burnable} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";

contract MyToken is ERC721, ERC721Burnable, Ownable {
    uint256 private _nextTokenId;

    constructor(address initialOwner)
        ERC721("MyToken", "MTK")
        Ownable(initialOwner)
    {}

    function safeMint(address to) public onlyOwner returns (uint256) {
        uint256 tokenId = _nextTokenId++;
        _safeMint(to, tokenId);
        return tokenId;
    }
}
```

Key points:

* Name/symbol: “MyToken” / “MTK”
* Owner‑only `safeMint`
* Auto‑increment token IDs starting at 0
* Burnable via `ERC721Burnable` (owner or approved may burn)

***

## Writing tests in Solidity for Foundry

Create a test file at `test/MyToken.t.sol` with the suite below.

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "forge-std/Test.sol";
import {MyToken} from "../src/MyToken.sol";
import {IERC721} from "@openzeppelin/contracts/token/ERC721/IERC721.sol";

contract MyTokenTest is Test {
    MyToken internal token;

    address internal owner;
    address internal alice;
    address internal bob;

    function setUp() public {
        owner = makeAddr("owner");
        alice = makeAddr("alice");
        bob = makeAddr("bob");

        // Deploy with explicit initial owner
        token = new MyToken(owner);

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
        assertTrue(token.supportsInterface(type(IERC721).interfaceId));
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
        // First mint should return 0
        vm.prank(owner);
        uint256 id0 = token.safeMint(alice);
        assertEq(id0, 0);
        assertEq(token.balanceOf(alice), 1);
        assertEq(token.ownerOf(0), alice);

        // Second mint should return 1
        vm.prank(owner);
        uint256 id1 = token.safeMint(alice);
        assertEq(id1, 1);
        assertEq(token.balanceOf(alice), 2);
        assertEq(token.ownerOf(1), alice);
    }

    /* =========================
                 Burn
       ========================= */

    function test_BurnByOwner_RemovesTokenAndDecrementsBalance() public {
        // Mint tokenId 0 to Alice
        vm.startPrank(owner);
        uint256 id0 = token.safeMint(alice);
        vm.stopPrank();

        assertEq(id0, 0);
        assertEq(token.balanceOf(alice), 1);
        assertEq(token.ownerOf(0), alice);

        // Alice (owner) burns tokenId 0
        vm.prank(alice);
        token.burn(0);

        // After burn: token no longer exists → ownerOf(0) should revert
        vm.expectRevert(
            abi.encodeWithSignature("ERC721NonexistentToken(uint256)", 0)
        );
        token.ownerOf(0);

        // Balance drops
        assertEq(token.balanceOf(alice), 0);
    }

    function test_BurnRequiresOwnerOrApproved() public {
        // Mint tokenId 0 to Alice
        vm.prank(owner);
        token.safeMint(alice);

        // Bob (not owner/approved) tries to burn → revert with ERC721InsufficientApproval(address,uint256)
        vm.prank(bob);
        vm.expectRevert(
            abi.encodeWithSignature(
                "ERC721InsufficientApproval(address,uint256)",
                bob,
                0
            )
        );
        token.burn(0);
    }

    function test_BurnByApprovedOperator_Succeeds() public {
        // Mint tokenId 0 to Alice
        vm.prank(owner);
        token.safeMint(alice);

        // Alice approves Bob for tokenId 0
        vm.prank(alice);
        token.approve(bob, 0);

        // Bob can now burn tokenId 0
        vm.prank(bob);
        token.burn(0);

        // Token gone
        vm.expectRevert(
            abi.encodeWithSignature("ERC721NonexistentToken(uint256)", 0)
        );
        token.ownerOf(0);
        assertEq(token.balanceOf(alice), 0);
    }

    function test_BurnByOperatorApprovedForAll_Succeeds() public {
        // Mint tokenId 0 to Alice
        vm.prank(owner);
        token.safeMint(alice);

        // Approve Bob for all of Alice's tokens
        vm.prank(alice);
        token.setApprovalForAll(bob, true);

        // Bob can burn tokenId 0
        vm.prank(bob);
        token.burn(0);

        vm.expectRevert(
            abi.encodeWithSignature("ERC721NonexistentToken(uint256)", 0)
        );
        token.ownerOf(0);
        assertEq(token.balanceOf(alice), 0);
    }

    /* =========================
               Fuzzing
       ========================= */

    function testFuzz_MintToAnyNonZeroAddress(address to) public {
        vm.assume(to != address(0));
        vm.assume(to.code.length == 0); // ensure EOA, not a contract

        vm.prank(owner);
        uint256 id = token.safeMint(to);

        // id should be valid (not strictly needed to check exact id; existence is enough)
        assertEq(token.ownerOf(id), to);
        assertEq(token.balanceOf(to), 1);
    }
}
```

***

## Understanding each test and concept

Foundry test basics:

* Test files go in `test/` and compile like any Solidity.
* A function is treated as a test if its name starts with `test` (default pattern). You can also use modifiers like `view` for read-only tests.
* `setUp()` runs before every test, letting you deploy fresh state.
* Assertions come from `forge-std/Test.sol`: `assertEq`, `assertTrue`, etc.
* Cheatcodes come from the `vm` interface in `Test`: powerful helpers to manipulate EVM context.

Key cheatcodes used:

* `vm.prank(addr)`: sets `msg.sender` for the next call only.
* `vm.startPrank(addr)` / `vm.stopPrank()`: sets `msg.sender` for multiple calls.
* `vm.expectRevert(bytes)`: expects the next call to revert with a specific error.
* `vm.label(addr, "name")`: names an address for prettier traces.
* `makeAddr("salt")`: generates a deterministic address for readability.
* `vm.assume(cond)`: discard fuzz inputs that don’t satisfy a condition.

Now, what each section does:

1. Basics

* `test_NameAndSymbol`: sanity checks for token metadata.
* `test_SupportsERC721Interface`: verifies ERC‑721 interface support via `supportsInterface()`. This asserts the contract follows the standard interface.

2. Ownership

* `test_OnlyOwnerCanMint`:
  * We simulate a call from `alice` using `vm.prank(alice)`.
  * We assert it reverts with OpenZeppelin v5’s custom error `OwnableUnauthorizedAccount(address)`.
  * The order matters: `vm.expectRevert(...)` must be set before the call that’s expected to revert.
* `test_MintByOwner_IncrementsBalanceAndReturnsTokenId`:
  * Simulates minting from the `owner`.
  * Asserts token IDs start at 0 and increment.
  * Checks `balanceOf` and `ownerOf` correctness.

3. Burn

* `test_BurnByOwner_RemovesTokenAndDecrementsBalance`:
  * Owner mints to `alice`.
  * `alice` burns her token.
  * After burn, `ownerOf(0)` must revert with OZ v5’s `ERC721NonexistentToken(uint256)` custom error.
* `test_BurnRequiresOwnerOrApproved`:
  * A non‑owner, non‑approved account (`bob`) attempts to burn → expect `ERC721InsufficientApproval(address,uint256)`.
* `test_BurnByApprovedOperator_Succeeds` and `test_BurnByOperatorApprovedForAll_Succeeds`:
  * Show both approval paths: single token approval and operator approval for all.
  * After burn, token no longer exists.

4. Fuzzing

* `testFuzz_MintToAnyNonZeroAddress(address to)`:
  * Foundry will try many random addresses for `to`.
  * `vm.assume(to != address(0))` filters out zero address (which would revert in ERC‑721).
  * We assert ownership and balance for all valid cases.

***

## Running tests

* Run all tests:
  * `forge test`
* With verbose logs/traces:
  * `forge test -vv` (more verbose), `-vvv`, or `-vvvv` (full traces)
* Run a single test by name:
  * `forge test --mt test_BurnByOwner_RemovesTokenAndDecrementsBalance`
* Run tests from a single contract:
  * `forge test --mc MyTokenTest`

Optional tooling:

* Gas report: add `gas_reports = ["MyToken", "MyTokenTest"]` to `foundry.toml`, then `forge test --gas-report`
* Coverage:
  * `forge coverage` (generates LCOV; integrate with your CI or IDE)

***

## Common gotchas

* Order of `expectRevert`:
  * Always call `vm.expectRevert(...)` immediately before the call you expect to revert.
* `prank` vs `startPrank`:
  * `vm.prank(addr)` affects only the next call; `vm.startPrank(addr)` persists until `vm.stopPrank()`. Use the latter for multi‑call sequences (e.g., deploy → call → call).
* `view` tests:
  * Mark pure/read‑only tests as `view` for clarity. It’s optional, but communicates intent.
* Deterministic addresses:
  * `makeAddr("label")` is a nice pattern for self‑documenting tests.
* Fuzzing:
  * Use `vm.assume` constraints to avoid invalid inputs that would cause spurious reverts (e.g., zero address).
  * Keep fuzz tests independent of each other (no hidden global state).
* Test isolation:
  * `setUp()` runs before every test, so each test gets a fresh deployment and state.
* Naming:
  * Descriptive names like `test_BurnByApprovedOperator_Succeeds` make failures easier to diagnose.

***

## Where tests fit with Hedera

* These tests run against Foundry’s local EVM, not Hedera. Use them to validate logic quickly.
* When satisfied, use your scripts from Part 1 to deploy/mint/burn on Hedera Testnet or Localnet.
* If something fails on-chain, add more unit tests here to replicate and fix.

<table data-card-size="large" data-view="cards"><thead><tr><th align="center"></th><th data-hidden data-card-target data-type="content-ref"></th></tr></thead><tbody><tr><td align="center"><p>Writer: Kiran, Developer Advocate</p><p><a href="https://github.com/kpachhai">GitHub</a> | <a href="https://www.linkedin.com/in/kiranpachhai/">LinkedIn</a></p></td><td><a href="https://www.linkedin.com/in/kiranpachhai/">https://www.linkedin.com/in/kiranpachhai/</a></td></tr><tr><td align="center"><p>Editor: Krystal, Technical Writer</p><p><a href="https://github.com/theekrystallee">GitHub</a> | <a href="https://x.com/theekrystallee">X</a></p></td><td><a href="https://x.com/theekrystallee">https://x.com/theekrystallee</a></td></tr></tbody></table>
