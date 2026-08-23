# Dotfiles

> Personal macOS development environment configuration

A comprehensive dotfiles repository for setting up a fully-configured macOS development environment. Includes shell configurations, modern CLI tools, editor settings, and system customizations managed via [Dotbot](https://github.com/anishathalye/dotbot).

## Features

- **Shell Environment** - Fish shell with Fisher plugin manager, Zsh fallback, and Starship prompt
- **Modern CLI Tools** - Rust-based replacements for traditional Unix utilities
- **Development Tools** - Git workflow enhancements, Docker, VS Code configuration
- **Package Management** - Homebrew with custom location, fnm, pyenv, pnpm
- **macOS Customizations** - Dock, Finder, and system preference tweaks

## Tech Stack

| Category | Tools |
|----------|-------|
| Shell | Fish, Zsh |
| Prompt | Starship |
| Editor | VSCodium / VS Code |
| Terminal | iTerm2 |
| Package Manager | Homebrew |
| Bootstrap | Dotbot |

## What's Included

### Shell Environment

- **Fish** - Primary shell with extensive aliases and functions
- **Fisher** - Fish plugin manager with 10+ plugins
- **Zsh** - Secondary shell configuration
- **Starship** - Cross-shell customizable prompt

### Modern CLI Replacements

| Tool | Replaces | Description |
|------|----------|-------------|
| `bat` | `cat` | Syntax highlighting and git integration |
| `eza` | `ls` | Icons, colors, and git status |
| `fd` | `find` | Simpler syntax, faster search |
| `ripgrep` | `grep` | Fast regex search |
| `dust` | `du` | Intuitive disk usage |
| `btop` | `top` | Resource monitor with graphs |
| `procs` | `ps` | Modern process viewer |
| `duf` | `df` | Disk usage with colors |
| `sd` | `sed` | Intuitive find and replace |
| `tealdeer` | `man` | Simplified command examples |

### Development Tools

- **Git** - Delta pager (Dracula theme), extensive aliases, LFS support
- **lazygit** - Terminal UI for git
- **Docker** - Via Colima container runtime
- **GitHub CLI** - Repository and PR management
- **VSCodium / VS Code** - 25 extensions, shared settings and keybindings (linked into VSCodium, Code, Code - Insiders)

### Package & Version Management

- **Homebrew** - Installed at `~/Dev/homebrew` (non-system location)
- **fnm** - Fast Node.js version manager
- **mise** - Python (and other runtime) version manager
- **pnpm** - Fast npm alternative

### Custom Functions

- `proj` - Fuzzy project switcher for `~/Workspaces` and `~/Code`
- `ghpr` - Interactive GitHub PR checkout with fzf
- `gpp` - Change directory and git pull
- `mkd` / `take` - Create directory and cd into it
- `j` - Zoxide smart directory jumping

### GUI Applications

- **iTerm2** - Terminal with MaterialOcean theme
- **Alfred** - Spotlight replacement
- **Rectangle** - Window management
- **Tower** - Git GUI client
- **DBeaver** - Database client

## Installation

### Prerequisites

- macOS
- Xcode Command Line Tools (`xcode-select --install`)
- Git

### Setup

```sh
git clone --recurse-submodules https://github.com/robmcguinness/dotfiles ~/.dotfiles
~/.dotfiles/install
```

The install script will:
1. Create working directories (`~/Code`, `~/Workspaces`, `~/Dev`)
2. Symlink configuration files
3. Install Homebrew to `~/Dev/homebrew`
4. Install packages via `brew bundle`
5. Configure Fish plugins via Fisher
6. Apply macOS system preferences
7. Install VS Code extensions

## Directory Structure

```
dotfiles/
├── install              # Main installation script
├── install.conf.yaml    # Dotbot configuration
├── Brewfile             # Homebrew packages and casks
├── extensions.txt       # VS Code extensions list
├── bat/                 # Bat configuration
├── editorconfig/        # EditorConfig settings
├── fish/                # Fish shell config, aliases, functions
├── git/                 # Git config and ignore patterns
├── iterm/               # iTerm2 profile
├── scripts/             # Automation scripts (macOS setup)
├── starship/            # Starship prompt configuration
├── vscode/              # VS Code settings and keybindings
└── zsh/                 # Zsh configuration
```

## Key Configurations

### Custom Homebrew Location

Homebrew is installed to `~/Dev/homebrew` instead of the default system location, providing:
- Portability across machines
- No sudo required for package management
- Isolation from system tools

### Git Aliases

Common aliases configured in `git/gitconfig`:
- `s` - Short status
- `d` - Diff with delta
- `p` - Pull with submodule update
- `pushup` - Push current branch to origin
- `lg` - Pretty log with graph
- `standup` - Show yesterday's commits

### Fish Plugins

Installed via Fisher:
- `fzf.fish` - Fuzzy finder integration
- `forgit` - Interactive git commands
- `fish-you-should-use` - Alias reminders
- `puffer-fish` - Text expansions
- `fish-ssh-agent` - SSH agent management

## Customization

1. Fork this repository
2. Update `git/gitconfig` with your name and email
3. Modify `Brewfile` to add/remove packages
4. Edit `fish/aliases.fish` for custom aliases
5. Adjust `vscode/settings.json` for editor preferences
6. Run `./install` to apply changes

## Inspiration

- [pgilad/dotfiles](https://github.com/pgilad/dotfiles)
