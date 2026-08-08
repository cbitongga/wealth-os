#!/usr/bin/env bash
#
# Recreates the Wealth OS Hermes cron jobs with corrected schedules and
# prompts aligned to the rewritten AGENTS.md.
#
# READ BEFORE RUNNING. Step 1 deletes your existing jobs.
# Run the sections one at a time, checking `hermes cron list` between each.

WORKDIR=/home/hermes/workspace/wealth-os

# =====================================================================
# STEP 1 — remove the old jobs
# =====================================================================
# Confirm the delete subcommand first:  hermes cron --help
# Then, one at a time:
#
#   hermes cron delete 312cc11d3b5c   # Wealth Opportunity Scout
#   hermes cron delete 5640e444ce7c   # Daily Wealth Committee
#   hermes cron delete 599925b3cbcf   # Weekly Wealth Experiment
#
# Verify with: hermes cron list


# =====================================================================
# STEP 2 — create the four new jobs
# =====================================================================
# Schedule column below uses hours, since "every 6h" is proven to work on
# your install. If the cron-expression test succeeded, swap in the
# commented-out expression on each job instead.
#
#   Scout        168h  = weekly
#   Committee     84h  = every 3.5 days (~2x per week)
#   Experiment   168h  = weekly
#   Review       720h  = ~monthly


# --------------------------------------------------- SCOUT (weekly)
# cron expression alternative: "0 6 * * 0"
hermes cron create "every 168h" \
  "Run a Wealth OS SCOUT. Read AGENTS.md and follow it exactly. Read profile.md, portfolio.md, rejected.md and wealth_thesis.md before doing anything else. Your mandate is DISCOVER AND GATE ONLY. You may add to opportunities.md and rejected.md. You may NOT write to wealth_thesis.md, you may NOT make anything active in portfolio.md, and you may NOT close experiments. Maximum 3 new opportunities and maximum 5 web searches. Rotate lever focus: check decisions.md for which of the five levers the last two scout runs covered, and do not cover lever 3 more than twice consecutively. Apply all seven kill gates BEFORE scoring anything. Log every rejection to rejected.md with the gate it failed. Do not re-surface anything already in rejected.md without materially new evidence. Enforce the WIP limit of 10 items in opportunities.md. Label every material claim as Verified, Inference or Speculation. Re-read every file you write to verify the change landed. If nothing meets threshold, say so plainly. End with the Final Report Format from AGENTS.md." \
  --workdir "$WORKDIR" \
  --name "Wealth Scout (weekly)"


# ----------------------------------------------- COMMITTEE (2x weekly)
# cron expression alternative: "0 7 * * 1,4"
hermes cron create "every 84h" \
  "Run a Wealth OS COMMITTEE. Read AGENTS.md and follow it exactly. Read profile.md, portfolio.md, experiments.md and opportunities.md. Your mandate is to DECIDE. You are FORBIDDEN from adding new opportunities, running web searches, or doing any discovery research this run. Enforce all WIP limits: 3 items in portfolio.md, 1 active experiment, 10 items in opportunities.md. Prune anything in opportunities.md untouched for 60 or more days by either reviving it with new evidence or moving it to rejected.md. You MUST produce at least one of the following: a promotion to active, a kill, an experiment closure, or an explicit written no-change decision with reasoning. Append every decision to decisions.md with the date. decisions.md is append only, never rewrite or delete its history. Re-read every file you write to verify the change landed. End with the Final Report Format from AGENTS.md." \
  --workdir "$WORKDIR" \
  --name "Wealth Committee (2x weekly)"


# ---------------------------------------------- EXPERIMENT (weekly)
# cron expression alternative: "0 7 * * 3"
hermes cron create "every 168h" \
  "Run the Wealth OS EXPERIMENT RUNNER. Read AGENTS.md and follow it exactly. Read profile.md, portfolio.md and experiments.md. Your mandate is to advance the ONE active experiment. Report progress against the success and failure thresholds that were declared when the experiment started. Enforce the kill date: if today is on or past it, close the experiment with a decision of continue, pivot or kill, and append that decision to decisions.md. If there is no active experiment, design one from the top item in portfolio.md and present it for my approval, including hypothesis, method, max cost, max hours, success threshold, failure threshold and kill date. Do NOT do discovery research. Remember that a waitlist signup is not validation and a payment is. Re-read every file you write to verify the change landed. End with the Final Report Format from AGENTS.md." \
  --workdir "$WORKDIR" \
  --name "Wealth Experiment (weekly)"


# ------------------------------------------------ REVIEW (monthly)
# cron expression alternative: "0 8 1 * *"
hermes cron create "every 720h" \
  "Run the Wealth OS MONTHLY REVIEW. Read AGENTS.md and follow it exactly. Read every Wealth OS file including the full history in decisions.md. APPEND to wealth_thesis.md, never rewrite it. Answer these questions honestly: what did I learn this month, which patterns are repeating, what keeps failing validation, which of the five levers have been neglected, and is this system earning its keep relative to the hours and tokens it consumes. Check whether profile.md is more than 90 days stale and flag it. Check the Known Unknowns table in profile.md and flag anything past its resolution date. Be blunt. If the honest conclusion is that the system produced research and no progress, say exactly that. If the honest conclusion is that I should stop scouting and go fix an operational problem in the franchise, say that too. Re-read every file you write to verify the change landed." \
  --workdir "$WORKDIR" \
  --name "Wealth Review (monthly)"


# =====================================================================
# STEP 3 — verify and stagger
# =====================================================================
#   hermes cron list
#
# If you used INTERVALS, Scout and Experiment are both 168h and were created
# seconds apart, so they will fire simultaneously every week and can corrupt
# files by writing at the same time. Fix by deleting and recreating the
# Experiment job 3 days from now, so the two stay half a week apart.
#
# If you used CRON EXPRESSIONS, they are already on different days. Nothing
# further needed.
#
# =====================================================================
# STEP 4 — smoke test each job manually before trusting the schedule
# =====================================================================
#   hermes cron --help          # find the manual-trigger subcommand
#   hermes cron run <id>
#
# Your Committee and Experiment jobs showed no Last run in `hermes cron list`,
# meaning they have never actually executed. Prove each one works now rather
# than discovering it next week.
