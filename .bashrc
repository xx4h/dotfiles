# xx4h bashrc
# use .bash files .bashrc.d

## begin xx4hBash helpers ##

function xx4hBashIsSources() {
    if [ -d ~/.bashrc.d ]; then
        ls ~/.bashrc.d/*.bash 2>/dev/null 1>/dev/null
        if [ $? -ne 0 ]; then
            return 1
        else
            return 0
        fi
    else
        return 1
    fi
}

xx4hBashIsSources && for extension in ~/.bashrc.d/*.bash; do source $extension; done

function xx4hBashGetSourceOrder() {
    xx4hBashIsSources && ls -1 ~/.bashrc.d/*.bash || echo "No .bash files to source in ~/.bashrc.d"
}

function h3lp () {
    echo "Some tools:"
    echo "  xx4hBashGetSourceOrder                 | List source order of .bash files"
    echo ""
    echo "Some functions:"
    echo "  xx4hBashIsSources                      | return 0 if there are sources, return 1 if there are no sources"
}

## end xx4hBash helpers ##

## begin inline settings

LIGHT_GRAY="\[\033[0;37m\]"
LIGHT_PURPLE="\[\033[1;34m\]"
YELLOW="\[\033[0;33m\]"
WHITE="\[\033[1;37m\]"
CYAN="\[\e[1;36m\]"
RED="\[\e[0;31m\]"
COLOR_NONE="\[\e[0m\]"

# Set the values for some environment variables:
VISUAL=vim
EDITOR=vim
QUILT_PATCHES="debian/patches"
export VISUAL EDITOR QUILT_PATCHES

# deactivate terminal signal
#setterm -bfreq 0

# Set up the LS_COLORS and LS_OPTIONS environment variables for color ls:
if [ "$SHELL" = "/bin/zsh" ]; then
eval `dircolors -z`
elif [ "$SHELL" = "/bin/ash" ]; then
eval `dircolors -s`
else
eval `dircolors -b`
fi

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
    PS1='┌──[\u@\h]─[\w]\n└──╼ \$ '
fi
unset color_prompt force_color_prompt

case "$TERM" in
xterm*|rxvt*|screen-256color*)
    PROMPT_COMMAND=set_prompt
    ;;
*)
    ;;
esac

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=999999
HISTFILESIZE=999999

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

PATH=$PATH:~/bin:/home/linux-ag/bin
export PATH DISPLAY LESS TERM PS1 PS2

## end inline settings
