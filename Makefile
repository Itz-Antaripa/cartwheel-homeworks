# Cartwheel suite runners.

.PHONY: seed test eval-ci eval-dev eval-safety eval-test leakage adversarial security-attacks

seed:
	uv run python -m seed.generate

test:
	uv run pytest

# The Module 4 adversarial suite: invariant/code-block tests plus the m4 holes.
adversarial:
	uv run pytest tests/test_adversarial.py -v

# Run all six supplied Homework 8 attacks against the local HTTP endpoint.
security-attacks:
	uv run python -m scenarios.runner security/supplied_attacks.jsonl --model $${CARTWHEEL_MODEL:-gpt-5.5} --output security/results/supplied-attacks.jsonl

# The Module 3 CI suite: every evaluation test, with no optimization split.
eval-ci:
	CARTWHEEL_RUN_E2E=1 uv run pytest tests/eval -s -q

# Homework 9 development evaluation. Set CANDIDATE to a short result name.
# Add SEARCH=1 to charge evaluated case runs to the 150-run budget.
eval-dev:
	uv run python -m optimize.runner --split development --candidate $${CANDIDATE:-manual} $(if $(SEARCH),--search)

eval-safety:
	uv run python -m optimize.safety

# Plans (if needed) and runs the one Homework 9 four-configuration test batch.
eval-test:
	uv run python -m optimize.frontier run

# The evaluation-case-versus-prompt leakage diff (also a pull-request CI step).
leakage:
	uv run python scripts/check_leakage.py
