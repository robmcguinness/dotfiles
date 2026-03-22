# .zshrc: minimal zsh fallback (fish is the primary shell)

eval "$(starship init zsh)"
eval "$(fnm env --use-on-cd --version-file-strategy=recursive)"

export PNPM_HOME="$HOME/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
