function kill_port
    lsof -iTCP -sTCP:LISTEN -P -n 2>/dev/null \
            | awk 'NR>1{split($9,a,":"); printf "%-8s %-8s %-6s %s\n",$2,a[length(a)],$1,$9}' \
            | fzf --multi --prompt='Kill port(s) › ' --layout=reverse \
            | awk '{print $1}' \
            | xargs -I{} kill {}
end
