# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal dotfiles repository for macOS. Manages shell configuration (ZSH), development tools (via Homebrew & mise), and editor settings using a symlink-based deployment system.

## Installation & Setup

### Initial Setup

```bash
# Clone repository
git clone https://github.com/zekus/dotfiles ~/.dotfiles
cd ~/.dotfiles

# Run interactive setup
./.scripts/install.sh
```

This will:
1. Install Homebrew and packages from Brewfile
2. Install mise and language runtimes from tool-versions
3. Stow all dotfile packages to create symlinks

### Maintenance Commands

```bash
brew bundle              # Update/install Homebrew packages
mise install            # Install runtime versions from .tool-versions
mise_i                  # Interactive version installer (fzf-based)
brew_i                  # Interactive brew package installer with preview
git status              # Track dotfile changes
```

### Bitwarden Secrets Setup

```bash
./.scripts/setup_bitwarden.sh  # Interactive Bitwarden integration setup
```

Automatically loads API keys and tokens from Bitwarden vault as environment variables. Required for Claude Code MCP servers and external tool integrations.

### Testing

```bash
./.scripts/test_color.sh  # Test terminal colors
./.scripts/test_fonts.sh  # Test font rendering
```

## Architecture

### Configuration Structure

**Modular ZSH Configuration** (zshrc sources these files):

- `zsh/env` - Environment variables, PATH, EDITOR settings
- `zsh/settings` - ZSH options (history, completion, vi-mode)
- `zsh/aliases` - Command shortcuts (git, docker, k8s, terraform)
- `zsh/functions` - Custom functions (git-done, git-nuke, mise_i, mkd)
- `zsh/langs` - Language-specific environment (Ruby, Elixir/Erlang)
- `zsh/bitwarden-secrets.zsh` - Secrets from Bitwarden (gitignored)

**XDG Config Directory** (`config/` managed via GNU stow):

- Neovim (LazyVim configuration)
- Starship (custom Rose Pine Moon theme)
- Ghostty, Zed, VS Code settings
- Yarn global packages

**Version Management** (mise with .tool-versions):

- Elixir 1.16.0, Erlang 26.2.1
- Node.js 22.16.0, Python 3.12.1, Ruby 3.4.4, Go 1.23.2
- Terraform 1.1.7, AWS CLI 2.22.26

**Package Management**:

- `tools/.Brewfile` - Declarative package definitions
- `tools/.Brewfile.lock.json` - Locked versions for reproducibility
- Includes: CLI tools, editors, apps, fonts, casks

### Key Design Patterns

**Symlink Deployment**:

- Uses GNU stow for package-based symlink management
- Packages organized semantically: shell/, git/, ruby/, tools/, config/, zsh/, vscode/
- Run `stow <package>` to link individual packages
- Run `.scripts/linkconfigs.sh` to link all packages

**Shell Features**:

- Plugin manager: Zi (z-shell) for Oh-My-Zsh plugins
- Prompt: Starship with git/language status
- Fuzzy finder: fzf with zsh integration
- Custom functions leverage fzf for interactive selection

**Bitwarden Secrets Management**:

- Automatic secret loading from Bitwarden vault on shell startup
- Master password stored in macOS Keychain (protected by macOS user authentication)
- Secrets organized in secure notes with hidden fields
- Dynamic configuration - no code changes needed to add secrets
- Zero plaintext credentials in dotfiles repository

**Security Considerations**:

- SSH keys symlinked from Keybase (/Volumes/Keybase/private/lantonio/ssh)
- GPG commit signing enabled in gitconfig
- Sensitive files excluded via .gitignore (bitwarden-secrets.zsh)
- git-secrets installed for secret scanning
- Bitwarden vault auto-locks based on configured timeout

### Common Custom Functions

**Git Workflows**:

