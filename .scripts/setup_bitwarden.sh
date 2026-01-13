#!/usr/bin/env bash

# Bitwarden Secrets Integration Setup Script
# Sets up Bitwarden CLI for automatic secret loading in shell sessions

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"
echo "$DOTFILES_DIR"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

log_info() {
  echo -e "${BLUE}ℹ${NC} $1"
}

log_success() {
  echo -e "${GREEN}✓${NC} $1"
}

log_warning() {
  echo -e "${YELLOW}⚠${NC} $1"
}

log_error() {
  echo -e "${RED}✗${NC} $1"
}

echo ""
echo "======================================"
echo "  Bitwarden Secrets Integration Setup"
echo "======================================"
echo ""

# Step 1: Check if Bitwarden CLI is installed
log_info "Checking Bitwarden CLI installation..."
if ! command -v bw &>/dev/null; then
  log_warning "Bitwarden CLI not found. Installing via Homebrew..."
  brew install bitwarden-cli
  log_success "Bitwarden CLI installed"
else
  log_success "Bitwarden CLI already installed ($(bw --version))"
fi

# Step 2: Check if jq is installed
log_info "Checking jq installation..."
if ! command -v jq &>/dev/null; then
  log_warning "jq not found. Installing via Homebrew..."
  brew install jq
  log_success "jq installed"
else
  log_success "jq already installed ($(jq --version))"
fi

# Step 3: Check Bitwarden login status
log_info "Checking Bitwarden login status..."

# Check Bitwarden status with error handling
BW_STATUS_OUTPUT=$(bw status 2>&1)
BW_STATUS_CODE=$?

if [ $BW_STATUS_CODE -ne 0 ]; then
  log_error "Failed to check Bitwarden status"
  log_error "Output: $BW_STATUS_OUTPUT"
  echo ""
  echo "Make sure Bitwarden CLI is working: bw --help"
  exit 1
fi

# Parse the status with validation
BW_STATUS=$(echo "$BW_STATUS_OUTPUT" | jq -r '.status' 2>/dev/null)

if [ -z "$BW_STATUS" ]; then
  log_error "Failed to parse Bitwarden status"
  log_error "Output: $BW_STATUS_OUTPUT"
  exit 1
fi

if [ "$BW_STATUS" = "unauthenticated" ]; then
  log_warning "Not logged in to Bitwarden"
  echo ""
  echo "Please log in to Bitwarden:"
  bw login
  log_success "Logged in to Bitwarden"
elif [ "$BW_STATUS" = "locked" ]; then
  log_success "Already logged in (vault locked)"
elif [ "$BW_STATUS" = "unlocked" ]; then
  log_success "Already logged in (vault unlocked)"
else
  log_warning "Unexpected Bitwarden status: $BW_STATUS"
  log_success "Continuing with setup..."
fi

# Step 4: Copy template file if bitwarden-secrets.zsh doesn't exist
if [ ! -f "$DOTFILES_DIR/zsh/bitwarden-secrets.zsh" ]; then
  log_info "Creating bitwarden-secrets.zsh from template..."
  cp "$DOTFILES_DIR/zsh/bitwarden-secrets.zsh.template" "$DOTFILES_DIR/zsh/bitwarden-secrets.zsh"
  chmod 600 "$DOTFILES_DIR/zsh/bitwarden-secrets.zsh"
  log_success "Created bitwarden-secrets.zsh with secure permissions (600)"
else
  log_success "bitwarden-secrets.zsh already exists"
fi

# Step 5: Store master password in macOS Keychain
echo ""
log_info "Storing Bitwarden master password in macOS Keychain..."
echo ""
echo "This will securely store your Bitwarden master password in macOS Keychain."
echo "The password will be used to automatically unlock your vault on shell startup."
echo ""
read -p "Do you want to store your master password? [y/N]: " -n 1 -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]; then
  # Check if password already exists
  if security find-generic-password -a "$USER" -s "Bitwarden CLI" &>/dev/null; then
    log_warning "Password already exists in Keychain"
    read -p "Do you want to update it? [y/N]: " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      security delete-generic-password -a "$USER" -s "Bitwarden CLI"
      log_info "Deleted existing password"
    else
      log_info "Keeping existing password"
    fi
  fi

  # Add password to Keychain
  if ! security find-generic-password -a "$USER" -s "Bitwarden CLI" &>/dev/null; then
    echo ""
    echo "Enter your Bitwarden master password (input will be hidden):"
    read -s BW_PASS
    # Use printf to stdin to avoid password exposure in process list
    printf '%s' "$BW_PASS" | security add-generic-password -a "$USER" -s "Bitwarden CLI" -w
    unset BW_PASS
    log_success "Password stored securely in macOS Keychain"
  fi
