function parse_git_branch {
    GIT_STATUS="$(~/.gitstatus.py 2>/dev/null)"
    GIT_FOLDER="$(echo "${GIT_STATUS}" | sed -n 1p)"
    GIT_BRANCH="$(echo "${GIT_STATUS}" | sed -n 2p)"
    GIT_CLEAN="$(echo "${GIT_STATUS}" | sed -n 9p)"
    if [ -n "$GIT_BRANCH" ]; then
        if [ "$GIT_CLEAN" -ne 1 ]; then
            echo '\342\224\200[\[\033[1;33m\]✗\[\033[0;36m\]]\342\224\200[\[\033[0;33m\]'"$GIT_BRANCH"'\[\033[0;36m\]]\342\224\200[\[\033[0;93m\]'"$GIT_FOLDER"'\[\033[0;31m\]]'
        else
            echo '\342\224\200[\[\033[1;32m\]✓\[\033[0;36m\]]\342\224\200[\[\033[0;33m\]'"$GIT_BRANCH"'\[\033[0;36m\]]\342\224\200[\[\033[0;93m\]'"$GIT_FOLDER"'\[\033[0;31m\]]'
        fi
    fi
}

function set_prompt() {
    PS1="\[\033[0;31m\]\342\224\214\342\224\200\$([[ \$? != 0 ]] && echo \"[\[\033[0;31m\]\342\234\227\[\033[0;36m\]]\342\224\200\")[$(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]root\[\033[01;33m\]@\[\033[01;96m\]\h'; else echo '\[\033[0;39m\]\u\[\033[01;33m\]@\[\033[01;96m\]\h'; fi)\[\033[0;31m\]]\342\224\200[\[\033[1;31m\]\j\[\033[0;31m\]]$(parse_git_branch)\342\224\200[\[\033[0;32m\]\w\[\033[0;31m\]]\n\[\033[0;31m\]\342\224\224\342\224\200\342\224\200\342\225\274 \[\033[0m\]\[\e[01;33m\]\\$\[\e[0m\]"
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
