---
description: Workflow for updating project rules — triggered by "update rule" or "make update-rule"
---

# Update Rule Workflow

> Triggered when the user says: **"update rule"** or runs `make update-rule MSG="..."`

---

## Step 1: Apply the Rule Update

1. Read the user's requested change.
2. Open the relevant rule file:
   - `.agents/rules/datc_design_rules.md` — for Antigravity rules
3. Make the requested modification directly in the file.

---

## Step 2: Sync to All Platforms

// turbo
1. Run `bash scripts/gen_ai_rules.sh` — this regenerates:
   - `.cursor/rules/datc_design.mdc`
   - `.github/copilot-instructions.md`
2. Update `CONTRIBUTING.md` if the rule change affects the universal guide.

---

## Step 3: Run Tests

// turbo
1. Run `flutter analyze` — verify the rule change didn't introduce issues.
2. Run `flutter test` — all tests must pass.

---

## Step 4: Log the Change

1. Print a summary of what was updated across all platforms.

---

## Checklist Summary

- [ ] Rule updated in `.agents/rules/datc_design_rules.md`
- [ ] AI rules re-generated (`bash scripts/gen_ai_rules.sh`)
- [ ] `CONTRIBUTING.md` updated (if applicable)
- [ ] `flutter analyze` — 0 issues
- [ ] `flutter test` — all pass
