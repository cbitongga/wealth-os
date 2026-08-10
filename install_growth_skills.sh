#!/usr/bin/env bash
#
# Growth OS — skill installer
#
# Creates four skills in ~/.hermes/skills/growth/
#   growth-scout, growth-committee, growth-experiment, growth-review
#
# Usage:
#   bash install_growth_skills.sh
#
# Safe to re-run: backs up any existing SKILL.md before overwriting.
#
# FRONTMATTER: this script uses the agentskills.io standard (name +
# description), which Hermes states it is compatible with. Step 1 below prints
# a bundled skill's frontmatter so you can confirm. If your version expects
# extra fields, add them to each file after install.

set -euo pipefail

SKILLS_ROOT="${HERMES_HOME:-$HOME/.hermes}/skills"
DEST="$SKILLS_ROOT/growth"

# ---------------------------------------------------------------- step 1

echo "=== Reference: frontmatter from a bundled skill ==="
REF=$(find "$SKILLS_ROOT" -name SKILL.md 2>/dev/null | head -1 || true)
if [ -n "$REF" ]; then
  echo "  ($REF)"
  sed -n '1,12p' "$REF"
else
  echo "  No bundled skills found under $SKILLS_ROOT"
  echo "  Verify the path before continuing."
fi
echo "=================================================="
echo

read -r -p "Continue and install the four growth skills? [y/N] " ok
[ "$ok" = "y" ] || [ "$ok" = "Y" ] || { echo "Aborted."; exit 0; }

# ---------------------------------------------------------------- helper

write_skill() {
  local name="$1"
  local dir="$DEST/$name"
  mkdir -p "$dir"
  if [ -f "$dir/SKILL.md" ]; then
    cp "$dir/SKILL.md" "$dir/SKILL.md.bak.$(date +%F-%H%M)"
    echo "  backed up existing $name"
  fi
  cat > "$dir/SKILL.md"
  echo "  wrote $dir/SKILL.md"
}

echo
echo "Installing to $DEST"
echo

# ---------------------------------------------------------------- scout

write_skill growth-scout <<'SKILLEOF'
---
name: growth-scout
description: Weekly discovery and gating run for the Homewatch CareGivers of Los Altos business growth system. Researches improvement opportunities across pricing, referral development, local visibility, retention and operations. Research only - never activates work. Use for the scheduled weekly growth scout job.
---

# Growth Scout

## Before doing anything

Read in this order, every run:

1. `AGENTS.md` — the operating mandate
2. `profile.md` — verified numbers, confidence tags, standing instructions
3. `portfolio.md` — what is already active
4. `rejected.md` — do not re-surface anything here without new evidence
5. `targets.md` — the referral target list
6. `decisions.md` — which levers the last two scout runs covered

Three prior diagnoses were wrong because figures were assumed rather than read.
Do not skip this.

## Mandate

**Discover and gate. Nothing else.**

May write to: `opportunities.md`, `rejected.md`, `targets.md`.
May not: activate anything in `portfolio.md`, close experiments, update
`metrics.md`.

## Limits

- Maximum 3 new items per run
- Maximum 8 web searches per run
- Maximum 10 items in `opportunities.md`

## Lever rotation

Check `decisions.md`. Do not cover the same lever three runs consecutively.

1. Margin — rate, wage structure, fixed cost
2. Demand generation — referral relationships
3. Local visibility — reviews, Google Business Profile, map rank
4. Retention and tenure
5. Operations and capacity

## Hard rules — apply BEFORE scoring

Any failure kills the item. Log to `rejected.md` with the rule it failed.

1. **Labor.** Proposals are NOT limited to the owner 6 hrs/week — two sisters
   work the business full-time and can execute. But their 80 combined hours are
   already allocated. Every proposal must state whose hours it uses, how many
   per week, and what those hours currently do instead. "Sister A has capacity"
   is not an answer. The owner 6 hrs/week is a ceiling only for approvals,
   legal and franchise questions, financial decisions, and technical work.
2. Costs under 2000 dollars, or explicitly flagged as needing a conversation.
3. Never propose increased marketing spend or lead-generation vendors.
4. Never propose a standard hourly rate above 46 dollars. That is market;
   above it loses clients. Premium tiers for complex, live-in or specialty care
   are separate products and may price higher.
5. Never propose cutting an existing caregiver's pay. Wage structure work
   applies to new hires only.
6. The owner will not cold-call. Sisters may.
7. Flag anything possibly restricted by the franchise agreement — pricing,
   marketing, website, Google Business Profile.
8. Flag legal questions for an attorney; never answer them. Covers referral
   compensation, healthcare marketing, wage structure, California licensure and
   overtime rules.
