#system reads .bash_profile first and will ignore this one
#look in ect/paths as well

. "$HOME/.bashrc"

. ~/.nvm/nvm.sh

export PATH=/Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/:$PATH
export PATH=/usr/local/Cellar/ruby/1.9.2-p0/bin:$PATH

# Tell ls to be colourful
export CLICOLOR=1
# export LSCOLORS=gxgxcxdxbxegedabagacad
export LSCOLORS=ExFxCxDxBxegedabagacad
#export LSCOLORS=Exfxcxdxbxegedabagacad
# Tell grep to highlight matches
export GREP_OPTIONS='--color=auto'

# navigation
alias ..='cd ..'
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias ..4='cd ../../../..'
alias ls='ls -la'

# list directories
alias lsd='ls -l | grep "^d"'

# ip address
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en1"
alias ips="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"



#Generic Colouriser is a great utility which can be used for colourising many different types of output and log files
source "`brew --prefix grc`/etc/grc.bashrc"
