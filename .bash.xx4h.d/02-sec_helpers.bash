# sec function helpers

# Check if HTTP method TRACE is enabled
function sec_check_http_trace_enabled() {
    host="$1"
    ssl="$2"

    if [ "$host" = "" ]; then
        echo "Usage: check_http_trace_enabled host:port [ssl]"
    return
    fi

    if [ "$ssl" != "" ]; then
        HTTP="--insecure https"
    OUTTXT="$host SSL"
    else
        HTTP="http"
    OUTTXT="$host NOSSL"
    fi

    CURLBASE="curl --connect-timeout 10 -v -X TRACE"

    OUTPUT="$($CURLBASE $HTTP://$host 2>&1 | egrep '^< HTTP/1.1')"

    if [ "$OUTPUT" = "" ]; then
            OUTRETURN="NORETURN"
    else
            OUTRETURN="$(echo $OUTPUT | awk '{print $3}')"
    fi
    echo "$OUTTXT $OUTRETURN"
}

# Return all Glue Records for given Domain
function sec_get_glue_records() {
    domain="$(echo $1 | sed 's/\.$//')"

    ns_to_ask=$(dig +short $(echo $domain | awk -F. '{print $NF}') NS|head -n1)

    dig +norec @$ns_to_ask $domain. NS | perl -lne 'print if (m(;; ADDITIONAL SECTION:) .. m(^$))' | egrep -v '^(;;.*|)$'
}

# Return certificate in fulltext from https site (no SNI)
function sec_get_fulltext_cert_nosni() {
    NAME=${1//:*}
    PORT=${1//*:}
    [ -n "$PORT" ] && PORT=443
    echo | openssl s_client -connect "${NAME}:${PORT}" 2>/dev/null | perl -lne 'if (m(^-----BEGIN.*) .. m(^-----END.*)) {print $_}' | openssl x509 -noout -text
}

# Return certificate in fulltext from https site (SNI)
function sec_get_fulltext_cert_sni() {
    NAME=${1//:*}
    PORT=${1//*:}
    [ -n "$PORT" ] && PORT=443
    echo | openssl s_client -connect "${NAME}:${PORT}" -servername "${NAME}" 2>/dev/null | perl -lne 'if (m(^-----BEGIN.*) .. m(^-----END.*)) {print $_}' | openssl x509 -noout -text
}

# Return encoded url
urlencode() {
    # urlencode <string>
    local length="${#1}"
    for (( i = 0; i < length; i++ )); do
        local c="${1:i:1}"
        case $c in
            [a-zA-Z0-9.~_-]) printf "$c" ;;
            *) printf '%%%02X' "'$c"
        esac
    done
}

# Return decoded url
function urldecode() {
    : "${*//+/ }"
    echo -e "${_//%/\\x}"
}