- `git-done` - Complete workflow: rebase, merge, test, push
- `git-nuke <branch>` - Delete local and remote branch
- `git-new-remote-tracking <branch>` - Create and push new branch
- `git-on-master` - Sync with master and rebase

**Interactive Tools** (fzf-powered):

- `mise_i` - Browse and install language versions
- `mise_uni` - Uninstall language versions
- `brew_i` - Browse and install brew packages
- `brew_uni` - Uninstall brew packages

**Utilities**:

- `mkd <dir>` - Create directory and cd into it
- `fs <path>` - Show file/directory size
- `myip` - Get current IP address

## Bitwarden Secrets Integration

### Overview

Automated secret management using Bitwarden CLI (`bw`) to load API keys and tokens as environment variables. Secrets are stored in encrypted Bitwarden vault and automatically loaded on shell startup.

### Architecture

**Components**:

- `zsh/bitwarden-secrets.zsh` - Auto-loader script (gitignored, contains actual configuration)
- `zsh/bitwarden-secrets.zsh.template` - Template file for new machines
- `.scripts/setup_bitwarden.sh` - Interactive setup script
- macOS Keychain - Stores Bitwarden master password (protected by macOS user authentication)

**How It Works**:

1. Shell startup triggers `bw_load_secrets()` function
2. Retrieves master password from macOS Keychain
3. Unlocks Bitwarden vault using `bw unlock --passwordenv`
4. Searches configured folder by ID for secure notes (avoids name ambiguity)
5. Extracts hidden fields and exports as environment variables
6. Exports `BW_SESSION` for current shell and child processes (re-unlocked on each shell startup)
7. Skips environment variables already set (doesn't override existing values)

**Note**: If you manually export a variable before sourcing bitwarden-secrets.zsh,
Bitwarden won't override it. Use `unset VAR_NAME` before running `bw-reload` if
you need to refresh a specific secret.

### Secret Organization

**Folder-Based Approach**: Secrets are organized in a dedicated Bitwarden folder to avoid name ambiguity with other vault items.

**Structure**:

```
Folder: "CLI"
├── Secure Note: "Claude"
│   ├── Hidden Field: ANTHROPIC_API_KEY = sk-ant-xxxxx
│   ├── Hidden Field: SHORTCUT_API_TOKEN = xxxx-xxxx
│   └── Hidden Field: GITHUB_TOKEN = ghp_xxxxx
│
├── Secure Note: "AWS"  (optional)
│   ├── Hidden Field: AWS_ACCESS_KEY_ID = AKIAXXXXX
│   └── Hidden Field: AWS_SECRET_ACCESS_KEY = xxxxx
│
└── Secure Note: "GitHub"  (optional)
    └── Hidden Field: GITHUB_TOKEN = ghp_xxxxx
```

**Benefits**:

- Folder filtering avoids conflicts with similarly-named items elsewhere in vault
- Logical grouping (Claude/MCP, AWS, GitHub, etc.)
- Multiple secrets per note
- Hidden field names = environment variable names
- Zero code changes to add new secrets

### Setup on New Machine

```bash
# 1. Install Bitwarden CLI and dependencies
./.scripts/setup_bitwarden.sh

# 2. Create folder and secure notes in Bitwarden vault
# Go to https://vault.bitwarden.com
# Create a folder named "CLI" (or similar)
# Create secure note named "Claude" inside that folder
# Add hidden fields: ANTHROPIC_API_KEY, SHORTCUT_API_TOKEN, etc.

# 3. Get your folder ID and configure the script
bw list folders | jq '.[] | select(.name == "CLI") | .id'
# Edit ~/.zsh/bitwarden-secrets.zsh and set secrets_folder_id to your folder ID

# 4. Store master password in Keychain (secure, interactive)
read -s BW_PASS && \
  security add-generic-password -a "$USER" -s "Bitwarden CLI" -w "$BW_PASS" && \
  unset BW_PASS && \
  echo "Password stored securely"

# 5. Test loading
source ~/.zshrc
echo $ANTHROPIC_API_KEY  # Should display your key
```

### Adding New Secrets

**Option 1: Add to existing note**

1. Edit "Claude" note in Bitwarden web UI
2. Add new hidden field (e.g., `OPENAI_API_KEY`)
3. Run `bw-reload` in terminal

**Option 2: Create new note**

1. Create secure note in Bitwarden (e.g., "AWS") **inside the CLI folder**
2. Add hidden fields for AWS credentials
3. Edit `zsh/bitwarden-secrets.zsh`, add `"AWS"` to `secret_notes` array
4. Run `bw-reload`

### Configuration

**Configure folder and notes** in `zsh/bitwarden-secrets.zsh`:

```bash
# Folder ID containing your secret notes (find with: bw list folders | jq '...')
local secrets_folder_id="YOUR_FOLDER_ID_HERE"  # e.g., "6d056b15-22cd-4731-8b7f-..."

# Notes to load from that folder
local secret_notes=(
    "Claude"      # For Claude Code and MCP servers
    "AWS"         # For AWS credentials
    "GitHub"      # For GitHub tokens
    # Add more as needed
)
```

**Find your folder ID:**
```bash
bw list folders | jq '.[] | {name, id}'
```

### Commands & Aliases

```bash
bw-reload     # Reload secrets from Bitwarden (after vault changes)
bw-lock       # Lock vault and clear BW_SESSION
bw sync       # Sync vault with Bitwarden server
bw status     # Check vault lock status
```

### Troubleshooting

**Secrets not loading?**

First, check dependencies:

```bash
# Verify required tools are installed
command -v bw &> /dev/null || echo "❌ bw missing - install: brew install bitwarden-cli"
command -v jq &> /dev/null || echo "❌ jq missing - install: brew install jq"

# Check vault status
bw status

# Manual unlock
bw unlock
# Copy and run the export command

# List items in your secrets folder (verify notes are there)
bw list items --folderid "YOUR_FOLDER_ID" | jq '[.[] | {name, type}]'

# Test specific note field names (no values shown)
bw list items --folderid "YOUR_FOLDER_ID" --search "Claude" | jq '.[0].fields[].name'

# Check if password is in Keychain
security find-generic-password -a "$USER" -s "Bitwarden CLI" -w
```

**Session expired**:

```bash
bw-reload  # Will auto-unlock and reload
```

**Update master password in Keychain**:

```bash
# Delete old password
security delete-generic-password -a "$USER" -s "Bitwarden CLI"

# Add new password (interactive, hidden input)
read -s BW_PASS && \
  security add-generic-password -a "$USER" -s "Bitwarden CLI" -w "$BW_PASS" && \
  unset BW_PASS
```

### Security Notes

- ✅ Master password stored in macOS Keychain (protected by macOS user authentication)
- ✅ Secrets never stored in plaintext on disk
- ✅ `BW_SESSION` only valid for current shell and children
- ✅ Vault auto-locks based on Bitwarden timeout setting
- ✅ `bitwarden-secrets.zsh` gitignored to prevent committing
- ✅ Template file tracks in git for new machine setup
- ⚠️ Any process running as your user can retrieve the password from Keychain
- ⚠️ Protection is at macOS user account level, not an additional layer
- ⚠️ Don't set `BW_SESSION` in permanent env vars
- ⚠️ Lock vault when not needed: `bw-lock`

### Files

```
zsh/bitwarden-secrets.zsh           # Active config (gitignored)
zsh/bitwarden-secrets.zsh.template  # Template for new machines
.scripts/setup_bitwarden.sh         # Setup automation
```

## Platform Requirements

- macOS (Darwin) - Contains Darwin-specific logic
- Apple Silicon (ARM64) paths where applicable
- Keybase.io for SSH key management
- Homebrew for package management
- Bitwarden account (free tier sufficient)
