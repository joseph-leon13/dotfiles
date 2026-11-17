# Behavioral-Rule Promotion to Structural

## TL;DR

When a behavioral discipline rule keeps being violated (observed ≥2 times),
promote it to STRUCTURAL via the 3-layer template: role-doc section +
Themis hint (severity=warn) + lint test guarding the role-doc text.
Layers are promoted IN ORDER, each stamped by a non-author with evidence
it works before the next starts (see Stamped promotion sequence).
Behavioral rules drift; structural rules don't.

## Why this exists

Behavioral discipline rules ("master should consult architect before
asking user", "intake should fan out specialists when implementer hits
a research blocker") work for a while, then drift. Joseph hits the same
failure mode twice — once is bad luck, twice is a class. The discipline
needs structural enforcement at that point.

## The 3-layer template

For each behavioral rule worth promoting:

1. **Role-doc section** (`packages/khimaira/src/khimaira/roles/<role>.md`)
   — explicit subsection naming the rule + trigger conditions + correct
   behavior + worked example from the violating incident. Markdown text;
   loads every session. Catches the rule by raising awareness at the
   moment of decision.

2. **Themis hint rule** (`packages/themis/src/themis/rules/<role>.yaml`,
   severity=`warn`) — detects the violation pattern at tool-call time
   via condition function. Doesn't block; nudges. Catches drift when
   the role-doc text didn't pre-empt it. Some rules can't be structurally
   enforced (content-pattern matching is fragile); skip this layer when
   detection isn't tractable.

3. **Lint test** (`packages/khimaira/tests/test_role_convention_lint.py`)
   — asserts the role-doc text + Themis rule are present. Catches silent
   regression (someone edits the doc and accidentally removes the rule).

## Stamped promotion sequence

The three structural layers are dependent and must be promoted in order. Do
not start a later layer until the preceding layer has a recorded stamp
carrying evidence that the layer works.

0. **L0 — decision table.** For every candidate behavior, state which layers
   are tractable, which are declined, and why. The task owner stamps scope
   before any layer is built.
1. **L1 — role documentation.** Write the trigger condition, correct
   behavior, and a worked failure from the observed incident. An independent
   reviewer reads the exact text and stamps that it describes the intended
   behavior before enforcement begins.
2. **L2 — Themis.** Where detection is structurally tractable, prove the rule
   in both directions: it fires on violating calls and stays silent on
   legitimate calls. Report the probe score and every false positive or
   escape honestly. An independent reviewer stamps the probe evidence before
   lint is added.
3. **L3 — lint.** Add the convention-preservation test, then mutation-prove
   it by deleting the load-bearing role-doc sentence, observing the test
   fail, and restoring the sentence. An independent reviewer stamps the
   mutation evidence.

The author of a layer cannot stamp it. If work is interrupted, stamped layers
remain complete; unstamped work remains held and must not be represented as
certified. A report that text/code was added is not a stamp — every stamp
records evidence at that layer's decision boundary.

Why the gates exist: the layers are causally dependent — L3 asserts L1's
text, and L2's message states the behavior L1 describes — so a wrong L1
propagates into L2/L3 and gets cemented by the very lint that was meant to
guard it. Stamping at each boundary catches the error at its cheapest point.
(Added 2026-08-03 after the F1-16 deploy-gate incident: a gate test shipped
twice with a wrong foundational claim, each time self-certified as a bundle;
five independent gate rounds were needed to unwind it. Authored by the
codex-27 promotion task; stamped by an independent reviewer per this same
sequence — L0 by the task owner, L1 by a seat that authored none of it.)

## Examples observed (2026-05-25 / 2026-05-26)

Behavioral rules promoted to structural in one session:

1. **silent-sessions** — daemon-side substrate fix + master-side observability convention + lint guards
2. **master-serializes-parallel-work** — pre-dispatch independence checkpoint in master.md + IN-MASTER-6 Themis hint + lint tests
3. **master-defaults-to-user** — pre-AskUserQuestion routing table in master.md + IN-MASTER-4 question-text-shape condition + lint tests
4. **worktree-stranding** — Step 7 Reconcile in master.md + merge_intent in agent.md + IN-AGENT-4 Themis hint + lint tests
5. **specter selector-scope-falsified** — class reversal via Phase A audit (see bug-class-enumeration.md case study 2); Phase B fix pending mechanism clarification
6. **idle-state silent-treatment** — Stay-oriented section in master.md + Status translation in intake.md + status template + lint tests
7. **agent-skip-BEGIN-gate** (META-IRONIC) — agent-2 jumped BEGIN gate on the task codifying BEGIN-gate scope. Caught + tracked but fix would require Themis on chat_task_update from agent before master's chat_task_signal_start. Deferred Cat 2 if recurs.
8. **intake-skip-master-mediation** (IMMEDIATE RECURRENCE) — intake-1 dispatched mnemosyne distiller restore directly to agent-3 (msg-c27d2bb49268), bypassing master's chat_task_create + BEGIN gate. Happened within minutes of BEGIN-gate scope landing in 9ba8b95. Confirms role-doc-only enforcement insufficient for intake; Themis structural enforcement candidate Cat 2.

## When NOT to promote

- Single observed violation — not yet a pattern; observe-before-fix
- Rule is too context-sensitive to structurally enforce (e.g. "use
  good judgment on naming") — leave behavioral
- Themis detection would require fragile content-pattern matching
  (skip layer 2; rely on role-doc + lint only)

## Cross-references

- [[bug-class-enumeration]] — class-level fix discipline; this rule
  promotes behavioral classes to structural form
- engineering rules — general engineering discipline; this rule
  applies specifically to roster-coordination behavioral rules

## Industry prior art

- **Promoting team conventions to lint rules** (eslint, ruff,
  pre-commit hooks) — same pattern at codebase scale
- **Behavioral interview rubrics → structured competency frameworks**
  in hiring (Netflix, Google) — same shape outside engineering
