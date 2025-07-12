#  .zshrc: for interactive shell configuration

eval "$(starship init zsh)"

eval "$(fnm env --use-on-cd --version-file-strategy=recursive)"

fish
# pnpm
export PNPM_HOME="/Users/robertmcguinness/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end


