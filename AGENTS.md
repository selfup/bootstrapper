# AGENTS.md

Guidance for coding agents working in this repo.

## Project

Personal bootstrap scripts for macOS/Linux. Scripts can be destructive; treat every change as something that may mutate a real machine’s PATH, shell rc, or installed toolchains.

Not a library. Prefer small, auditable bash over abstraction.

## Layout

- `scripts/` — install/setup scripts (run from repo root)
- `.bootstrapper.env` — pinned versions (`GO_DL_VERSION`, `NVM_VERSION`, `GODOT_VERSION`)
- `scripts/shell_check.sh` — shared OS/shell detection; sourced by most install scripts
- `scripts/readme.sh` — regenerates `README.md` from `.bootstrapper.env`
- `.tmux.conf` — optional tmux config

## Conventions

- Bash with `set -eo pipefail`
- Keep the destructive-action warning banner on install scripts
- Source `scripts/shell_check.sh` when a script needs OS/shell/env setup
- Scripts must be run from the repo root (they look for `.bootstrapper.env` there)
- Prefer idempotent / early-exit behavior when a tool is already installed; use `--force` only when overwrite is intentional
- Log progress with `---` prefixed messages
- Keep `README.md` in sync by editing `scripts/readme.sh` and running `./scripts/readme.sh` — do not hand-edit README content that the generator owns

## Current toolchain scope

Supported install paths: Go, Rust (+ cargo tools including `uv`), NVM/Node, brew/apt deps, Godot (Ubuntu), Godot project bootstrap.

Do **not** reintroduce asdf, pyenv, or `.tool-versions` unless explicitly asked.

## Docs / versions

1. Change pins in `.bootstrapper.env`
2. Update script behavior if needed
3. Update `scripts/readme.sh` and regenerate with `./scripts/readme.sh`

## Commits

- No agent attribution in commits (no `Co-authored-by`, `Made-with`, or similar trailers/footers)
- Author/committer identity must be the human owner’s configured git user only

## Safety

- Never silently remove user shell config or home-directory installs
- Prefer prompting or printing the exact command when sudo/apt is required
- Do not add network-install curls without matching the existing audit-first style
