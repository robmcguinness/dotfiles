# Open a herdr orchestration layout: orchestrator, coder, reviewer agents and
# `hunk diff --watch`.
#
# Each role runs a selectable model. The model prefix decides the CLI:
#   gpt-*     codex  -m <model> -c model_reasoning_effort=<effort>
#   claude-*  claude --model <model> --effort <effort>
#
# Selection (--select):
#   The first run opens an fzf picker for each role's model and effort.
#   Choices persist in universal variables (orc_<role>_model/_effort) and
#   later runs reuse them silently. Run `orc --select` to choose again.
#
# Layouts (--layout, default: tabs):
#   tabs  one tab per agent — orch, coder, reviewer, hunk (4 tabs)
#   grid  the original 2×2 single-tab grid
#
# Close (--close):
#   Closes every tab in the current workspace labelled "orc: <repo>…", i.e.
#   all agent tabs plus the hunk tab. Run it from any pane in that workspace.
#
#     ❯ orc --close
#     orc › dotfiles  (close)
#       ✓ closed w2:t3
#       ✓ closed w2:t4
#       ✓ closed w2:t5
#       ✓ closed w2:t6
#     closed 4/4
#
# All other args are forwarded verbatim to the claude-CLI roles.
#
#     ❯ orc --plugin-dir ~/Workspaces/rm3-claude-plugin --chrome
#     orc › dotfiles  (agent per tab)
#       ✓ preflight (herdr, jq, git, hunk, claude, codex)
#       ✓ tabs created  4/4
#       ✓ dotfiles-orch      claude --model claude-fable-5-1 --effort high --plugin-dir … --chrome
#       ✓ dotfiles-coder     claude --model claude-opus-5 --effort medium --plugin-dir … --chrome
#       ✓ dotfiles-reviewer  codex -m gpt-5.6-sol -c model_reasoning_effort=high
#       ✓ dotfiles-hunk      hunk diff --watch
#     done in 14s → herdr agent prompt dotfiles-orch "..."
#
function orc --description 'Open a herdr orc layout: orchestrator, coder, reviewer, hunk --watch (--select picks models/effort, --layout tabs|grid, --close closes them)'
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
    function __orc_pick --argument-names prompt saved --description 'fzf picker; previous choice listed first'
        set -l opts $argv[3..]
        # list the saved value first so plain Enter keeps the previous choice
        if contains -- "$saved" $opts
            set opts $saved (string match -v -- $saved $opts)
        end
        printf '%s\n' $opts | fzf --height=40% --reverse --no-multi \
            --prompt="$prompt › " --header="Enter keeps: $opts[1]"
    end

    # ---- args --------------------------------------------------------------
    # --ignore-unknown: everything that is not --layout/--select keeps flowing
    # to the claude panes untouched (e.g. --plugin-dir, --chrome).
    argparse --ignore-unknown 'layout=' select close -- $argv; or return 1
    set -l layout tabs
    set -q _flag_layout; and set layout $_flag_layout
    if not contains -- $layout tabs grid
        __orc_fail "invalid --layout '$layout' (expected: tabs, grid)"
        return 1
    end

    if not set -q HERDR_ENV
        __orc_fail 'not running inside a herdr pane'
        return 1
    end

    # ---- close -------------------------------------------------------------
    # --close: close every tab this function created for the current repo.
    # Tabs are found by the label orc wrote at create time, so both layouts
    # (tabs: "orc: <repo> · <role>", grid: "orc: <repo>") are covered. Labels
    # survive agent exit and the hunk pane never hosts an agent, so labels are
    # a more reliable handle than agent names.
    if set -q _flag_close
        for tool in herdr jq
            command -q $tool; or begin; __orc_fail "missing tool: $tool"; return 1; end
        end
        set -l root (git rev-parse --show-toplevel 2>/dev/null); or set root $PWD
        set -l repo (basename $root)
        set -l tabs (herdr tab list --workspace $HERDR_WORKSPACE_ID 2>/dev/null \
            | jq -r --arg repo $repo '.result.tabs[]
                | select(.label == "orc: \($repo)" or (.label | startswith("orc: \($repo) · ")))
                | .tab_id')
        if test (count $tabs) -eq 0
            __orc_fail "no orc tabs for '$repo' in workspace $HERDR_WORKSPACE_ID"
            return 1
        end
        set_color --bold; echo -n "orc › $repo"; set_color normal; echo '  (close)'
        set -l closed 0
        for tab in $tabs
            # never close the tab this shell is running in; report it instead
            if test "$tab" = "$HERDR_TAB_ID"
                __orc_fail "skipped $tab (current tab)"
                continue
            end
            __orc_run herdr tab close $tab >/dev/null; or begin
                __orc_fail "tab close $tab"; continue
            end
            set closed (math $closed + 1)
            __orc_ok "closed $tab"
        end
        echo "closed $closed/"(count $tabs)
        return 0
    end

    # ---- model / effort selection ------------------------------------------
    set -l orc_roles orch coder reviewer
    set -l orc_models gpt-6-astra gpt-5.6-sol gpt-5.6-terra gpt-5.6-luna \
        claude-fable-5-1 claude-opus-5 claude-haiku-4-5 claude-sonnet-5
    set -l orc_efforts low medium high
    # first-run picker defaults, matching the old hard-coded behavior
    set -l orc_default_models claude-fable-5-1 claude-opus-5 gpt-5.6-sol
    set -l orc_default_efforts high medium high

    set -l i 0
    for role in $orc_roles
        set i (math $i + 1)
        set -l mvar orc_{$role}_model
        set -l evar orc_{$role}_effort
        if set -q _flag_select; or not set -q $mvar; or not set -q $evar
            if not command -q fzf
                __orc_fail 'missing tool: fzf (needed for --select)'
                return 1
            end
            set -l saved $orc_default_models[$i]
            set -q $mvar; and set saved $$mvar
            set -l pick (__orc_pick "$role model" $saved $orc_models)
            if test -z "$pick"
                __orc_fail "selection aborted ($role model)"
                return 1
            end
            set -U $mvar $pick

            set saved $orc_default_efforts[$i]
            set -q $evar; and set saved $$evar
            set pick (__orc_pick "$role effort" $saved $orc_efforts)
            if test -z "$pick"
                __orc_fail "selection aborted ($role effort)"
                return 1
            end
            set -U $evar $pick
        end
    end

    # kind + launch args per role, derived from the model prefix
    set -l kind_orch ''; set -l args_orch
    set -l kind_coder ''; set -l args_coder
    set -l kind_reviewer ''; set -l args_reviewer
    for role in $orc_roles
        set -l mvar orc_{$role}_model
        set -l evar orc_{$role}_effort
        set -l model $$mvar
        set -l effort $$evar
        if string match -q 'gpt-*' -- $model
            set kind_$role codex
            # hunk's session CLI reaches the daemon over loopback HTTP (127.0.0.1);
            # codex's default workspace-write sandbox denies all network, so without
            # this the role sees "No active Hunk sessions" for a live session.
            set args_$role -m $model -c model_reasoning_effort=$effort \
                -c sandbox_workspace_write.network_access=true
        else
            set kind_$role claude
            set args_$role --model $model --effort $effort $argv
        end
    end

    # ---- preflight ---------------------------------------------------------
    set -l tools herdr jq git hunk
    contains -- claude $kind_orch $kind_coder $kind_reviewer; and set -a tools claude
    contains -- codex $kind_orch $kind_coder $kind_reviewer; and set -a tools codex
    set -l missing
    for tool in $tools
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
    # 20 leaves room for the longest role suffix (-reviewer-N) inside 32 chars
    set base (string sub -l 20 -- $base | string trim -c '-')
    set -l live (herdr agent list 2>/dev/null | jq -r '.result.agents[].name // empty')

    set -l names
    for role in $orc_roles
        set -l name "$base-$role"
        set -l n 1
        while contains -- $name $live
            set n (math $n + 1)
            set name "$base-$role-$n"
        end
        set -a names $name
        set -a live $name
    end
    set -l name_orch $names[1]
    set -l name_coder $names[2]
    set -l name_reviewer $names[3]
    set -l name_hunk "$base-hunk"

    set -l layout_label '  (agent per tab)'
    test $layout = grid; and set layout_label '  (2×2 herdr grid)'
    set_color --bold; echo -n "orc › $repo"; set_color normal; echo $layout_label
    __orc_ok "preflight ("(string join ', ' $tools)")"

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
        for role in $orc_roles hunk
            set -l json (__orc_run herdr tab create --cwd $PWD --label "orc: $repo · $role" --no-focus); or begin
                __orc_fail "tab create ($role)"; return 1
            end
            set -a panes (printf '%s\n' $json | jq -r '.result.root_pane.pane_id')
            # focus lands back on the orchestrator so the user starts there
            test $role = orch; and set focus_tab (printf '%s\n' $json | jq -r '.result.tab.tab_id')
        end
        set p1 $panes[1]; set p2 $panes[2]; set p3 $panes[3]; set p4 $panes[4]
    end

    herdr pane rename $p1 $name_orch >/dev/null
    herdr pane rename $p2 $name_coder >/dev/null
    herdr pane rename $p3 $name_reviewer >/dev/null
    herdr pane rename $p4 $name_hunk >/dev/null
    if test $layout = grid
        __orc_ok 'panes split  4/4'
    else
        __orc_ok 'tabs created  4/4'
    end

    # ---- launch ------------------------------------------------------------
    __orc_run herdr agent start $name_orch --kind $kind_orch --pane $p1 --timeout 60000 -- $args_orch >/dev/null; or begin
        __orc_fail "$name_orch  $kind_orch $args_orch"; return 1
    end
    __orc_ok "$name_orch  $kind_orch $args_orch"

    __orc_run herdr agent start $name_coder --kind $kind_coder --pane $p2 --timeout 60000 -- $args_coder >/dev/null; or begin
        __orc_fail "$name_coder  $kind_coder $args_coder"; return 1
    end
    __orc_ok "$name_coder  $kind_coder $args_coder"

    __orc_run herdr agent start $name_reviewer --kind $kind_reviewer --pane $p3 --timeout 60000 -- $args_reviewer >/dev/null; or begin
        __orc_fail "$name_reviewer  $kind_reviewer $args_reviewer"; return 1
    end
    __orc_ok "$name_reviewer  $kind_reviewer $args_reviewer"

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
    echo " → herdr agent prompt $name_orch \"...\""
end
