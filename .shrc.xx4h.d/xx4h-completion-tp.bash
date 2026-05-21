# Completion for `tp` (see 02-misc_helpers.sh)
# Projects = directories under ${XDG_DATA_HOME:-$HOME/.local/share}/tmux-project/
_tp_complete() {
    local cur="${COMP_WORDS[COMP_CWORD]}"
    local base="${XDG_DATA_HOME:-$HOME/.local/share}/tmux-project"
    local opts="-l --list -r --running -a --attached -d --detached -s --stopped -h --help"

    case $COMP_CWORD in
        1)
            if [[ $cur == -* ]]; then
                COMPREPLY=( $(compgen -W "$opts" -- "$cur") )
                return
            fi
            local projects=()
            if [ -d "$base" ]; then
                local dir name
                for dir in "$base"/*/; do
                    [ -d "$dir" ] || continue
                    name="${dir%/}"
                    projects+=( "${name##*/}" )
                done
            fi
            COMPREPLY=( $(compgen -W "${projects[*]}" -- "$cur") )
            ;;
        2)
            # WORKDIR — directory completion
            COMPREPLY=( $(compgen -d -- "$cur") )
            ;;
    esac
}
complete -F _tp_complete tp
