# Bitwarden Secrets Integration - Quick Reference

Automated API key/token management for Claude Code and shell environments.

## Quick Start (New Machine)

```bash
# 1. Run setup script
~/.dotfiles/.scripts/setup_bitwarden.sh

# 2. Create folder and secure note in Bitwarden (https://vault.bitwarden.com)
#    - Create a folder named "CLI" (or similar)
#    - Create secure note named "Claude" inside that folder
#    - Add hidden fields: ANTHROPIC_API_KEY, SHORTCUT_API_TOKEN, etc.

# 3. Get your folder ID and configure the script
bw list folders | jq '.[] | select(.name == "CLI") | .id'
# Edit ~/.zsh/bitwarden-secrets.zsh and set secrets_folder_id

# 4. Test
source ~/.zshrc
echo $ANTHROPIC_API_KEY
```

## How It Works

1. **Shell startup** → loads `zsh/bitwarden-secrets.zsh`
2. **Retrieves** master password from macOS Keychain
3. **Unlocks** Bitwarden vault
4. **Searches** configured folder for secure notes (by folder ID + type)
5. **Extracts** hidden fields from matching notes
6. **Exports** as environment variables

## Structure

**Bitwarden Vault:**
```
Folder: "CLI"
└── Secure Note: "Claude"
    ├── Hidden Field: ANTHROPIC_API_KEY = sk-ant-xxxxx
    ├── Hidden Field: SHORTCUT_API_TOKEN = xxxx-xxxx
    └── Hidden Field: GITHUB_TOKEN = ghp_xxxxx
```

Notes are filtered by folder ID to avoid ambiguity with other vault items.

**Dotfiles:**
```
zsh/bitwarden-secrets.zsh           # Your config (gitignored)
zsh/bitwarden-secrets.zsh.template  # Template for new machines
.scripts/setup_bitwarden.sh         # Automated setup
```

## Common Tasks

### Add New Secret to Existing Note
1. Edit "Claude" note in Bitwarden web UI
2. Add hidden field (name = env var name)
3. `bw-reload`

### Create New Secret Group
1. Create secure note in Bitwarden (e.g., "AWS") **inside the CLI folder**
2. Add hidden fields
3. Edit `zsh/bitwarden-secrets.zsh`:
   ```bash
   local secret_notes=(
       "Claude"
       "AWS"      # ← Add this
   )
   ```
4. `bw-reload`

### Update Master Password in Keychain
```bash
# Interactive (password hidden):
read -s BW_PASS && \
  security delete-generic-password -a "$USER" -s "Bitwarden CLI" 2>/dev/null; \
  security add-generic-password -a "$USER" -s "Bitwarden CLI" -w "$BW_PASS" && \
  unset BW_PASS && \
  echo "✓ Password updated"
```

## Commands

| Command | Description |
|---------|-------------|
| `bw-reload` | Reload secrets from vault |
| `bw-lock` | Lock vault and clear session |
| `bw sync` | Sync with Bitwarden server |
| `bw status` | Check vault status |
| `bw list folders \| jq '...'` | Find folder IDs |

## Troubleshooting

**Secrets not loading?**
```bash
bw status              # Check vault status
bw sync                # Sync from server
bw-reload              # Reload secrets
```

**Vault locked?**
```bash
bw unlock              # Manual unlock
# Copy and run the export command
```

**Test folder + note retrieval:**
```bash
# List items in your secrets folder (replace with your folder ID)
bw list items --folderid "YOUR_FOLDER_ID" | jq '[.[] | {name, type}]'

# Get specific note fields (no values shown)
bw list items --folderid "YOUR_FOLDER_ID" --search "Claude" | jq '.[0].fields[].name'
```

**Find folder ID:**
```bash
bw list folders | jq '.[] | {name, id}'
```

## Security

✅ Master password in macOS Keychain (encrypted)
✅ Secrets never in plaintext on disk
✅ bitwarden-secrets.zsh gitignored
✅ BW_SESSION scoped to shell session
⚠️ Lock vault when not needed: `bw-lock`

## Full Documentation

See [CLAUDE.md](../CLAUDE.md#bitwarden-secrets-integration) for complete details.
