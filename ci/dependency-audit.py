#!/usr/bin/env python3
"""AC-4: inventory of the dependencies every PlatformIO project declares.

Reads the platformio.ini of each project in ci/platformio-projects.txt and
prints the platform, the framework, the pinned platform packages and the
library dependencies as a Markdown table. When GITHUB_STEP_SUMMARY is set the
table is appended there too, so the inventory is visible on the run page.

This is an inventory check, not a vulnerability gate: PlatformIO has no
first-party vulnerability database, so there is nothing to compare against.
The check fails when a manifest is missing or cannot be parsed, or when a
project declares no platform at all.

It also runs ci/check-renovate-config.sh, which checks how the dependencies of
this repository are updated (ONN-24 AC-1 and AC-2).
"""

from __future__ import annotations

import configparser
import os
import subprocess
import sys
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parent.parent


def project_dirs() -> list[str]:
    out = subprocess.run(
        [str(REPO_ROOT / "ci" / "project-list.sh")],
        check=True,
        capture_output=True,
        text=True,
    ).stdout
    return [line for line in out.splitlines() if line]


def values(section: configparser.SectionProxy, key: str) -> list[str]:
    """PlatformIO writes multi-value options one per line."""
    raw = section.get(key, "")
    return [item.strip() for item in raw.splitlines() if item.strip()]


def inventory(project: str) -> tuple[dict[str, list[str]], list[str]]:
    """Return the declared dependencies of a project and any problems found."""
    manifest = REPO_ROOT / project / "platformio.ini"
    if not manifest.is_file():
        return {}, [f"{project}: no platformio.ini"]

    parser = configparser.ConfigParser(strict=False)
    try:
        parser.read(manifest, encoding="utf-8")
    except configparser.Error as exc:
        return {}, [f"{project}: cannot parse platformio.ini: {exc}"]

    found: dict[str, list[str]] = {
        "platform": [],
        "framework": [],
        "platform_packages": [],
        "lib_deps": [],
    }
    # Options in [env] apply to every [env:NAME]; collect both.
    for name in parser.sections():
        if name != "env" and not name.startswith("env:"):
            continue
        section = parser[name]
        for key in found:
            for value in values(section, key):
                if value not in found[key]:
                    found[key].append(value)

    problems = [] if found["platform"] else [f"{project}: no platform declared"]
    return found, problems


def renovate_config() -> int:
    """ONN-24 AC-1 and AC-2: the Renovate configuration of this repository."""
    # The child writes to the same stdout; flush first so the log reads in order.
    sys.stdout.flush()
    return subprocess.run(
        [str(REPO_ROOT / "ci" / "check-renovate-config.sh")],
        check=False,
    ).returncode


def main() -> int:
    projects = project_dirs()
    if not projects:
        print("AC-4 FAIL: ci/platformio-projects.txt lists no projects", file=sys.stderr)
        return 1

    rows: list[str] = []
    problems: list[str] = []
    lib_total = 0

    for project in projects:
        found, found_problems = inventory(project)
        problems.extend(found_problems)
        if not found:
            continue
        lib_total += len(found["lib_deps"])
        rows.append(
            "| {} | {} | {} | {} | {} |".format(
                project,
                ", ".join(found["platform"]) or "—",
                ", ".join(found["framework"]) or "—",
                "<br>".join(found["platform_packages"]) or "—",
                "<br>".join(found["lib_deps"]) or "—",
            )
        )

    report = "\n".join(
        [
            "## AC-4: declared PlatformIO dependencies",
            "",
            f"{len(projects)} projects, {lib_total} library dependencies declared.",
            "",
            "| Project | Platform | Framework | Platform packages | Library dependencies |",
            "| --- | --- | --- | --- | --- |",
            *rows,
            "",
            "_Inventory only: PlatformIO has no first-party vulnerability database._",
            "",
        ]
    )
    print(report)

    summary = os.environ.get("GITHUB_STEP_SUMMARY")
    if summary:
        with open(summary, "a", encoding="utf-8") as handle:
            handle.write(report)

    for problem in problems:
        print(f"AC-4 FAIL: {problem}", file=sys.stderr)
    if not problems:
        print(f"AC-4 OK: dependency inventory produced for {len(projects)} projects.")

    # Run both halves before failing, so one run shows every problem.
    return 1 if (renovate_config() or problems) else 0


if __name__ == "__main__":
    sys.exit(main())
