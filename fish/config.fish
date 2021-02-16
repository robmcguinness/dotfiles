. ~/.config/fish/aliases.fish
set -gx fish_greeting ''

eval (starship init fish)

set -U fish_user_paths /usr/local/bin $fish_user_paths
set -Ux PYENV_ROOT $HOME/.pyenv
set -Ux fish_user_paths $PYENV_ROOT/bin $fish_user_paths


# pyenv init
if command -v pyenv 1>/dev/null 2>&1
  pyenv init - | source
end
