#!/usr/bin/env bash
# AC-2: every C/C++ source matches .clang-format.
#
# Reports the offending files and exits non-zero on a formatting violation.
# Run `ci/format.sh` to fix them in place.
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "${repo_root}"

clang_format="${CLANG_FORMAT:-clang-format}"
"${clang_format}" --version

count=0
files=()
while IFS= read -r -d '' file; do
  count=$((count + 1))
  files+=("${file}")
done < <(ci/source-list.sh)

if [[ ${count} -eq 0 ]]; then
  echo "AC-2 FAIL: no C/C++ sources found, the check would pass vacuously." >&2
  exit 1
fi

if ! "${clang_format}" --dry-run -Werror --style=file "${files[@]}"; then
  echo "AC-2 FAIL: formatting violations above. Run ci/format.sh and commit the result." >&2
  exit 1
fi

echo "AC-2 OK: ${count} C/C++ sources match .clang-format."
