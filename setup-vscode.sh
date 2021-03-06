#!/usr/bin/env bash
setup_vscode() {

  local PLUGINS_TO_INSTALL="2gua.rainbow-brackets
  Rubymaniac.vscode-paste-and-indent
  TeddyDD.fish
  alefragnani.Bookmarks
  alexdima.copy-relative-path
  andrewmarkle.primer-light
  anseki.vscode-color
  atian25.copy-syntax
  be5invis.vscode-custom-css
  bierner.markdown-preview-github-styles
  bungcip.better-toml
  christian-kohler.npm-intellisense
  christian-kohler.path-intellisense
  codezombiech.gitignore
  cssho.vscode-svgviewer
  DavidAnson.vscode-markdownlint
  dbaeumer.vscode-eslint
  donjayamanne.githistory
  drKnoxy.eslint-disable-snippets
  eamodio.gitlens
  EditorConfig.EditorConfig
  eg2.vscode-npm-script
  esbenp.prettier-vscode
  fabiospampinato.vscode-open-in-gittower
  felipecaputo.git-project-manager
  formulahendry.auto-close-tag
  formulahendry.auto-rename-tag
  formulahendry.code-runner
  foxundermoon.shell-format
  hdevalke.rust-test-lens
  jeff-hykin.better-shellscript-syntax
  mohsen1.prettify-json
  nemesv.copy-file-name
  nwallace.peep
  oderwat.indent-rainbow
  Orta.vscode-jest
  rust-lang.rust
  serayuzgur.crates
  sleistner.vscode-fileutils
  streetsidesoftware.code-spell-checker
  tombonnike.vscode-status-bar-format-toggle
  tomoki1207.vscode-gfm-preview
  vadimcn.vscode-lldb
  vscode-icons-team.vscode-icons
  wayou.vscode-todo-highlight
  wix.vscode-import-cost
  wmaurer.change-case
  wmaurer.join-lines"

  for i in ${PLUGINS_TO_INSTALL[@]}; do
    code --install-extension "$i"
  done
}
setup_vscode
