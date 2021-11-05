#!/usr/bin/env zsh
setup_vscode() {
  local PLUGINS_TO_INSTALL="alefragnani.Bookmarks  
  andrewmarkle.primer-light  
  christian-kohler.npm-intellisense
  christian-kohler.path-intellisense
  codezombiech.gitignore
  DavidAnson.vscode-markdownlint
  dbaeumer.vscode-eslint  
  drKnoxy.eslint-disable-snippets
  eamodio.gitlens
  EditorConfig.EditorConfig
  eg2.vscode-npm-script
  esbenp.prettier-vscode
  fabiospampinato.vscode-open-in-gittower
  felipecaputo.git-project-manager
  formulahendry.auto-close-tag
  formulahendry.auto-rename-tag    
  nemesv.copy-file-name
  nwallace.peep
  oderwat.indent-rainbow
  Orta.vscode-jest
  rust-lang.rust
  sleistner.vscode-fileutils
  streetsidesoftware.code-spell-checker  
  vscode-icons-team.vscode-icons
  wayou.vscode-todo-highlight
  wmaurer.change-case  

  for i in ${PLUGINS_TO_INSTALL[@]}; do
    code --install-extension "$i"
  done
}
setup_vscode
