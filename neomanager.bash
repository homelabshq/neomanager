#!/usr/bin/env bash

# neomanager shell integration for bash

NEOMANAGER_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export NEOMANAGER_DIR
export PATH="$NEOMANAGER_DIR:$PATH"

_neomanager_cd() {
    builtin cd "$@" || return

    local version=""
    local dir="$PWD"
    while [ "$dir" != "/" ]; do
        if [ -f "$dir/.nvimrc" ]; then
            version=$(cat "$dir/.nvimrc" 2>/dev/null)
            break
        fi
        dir=$(dirname "$dir")
    done

    if [ -n "$version" ] && [ "$version" != "$_NEOMANAGER_LAST_VERSION" ]; then
        echo "neomanager: Switched to neovim $version (from .nvimrc)"
    fi

    export _NEOMANAGER_LAST_VERSION="${version:-}"
}

alias cd='_neomanager_cd'

_neomanager_cd .

# Aliases
alias neomanager='nvimmgr'

# Wrap nvim to launch the managed neovim version
nvim() {
    nvimmgr exec "$@"
}
