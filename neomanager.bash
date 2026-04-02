#!/usr/bin/env bash

# neomanager shell integration for bash

NEOMANAGER_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
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

__neomanager_prompt_command() {
    _neomanager_version_check
}

_neomanager_append_prompt_command() {
    local pc
    pc='__neomanager_prompt_command'
    if [ -z "$PROMPT_COMMAND" ]; then
        PROMPT_COMMAND="$pc"
    elif ! echo "$PROMPT_COMMAND" | grep -q "$pc"; then
        PROMPT_COMMAND="${PROMPT_COMMAND};${pc}"
    fi
}

_neomanager_append_prompt_command
_neomanager_version_check

# Aliases
alias neomanager='nvimmgr'

# Wrap nvim to launch the managed neovim version
nvim() {
    nvimmgr exec "$@"
}
