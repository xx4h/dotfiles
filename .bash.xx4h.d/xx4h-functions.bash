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

function xx4hBashStartDebug() {
    if [ -f ~/.bashrc.debug ]; then
        echo "Debug alread enabled. (~/.bashrc.debug exists)"
    else
        touch ~/.bashrc.debug
    fi
}

alias xx4hBashStartProfiling=xx4hBashStartDebug

function xx4hBashStopDebug() {
    if [ -f ~/.bashrc.debug ]; then
        rm ~/.bashrc.debug
    else
        echo "Debug alread disabled. (~/.bashrc.debug does NOT exist)"
    fi
}

alias xx4hBashStopProfiling=xx4hBashStopDebug

# print all 256 colors
#  thanks to: https://misc.flogisoft.com/bash/tip_colors_and_formatting
function xx4hBashGet256Colors() {
    # This program is free software. It comes without any warranty, to
    # the extent permitted by applicable law. You can redistribute it
    # and/or modify it under the terms of the Do What The Fuck You Want
    # To Public License, Version 2, as published by Sam Hocevar. See
    # http://sam.zoy.org/wtfpl/COPYING for more details.

    for fgbg in 38 48 ; do # Foreground / Background
        for color in {0..255} ; do # Colors
            # Display the color
            printf "\e[${fgbg};5;%sm  %3s  \e[0m" $color $color
            # Display 6 colors per lines
            if [ $((($color + 1) % 6)) == 4 ] ; then
                echo # New line
            fi
        done
        echo # New line
    done
}

function xx4hBashGetSourceOrder() {
    xx4hBashIsSources && ls -1 ~/.bashrc.d/*.bash || echo "No .bash files to source in ~/.bashrc.d"
}

function h3lp () {
    echo "Some tools:"
    echo "  xx4hBashGetSourceOrder                 | List source order of .bash files"
    echo "  xx4hBashStartDebug                     | Enable profiling and debug for bash startup"
    echo "  xx4hBashStartProfiling                 | Enable profiling and debug for bash startup (same es xx4hBashStartDebug)"
    echo "  xx4hBashStopDebug                      | Disable profiling and debug for bash startup"
    echo "  xx4hBashStopProfiling                  | Disable profiling and debug for bash startup (same es xx4hBashStopDebug)"
    echo ""
    echo "Some functions:"
    echo "  xx4hBashIsSources                      | return 0 if there are sources, return 1 if there are no sources"
    echo ""
}
