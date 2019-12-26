#!/usr/bin/env bash

count=1

reset="\033[0m"
highlight="\033[41m\033[97m"
dot="\033[94m❯ $reset"
dim="\033[2m"
blue="\e[34m"
green="\e[32m"
yellow="\e[33m"
tag_green="\e[30;42m"
tag_blue="\e[30;46m"
bold=$(tput bold)
normal=$(tput sgr0)
underline="\e[37;4m"
indent="  "

cwd="$(pwd)"

print_success() {
  print_in_green "[✔] $1\n"
}

print_success_muted() {
    printf "${dim}[✔] $1${reset}\n" "$@"
}

print_in_green() {
  printf "\e[0;32m" "$1"
}

step() {
  printf "\n${dot}${underline}$@${reset}\n\n"
}

function install_or_upgrade {
  if brew ls --versions "$1" >/dev/null; then
      HOMEBREW_NO_AUTO_UPDATE=1 brew upgrade "$1"
  else
      HOMEBREW_NO_AUTO_UPDATE=1 brew install "$1"
  fi
}

