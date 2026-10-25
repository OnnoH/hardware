#!/usr/bin/env bash
# AC-1: the build matrix covers every PlatformIO project in the repository.
#
# Fails when a platformio.ini exists that ci/platformio-projects.txt does not
# list, or when the list names a directory that has no platformio.ini.
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "${repo_root}"

listed="$(mktemp)"
found="$(mktemp)"
trap 'rm -f "${listed}" "${found}"' EXIT

ci/project-list.sh | LC_ALL=C sort >"${listed}"
find . -name platformio.ini -not -path './.git/*' -printf '%h\n' |
  sed 's|^\./||' | LC_ALL=C sort >"${found}"

if ! diff -u --label 'ci/platformio-projects.txt' "${listed}" \
  --label 'platformio.ini found in repository' "${found}"; then
  echo "AC-1 FAIL: the project list and the repository disagree (see diff above)." >&2
  echo "Add or remove the project directory in ci/platformio-projects.txt." >&2
  exit 1
fi

echo "AC-1 OK: $(wc -l <"${listed}" | tr -d ' ') PlatformIO projects, all in the build matrix."
