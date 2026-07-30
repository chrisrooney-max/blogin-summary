---
name: blogin-summary
description: Check blogin for new posts since the last run and produce a one-sentence summary of each
---

Run the `blogin-summarizer` agent to check blogin for new posts and summarize them.

Only analyse posts tagged **#gen-ai**, **#tech-community**, or **Uncategorized** — the agent filters to this tag allowlist before summarizing. Posts with any other tag are skipped.

$ARGUMENTS (optional): pass through any override, e.g. a different state file path.

Delegate the full fetch, diff, and summarize workflow to the `blogin-summarizer` agent — do not reimplement its logic here. Report the agent's output back to the user as-is.
