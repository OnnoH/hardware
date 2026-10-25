#!/usr/bin/env bash
# ONN-24 AC-1 and AC-2: the Renovate configuration of this repository.
#
# ONN-24 AC-1: renovate.json exists at the repository root and matches the
#              configuration the board approved (compared as JSON, so key
#              order and whitespace do not matter).
# ONN-24 AC-2: renovate-config-validator accepts it, exit code 0.
#
# Run from the dependency gate (ci/dependency-audit.py): renovate.json decides
# how this repository's dependencies are updated, so it is checked where the
# dependencies are. ONN-24 forbids changes under .github/, so this check has no
# job of its own.
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "${repo_root}"

# The configuration of ONN-24, verbatim.
read -r -d '' expected <<'JSON' || true
{
  "$schema": "https://docs.renovatebot.com/renovate-schema.json",
  "extends": ["config:recommended"],
  "packageRules": [
    {
      "description": "Merge minor, patch, pin and digest updates once CI is green; majors wait for a maintainer.",
      "matchUpdateTypes": ["minor", "patch", "pin", "digest"],
      "automerge": true
    }
  ]
}
JSON

if [[ ! -f renovate.json ]]; then
  echo "ONN-24 AC-1 FAIL: no renovate.json at the repository root." >&2
  exit 1
fi

if ! jq -e . renovate.json >/dev/null; then
  echo "ONN-24 AC-1 FAIL: renovate.json is not valid JSON." >&2
  exit 1
fi

if ! diff -u --label 'expected (ONN-24)' <(jq -S . <<<"${expected}") \
  --label 'renovate.json' <(jq -S . renovate.json); then
  echo "ONN-24 AC-1 FAIL: renovate.json differs from the approved configuration." >&2
  exit 1
fi

echo "ONN-24 AC-1 OK: renovate.json matches the approved configuration."

# Unpinned on purpose: validating against the current Renovate is what catches
# an option this repository uses being deprecated or renamed.
if ! command -v npx >/dev/null; then
  echo "ONN-24 AC-2 FAIL: npx is not available, cannot run renovate-config-validator." >&2
  exit 1
fi

if ! npx --yes --package renovate renovate-config-validator renovate.json; then
  echo "ONN-24 AC-2 FAIL: renovate-config-validator rejected renovate.json." >&2
  exit 1
fi

echo "ONN-24 AC-2 OK: renovate-config-validator exited 0."
