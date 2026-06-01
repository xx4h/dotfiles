# Completion for `tp` (see 02-misc_helpers.sh)
# Projects = directories under ${XDG_DATA_HOME:-$HOME/.local/share}/tmux-project/
_tp_complete() {
    local cur="${COMP_WORDS[COMP_CWORD]}"
    local base="${XDG_DATA_HOME:-$HOME/.local/share}/tmux-project"
    local opts="-l --list -r --running -a --attached -d --detached -s --stopped -S --stop -h --help"

    # Collect project names from the data dir.
    local projects=()
    if [ -d "$base" ]; then
        local dir name
        for dir in "$base"/*/; do
            [ -d "$dir" ] || continue
            name="${dir%/}"
            projects+=( "${name##*/}" )
        done
    fi

    case $COMP_CWORD in
        1)
            if [[ $cur == -* ]]; then
                COMPREPLY=( $(compgen -W "$opts" -- "$cur") )
                return
            fi
            COMPREPLY=( $(compgen -W "${projects[*]}" -- "$cur") )
            ;;
        2)
            # `tp -S/--stop PROJECT` — complete project names (plus --all)
            if [[ ${COMP_WORDS[1]} == -S || ${COMP_WORDS[1]} == --stop ]]; then
                COMPREPLY=( $(compgen -W "--all ${projects[*]}" -- "$cur") )
                return
            fi
            # `tp PROJECT WORKDIR` — directory completion
            COMPREPLY=( $(compgen -d -- "$cur") )
            ;;
    esac
}
complete -F _tp_complete tp
