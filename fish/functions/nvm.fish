function nvm --description 'Node version manager'
  # --no-use to the end of the above script to postpone using nvm until used
  bass source ~/.nvm/nvm.sh --no-use ';' nvm $argv
end
