# Bootstrapper

Install/Configure/Boilerplate/Bricklay/Bootstrap things on stuff!

Currently supports:

* Installing Go (golang) on x86_64/arm64 Linux/Mac
* Installing Rust on Linux/Mac
* Installing NVM (Node Version Manager) on Linux/Mac
* Installing Node LTS via NVM on Linux/Mac
* Installing pyenv on Linux/Mac
* Installing Python via pyenv on Linux/Mac
* Installing common brew dependencies on macOS
* Installing common apt dependencies on Linux
* Installing asdf version manager on Linux/Mac
* Installing languages via asdf (java, erlang, elixir, zig, odin)
* Installing Godot 4.6.3-stable on Ubuntu (user-space install, checksum-verified)
* Bootstrapping a Godot project
* Running Godot in headless mode to exec a script
* Adding a convenient tmux config with better pane oriented pane control commands

### :warning: Steps and Warnings :warning:

1. If you are not me, you should probably not use this.
1. It can be destructive!
1. I repeat, this was written for me
1. Inspect all scripts before running them
1. Fully understand what the commands are doing

## Examples..

#### Linux/Mac: Go 1.26.6

Deps: grep, curl, tar, uname, head, $SHELL, $OSTYPE

`./scripts/golang.sh`

Force an overwrite of current version installed in the path this script installs in:

`./scripts/golang.sh --force`

Fetch and install the latest go version from go.dev instead of the pinned `GO_DL_VERSION` (can be combined with `--force`):

`./scripts/golang.sh --latest`

If the flag is not provided then this scripts will exit 0. Also installs go packages: scnnr.

Example use:

```console
bootstrapper (master) $ ./scripts/golang.sh
--- shell config file is: .bashrc ---
--- OS is: linux ---
--- current installation: go version go1.24.1 linux/amd64 ---
--- current go version 1.24.1 already installed and overwrite flag not provided ---
--- exiting ---
```

#### Windows: Go 1.26.6

:warning: _this will start downloading the .msi_ :warning:

https://go.dev/doc/install?download=go1.26.6.windows-amd64.msi

#### Linux/Mac: Rust

Deps: curl

`./scripts/rust.sh`

Installs Rust via rustup with default settings. Also installs cargo packages: hexyl, ripgrep, bottom, exa.

#### Linux/Mac: NVM 0.40.4

Deps: curl, bash

`./scripts/nvm.sh`

Installs NVM and configures your shell. Restart your shell after running.

#### Linux/Mac: Node LTS

Deps: nvm (run `./scripts/nvm.sh` first)

`./scripts/node.sh`

Installs the latest Node LTS version and sets it as the default.

#### Linux/Mac: pyenv

Deps: git, curl, build tools (macOS: xcode-select, homebrew; Linux: build-essential, libssl-dev, etc.)

`./scripts/pyenv.sh`

Installs pyenv and configures your shell. Script will prompt you to install any missing dependencies. Restart your shell after running.

#### Linux/Mac: Python 3.14.5

Deps: pyenv (run `./scripts/pyenv.sh` first)

`./scripts/python.sh`

Installs Python 3.14.5 via pyenv and sets it as the global default.

#### macOS: Brew Dependencies

Deps: homebrew

`./scripts/brew_deps.sh`

Installs common brew packages: pyenv, asdf, imagemagick, ffmpeg, odin, zig, elixir, gleam, sqlite, htop, wget, curl.

#### Linux: Apt Dependencies

Deps: apt

`./scripts/apt_deps.sh`

Checks for common apt packages: build-essential, curl, wget, git, htop, sqlite3, imagemagick, ffmpeg. Prompts you to install any missing packages.

#### Linux/Mac: asdf 0.19.0

Deps: git

`./scripts/asdf.sh`

Installs asdf version manager. Restart your shell after running, then run asdf_plugins.sh.

#### Linux/Mac: asdf Plugins

Deps: asdf (run `./scripts/asdf.sh` first)

`./scripts/asdf_plugins.sh`

Installs plugins and versions from .bootstrapper.env: java (temurin-25.0.3+9.0.LTS), erlang (29.0.1), elixir (1.20.0-otp-28), zig (0.16.0), odin (dev-2026-05).

#### Ubuntu: Godot 4.6.3-stable Install

Deps: curl, unzip, sha512sum, grep

`./scripts/install_godot_ubuntu.sh`

Downloads Godot 4.6.3-stable (standard build), verifies it against the official SHA512-SUMS.txt, and installs it entirely in user space (no sudo): binary to `~/.local/bin/godot`, an icon to `~/.local/share/icons/`, and a `.desktop` launcher to `~/.local/share/applications/`. Run `godot` from a new login shell or launch it from your application menu.

#### Linux/Mac: Godot Project Bootstrap

Deps: $PROJECT_DIR environment variable

`PROJECT_DIR=./myproject ./scripts/setup_godot_project.sh`

Creates common Godot project directories: models, textures, shaders, sounds, materials, scenes, addons, scripts, lib.

#### Linux/Mac: Godot Headless Script

Deps: godot (on your PATH)

`./scripts/gdscript.gd`

A minimal headless GDScript run via `godot --headless --script` (the shebang handles the invocation). Extends `SceneTree`, prints `Hello!`, and quits — a template for your own Godot automation/CLI scripts.

### LICENSE

This project is MIT licensed. Please check the LICENSE file.
