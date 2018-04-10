# xx4h bashrc
# use .bash files .bashrc.d

## begin inline settings

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

## end inline settings
