set fish_greeting

set -x EDITOR "code-insiders"

fish_add_path $HOME/Dev/homebrew/bin $HOME/Dev/homebrew/sbin /usr/local/bin $HOME/.cargo/env $HOME/.local/bin

. ~/.config/fish/aliases.fish

starship init fish | source
zoxide init fish | source

# Lazy-load fnm: only activate when changing directories
set -gx PNPM_HOME "$HOME/Library/pnpm"
fish_add_path "$PNPM_HOME"

if type -q fnm
    fnm env --shell fish | source
    function _fnm_autoload --on-variable PWD
        if test -e .node-version -o -e .nvmrc
            fnm use --silent-if-unchanged 2>/dev/null
        end
    end
end

# mise (replaces pyenv for Python version management)
if type -q mise
    mise activate fish | source
end
