fish_add_path /opt/homebrew/bin /opt/homebrew/sbin /usr/local/bin

. ~/.config/fish/aliases.fish
set -gx fish_greeting ''

starship init fish | source
zoxide init fish | source

set -gx PYENV_ROOT "$HOME/.pyenv"
fish_add_path -U /usr/local/bin "$PYENV_ROOT/bin" "$HOME/.cargo/bin"

# pyenv init
status is-interactive; and pyenv init --path | source
