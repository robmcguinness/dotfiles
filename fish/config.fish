set fish_greeting
set -x EDITOR "codium"
set -x TURBO_TELEMETRY_DEBUG 1
set -x PNPM_HOME "$HOME/Library/pnpm"
set -x HOMEBREW_NO_UPDATE_REPORT_FORMULAE 1
set -x HOMEBREW_NO_UPDATE_REPORT_CASKS 1
set -x HOMEBREW_NO_ENV_HINTS 1

fish_add_path $HOME/Dev/homebrew/bin $HOME/Dev/homebrew/sbin /usr/local/bin $HOME/.cargo/env $HOME/.local/bin $PNPM_HOME/bin

. ~/.config/fish/aliases.fish

starship init fish | source
zoxide init fish | source

# fnm is initialised in conf.d/fnm.fish (--use-on-cd)

# mise (replaces pyenv for Python version management)
if type -q mise
    mise activate fish | source
end
