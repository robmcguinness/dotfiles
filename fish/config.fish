fish_add_path /opt/homebrew/bin /opt/homebrew/sbin /usr/local/bin

. ~/.config/fish/aliases.fish
set -gx fish_greeting ''

set -gx PYENV_ROOT "$HOME/.pyenv"
fish_add_path -U /usr/local/bin "$PYENV_ROOT/bin" "$HOME/.cargo/bin"

# pyenv init
if command -v pyenv 1>/dev/null 2>&1
  pyenv init - | source
end

eval (starship init fish)
