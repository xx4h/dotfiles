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
