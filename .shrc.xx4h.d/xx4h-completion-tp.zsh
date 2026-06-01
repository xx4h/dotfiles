# Completion for `tp` (see 02-misc_helpers.sh)
# Projects = directories under ${XDG_DATA_HOME:-$HOME/.local/share}/tmux-project/
_tp() {
    local base="${XDG_DATA_HOME:-$HOME/.local/share}/tmux-project"
    local -a projects
    if [[ -d $base ]]; then
        projects=( "$base"/*(N/:t) )
    fi

    if (( CURRENT == 2 )); then
        _alternative \
            'projects:project:compadd -a projects' \
            'options:option:((
                -l\:"list\ all"
                --list\:"list\ all"
                -r\:"list\ running"
                --running\:"list\ running"
                -a\:"list\ attached"
                --attached\:"list\ attached"
                -d\:"list\ detached"
                --detached\:"list\ detached"
                -s\:"list\ stopped"
                --stopped\:"list\ stopped"
                -S\:"save\ and\ stop"
                --stop\:"save\ and\ stop"
                -h\:"help"
                --help\:"help"
            ))'
    elif (( CURRENT == 3 )); then
        # `tp -S/--stop PROJECT` — complete project names (plus --all)
        if [[ ${words[2]} == -S || ${words[2]} == --stop ]]; then
            _alternative \
                'projects:project:compadd -a projects' \
                'options:option:((--all\:"stop\ all\ running"))'
        else
            _path_files -/
        fi
    fi
}
compdef _tp tp
