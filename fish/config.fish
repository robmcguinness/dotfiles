set fish_greeting

set -x EDITOR "code-insiders"

fish_add_path $HOME/Dev/homebrew/bin $HOME/Dev/homebrew/sbin /usr/local/bin $HOME/.cargo/env

. ~/.config/fish/aliases.fish

starship init fish | source
zoxide init fish | source
fnm env | source

set -gx PYENV_ROOT "$HOME/.pyenv"
set -gx PNPM_HOME "$HOME/Library/pnpm"

fish_add_path "$PYENV_ROOT/bin" "$PNPM_HOME"

# pyenv init
status is-interactive
and pyenv init --path | source

string match -g "$TERM_PROGRAM" "vscode-insiders" and "/Applications/Visual Studio Code - Insiders.app/Contents/Resources/app/out/vs/workbench/contrib/terminal/common/scripts/shellIntegration-bash.sh" | source
