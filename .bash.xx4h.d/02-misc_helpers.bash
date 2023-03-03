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

# alembic python3
alias alembic3='python -m alembic.config'

# thanks to https://stackoverflow.com/a/10525920/1922402
# Video to gif
function video2gif() {
    if [ -z "$1" -o -z "$2" ]; then
        echo "Usage: video2gif /path/to/video /path/to/output.gif"
        return
    fi

    if which ffmpeg 1>/dev/null; then
        CMD="ffmpeg"
    elif which avconv 1>/dev/null; then
        CMD="avconv"
    else
        echo "We need either ffmpeg or avconv..."
        return
    fi
    if ! which gifsicle 1>/dev/null; then
        echo "We need gifsicle..."
        return
    fi

    CONVDIR=`mktemp -d -t video2gif_XXXXXXXXXXXXX`
    $CMD -i "$1" -t 10 "$CONVDIR/out%02d.gif"
    gifsicle --delay=10 --loop "$CONVDIR"/*.gif > "$2"
    rm -f "$CONVDIR/*.gif"
    rm -r "$CONVDIR"
}

# 3-Point Fatcalc Men
function 3pointmen() {
    if [ -z "$1" ] || ( [ -z "$2" ] || [ -z "$3" ] || [ -z "$4" ] ); then
        echo "Usage: 3pointmen AGE BELLY BREAST LEG"
    else
        age="$1"
        sum="$(( $2 + $3 + $4 ))"
        python -c "print( ((4.95/( 1.10938 - (0.0008267 * $sum) + (0.0000016 * $sum**2) - (0.0002574 * $age))) - 4.5) * 100)"
    fi
}

# check if ipv6 ip is in ipv6 network
function check_ipv6_ip_ipv6_net() {
    python -c "import ipaddress; print(ipaddress.ip_address('$1') in ipaddress.ip_network('$2'))"
}
