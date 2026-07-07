# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

Personal dotfiles for a Linux development environment. Files are tracked in git and deployed by symlinking or copying to `$HOME`. There is no build or test pipeline.

## Structure

- Root-level files: `.zshrc`, `.zshenv`, `.zsh_sudo`, `.backup.sh`, `.backup-ignore`
- Application configs follow XDG standards under `.config/<app>/`

## Key Configurations

| Tool | Location |
|------|----------|
| Zsh | `.zshrc` (aliases, plugins, key bindings), `.zshenv` (PATH, env vars) |
| Neovim | `.config/nvim/init.lua`, `.config/nvim/coc-settings.json` |
| tmux | `.config/tmux/tmux.conf` |
| Ghostty | `.config/ghostty/config` |
| Git | `.config/git/config` |
| Starship | `.config/starship.toml` |
| Backup | `.backup.sh` (duplicity + Backblaze B2) |

## Conventions

**Neovim plugins** are managed by vim-plug. Update with `:PlugUpdate` inside Neovim. LSP is handled by coc.nvim with language servers configured in `coc-settings.json`.

**tmux plugins** are managed by TPM (Tmux Plugin Manager). Update with `<prefix>+U`.

**Shell `up` alias** runs a full system update: apt packages, npm globals, tmux plugins, Neovim plugins, rustup, juliaup, pipx/uv tools.

**Backup secrets** (`~/.backup-config.sh`) contain GPG key IDs and Backblaze B2 credentials — intentionally not tracked in this repository.

**Claude Code settings** (`.claude/settings.json`) configure tool permissions for this machine; changes here affect what Claude Code can run without confirmation prompts.
