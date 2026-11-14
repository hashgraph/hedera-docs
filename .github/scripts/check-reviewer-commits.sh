#!/usr/bin/env bash
# Tells an automation job whether it may refresh its PR branch.
#
# create-pull-request force-pushes its branch, which would wipe fixes a reviewer
# pushed to an open automated PR, so a branch with commits from anyone other than
# github-actions[bot] is left alone until its PR is merged or closed.
#
# Usage: check-reviewer-commits.sh <branch>
# Writes exists=true|false and skip=true|false to $GITHUB_OUTPUT. Needs GH_TOKEN.

set -euo pipefail

BRANCH="$1"
BOT_EMAIL='41898282+github-actions[bot]@users.noreply.github.com'
OUT="${GITHUB_OUTPUT:-/dev/stdout}"

if [[ -z "$(git ls-remote --heads origin "${BRANCH}")" ]]; then
  echo "No existing ${BRANCH} branch."
  { echo "exists=false"; echo "skip=false"; } >> "${OUT}"
  exit 0
fi

authors="$(gh api "repos/${GITHUB_REPOSITORY}/compare/${GITHUB_REF_NAME}...${BRANCH}" \
  --jq '[.commits[].commit.author.email] | unique | .[]')"
others="$(grep -vxF "${BOT_EMAIL}" <<<"${authors}" || true)"

if [[ -n "${others}" ]]; then
  echo "::warning::${BRANCH} has commits from reviewers (${others//$'\n'/, }). Not refreshing it; merge or close that PR first."
  { echo "exists=true"; echo "skip=true"; } >> "${OUT}"
else
  { echo "exists=true"; echo "skip=false"; } >> "${OUT}"
fi
