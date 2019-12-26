function search --description 'Search shell history using fzf'
  history | fzf $arg
end
