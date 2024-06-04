function parse_git_branch {
    [ "${XX4H_DISABLE_GIT_PARSE}" = "1" ] && return
    GIT_ROOTPATH="$(git rev-parse --show-toplevel 2>/dev/null)"
    if [ $? -ne 0 ]; then
      return
    fi
    [ "${XX4H_DISABLE_GIT_PARSE_USER_HOME}" = "1" ] && [ "${GIT_ROOTPATH}" = "$HOME" ] && return
    GIT_STATUS="$(~/.gitstatus.py 2>/dev/null)"
    GIT_FOLDER="$(echo "${GIT_STATUS}" | sed -n 1p)"
    GIT_BRANCH="$(echo "${GIT_STATUS}" | sed -n 2p)"
    GIT_CLEAN="$(echo "${GIT_STATUS}" | sed -n 9p)"
    if [ -n "$GIT_BRANCH" ]; then
        if [ "$GIT_CLEAN" -ne 1 ]; then
            echo '\[\033[0;36m\]\342\224\200[\[\033[1;33m\]✗\[\033[0;36m\]]\342\224\200[\[\033[0;33m\]'"$GIT_BRANCH"'\[\033[0;36m\]]\342\224\200[\[\033[0;93m\]'"$GIT_FOLDER"'\[\033[0;36m\]]'
        else
            echo '\[\033[0;36m\]\342\224\200[\[\033[1;32m\]✓\[\033[0;36m\]]\342\224\200[\[\033[0;33m\]'"$GIT_BRANCH"'\[\033[0;36m\]]\342\224\200[\[\033[0;93m\]'"$GIT_FOLDER"'\[\033[0;36m\]]'
        fi
    fi
}

function parse_kubernetes {
    [ "${XX4H_DISABLE_KUBERNETES_PARSE}" = "1" ] && return
    if [ -f ~/.kube/config ]; then
        kuber_context="$(grep -E '^current-context: ' ~/.kube/config | awk '{print $2}')"
    fi
    [[ -n "$kuber_context" ]] && echo '\[\e[34m\]\342\224\200[\[\033[0;93m\]kube\[\e[34m\]]\342\224\200[\[\033[0;94m\]'"$kuber_context"'\]\[\e[34m\]]'
}

# Thanks to https://stackoverflow.com/questions/10406926/how-do-i-change-the-default-virtualenv-prompt
function parse_virtualenv {
    [ "${XX4H_DISABLE_VIRTUALENV_PARSE}" = "1" ] && return
    # Get Virtual Env
    if [[ -n "$VIRTUAL_ENV" ]]; then
        # Strip out the path and just leave the env name
        venv="${VIRTUAL_ENV##*/}"
    else
        # In case you don't have one activated
        venv=''
    fi
    [[ -n "$venv" ]] && echo '\[\e[34m\]\342\224\200[\[\033[0;93m\]venv\[\e[34m\]]\342\224\200[\[\033[0;94m\]'"$venv"'\]\[\e[34m\]]'
}

function parse_nodeenv {
    [ "${XX4H_DISABLE_NODEENV_PARSE}" = "1" ] && return
    # Get nodeenv
    if [[ -n "$NODE_VIRTUAL_ENV" ]]; then
        # Strip out the path and just leave the env name
        nenv="${NODE_VIRTUAL_ENV##*/}"
    else
        # In case you don't have one activated
        nenv=''
    fi
    [[ -n "$nenv" ]] && echo '\[\e[34m\]\342\224\200[\[\033[0;93m\]nenv\[\e[34m\]]\342\224\200[\[\033[0;94m\]'"$nenv"'\]\[\e[34m\]]'
}

function set_prompt() {
    # ┌─ with [✗]─ if exit code of last line was != 0 AND [ at the end (colored red if exit code == 0, cyan if not)
    PS1="${RED}\342\224\214\342\224\200\$([[ $? != 0 ]] && echo \"[${RED}\342\234\227${CYAN}]\342\224\200\")["
    # USER@HOSTNAME (user in default color, if root, user red)
    if [[ ${EUID} == 0 ]]; then
        PS1="${PS1}${TEXT_BOLD}${RED}root${LIGHT_YELLOW}@${LIGHT_CYAN}\h${COLOR_NONE}"
    else
        PS1="${PS1}${TEXT_BOLD}${DEFAULT_COLOR}\u${LIGHT_YELLOW}@${LIGHT_CYAN}\h${COLOR_NONE}"
    fi
    # ─[0] while 0 is the count of background jobs in the current shell
    PS1="${PS1}${RED}]\342\224\200[${TEXT_BOLD}\j${COLOR_NONE}${RED}]"
    # ─[✗]─[BRANCH]─[GIT_BASE_FOLDER]─[~] (if current path is in git) or ─[~] AND a new line, which creates the two-line PS1
    PS1="${PS1}$(parse_virtualenv)$(parse_nodeenv)$(parse_kubernetes)$(parse_git_branch)${RED}\342\224\200[${GREEN}\w${RED}]\n"
    # └──╼ $
    PS1="${PS1}${RED}\342\224\224\342\224\200\342\224\200\342\225\274 ${COLOR_NONE}${LIGHT_YELLOW}\\$ ${COLOR_NONE}"
}

if [ "$color_prompt" = yes ]; then
    PROMPT_COMMAND=set_prompt
else
    case "$TERM" in
    xterm*|rxvt*|screen-256color*)
        PROMPT_COMMAND=set_prompt
        ;;
    *)
        PS1='┌──[\u@\h]─[\w]\n└──╼ \$ '
        ;;
    esac
fi
unset color_prompt force_color_prompt


# If not running interactively, don't do anything
[ -z "$PS1" ] && return
