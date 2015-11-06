# Path oh-my-fish.
set fish_path $HOME/.oh-my-fish
# brew
set PATH $PATH $HOME/Dev/homebrew/bin
# rvm
set PATH $PATH $HOME/.rvm/bin

ulimit -n 8192

# Path to your custom folder (default path is ~/.oh-my-fish/custom)
#set fish_custom $HOME/dotfiles/oh-my-fish

# Load oh-my-fish configuration.
. $fish_path/oh-my-fish.fish

# Custom plugins and themes may be added to ~/.oh-my-fish/custom
# Plugins and themes can be found at https://github.com/oh-my-fish/
Theme agnoster
set -g theme_display_user yes

Plugin 'theme'
Plugin 'brew'
Plugin 'sublime'
Plugin 'balias'
Plugin 'percol'

balias ..='cd ..'
balias ..2='cd ../..'
balias ..3='cd ../../..'
balias ..4='cd ../../../..'
balias h="cd"
balias c="clear"
balias l='ls -lah'
balias lf='ls -Gl | grep ^d' # only list directories
balias lsd='ls -Gal | grep ^d' # only list directories, including hidden ones
balias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"

balias k9='kill -9'
balias hs='history | grep'
balias sshkeys="tail +1 ~/.ssh/*.pub"

# git
balias gc='git clone'
balias gp='git pull'
balias gpu='git push'
balias gll='git log --pretty=format:"%C(yellow)%h%Cred%d %Creset%s%Cblue [%cn]" --decorate'
balias gl='git log --pretty=format:"%C(yellow)%h\\ %ad%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --date=short'
balias gs='git status -sb'
balias gf='git fetch'
balias gd='git diff'
balias gm='git commit -m'
balias gma='git commit -am'
balias gb='git branch'
balias gco='git checkout'
balias gfo='git fetch origin'
balias gra='git remote add'
balias grr='git remote rm'
balias gbr='git branch -r'
balias gba='git branch -a'
balias pubkey='pbcopy < ~/.ssh/id_rsa.pub'
balias sourcme='source ~/.config/fish/config.fish'
balias showa="cat ~/.config/fish/config.fish"

# iterate through all git repos and show the url
balias gurls='find . -type d -name .git -exec sh -c "cd \"{}\"/../ && git config --get remote.origin.url" \;'
# iterate through all git repos and run `git pull`
balias gua='find . -type d -name .git -exec sh -c "cd \"{}\"/../ && pwd && git pull" \;'

balias gurls='find . -type d -name .git -exec sh -c "cd \"{}\"/../ && git config --get remote.origin.url" \;'
balias gu='find . -type d -name .git -exec sh -c "cd \"{}\"/../ && pwd && git pull" \;'

# python
# balias cat='pygmentize -O style=monokai -f console256 -g'

# autojump
[ -f /Users/rmcguinness/Dev/homebrew/share/autojump/autojump.fish ]; and . /Users/rmcguinness/Dev/homebrew/share/autojump/autojump.fish

# percol
function fish_user_key_bindings
  bind \cr percol_select_history
end

function nvm
  bass source ~/.nvm/nvm.sh ';' nvm $argv
end

# java
set -x JAVA_HOME /Library/Java/JavaVirtualMachines/jdk1.7.0_71.jdk/Contents/Home
set -gx JBOSS_HOME $HOME/jboss

# browsers
set -x CHROME_BIN "/Users/rmcguinness/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
set -x FIREFOX_BIN "/Users/rmcguinness/Applications/Firefox.app/Contents/MacOS/firefox-bin"

# AXI builds
set -gx JAVA3_HOME /System/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home
set -gx JAVA4_HOME /System/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home
set -gx JAVA5_HOME /System/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home
set -gx JAVA6_HOME /System/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home
set -gx JAVA7_HOME /Library/Java/JavaVirtualMachines/jdk1.7.0_71.jdk/Contents/Home
set -gx JAVA8_HOME /Library/Java/JavaVirtualMachines/jdk1.8.0_66.jdk/Contents/Home

set -gx GRADLE_OPTS "-Xmx1024m -Xms256m -XX:MaxPermSize=512m -XX:+CMSClassUnloadingEnabled -XX:+HeapDumpOnOutOfMemoryError"

set -gx OCI_HOME /Users/rmcguinness/Dev/oracle
set -gx OCI_LIB_DIR /Users/rmcguinness/Dev/oracle
set -gx OCI_INCLUDE_DIR /Users/rmcguinness/Dev/oracle/sdk/include
set -gx DYLD_LIBRARY_PATH /Users/rmcguinness/Dev/oracle
set -gx _JAVA_OPTIONS "-Dapple.awt.UIElement=true"