else
  log_warning "Skipping password storage. You'll need to unlock manually with: bw unlock"
fi

# Step 6: Instructions for creating secrets in Bitwarden
echo ""
log_info "Setting up secrets in Bitwarden..."
echo ""
echo "You need to create a secure note in Bitwarden to store your API keys:"
echo ""
echo "  1. Go to https://vault.bitwarden.com"
echo "  2. Click '+ New Item'"
echo "  3. Type: Secure Note"
echo "  4. Name: Claude"
echo "  5. Add Hidden Fields (one per API key):"
echo "     - Field Name: ANTHROPIC_API_KEY"
echo "     - Field Type: Hidden"
echo "     - Value: (your API key)"
echo "  6. Repeat for other secrets (SHORTCUT_API_TOKEN, GITHUB_TOKEN, etc.)"
echo "  7. Save"
echo ""
echo "You can add more notes for different purposes (AWS, GitHub, DevOps, etc.)"
echo "Edit ${DOTFILES_DIR}/zsh/bitwarden-secrets.zsh to add them to the secret_notes array."
echo ""

read -p "Have you created the 'Claude' secure note? [y/N]: " -n 1 -r
echo

# Step 7: Test the setup
if [[ $REPLY =~ ^[Yy]$ ]]; then
  echo ""
  log_info "Testing Bitwarden integration..."

  # Source the script and capture output
  if [ -f "$DOTFILES_DIR/zsh/bitwarden-secrets.zsh" ]; then
    echo ""
    log_info "Loading secrets..."

    # Source and capture stderr
    source_output=$(source "$DOTFILES_DIR/zsh/bitwarden-secrets.zsh" 2>&1)
    source_status=$?

    # Show any output from the sourcing
    if [ -n "$source_output" ]; then
      echo "$source_output"
    fi

    # Count any environment variables that look like secrets
    # Check common secret patterns
    loaded_secrets=()

    # Check for common API key patterns
    for var in ANTHROPIC_API_KEY SHORTCUT_API_TOKEN GITHUB_TOKEN \
               AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY OPENAI_API_KEY \
               AZURE_API_KEY GCP_API_KEY; do
      if [ -n "${(P)var}" ]; then
        loaded_secrets+=("$var")
      fi
    done

    echo ""
    if [ ${#loaded_secrets[@]} -gt 0 ]; then
      log_success "Secrets loaded successfully! (${#loaded_secrets[@]} found)"
      echo ""
      echo "Loaded environment variables:"
      for var in "${loaded_secrets[@]}"; do
        echo "  - $var"
      done
    else
      log_warning "No secrets loaded."
      echo ""
      echo "Troubleshooting steps:"
      echo "  1. Verify BW_SESSION is set: echo \$BW_SESSION"
      echo "  2. Check if vault is unlocked: bw status"
      echo "  3. List items in your folder:"
      echo "     bw list items --folderid <your-folder-id> | jq '.[] | {name, type}'"
      echo "  4. Verify hidden fields exist:"
      echo "     bw list items --search Claude | jq '.[0].fields[]? | select(.type==1)'"
      echo "  5. Try manually loading: source $DOTFILES_DIR/zsh/bitwarden-secrets.zsh"
      echo "  6. Check with debug mode: BW_DEBUG=1 source $DOTFILES_DIR/zsh/bitwarden-secrets.zsh"
      echo ""
    fi
  fi
else
  log_info "Skipping test. Create the secure note and run: bw-reload"
fi

# Step 8: Final instructions
echo ""
echo "======================================"
echo "  Setup Complete!"
echo "======================================"
echo ""
echo "Next steps:"
echo ""
echo "  1. Open a new terminal or run: source ~/.zshrc"
echo "  2. Verify secrets are loaded: echo \$ANTHROPIC_API_KEY"
echo "  3. Restart Claude Code to pick up the new environment variables"
echo ""
echo "Useful commands:"
echo "  - bw-reload    Reload secrets from Bitwarden"
echo "  - bw-lock      Lock the Bitwarden vault"
echo "  - bw sync      Sync vault with Bitwarden server"
echo "  - bw status    Check vault status"
echo ""
echo "Documentation: ${DOTFILES_DIR}/CLAUDE.md"
echo ""
