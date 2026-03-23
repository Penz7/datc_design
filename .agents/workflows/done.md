---
description: Workflow for committing and pushing changes to GitHub — triggered by "done" or "xong rồi"
---

# Done — Git Commit & Push Workflow

> Triggered when the user says: **"done"**, **"xong rồi"**, **"xong"**, or **"push lên github"**

---

## Step 1: Final Verification

// turbo
1. Run `flutter analyze` — must have ZERO issues.
2. Run `flutter test` — ALL tests must pass.

> ⚠️ If analyze or test fails, STOP and fix before proceeding.

---

## Step 2: Re-generate AI Rules (if rules/workflows changed)

If any files in `.agents/rules/`, `.agents/workflows/`, or `CONTRIBUTING.md` were modified:

// turbo
1. Run `bash scripts/gen_ai_rules.sh` to sync rules to Cursor and GitHub Copilot.

---

## Step 3: Format Code

// turbo
1. Run `dart format .` to ensure consistent formatting.

---

## Step 4: Stage Changes

// turbo
1. Run `git add -A` to stage all changes.
2. Run `git status` to review what will be committed.
3. Present the staged changes to the user for confirmation.

---

## Step 5: Commit

1. Generate a concise, meaningful commit message based on the work done.
2. Follow conventional commit format:
   - `feat: <description>` — new widget or feature
   - `fix: <description>` — bug fix
   - `refactor: <description>` — code refactor without behavior change
   - `docs: <description>` — documentation only
   - `chore: <description>` — rules, config, dependencies
   - `test: <description>` — test additions or fixes

// turbo
3. Run `git commit -m "<type>: <description>"`.

---

## Step 6: Push

// turbo
1. Run `git push origin HEAD` to push to the current branch on GitHub.
2. If push fails due to no upstream, run `git push --set-upstream origin <branch>`.

---

## Checklist Summary

- [ ] `flutter analyze` — 0 issues
- [ ] `flutter test` — all pass
- [ ] AI rules synced (if changed)
- [ ] Code formatted
- [ ] `git add -A`
- [ ] `git commit -m "<message>"`
- [ ] `git push origin HEAD`
