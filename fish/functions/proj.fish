function proj --description 'Quick project switcher with fzf'
    set -l selected (fd -t d -d 2 . ~/Workspaces ~/Code 2>/dev/null | fzf --height 40% --reverse)
    if test -n "$selected"
        cd $selected
        test -d .git && git status -s
    end
end
