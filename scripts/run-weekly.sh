#!/bin/bash
set -euo pipefail

REPO_DIR="/Users/christopherrooney/blogin-summary"
LOG_FILE="$REPO_DIR/logs/weekly-run.log"
CLAUDE_BIN="$HOME/.local/bin/claude"

cd "$REPO_DIR"

{
  echo "===== Run started: $(date -u +"%Y-%m-%dT%H:%M:%SZ") ====="

  git pull --ff-only origin main

  "$CLAUDE_BIN" -p "This is the blogin-summary repo. Read and follow .claude/agents/blogin-summarizer.md exactly, step by step, to check blogin for new posts and produce today's report: use the mcp__blogin__* tools to fetch posts (fall back to the fixtures/posts.json stub only if those tools are unavailable). Apply the tag allowlist, write one-sentence summaries, flag POV candidates per Step 4.5 and reference/example-pov.md, update state/seen-posts.json, and write reports/<YYYY-MM-DD>.md using today's actual date. After writing both files, stage them, commit with a clear message, and push to the main branch of this repository (git remote 'origin', branch 'main')." \
    --allowedTools "Read Write Bash(git *) mcp__blogin__list_recent_posts mcp__blogin__read_content mcp__blogin__list_categories mcp__blogin__search_content mcp__blogin__list_post_readers mcp__blogin__list_user_reads mcp__blogin__read_comment_context mcp__blogin__get_category mcp__blogin__get_user mcp__blogin__search_users"

  echo "===== Run finished: $(date -u +"%Y-%m-%dT%H:%M:%SZ") ====="
} >> "$LOG_FILE" 2>&1
