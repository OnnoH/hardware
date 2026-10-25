#!/usr/bin/env bash
# Reformat every C/C++ source in place according to .clang-format.
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "${repo_root}"

clang_format="${CLANG_FORMAT:-clang-format}"
ci/source-list.sh | xargs -0 "${clang_format}" -i --style=file
echo "Formatted. Check 'git diff' before committing."
