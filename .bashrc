# ~/.bashrc
#
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# Store 10,000 history entries
export HISTSIZE=10000
# Don't store duplicates
export HISTCONTROL=erasedups
# Append to history file
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

#command history will be saved for all terminals.
export PROMPT_COMMAND='history -a'

bind 'set bind-tty-special-chars off'
bind '"\ep": history-search-backward'
bind '"\en": history-search-forward'
bind '"\C-w": backward-kill-word'

C_DEFAULT="\[\033[m\]"
C_WHITE="\[\033[1m\]"
C_BLACK="\[\033[30m\]"
C_RED="\[\033[31m\]"
C_GREEN="\[\033[32m\]"
C_YELLOW="\[\033[33m\]"
C_BLUE="\[\033[34m\]"
C_PURPLE="\[\033[35m\]"
C_CYAN="\[\033[36m\]"
C_LIGHTGRAY="\[\033[37m\]"
C_DARKGRAY="\[\033[1;30m\]"
C_LIGHTRED="\[\033[1;31m\]"
C_LIGHTGREEN="\[\033[1;32m\]"
C_LIGHTYELLOW="\[\033[1;33m\]"
C_LIGHTBLUE="\[\033[1;34m\]"
C_LIGHTPURPLE="\[\033[1;35m\]"
C_LIGHTCYAN="\[\033[1;36m\]"
C_BG_BLACK="\[\033[40m\]"
C_BG_RED="\[\033[41m\]"
C_BG_GREEN="\[\033[42m\]"
C_BG_YELLOW="\[\033[43m\]"
C_BG_BLUE="\[\033[44m\]"
C_BG_PURPLE="\[\033[45m\]"
C_BG_CYAN="\[\033[46m\]"
C_BG_LIGHTGRAY="\[\033[47m\]"

# RVM
if [[ -s /Users/robertmcguinness/.rvm/scripts/rvm ]] ; then
  source /Users/robertmcguinness/.rvm/scripts/rvm;
fi

[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh

if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

source "`brew --prefix`/etc/grc.bashrc"

eval "$(jenv init -)"

if [ -f /usr/local/git/contrib/completion/git-completion.bash ]; then
. /usr/local/git/contrib/completion/git-completion.bash
fi

if [ -f ~/git-prompt.sh ]; then
  . ~/git-prompt.sh
fi

if [ -f "$HOME/.gvm/scripts/gvm" ]; then
. ~/.gvm/scripts/gvm
fi

export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh


eval "$(pyenv init -)"

GIT_PS1_SHOWDIRTYSTATE=true

# BEGIN CUSTOM PROMPT
# \d Date
# \h Host
# \n New Line
# \t Time
# \u Username
# \W Current Working Directory
# \w Full Path to Current Directory
export PS1="\n$C_LIGHTGREEN\u$C_DARKGRAY@$C_BLUE\h $C_DARKGRAY: $C_LIGHTYELLOW\w $C_RED\$(__git_ps1) \n$C_DARKGRAY->$C_DEFAULT"
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
