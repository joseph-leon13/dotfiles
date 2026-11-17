# /khimaira-wind-down — wind down the roster to a stable checkpoint for the day

Brings all in-flight work to a clean stop, posts a handoff, sets the wind-down sentinel, and notifies all roster members to stand down.

## Steps

1. Set the wind-down sentinel — set_roster_wind_down(True) (suppresses Guard-4/Guard-5 overnight alarms).

2. Gather in-flight state:
   - session_list() filtered to active roster members
   - chat_history(roster_chat, limit=50) — recent task status, any open gates
   - session_recent_decisions(my_id, limit=20)

3. For each agent with in_progress tasks:
   - Post a notice: "🌙 Wind-down: please finish your current step, post a done/progress update to the roster chat, and stand down. Do NOT start new tasks."
   - Wait up to 60s for their acknowledgement.

4. Build and post the wind-down handoff (via session_post_handoff, scope_cwd=project_root):
   ```
   🌙 WIND-DOWN CHECKPOINT — <date>

   ═══ RESUME FIRST STEPS ═══
   [Most urgent action on wake: pending gates, session restores, etc.]

   ═══ IN-FLIGHT AT WIND-DOWN ═══
   [Each agent's last known state + what they were working on]

   ═══ PENDING GATES ═══
   [Tasks done but awaiting approval]

   ═══ OPEN BACKLOG ═══
   [Priority-ordered list of pending work]

   ═══ ROSTER STATE ═══
   [Active chat_id, member list, any sessions to respawn on wake]

   ═══ KEY CONTEXT ═══
   [Non-obvious things next session needs to know]
   ```
   This handoff text IS the wind-down receipt `roster stop` checks for (2026-08-01) — no
   separate marker needed. It qualifies because it is scope_cwd-scoped and posted fresh
   by this step; `roster stop` looks for a recent handoff whose body contains the literal
   string `WIND-DOWN CHECKPOINT`.

4b. Capture durable roster knowledge into the graph, NOT just this session's text handoff
    (2026-08-01 — do not skip this: the previous version of this command never did it, and
    a whole roster-memory feature — CAPTURED_IN edges, notebook_link, traversal — went
    unused for weeks as a result. This step is what makes it actually get used):
   - Create ONE hub note in the notebook for this wind-down, scoped to the project. Title
     it plainly, e.g. "Roster wind-down — <project> — <date>".
   - Identify the durable notes this roster created or substantively advanced this session
     (check session_recent_decisions and notebook_search for notes touched today).
   - Link each to the hub note: notebook_link(from_note_id=<hub>, to_note_id=<note>,
     type="CAPTURED_IN"). Do not invent relationships between the linked notes themselves
     — CAPTURED_IN only says "this hub captured this note," nothing more.
   - Confirm it actually landed: kg_subgraph(node_id="note:<hub_id>", hops=1) should show
     the edges you just created. If it doesn't, something failed silently — say so in the
     confirmation printed in step 6, don't just assume it worked.
   - If there is genuinely nothing durable to capture (a short session, pure firefighting),
     skip this and say so explicitly in step 6's confirmation — an explicit "nothing to
     capture" is fine; a silent skip is what caused the original gap.

5. Broadcast to roster chat:
   "🌙 Wind-down active. Sentinel set — Guard-4/Guard-5 suppressed overnight. Handoff posted for tomorrow's session. Everyone stand down."

6. Print confirmation: handoff_id, sentinel status, list of sessions standing down, and
   the outcome of step 4b — hub note id + edge count, or an explicit "nothing captured
   this session" if you skipped it. Never omit this line silently.

## When NOT to use
- Mid-task when an agent is in the middle of a critical operation (wait for a clean checkpoint)
- If a B3 gate just opened and the reviewer is about to post (let the gate close first)

## Roster swap (retire this roster → spin a fresh one, no manual context copy)
The wind-down handoff is `scope_cwd`-scoped to the project dir, so a NEW roster started in
the SAME dir auto-reads it. Two steps:
1. `/khimaira-wind-down` here (writes the handoff + MASTER-HANDOFF.md, sets the sentinel).
2. `roster start` in the same project dir → the new (auto-named) master boots, its
   SessionStart hook surfaces this handoff, and it continues from your checkpoint.
No manual copy needed — the handoff IS the transfer. (Lean-roster swap flow, 2026-06-28.)
