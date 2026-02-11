#!/usr/bin/env bash

# neomanager shell integration for bash

NEOMANAGER_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export NEOMANAGER_DIR
export PATH="$NEOMANAGER_DIR:$PATH"

# Auto-switch neovim version when entering a directory with .nvimrc
_neomanager_cd() {
    builtin cd "$@" || return
    if [ -f "$PWD/.nvimrc" ]; then
        local version
        version=$(cat "$PWD/.nvimrc" 2>/dev/null)
        if [ -n "$version" ]; then
            echo "neomanager: Switched to neovim $version (from .nvimrc)"
        fi
    fi
}

alias cd='_neomanager_cd'

# Aliases
alias neomanager='nvimmgr'

# Wrap nvim to launch the managed neovim version
nvim() {
    nvimmgr exec "$@"
}
