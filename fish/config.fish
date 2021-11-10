set fish_greeting

set -x EDITOR "nvim"

fish_add_path /opt/homebrew/bin /opt/homebrew/sbin /usr/local/bin

. ~/.config/fish/aliases.fish

starship init fish | source
zoxide init fish | source
fnm env | source

set -gx PYENV_ROOT "$HOME/.pyenv"
fish_add_path -U /usr/local/bin "$PYENV_ROOT/bin" "$HOME/.cargo/bin"
# pyenv init
status is-interactive; and pyenv init --path | source


