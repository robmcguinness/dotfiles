#!/usr/bin/env bash
# Idempotent machine bootstrap: Homebrew, packages, fish plugins, editor extensions, shell.
# Run via `./install` (dotbot) or directly. Set DOTFILES_FAST=1 to skip package upgrades.
set -euo pipefail

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BREW_PREFIX="$HOME/Dev/homebrew"

export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_INSTALL_CLEANUP=1
export HOMEBREW_NO_ENV_HINTS=1
export HOMEBREW_NO_ANALYTICS=1

log() { printf '\n\033[1;34m==> %s\033[0m\n' "$*"; }

# --- Homebrew ------------------------------------------------------------------
if [ ! -x "$BREW_PREFIX/bin/brew" ]; then
  log "Installing Homebrew to $BREW_PREFIX"
  mkdir -p "$BREW_PREFIX"
  curl -fsSL https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C "$BREW_PREFIX"
else
  log "Homebrew already installed"
fi
eval "$("$BREW_PREFIX/bin/brew" shellenv)"

# --- Packages ------------------------------------------------------------------
log "brew bundle"
bundle_args=(--file="$BASEDIR/Brewfile")
[ "${DOTFILES_FAST:-0}" = "1" ] && bundle_args+=(--no-upgrade)
brew bundle "${bundle_args[@]}"

# --- docker-compose as a CLI plugin --------------------------------------------
log "docker-compose plugin"
mkdir -p "$HOME/.docker/cli-plugins"
ln -sfn "$(brew --prefix)/opt/docker-compose/bin/docker-compose" "$HOME/.docker/cli-plugins/docker-compose"

# --- fish plugins --------------------------------------------------------------
log "fisher update"
fish -c "fisher update" || echo "fisher update failed (non-fatal)"

# --- Editor extensions ---------------------------------------------------------
for bin in codium code code-insiders; do
  command -v "$bin" >/dev/null 2>&1 || continue
  log "Extensions for $bin"
  installed="$("$bin" --list-extensions 2>/dev/null | tr '[:upper:]' '[:lower:]')"
  while IFS= read -r ext; do
    [ -z "$ext" ] && continue
    if grep -qixF "$ext" <<<"$installed"; then continue; fi
    "$bin" --install-extension "$ext" || echo "  skip $ext (not available for $bin)"
  done < "$BASEDIR/extensions.txt"
done

# --- Default shell -------------------------------------------------------------
FISH="$BREW_PREFIX/bin/fish"
if ! grep -qxF "$FISH" /etc/shells; then
  log "Adding fish to /etc/shells (sudo)"
  echo "$FISH" | sudo tee -a /etc/shells >/dev/null
fi
if [ "$(dscl . -read "/Users/$USER" UserShell | awk '{print $2}')" != "$FISH" ]; then
  log "Setting fish as default shell"
  chsh -s "$FISH"
fi

# --- macOS defaults ------------------------------------------------------------
log "macOS defaults"
"$BASEDIR/scripts/macos.sh"

log "Bootstrap complete"
