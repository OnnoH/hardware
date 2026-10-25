#!/usr/bin/env bash
# Print the project directories from ci/platformio-projects.txt, one per line.
# Project directories contain spaces, so every consumer reads whole lines.
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
sed -e 's/[[:space:]]*$//' -e '/^#/d' -e '/^$/d' "${repo_root}/ci/platformio-projects.txt"
