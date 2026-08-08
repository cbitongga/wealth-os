#!/usr/bin/env bash
# Scaffolds the files referenced by the rewritten Wealth OS AGENTS.md.
# Safe to re-run: never overwrites an existing file.
set -euo pipefail

DIR="${1:-/home/hermes/workspace/wealth-os}"
mkdir -p "$DIR"
cd "$DIR"

make_file() {
  if [ -e "$1" ]; then
    echo "skip   $1 (already exists)"
  else
    cat > "$1"
    echo "create $1"
  fi
}

make_file profile.md <<'EOF'
# Profile

Last updated: YYYY-MM-DD

The agent scores conservatively and flags a warning if this file is more than
90 days stale. Keep it current.

## Time

- Hours per week actually available for new ventures:
- Hours per week currently spent IN the franchise (not on it):
- Day job status and weekly hours:

## Capital

- Capital deployable without stress:
- Cash reserve floor (never go below):
- Current net worth:
- Target: $1,000,000 net worth by <date>

## Franchise

- Brand / territory:
- Annual revenue:
- Approximate SDE or EBITDA:
- Headcount (caregivers / admin):
- My weekly hours in it:
- Biggest current operational bottleneck:

## Constraints

- Employment agreement IP / moonlighting restrictions:
- Franchise agreement non-compete summary (read the FDD):
- Risk tolerance (1-10):
- Anything I refuse to do regardless of return:
EOF

make_file portfolio.md <<'EOF'
# Active Portfolio

Hard cap: 3 items. Adding a fourth requires killing or completing one.

## Active Items

_(none yet)_

<!--
Template:

### <name>
- Lever: 1-5
- Why active: 
- Current stage: 
- My weekly hours committed: 
- Money committed to date: 
- Next milestone and date: 
- Kill condition: 
- Date activated: 
-->

## Open Experiment

Cap: 1.

_(none yet)_
EOF

make_file decisions.md <<'EOF'
# Decision Log

APPEND ONLY. Never edit or delete prior entries.

Format: `YYYY-MM-DD | RUN TYPE | DECISION | RATIONALE`

---
EOF

make_file opportunities.md <<'EOF'
# Opportunities

Candidates that passed all kill gates but are not yet active. Hard cap: 10.
Anything untouched for 60 days gets reviewed: revive with new evidence, or reject.

---
EOF

make_file experiments.md <<'EOF'
# Experiments

Every experiment declares its success threshold, failure threshold, and kill
date BEFORE it starts.

---
EOF

make_file rejected.md <<'EOF'
# Rejected

Read this before every scout run. Do not re-surface anything here without
materially new evidence.

Format: idea | date | gate or reason failed | evidence | what would change my mind

---
EOF

make_file wealth_thesis.md <<'EOF'
# Wealth Thesis

Append only. Never rewrite from scratch.

## Standing conclusions

- I hold two asset bases: an operating home care franchise and an enterprise
  software career. The defensible ground is the intersection.
- Time, not ideas or capital, is the binding constraint.
- Unverified: the franchise's enterprise value may be the single largest
  component of the path to $1M. Confirm once profile.md has real numbers.

## Patterns observed

_(to be filled by monthly reviews)_

## Repeated validation failures

_(to be filled by monthly reviews)_
EOF

echo
echo "Done. Directory: $DIR"
ls -la "$DIR"
echo
echo "NEXT: fill in profile.md before the next agent run."
