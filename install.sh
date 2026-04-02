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

echo ""
echo "  neomanager installed successfully!"
echo ""
echo "  Next steps:"
echo ""
if [ "$SHELL_TYPE" = "bash" ]; then
    echo "  1. Add this to ~/.bashrc:"
    echo ""
    echo "       source $INSTALL_DIR/neomanager.bash"
    echo ""
    echo "  2. Reload your shell:"
    echo ""
    echo "       source ~/.bashrc"
elif [ "$SHELL_TYPE" = "zsh" ]; then
    echo "  1. Add this to ~/.zshrc:"
    echo ""
    echo "       source $INSTALL_DIR/neomanager.zsh"
    echo ""
    echo "  2. Reload your shell:"
    echo ""
    echo "       source ~/.zshrc"
else
    echo "  1. Add one of these to your shell config:"
    echo ""
    echo "       source $INSTALL_DIR/neomanager.bash  # bash"
    echo "       source $INSTALL_DIR/neomanager.zsh   # zsh"
    echo ""
    echo "  2. Reload your shell."
fi

echo ""
echo "  3. Install neovim:"
echo ""
echo "       neomanager install-latest"
echo ""
