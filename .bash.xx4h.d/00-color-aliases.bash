# Escape Opening Foreground/Background ; 5 (just a static, idk) ; 256 colors color + m at the end
# \e     [       38/48                 ; 5                      ; 11m
#
# always remove all spaces from the above code
# use xx4hBashGet256Colors to get the color codes for the above example

LIGHT_GRAY="\e[37m"
LIGHT_PURPLE="\e[34m"
LIGHT_YELLOW="\e[38;5;190m"
LIGHT_CYAN="\e[96m"
YELLOW="\e[38;5;220m"
WHITE="\e[37m"
GREEN="\e[32m"
CYAN="\e[36m"
RED="\e[31m"
COLOR_NONE="\e[0m"
DEFAULT_COLOR="\e[39m"

TEXT_BOLD="\e[1m"
