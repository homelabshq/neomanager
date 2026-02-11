# neomanager

A lightweight version manager for [Neovim](https://neovim.io), written in Bash. Install, switch, and manage multiple Neovim versions with ease.

## Features

- Install pre-built Neovim releases from GitHub
- Install nightly builds
- Build from source
- Switch between versions globally or per-project (`.nvimrc`)
- Automatic version switching when entering project directories
- Supports macOS (Intel & Apple Silicon) and Linux (x86_64, ARM64, ARMv7)

## Installation

### Quick install (recommended)

```bash
curl -fsSL https://raw.githubusercontent.com/homelabshq/neomanager/main/install.sh | bash
```

### Manual install

Clone the repository:

```bash
git clone https://github.com/homelabshq/neomanager.git ~/.neomanager
```

Add to your shell config:

**Bash** (`~/.bashrc`):

```bash
source ~/.neomanager/neomanager.bash
```

**Zsh** (`~/.zshrc`):

```bash
source ~/.neomanager/neomanager.zsh
```

Then reload your shell:

```bash
source ~/.bashrc   # or source ~/.zshrc
```

## Usage

### Install a specific version

```bash
neomanager install v0.10.0
```

### Install the latest stable version

```bash
neomanager install-latest
```

### Install a nightly build

```bash
neomanager install nightly
```

### Build from source

```bash
neomanager install-source
```

### List installed versions

```bash
neomanager list
```

### List available remote versions

```bash
neomanager list-remote
```

### Set default version (global)

```bash
neomanager use v0.10.0
```

### Set version for current project

```bash
neomanager use-local v0.9.5
```

This creates a `.nvimrc` file in the current directory. When you `cd` into this directory, neomanager automatically switches to the specified version.

### Show current version

```bash
neomanager current
```

### Show path to active binary

```bash
neomanager which
```

### Uninstall a version

```bash
neomanager uninstall v0.9.5
```

### Check for updates

```bash
neomanager update
```

### Use Neovim

Once a version is set, just use `nvim` as usual:

```bash
nvim
nvim file.txt
```

## How It Works

neomanager downloads pre-built Neovim binaries from GitHub releases (or builds from source). Versions are stored in `~/.neomanager/versions/`. The active version is tracked in `~/.neomanager/current` or per-directory via `.nvimrc` files.

When you source the shell integration, it:
- Adds the `neomanager` and `nvim` commands
- Hooks into `cd` to automatically detect `.nvimrc` files

## Requirements

- `curl` and `tar` (for downloading releases)
- `git`, `make`, and `cmake` (only for building from source)

## Supported Platforms

| Platform | Architecture | Notes |
|----------|-------------|-------|
| macOS    | Intel (x86_64) | All versions |
| macOS    | Apple Silicon (arm64) | v0.10.0+ |
| Linux    | x86_64 | All versions |
| Linux    | ARM64 (aarch64) | v0.11.0+ |

## License

[MIT](LICENSE)
