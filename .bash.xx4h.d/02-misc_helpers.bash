# Misc Helpers

# Returns summary of all lines (default column 1)
function add () {
    COLUMN=${1:-1}
    if ! [[ $COLUMN =~ ^[0-9]+$ ]]; then
        echo "Column needs to be a number!"
        exit
    fi
    # maybe add version which prints all lines and sum=
    # awk '{sum+=$'$COLUMN' ; print $0} END{print "sum=",sum}'
    awk '{sum+=$'$COLUMN'} END{print sum}'
}

# Return encoded url
function urlencode() {
    # urlencode <string>
    local length="${#1}"
    for (( i = 0; i < length; i++ )); do
        local c="${1:i:1}"
        case $c in
            [a-zA-Z0-9.~_-]) printf "$c" ;;
            *) printf '%%%02X' "'$c"
        esac
    done
    echo
}

# Return decoded url
function urldecode() {
    : "${*//+/ }"
    echo -e "${_//%/\\x}"
}

# Pretty print json
function pjson() {
          python -m json.tool
}

