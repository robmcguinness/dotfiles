# Open a herdr orchestration layout: Claude fable, Claude opus, Codex
# (gpt-5.6-sol, high reasoning) and `hunk diff --watch`.
#
# Layouts (--layout, default: tabs):
#   tabs  one tab per agent — fable, opus, codex, hunk (4 tabs)
#   grid  the original 2×2 single-tab grid
#
# All other args are forwarded verbatim to both claude panes.
#
#     ❯ orc --plugin-dir ~/Workspaces/rm3-claude-plugin --chrome
#     orc › dotfiles  (agent per tab)
#       ✓ preflight (herdr, jq, git, claude, codex, hunk)
#       ✓ tabs created  4/4
#       ✓ dotfiles-fable  claude --model fable --effort high --plugin-dir … --chrome
#       ✓ dotfiles-opus   claude --model opus --effort medium --plugin-dir … --chrome
#       ✓ dotfiles-codex  codex -m gpt-5.6-sol -c model_reasoning_effort=high
#       ✓ dotfiles-hunk   hunk diff --watch
#     done in 14s → herdr agent prompt dotfiles-fable "..."
#
#     ❯ orc --layout grid
#     orc › dotfiles  (2×2 herdr grid)
#       ✓ preflight (herdr, jq, git, claude, codex, hunk)
#       ✓ tab created  wG:t4
#       ✓ panes split  4/4
#       …
#
function orc --description 'Open a herdr orc layout: claude fable, claude opus, codex, hunk --watch (--layout tabs|grid)'
    set -l started (date +%s)

    # ---- helpers -----------------------------------------------------------
    function __orc_ok
        set_color green; echo -n '  ✓ '; set_color normal; echo $argv
    end
    function __orc_fail
        set_color red; echo -n '  ✗ '; set_color normal; echo $argv >&2
    end
    function __orc_run --description 'run a herdr command, print JSON error on failure'
        set -l out ($argv 2>&1)
        set -l rc $status
        if test $rc -ne 0
            printf '%s\n' $out >&2
            return $rc
        end
        printf '%s\n' $out
    end

    # ---- args --------------------------------------------------------------
    # --ignore-unknown: everything that is not --layout keeps flowing to the
    # claude panes untouched (e.g. --plugin-dir, --chrome).
    argparse --ignore-unknown 'layout=' -- $argv; or return 1
    set -l layout tabs
    set -q _flag_layout; and set layout $_flag_layout
    if not contains -- $layout tabs grid
        __orc_fail "invalid --layout '$layout' (expected: tabs, grid)"
        return 1
    end

    # ---- preflight ---------------------------------------------------------
    if not set -q HERDR_ENV
        __orc_fail 'not running inside a herdr pane'
        return 1
    end
    set -l missing
    for tool in herdr jq git claude codex hunk
        command -q $tool; or set -a missing $tool
    end
    if test (count $missing) -gt 0
        __orc_fail "missing tools: $missing"
        return 1
    end

    # ---- names -------------------------------------------------------------
    set -l root (git rev-parse --show-toplevel 2>/dev/null); or set root $PWD
    set -l repo (basename $root)
    # herdr agent names: [a-z][a-z0-9_-]{0,31}, unique among live agents
    set -l base (string lower -- $repo | string replace -ra '[^a-z0-9_-]' '-' | string replace -ra -- '-+' '-' | string trim -c '-')
    string match -qr '^[a-z]' -- $base; or set base "r-$base"
    set base (string sub -l 26 -- $base | string trim -c '-')
    set -l live (herdr agent list 2>/dev/null | jq -r '.result.agents[].name // empty')

    set -l names
    for role in fable opus codex
        set -l name "$base-$role"
        set -l n 1
        while contains -- $name $live
            set n (math $n + 1)
            set name "$base-$role-$n"
        end
        set -a names $name
        set -a live $name
    end
    set -l name_fable $names[1]
    set -l name_opus $names[2]
    set -l name_codex $names[3]
    set -l name_hunk "$base-hunk"

    set -l layout_label '  (agent per tab)'
    test $layout = grid; and set layout_label '  (2×2 herdr grid)'
    set_color --bold; echo -n "orc › $repo"; set_color normal; echo $layout_label
    __orc_ok 'preflight (herdr, jq, git, claude, codex, hunk)'

    # ---- layout ------------------------------------------------------------
    # declared up front: `set -l` inside the if/else below would be block-scoped
    set -l p1 ''; set -l p2 ''; set -l p3 ''; set -l p4 ''
    set -l focus_tab ''
    if test $layout = grid
        set -l json (__orc_run herdr tab create --cwd $PWD --label "orc: $repo" --no-focus); or begin
            __orc_fail 'tab create'; return 1
        end
        set focus_tab (printf '%s\n' $json | jq -r '.result.tab.tab_id')
        set p1 (printf '%s\n' $json | jq -r '.result.root_pane.pane_id')
        __orc_ok "tab created  $focus_tab"

        set p2 (__orc_run herdr pane split --pane $p1 --direction right --ratio 0.5 --cwd $PWD --no-focus | jq -r '.result.pane.pane_id'); or begin
            __orc_fail 'split right'; return 1
        end
        set p3 (__orc_run herdr pane split --pane $p1 --direction down --ratio 0.5 --cwd $PWD --no-focus | jq -r '.result.pane.pane_id'); or begin
            __orc_fail 'split down (left)'; return 1
        end
        set p4 (__orc_run herdr pane split --pane $p2 --direction down --ratio 0.5 --cwd $PWD --no-focus | jq -r '.result.pane.pane_id'); or begin
            __orc_fail 'split down (right)'; return 1
        end
    else
        # tabs mode: one tab per role; the tab's root pane hosts the agent
        set -l panes
        for role in fable opus codex hunk
            set -l json (__orc_run herdr tab create --cwd $PWD --label "orc: $repo · $role" --no-focus); or begin
                __orc_fail "tab create ($role)"; return 1
            end
            set -a panes (printf '%s\n' $json | jq -r '.result.root_pane.pane_id')
            # focus lands back on the orchestrator so the user starts there
            test $role = fable; and set focus_tab (printf '%s\n' $json | jq -r '.result.tab.tab_id')
        end
        set p1 $panes[1]; set p2 $panes[2]; set p3 $panes[3]; set p4 $panes[4]
    end

    herdr pane rename $p1 $name_fable >/dev/null
    herdr pane rename $p2 $name_opus >/dev/null
    herdr pane rename $p3 $name_codex >/dev/null
    herdr pane rename $p4 $name_hunk >/dev/null
    if test $layout = grid
        __orc_ok 'panes split  4/4'
    else
        __orc_ok 'tabs created  4/4'
    end

    # ---- launch ------------------------------------------------------------
    set -l claude_fable --model fable --effort high $argv
    # medium effort: the coder runs many short, well-scoped units; high was
    # slower without better output
    set -l claude_opus --model opus --effort medium $argv
    set -l codex_args -m gpt-5.6-sol -c model_reasoning_effort=high

    __orc_run herdr agent start $name_fable --kind claude --pane $p1 --timeout 60000 -- $claude_fable >/dev/null; or begin
        __orc_fail "$name_fable  claude $claude_fable"; return 1
    end
    __orc_ok "$name_fable  claude $claude_fable"

    __orc_run herdr agent start $name_opus --kind claude --pane $p2 --timeout 60000 -- $claude_opus >/dev/null; or begin
        __orc_fail "$name_opus  claude $claude_opus"; return 1
    end
    __orc_ok "$name_opus  claude $claude_opus"

    __orc_run herdr agent start $name_codex --kind codex --pane $p3 --timeout 60000 -- $codex_args >/dev/null; or begin
        __orc_fail "$name_codex  codex $codex_args"; return 1
    end
    __orc_ok "$name_codex  codex $codex_args"

    __orc_run herdr pane run $p4 'hunk diff --watch' >/dev/null; or begin
        __orc_fail "$name_hunk  hunk diff --watch"; return 1
    end
    # hunk is a full-screen TUI; confirm it took over the pane rather than erroring out
    if not herdr pane wait-output $p4 --regex '(?i)hunk|no changes|watch' --timeout 15000 >/dev/null 2>&1
        __orc_fail "$name_hunk  hunk diff --watch (no output within 15s)"; return 1
    end
    __orc_ok "$name_hunk  hunk diff --watch"

    # ---- finish ------------------------------------------------------------
    herdr tab focus $focus_tab >/dev/null
    set -l secs (math (date +%s) - $started)
    set_color --bold; echo -n "done in $secs"s; set_color normal
    echo " → herdr agent prompt $name_fable \"...\""
end