9. No client PHI, no caregiver PII, no family identities in any output.
10. Prefer anything affecting contribution within 60 days.

## Scoring

Score 1-10 on five dimensions, report the mean:

1. Dollar impact per month — **show the arithmetic**
2. Speed to impact in days
3. Labor cost and displacement — whose hours, how many, what they stop doing
4. Reversibility
5. Evidence strength

**Every item must state: expected dollars per month, whose hours and how many,
cost, and the single most likely reason it fails. An item without a dollar
estimate is not an item.**

## Evidence

Tag every material claim [Verified], [Inference] or [Speculation]. A claim with
no retrieved URL is never [Verified]. Never fabricate a rate, a name, an address
or a statistic.

Counts as evidence: published competitor rates, competitor job postings showing
wages, competitor 1 and 2 star reviews, named organizations verified at an
address, trade association data with a source, California regulation from state
sources.

Does not count: vendor content marketing, listicles, generic advice, your own
reasoning about what should work, a single review.

## No generic advice

"Build relationships with case managers" is not an item.
"Visit these four named SNFs in Mountain View, ask for the case manager, leave
this one-page sheet" is.

## Teach the norm

The operators are nine months into an industry they are still learning. With
every finding, explain the standard practice behind it, what a well-run agency's
numbers look like at this stage, and what an experienced operator would catch
immediately. Cite sources.

## targets.md

Maintain the named referral target list: SNFs, rehab facilities, hospital
discharge departments, assisted and independent living communities, memory care,
elder law attorneys, geriatric care managers, hospices, senior-focused financial
advisors, PT and OT practices. Across Palo Alto, Los Altos, Menlo Park,
Atherton, Portola Valley, Mountain View, Redwood City, Sunnyvale, Stanford and
Cupertino.

Public information only: name, address, public phone, website, publicly listed
staff. Group by city so field visits can be routed.

## Output

1. Position — clients, inquiries, starts this month, contribution, runway
2. What I found — dollar estimates and evidence tags
3. What the industry norm is — one paragraph with a source
4. What I need from a human — the specific action only a person can take
5. Files modified — verified by re-reading each one
6. One question

If nothing meets threshold, say so plainly. That is a complete run.
SKILLEOF

# ---------------------------------------------------------------- committee

write_skill growth-committee <<'SKILLEOF'
---
name: growth-committee
description: Twice-weekly decision run for the Homewatch CareGivers of Los Altos business growth system. Reviews the portfolio, updates metrics, enforces work-in-progress limits, and produces a promotion, kill, experiment closure or explicit no-change. Forbidden from research. Use for the scheduled growth committee job.
---

# Growth Committee

## Before doing anything

Read `AGENTS.md`, then `profile.md`, `portfolio.md`, `metrics.md`,
`experiments.md`, `opportunities.md`.

## Mandate

**Decide. You are FORBIDDEN from adding new opportunities, running web searches,
or doing any discovery research this run.**

Researching is easier than killing something. That is exactly why this run may
not research.

## Required actions

**Update `metrics.md`.** Flag any metric more than 14 days stale. Three are
currently unknown and are the highest-priority gaps: cash balance, runway, and
client end dates. Ask for them; never estimate them into the table.

**Enforce WIP limits.** 3 items in `portfolio.md`, 1 active experiment, 10 in
`opportunities.md`. Prune anything in `opportunities.md` untouched for 30 or
more days: revive with new evidence or move to `rejected.md`.

**Produce at least one of:** a promotion to active, a kill, an experiment
closure, or an explicit written no-change with reasoning.

**Append to `decisions.md`** with the date and lever. That file is append-only.
Never rewrite or delete its history.

## Promotion rule

A new item enters `portfolio.md` only if it beats the weakest item already
there. If it does not, either reject it or explicitly propose retiring the
weaker item.

## Labor check

Before promoting anything, confirm it states whose hours it uses, how many per
week, and what those hours currently do instead. Sisters are full-time and can
execute, but their 80 combined hours are already allocated. Reject any item that
assumes free capacity.

## Say the hard thing

If the honest conclusion is that the bottleneck is a human action nobody has
taken — a call to the bookkeeper, ten minutes with the scheduler, an hour
calling competitors — say exactly that and name the action. A run that produces
no promotion but correctly identifies the real blocker is a successful run.

## Output

1. Position — clients, inquiries, starts this month, contribution, runway
2. Decision made — or an explicit no-change with reasoning
3. Metrics updated, and anything stale or unknown
4. What I need from a human
5. Files modified — verified by re-reading
6. One question
SKILLEOF

# ---------------------------------------------------------------- experiment

