# Global Claude Code Instructions

## Precedence and authority

- Current source and reproducible behavior are authoritative for what code does now.
- Project-local instructions add repository-specific rules; role contracts add role authority.
- Stop on safety or authority conflicts. For preferences, follow the more specific project
  instruction and flag the contradiction.
- Treat Notebook, Linear, semantic indexes, and documentation as orientation and institutional
  memory, not proof of current implementation.

## Core rules

The compact, load-bearing rule set is in `~/.claude/rules/DIGEST.md`. Detailed
rule bodies remain in `~/dotfiles/claude/rules/{personal,engineering}/` as the
canonical cross-tool sources. The digest is the quick authority map; read a
detailed source when its nuance changes the task.

Research before implementing, trace actual callers before changing a shared file,
format every modified file, test the unhappy path, and never bypass pre-commit
hooks. For a reported bug, enumerate the bug class and every known decision path
before choosing a fix; prefer a mandatory chokepoint over patches to individual arms.

## Khimaira

The SessionStart hook supplies the exact Khimaira session identifier and bounded
current state. Use that identifier; never infer identity from session recency or
guess another session's UUID. Register real-time chat once at session start when
the hook requests it. Khimaira chat, task cards and verdicts are the durable record
of roster work. To make a local Claude seat act on that record, send one native
`SendMessage` pointer after the record is written; never wake a Claude seat with
terminal keystrokes. Content-free window nudges are for Codex workers only, since
they lack native turn causation.

Use the unified Khimaira MCP surface for session state, Notebook, semantic code
search, browser verification, cartography, and related platform tools. Tool
inventories change; use connected tool schemas or `khimaira tools` instead of a
hard-coded count or legacy standalone-server list.

Externalize only meaningful decisions, questions, and status changes. File touches
are recorded by hooks. A missing or timed-out collector is `UNKNOWN`, never
evidence that no context exists.

## Orchestration

Decompose substantive parallel work, serialize edits to shared files, and keep an
independent review layer. Project and role instructions decide whether the executor
is an in-session agent or a long-lived roster seat. Never create Git worktrees unless
the user explicitly reverses their standing no-worktrees preference.

## Detailed references

Read the smallest relevant detailed rule only when its nuance changes the task:

- personal workflow and behavioral rules: `~/dotfiles/claude/rules/personal/`
- engineering conventions: `~/dotfiles/claude/rules/engineering/`
- Khimaira operations and roster procedures: the project's skills and role docs
