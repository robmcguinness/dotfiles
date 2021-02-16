#!/usr/bin/env bash

install_or_upgrade gettext
install_or_upgrade coreutils
install_or_upgrade curl
install_or_upgrade wget
install_or_upgrade git-flow-avh
install_or_upgrade grc
install_or_upgrade openssl
install_or_upgrade git
install_or_upgrade git-extras
install_or_upgrade fish
install_or_upgrade pyenv

brew install --cask qlstephen qlmarkdown quicklook-json qlimagesize suspicious-package quicklookase
brew install --cask visual-studio-code open-in-code

brew tap homebrew/cask-fonts
brew install --cask font-cascadia-code
