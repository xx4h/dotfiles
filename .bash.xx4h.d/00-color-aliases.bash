# Escape Opening Foreground/Background ; 5 (just a static, idk) ; 256 colors color + m at the end
# \e     [       38/48                 ; 5                      ; 11m
#
# always remove all spaces from the above code
# use xx4hBashGet256Colors to get the color codes for the above example
LIGHT_YELLOW="\[\033[38;5;190m\]"
YELLOW="\[\033[38;5;220m\]"

RED="\[\033[31m\]"
GREEN="\[\033[32m\]"
BOLD_GREEN="\[\033[1;32m\]"
ORANGE="\[\e[0;33m\]"
BOLD_ORANGE="\[\e[1;33m\]"
BLUE="\[\033[34m\]"
LIGHT_GRAY="\[\033[37m\]"
LIGHT_BLUE="\[\033[94m\]"
LIGHT_CYAN="\[\033[96m\]"
WHITE="\[\033[37m\]"
CYAN="\[\033[36m\]"

bgreen="\[\e[1;32m\]"
yellow="\[\e[0;93m\]"
lblue="\[\e[0;94m\]"


COLOR_NONE="\[\033[0m\]"
DEFAULT_COLOR="\[\033[39m\]"

BOLD="\[\e[1m\]"

show_colour() {
    perl -e 'foreach $a(@ARGV){print "\e[48;2;".join(";",unpack("C*",pack("H*",$a)))."m         \e[49m "};print "\n"' "$@"
}
