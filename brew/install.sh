#!/usr/bin/env bash

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade --all

# Install GNU core utilities (those that come with OS X are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum

brew install gettext
brew install coreutils
brew install curl
brew install wget
brew install git-flow-avh
brew install grc
brew install libyaml
brew install openssl
brew install readline
brew install wget
brew install fish
brew install git
brew install gnu-getopt
brew install htop
brew install node
brew install pkg-config
brew install gdbm
brew install git-extras
brew install go
brew install httpie
brew install python
brew install unar

# Remove outdated versions from the cellar.
brew cleanup
