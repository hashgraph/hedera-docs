# SDK docs sync

The [SDK Docs Sync](../workflows/sdk-docs-sync.yml) workflow keeps the native SDK docs in step with the [hiero-ledger SDK repos](https://github.com/orgs/hiero-ledger/repositories?q=sdk). It runs daily at 08:00 UTC and on demand (**Actions → SDK Docs Sync → Run workflow**). It has two jobs: **sync**, which keeps versions current and reports changes, and **draft-docs**, which writes docs for APIs that are missing.

## Sync: versions and change reports

Each `<sdk>.json` file here records the SDK version the docs were last reviewed against, along with the package name seen at that version. Merging a sync PR moves that version forward.

For each SDK (`js`, `java`, `go`, `python`, `swift`, `rust`, `cpp`), when the latest stable release is newer than the recorded version:

1. **Bumps install pins** in the docs (Gradle/Maven coordinates, `package.json` snippets, and so on) to the latest version. Only explicit install snippets are bumped. "Available in vX.Y.Z+" feature minimums are never touched.
2. **Diffs the public API** between the two tags using the SDK source trees, not the changelog. It looks for new and removed `*Transaction`/`*Query` classes and for public methods added to or removed from existing classes. Each change is checked against the docs, and items that aren't documented are flagged.
3. **Flags breaking changes and deprecations** from the release notes of every release in between.
4. **Flags a package rename upstream**, plus retired identifiers that are still in the docs (such as `@hashgraph/sdk`). These are reported only, never auto-replaced.

The result is one PR per SDK on `automation/sdk-sync-<sdk>`, with a checklist report as the PR body.

## Draft-docs: writing docs for missing APIs

1. **Finds what's missing** ([`sdk-coverage.js`](../scripts/sdk-coverage.js)), at each SDK's latest release, measured against the docs as they are now:
   - public `*Transaction`/`*Query` classes that no SDK reference page (`native/`, outside the tutorials) mentions
   - setter-style methods (`set*`, `add*`, `clear*`) of documented classes that their reference page never mentions, measured on the JS and Java SDKs, whose names the method tables use
2. **Drafts the docs** ([`sdk-draft-docs.js`](../scripts/sdk-draft-docs.js)), one session per gap, up to `draft_limit` gaps per run (default 8). It reads the SDK source, examples and tests at the release tag, then adds rows to the existing methods table or writes a new page and adds it to the sidebar, following the repository's terminology and authoring rules.
3. **Opens one PR** on `automation/sdk-docs-drafts`. The PR body lists what was drafted (with the files changed and the SDK files used), what the drafting step declined to document, what failed, what's left for the next run, and the run's cost.

**Guardrails.** The drafting step has no shell and no general network access. It can:
- read docs pages and files that exist in the SDK source trees at the release tag
- write only `native/**/*.mdx` pages outside the tutorials
- add a nav entry to `docs.json` by inserting one line

Every write must compile as MDX and pass the terminology check, or it's rejected. A session that fails or runs out of steps is rolled back. The job re-checks every changed page before opening the PR, and nothing merges without review.

**Between runs,** an open drafts PR is carried forward: its changes are re-applied on top of the latest `main`, so earlier drafts are kept and only new gaps are drafted. A gap the drafting step declined, or that failed twice, isn't retried until the drafts PR is merged or closed. These decisions are stored in a hidden comment in the PR body.

**Setup:** add an `SDK_DRAFTS_API_KEY` repository secret. Without it, the job lists the gaps in the run's job summary and drafts nothing.

## Ignoring APIs

Deprecated methods are detected from the SDK source (JSDoc/Javadoc `@deprecated`, Go `Deprecated:`, Rust `#[deprecated]`, Swift `@available(*, deprecated)`, C++ `[[deprecated]]`), so they're never reported as gaps. The sync report lists newly deprecated methods as **Deprecated**, marked "(still in docs)" when a page still mentions them.

[`ignore.json`](ignore.json) lists everything else that should never be reported or drafted: internal classes, SDK-specific spellings of documented APIs, system-only and admin-only APIs, and APIs the docs leave out on purpose. Each entry needs a reason, ideally linking the issue or PR where it was decided. Method entries can match:

- `"name"`: one method name, in any SDK's spelling (`setFoo`, `SetFoo`, `set_foo`)
- `"contains"`: every method whose name contains a fragment, for a whole family across SDKs (for example `"hook"`)
- `"class"` plus `"name"`: one method on one class only

When the drafting step skips something you agree shouldn't be documented, add it here.

## Reviewer edits are protected

Once anyone other than the bot pushes to a sync or drafts branch, the workflow stops refreshing that PR so it doesn't overwrite their work. Merge or close the PR to resume.

## Common tasks

- **Re-report older changes:** run the workflow with a single SDK and set `from` (for example `2.76.0`).
- **Run only the drafting job:** run the workflow with `sdk` set to `none`.
- **Run locally** (on a scratch branch, because these edit files in place):
  ```bash
  npm install --no-save @anthropic-ai/sdk@0.131.0 zod@4.6.5 @mdx-js/mdx@3.1.1
  GH_TOKEN=$(gh auth token) node .github/scripts/sdk-sync.js --sdk java
  GH_TOKEN=$(gh auth token) node .github/scripts/sdk-coverage.js --out /tmp/gaps.json --summary /tmp/gaps.md
  SDK_DRAFTS_API_KEY=... GH_TOKEN=$(gh auth token) node .github/scripts/sdk-draft-docs.js --gaps /tmp/gaps.json --report /tmp/drafts.md --limit 1
  ```
  `--only <id>` drafts a single gap from `gaps.json` (for example `class:mirrornodetokenbalancequery`).
- **Add a pin pattern, retired identifier, or new SDK:** edit [`sdk-sources.js`](../scripts/lib/sdk-sources.js), add a `<sdk>.json` state file, and add the SDK to the workflow matrix and the `sdk` input options.
