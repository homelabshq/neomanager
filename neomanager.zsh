#!/usr/bin/env zsh

# neomanager shell integration for zsh

NEOMANAGER_DIR="${0:A:h}"
export NEOMANAGER_DIR
export PATH="$NEOMANAGER_DIR:$PATH"

# Auto-switch neovim version when entering a directory with .nvimrc
_neomanager_chpwd() {
    if [ -f "$PWD/.nvimrc" ]; then
        local version
        version=$(cat "$PWD/.nvimrc" 2>/dev/null)
        if [ -n "$version" ]; then
            echo "neomanager: Switched to neovim $version (from .nvimrc)"
        fi
    fi
}

autoload -U add-zsh-hook
add-zsh-hook chpwd _neomanager_chpwd

# Aliases
alias neomanager='nvimmgr'

# Wrap nvim to route through neomanager
nvim() {
    nvimmgr "$@"
}
