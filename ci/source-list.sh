#!/usr/bin/env bash
# Print every C/C++ source and header tracked in this repository, NUL separated.
# Build output (.pio) and the git directory are skipped.
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "${repo_root}"

find . \
  \( -path './.git' -o -name '.pio' -o -name '.vscode' \) -prune -o \
  -type f \( -name '*.c' -o -name '*.cpp' -o -name '*.h' -o -name '*.hpp' -o -name '*.ino' \) \
  -print0 | LC_ALL=C sort -z
