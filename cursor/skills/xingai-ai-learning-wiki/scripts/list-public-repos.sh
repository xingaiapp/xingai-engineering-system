#!/usr/bin/env bash
# List public repos under xingaiapp for AI-Learning Wiki ingest.
# Usage: bash list-public-repos.sh [--json]
set -euo pipefail

ORG="${XINGAI_GH_ORG:-xingaiapp}"
LIMIT="${XINGAI_GH_LIMIT:-200}"

if ! command -v gh >/dev/null 2>&1; then
  echo "error: gh CLI required (https://cli.github.com/)" >&2
  exit 1
fi

if [[ "${1:-}" == "--json" ]]; then
  gh repo list "$ORG" --visibility public --limit "$LIMIT" \
    --json name,url,description,updatedAt,isFork,isArchived
  exit 0
fi

echo -e "name\turl\tdescription\tupdatedAt"
gh repo list "$ORG" --visibility public --limit "$LIMIT" \
  --json name,url,description,updatedAt \
  --jq '.[] | [.name, .url, (.description // "" | gsub("\t"; " ")), .updatedAt] | @tsv'
