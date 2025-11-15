# Hedera Documentation

## Contributor Quickstart Guide

Welcome to the Hedera documentation repository!
This guide will help you get started contributing to the official Hedera Docs site.

Our documentation is Git-based, meaning all content lives in `.mdx` files within this repository.
To contribute, fork the repo, create a branch, make your edits, and open a pull request (PR).
Once your PR is reviewed and merged, the updated docs will automatically appear on the live site.

---

### 1. Local Repo Setup

1. Clone the repository:

   ```bash
   git clone https://github.com/hashgraph/hedera-docs.git
   cd hedera-docs
   ```
2. Install the Mintlify CLI (requires Node.js):

   ```bash
   npm i -g mint
   ```
3. Install project dependencies:

   ```bash
   npm install
   ```

Reference the official [Mintlify docs](https://www.mintlify.com/docs/quickstart) for more details.

---

### 2. Local Preview

Run the local dev server:

```bash
mint dev
```

Open `http://localhost:3000` to view changes as you edit.

---

### 3. Editing Content

* Write pages in **MDX** under the docs directory.
* Include **frontmatter** at the top of each page for title and description.
* **Navigation is managed in `docs.json`.**

**Frontmatter example**

```md
---
title: "Introduction"
description: "Overview of the Hedera docs"
---
```

**docs.json example**

```json
{
  "navigation": [
    {
      "group": "Getting Started",
      "pages": ["introduction", "quickstart", "deploy-contract"]
    },
    {
      "group": "Core Concepts",
      "pages": ["accounts", "tokens", "smart-contracts"]
    }
  ]
}
```

---

### 4. Branching and Commits

Create a feature branch:

```bash
git checkout -b docs/update-quickstart
```

Commit with a clear message **and** DCO sign-off:

```bash
git commit -s -m "docs: update contributor quickstart for Hedera"
```

Push your branch:

```bash
git push -u origin docs/update-quickstart
```

Then open a pull request to this repository.

---

### 5. Developer Certificate of Origin (DCO)

All contributions must comply with the Developer Certificate of Origin (DCO). Each commit must include a sign-off line in the commit message:

```
Signed-off-by: Your Name <your.email@example.com>
```

Add it automatically with `-s` on `git commit`.

If you forgot to sign off, amend your last commit:

```bash
git commit --amend -s
git push --force
```

PRs without valid DCO sign-offs will not pass automated checks. GitHub docs on commit signatures can be found [here](https://docs.github.com/en/authentication/managing-commit-signature-verification).

---

### 6. Reviews and Approvals

- All contributions are submitted through pull requests.
- PRs are reviewed by the Hedera docs team or community maintainers.
- Once approved, PRs are merged into main. Merging automatically deploys the updated docs to:
    * https://docs.hedera.com

---

### 7. Common Tasks Cheat Sheet

| Task                     | Command / File                | Notes                                |
| ------------------------ | ----------------------------- | ------------------------------------ |
| Check status of changes  | `git status`                  | Shows modified and untracked files   |
| Start local preview      | `mint dev`                 | Runs docs site locally               |
| Add a new page           | Create `.mdx` in `/hedera`      | Each page must include frontmatter   |
| Edit navigation          | `docs.json`                   | Controls sidebar and menu            |
| Create a branch          | `git checkout -b <branch>`    | Use descriptive branch names         |
| Commit with DCO          | `git commit -s -m "message"`  | Required for all contributions       |
| Push branch              | `git push -u origin <branch>` | Pushes your changes to your fork     |

---

### 8. Need Help?

If you have questions or need support:

- Open a [GitHub Issue](https://github.com/hashgraph/hedera-docs/issues)
- Join the conversation in the [Hedera Discord](https://hedera.com/discord)
- [Mintlify Documentation](https://www.mintlify.com/docs)

We welcome your contributions to improve the Hedera documentation!


