# .zshrc: minimal zsh fallback (fish is the primary shell)

BREW_PREFIX="$HOME/Dev/homebrew"
path=("$BREW_PREFIX/bin" "$BREW_PREFIX/sbin" $path)

export PNPM_HOME="$HOME/Library/pnpm"
path=("$PNPM_HOME/bin" $path)

eval "$(starship init zsh)"
eval "$(fnm env --use-on-cd --version-file-strategy=recursive)"

[ -f "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ] && source "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
[ -f "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ] && source "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
