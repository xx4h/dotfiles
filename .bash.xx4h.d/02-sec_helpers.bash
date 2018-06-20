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
