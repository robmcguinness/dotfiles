function search --description 'Search shell history using percol'
  history | grep $argv | percol
end