#!/usr/bin/env zsh
setup_vscode() {
  local PLUGINS_TO_INSTALL="alefragnani.Bookmarks
alexdima.copy-relative-path
andrewmarkle.primer-light
bradlc.vscode-tailwindcss
bungcip.better-toml
christian-kohler.npm-intellisense
christian-kohler.path-intellisense
codezombiech.gitignore
DavidAnson.vscode-markdownlint
dbaeumer.vscode-eslint
drKnoxy.eslint-disable-snippets
eamodio.gitlens
EditorConfig.EditorConfig
emmanuelbeziat.vscode-great-icons
esbenp.prettier-vscode
fabiospampinato.vscode-open-in-gittower
felipecaputo.git-project-manager
formulahendry.auto-close-tag
formulahendry.auto-rename-tag
hdevalke.rust-test-lens
heybourn.headwind
jeff-hykin.better-shellscript-syntax
matklad.rust-analyzer
nemesv.copy-file-name
nwallace.peep
oderwat.indent-rainbow
Orta.vscode-jest
richie5um2.vscode-sort-json
skyapps.fish-vscode
sleistner.vscode-fileutils
streetsidesoftware.code-spell-checker
tombonnike.vscode-status-bar-format-toggle
vadimcn.vscode-lldb
vscode-icons-team.vscode-icons
wayou.vscode-todo-highlight
wmaurer.change-case
zhuangtongfa.material-theme"

  for i in ${PLUGINS_TO_INSTALL[@]}; do
    code --install-extension "$i"
  done
}
setup_vscode

ln -sf $HOME/Workspaces/dotfiles/vscode/settings.json ~/Library/Application\ Support/Code/User/
ln -sf $HOME/Workspaces/dotfiles/vscode/keybindings.json ~/Library/Application\ Support/Code/User/

