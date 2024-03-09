set fish_greeting

set -x EDITOR "code"

fish_add_path $HOME/Dev/homebrew/bin /Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/ $HOME/Dev/homebrew/sbin /usr/local/bin $HOME/.cargo/env

. ~/.config/fish/aliases.fish

starship init fish | source
zoxide init fish | source
fnm env | source

set -gx PYENV_ROOT "$HOME/.pyenv"
set -gx PNPM_HOME "$HOME/Library/pnpm"

fish_add_path -U /usr/local/bin "$PYENV_ROOT/bin" "$HOME/.cargo/bin" "$PNPM_HOME"

# pyenv init
status is-interactive
and pyenv init --path | source