write_skill growth-experiment <<'SKILLEOF'
---
name: growth-experiment
description: Weekly experiment run for the Homewatch CareGivers of Los Altos business growth system. Advances the single active validation experiment against its declared thresholds and kill date, or designs the next one from the top portfolio item and presents it for approval. No discovery research. Use for the scheduled growth experiment job.
---

# Growth Experiment Runner

## Before doing anything

Read `AGENTS.md`, then `profile.md`, `portfolio.md`, `experiments.md`.

## Mandate

**Advance the ONE active experiment. No discovery research.**

## If an experiment is active

Report progress against the success and failure thresholds declared when it
started — not thresholds invented now.

Enforce the kill date. If today is on or past it, close the experiment with a
decision of continue, pivot or kill, and append that to `decisions.md`.

## If no experiment is active

Design one from the top item in `portfolio.md` and present it for approval:

- hypothesis
- method
- who does the work, how many hours per week, and what those hours displace
- maximum cost
- success threshold
- failure threshold
- kill date

Then stop. The owner approves before anything starts.

## Design rules

Prefer experiments producing signal in under 30 days. Design them to kill the
idea cheaply, not to confirm it.

Good shapes for this business:

- present the 46 dollar rate to two new inquiries and observe acceptance
- visit five named facilities in one city in one week and count callbacks
- ask ten current and past families for a Google review using a written script
- test one referral channel deeply for 30 days rather than five shallowly
- call five competitors as a prospective family and record their rates

**A signed client or a paid rate is validation. Interest is not. A waitlist is
not.**

## Sample size honesty

At 1 to 2 inquiries per month, most conversion metrics cannot produce a readable
signal in 30 days. Prefer process metrics that move on every inquiry — callback
time, visits made, reviews requested — and read outcome metrics over 90 days.
Say so plainly when a proposed threshold is too small to be meaningful.

## Output

1. Position
2. Experiment status against declared thresholds, days to kill date
3. Decision, if the kill date has arrived
4. What I need from a human
5. Files modified — verified by re-reading
6. One question
SKILLEOF

# ---------------------------------------------------------------- review

write_skill growth-review <<'SKILLEOF'
---
name: growth-review
description: Monthly retrospective for the Homewatch CareGivers of Los Altos business growth system. Appends learnings to the playbook, checks for stale data and overdue unknowns, and judges whether the system is earning its keep. Use for the scheduled monthly growth review job.
---

# Growth Monthly Review

## Before doing anything

Read every file in the directory, including the full history in `decisions.md`.

## Mandate

**Append to `playbook.md`. Never rewrite it.**

Answer honestly:

- What moved this month, and what did not
- Which of the five levers were neglected
- What the family's hours actually produced, and whether the labor displacement
  assumptions in promoted items held up
- Which industry norms we learned, with sources
- Whether this system is earning its keep relative to the hours and tokens it
  consumes

## Checks

- Is `profile.md` stale? It refreshes monthly while the business is loss-making.
- Are any items in the Known Unknowns table past their resolution date?
- Are cash balance, runway and client end dates still unknown? If so, say so
  first, before anything else in the report.

## Be blunt

If the agent produced research all month while the real bottleneck was a phone
call nobody made, say exactly that.

If the honest conclusion is "stop running this system and go fix the business,"
say that.

## Output

Append to `playbook.md` under dated headings:

- Industry norms learned
- What worked
- What did not work
- Repeated failures and dead ends

Then report: the month in one paragraph, the single most important thing to do
next, and whether to keep running this system.
SKILLEOF

# ---------------------------------------------------------------- verify

echo
echo "Installed:"
ls -la "$DEST"
echo
echo "NEXT STEPS"
echo "  1. Confirm Hermes discovers them:"
echo "       hermes skills --help"
echo "       hermes skills list        # note the exact resolved names"
echo
echo "  2. Attach to the cron jobs (names, not hex IDs):"
echo "       hermes cron edit \"Growth Scout (weekly)\"        --skill growth-scout      --prompt \"Run the weekly growth scout.\""
echo "       hermes cron edit \"Growth Committee (2x weekly)\" --skill growth-committee  --prompt \"Run the growth committee.\""
echo "       hermes cron edit \"Growth Experiment (weekly)\"   --skill growth-experiment --prompt \"Advance the active experiment.\""
echo "       hermes cron edit \"Growth Review (monthly)\"      --skill growth-review     --prompt \"Run the monthly review.\""
echo
echo "  3. Check nothing is blocked:"
echo "       hermes cron status"
echo "       hermes cron list"
echo
echo "  4. Smoke test the committee:"
echo "       hermes cron run \"Growth Committee (2x weekly)\""
echo "       cat /home/hermes/workspace/growth-os/decisions.md"
