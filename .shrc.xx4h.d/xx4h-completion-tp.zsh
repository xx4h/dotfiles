# Completion for `tp` (see 02-misc_helpers.sh)
# Projects = directories under ${XDG_DATA_HOME:-$HOME/.local/share}/tmux-project/
_tp() {
    local base="${XDG_DATA_HOME:-$HOME/.local/share}/tmux-project"

    if (( CURRENT == 2 )); then
        local -a projects
        if [[ -d $base ]]; then
            projects=( "$base"/*(N/:t) )
        fi
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
                -h\:"help"
                --help\:"help"
            ))'
    elif (( CURRENT == 3 )); then
        _path_files -/
    fi
}
compdef _tp tp
