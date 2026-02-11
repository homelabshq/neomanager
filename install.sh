#!/usr/bin/env bash

set -e

INSTALL_DIR="${NEOMANAGER_DIR:-$HOME/.neomanager}"
REPO_URL="https://raw.githubusercontent.com/homelabshq/neomanager/main"

log() {
    echo "neomanager: $1"
}

error() {
    echo "neomanager error: $1" >&2
    exit 1
}

# Check required dependencies
if ! command -v curl &> /dev/null; then
    error "'curl' is required but not found. Please install it first."
fi

if [ -d "$INSTALL_DIR" ]; then
    log "neomanager is already installed at $INSTALL_DIR"
    log "To reinstall, remove it first: rm -rf $INSTALL_DIR"
    exit 1
fi

log "Installing neomanager to $INSTALL_DIR..."

mkdir -p "$INSTALL_DIR"

log "Downloading nvimmgr..."
curl -fsSL "$REPO_URL/nvimmgr" -o "$INSTALL_DIR/nvimmgr"
chmod +x "$INSTALL_DIR/nvimmgr"

log "Downloading shell integrations..."
curl -fsSL "$REPO_URL/neomanager.bash" -o "$INSTALL_DIR/neomanager.bash"
curl -fsSL "$REPO_URL/neomanager.zsh" -o "$INSTALL_DIR/neomanager.zsh"

SHELL_TYPE=$(basename "$SHELL")

log ""
log "neomanager installed successfully!"
log ""
log "Add this to your shell config:"

if [ "$SHELL_TYPE" = "bash" ]; then
    log ""
    log "  echo 'source $INSTALL_DIR/neomanager.bash' >> ~/.bashrc"
    log "  source ~/.bashrc"
elif [ "$SHELL_TYPE" = "zsh" ]; then
    log ""
    log "  echo 'source $INSTALL_DIR/neomanager.zsh' >> ~/.zshrc"
    log "  source ~/.zshrc"
else
    log ""
    log "  source $INSTALL_DIR/neomanager.bash  (for bash-compatible shells)"
    log "  source $INSTALL_DIR/neomanager.zsh   (for zsh)"
fi

log ""
log "Then install neovim:"
log "  neomanager install-latest"
