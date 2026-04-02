#!/usr/bin/env zsh

# neomanager shell integration for zsh

NEOMANAGER_DIR="${0:A:h}"
export NEOMANAGER_DIR
export PATH="$NEOMANAGER_DIR:$PATH"

_neomanager_version_check() {
    local version=""
    local dir="$PWD"
    while [ "$dir" != "/" ]; do
        if [ -f "$dir/.nvim-version" ]; then
            version=$(cat "$dir/.nvim-version" 2>/dev/null)
            if [ -n "$version" ] && echo "$version" | grep -qE '^(v[0-9]+\.[0-9]+\.[0-9]+|nightly|nightly-[0-9]{8}|source-[0-9]{8}|stable)$'; then
                break
            fi
            version=""
        fi
        dir=$(dirname "$dir")
    done

    if [ -n "$version" ] && [ "$version" != "$_NEOMANAGER_LAST_VERSION" ]; then
        echo "neomanager: Switched to neovim $version (from .nvim-version)"
    fi

    export _NEOMANAGER_LAST_VERSION="${version:-}"
}

autoload -U add-zsh-hook
add-zsh-hook chpwd _neomanager_version_check

_neomanager_version_check

# Aliases
alias neomanager='nvimmgr'

# Wrap nvim to launch the managed neovim version
nvim() {
    nvimmgr exec "$@"
}
