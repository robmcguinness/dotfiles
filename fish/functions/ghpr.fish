function ghpr --description 'Checkout GitHub PR by number'
    if test (count $argv) -eq 0
        set -l pr (gh pr list --limit 50 | fzf --height 40% | awk '{print $1}')
        test -n "$pr" && gh pr checkout $pr
    else
        gh pr checkout $argv[1]
    end
end
