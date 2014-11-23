
function git_current_branch() {
    ref=$(git symbolic-ref HEAD 2> /dev/null) || \
    ref=$(git rev-parse --short HEAD 2> /dev/null) || return
    echo ${ref#refs/heads/}
}

function git_status_is_clean() {
    lines=$(git status --porcelain | egrep -v '^\?\? ' | wc -l)
    test $lines = 0
}

function git_unknown_files() {
    lines=$(git status --porcelain | egrep '^\?\? ' | wc -l)
    test $lines = 0
}

function git_stash_is_clean() {
    lines=$(git stash list | wc -l)
    test $lines = 0
}

function git_no_branches() {
    lines=$(git branch | wc -l)
    test $lines = 1
}

function git_single_remote() {
    lines=$(git remote | wc -l)
    test $lines -le 1
}

function git_no_remote() {
    lines=$(git remote | wc -l)
    test $lines = 0
}

function git_branch_is_pushed() {
    git_no_remote || git diff-tree --quiet origin/master heads/master
}

#-----------------------------------------------------------------------------

function git_prompt_precmd() {
    if [ -z `git_current_branch` ]; then
        GITINFO=""
    else
        GITINFO=" [`git_current_branch`"
        if ! git_status_is_clean; then
            GITINFO="$GITINFO*"
        fi
        if ! git_unknown_files; then
            GITINFO="${GITINFO}?"
        fi
        if ! git_branch_is_pushed; then
            GITINFO="$GITINFO➚"
        fi
        if ! git_stash_is_clean; then
            GITINFO="$GITINFO☰"
        fi
        if ! git_no_branches; then
            GITINFO="$GITINFO⌥"
        fi
        if ! git_single_remote; then
            GITINFO="$GITINFO®"
        fi
        GITINFO="$GITINFO]"
    fi
    echo $GITINFO
}

