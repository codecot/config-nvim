# Audit docs and cleanup repository documentation

## Context

This repository contains a personal Neovim configuration with several startup profiles:

- `init-safe.lua`
- `init-minimal.lua`
- `init-enhanced.lua`
- `init-complex.lua`
- `init-enhanced-backup.lua`

It also contains multiple documentation files created during previous iterations:

- `README.md`
- `QUICK-REFERENCE.md`
- `TESTING.md`
- `IMPROVEMENTS.md`
- `FINAL-STATUS.md`
- `FINAL-SUCCESS.md`
- `MISSION-COMPLETE.md`
- `REPO-SUMMARY.md`
- `REPOSITORY-STATUS.md`
- `E1155-FIX.md`
- `PROJECT.md`

Some of these documents may overlap, be outdated, or repeat the same information in different forms.

The goal of this task is to clean up and rationalize the documentation without changing the actual Neovim configuration behavior.

## Goal

Make the repository easier to understand for a future reader or automation agent by ensuring that:

1. `README.md` is the main human entry point.
2. `PROJECT.md` remains the structured project description used by automation.
3. Supporting documentation is either clearly useful, consolidated, or marked as historical.
4. The available configuration profiles are clearly documented.
5. The smoke-test / verification scripts are documented in one obvious place.

## Scope

Update documentation only.

Allowed changes:

- Edit Markdown documentation files.
- Add a small documentation index if useful.
- Rename or move documentation files only if it clearly improves clarity.
- Add an `archive/` or `docs/archive/` folder for historical completion/status documents if appropriate.
- Update links after moving or renaming docs.

Do not change:

- Lua configuration behavior.
- Plugin definitions.
- `lazy-lock.json`.
- Bash script behavior.
- Repository runtime logic.

## Required work

### 1. Audit existing documentation

Review all top-level Markdown documentation files and identify:

- which file should be the primary entry point,
- which files are still useful,
- which files are historical/completion notes,
- which files duplicate content,
- whether any statements contradict the current project structure.

### 2. Improve `README.md`

Update `README.md` so it clearly explains:

- what this repository is,
- how to install it into `~/.config/nvim`,
- how to switch between profiles,
- how to run the verification scripts,
- where to find more detailed documentation,
- what Neovim version is expected.

The README should be concise and practical.

### 3. Document configuration profiles

Add or update a section that explains the available profiles:

| Profile | File | Purpose |
|---|---|---|
| Safe | `init-safe.lua` | Stable fallback profile |
| Minimal | `init-minimal.lua` | Lightweight setup |
| Enhanced | `init-enhanced.lua` | Main richer profile |
| Complex | `init-complex.lua` | Full/experimental profile |

If the actual files suggest different meanings, prefer the repository reality over this table.

### 4. Clarify verification scripts

Document what each script is for:

- `test-config.sh`
- `test-final.sh`
- `verify-repo.sh`

Explain how to run them and what a successful result means.

### 5. Consolidate or archive historical docs

Review these files:

- `FINAL-STATUS.md`
- `FINAL-SUCCESS.md`
- `MISSION-COMPLETE.md`
- `REPO-SUMMARY.md`
- `REPOSITORY-STATUS.md`

If they are mostly historical status artifacts, move them into a clearly named archive folder such as:

```text
docs/archive/

or add a short note at the top of each saying that they are historical.

Prefer the least disruptive change that improves clarity.

6. Keep PROJECT.md consistent

Review PROJECT.md and update it only if documentation moves or naming changes make it inaccurate.

Do not expand PROJECT.md into a long README. It should stay structured and concise.

Acceptance criteria
README.md is the obvious starting point for a human user.
PROJECT.md remains accurate after the cleanup.
Profile selection is documented clearly.
Verification scripts are documented clearly.
Historical/completion documents are either archived or clearly marked.
Markdown links are not broken.
No Lua configuration behavior changes.
No plugin lockfile changes.
No runtime code changes unless required only to fix broken documentation references.
Suggested validation

Run:

./test-config.sh
./test-final.sh
./verify-repo.sh

If any script fails because of the existing environment rather than this documentation change, record that in the task result instead of changing runtime behavior.

Also run a quick grep/check for links to moved files if documentation files are archived.

Non-goals
Do not redesign the Neovim setup.
Do not update plugins.
Do not change keymaps or options.
Do not introduce a new plugin manager.
Do not add CI.
Do not rework the repository structure beyond documentation cleanup.