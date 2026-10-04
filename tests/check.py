#!/usr/bin/env python3
"""Run the assignment programs in the actual RARS simulator."""

import subprocess
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
checks = 0


def check(name, filename, values, expected, options=()):
    global checks
    result = subprocess.run(
        [str(ROOT / "tools/rars.sh"), "nc", "me", "ae1", "se1", "sm",
         "10000", *options, str(ROOT / filename)],
        input="".join(f"{value}\n" for value in values),
        text=True,
        capture_output=True,
        timeout=15,
        cwd=ROOT,
    )
    if result.returncode or "maximum step limit" in result.stderr.lower():
        raise AssertionError(f"{name}: RARS failed: {result.stderr}")
    if result.stdout != expected:
        raise AssertionError(
            f"{name}: expected {expected!r}, got {result.stdout!r}; "
            f"stderr={result.stderr!r}"
        )
    checks += 1
    print(f"PASS: {name}")


def line(values):
    return " ".join(map(str, values)) + "\n"


for value in (3, 2, 4, 0, -3, -2147483648, 2147483647):
    check(f"a: x={value}", "task_a.asm", [value], f"{int(value == 3)}\n")

for value in (132, 134, 137, 138, 139, 142, 144, 0, -3):
    expected = range(min(value, 138), max(value, 138) + 1, 3)
    check(f"b: x={value}", "task_b.asm", [value], line(expected))

for name, values, stored in (
    ("zero first", [0, 99], []),
    ("zero in the middle", [7, -2, 9, 0, 99], [7, -2, 9]),
    ("full array without zero", list(range(1, 20)), list(range(1, 20))),
    ("ignore twentieth value", list(range(1, 21)), list(range(1, 20))),
    ("signed bounds", [-2147483648, 2147483647, 0], [-2147483648, 2147483647]),
):
    check(f"c: {name}", "task_c.asm", values, line(stored))

print(f"All {checks} checks passed in RARS.")
