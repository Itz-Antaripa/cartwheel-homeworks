---
name: improve-loop
description: Improve one Cartwheel agent layer with the Homework 9 development evaluation, while preserving the fixed graders and the 150 run search budget.
---

# Improve loop

Use the development cases only. Never run `make eval-test` or `uv run python -m optimize.frontier` during the improvement loop.

1. Read `optimize/allowlist.txt`, `optimize/state/split.json`, and `optimize/state/search_budget.json`.
2. Read the latest development result, and choose one failure that lowers the reported score.
3. Change files from one layer only. The allowed layers are the prompt in `agent/agent.py`, the tools in `agent/tools.py`, or the agent harness in the other allowlisted files.
4. Do not edit `eval_cases/`, `tests/`, `analysis/state/judges/`, or `optimize/state/`.
5. Run `SEARCH=1 CANDIDATE=<short-name> make eval-dev`. One evaluated case run uses one unit of the 150 run budget, and the command refuses to exceed the budget.
6. Compare the new score and `write_pass_5` result with the current best result. Keep the change only when the evidence supports it.
7. Run `make eval-safety` before keeping a candidate. A safety failure rejects the candidate even when its development score is higher.
8. Stop when the budget is exhausted, when two consecutive changes do not improve the score, or when one candidate passes every development case and the safety suite.

After every candidate, append one JSON object to `optimize/results/improve-loop.jsonl`. Record `candidate`, `changed_layer`, `changed_files`, `rationale`, `development_score`, `write_pass_5`, `decision`, `git_commit`, and `result_file`.

Report the changed layer, the files changed, the development results compared, the remaining budget, and any failures that remain.
