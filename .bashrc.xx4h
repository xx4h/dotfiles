# xx4h bashrc
# use .bash files .bashrc.d

## begin inline settings

# thanks to:
#   https://stackoverflow.com/questions/5014823/how-to-profile-a-bash-shell-script-slow-startup?answertab=votes#tab-top
if [ -f ~/.bashrc.debug ]; then
    PS4='+ $(date "+%s.%N")\011 '
    exec 3>&2 2>/tmp/bashstart.$$.log
    set -x
fi

# deactivate terminal signal
#setterm -bfreq 0

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

# source pre.bashrc.d
for rc_file in ~/.pre.bashrc.d/*.bash; do
    if ! [[ "$rc_file" =~ \*\.bash$ ]]; then
        . "$rc_file"
    fi
done

# source xx4h bash stuff
for rc_file in ~/.bash.xx4h.d/*.bash; do
    if ! [[ "$rc_file" =~ \*\.bash$ ]]; then
        . "$rc_file"
    fi
done

for rc_file in ~/.bashrc.d/*.bash; do
    if ! [[ "$rc_file" =~ \*\.bash$ ]]; then
        . "$rc_file"
    fi
done

if [ -f ~/.bashrc.debug ]; then
    set +x
    exec 2>&3 3>&-
fi

## end inline settings
