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

    OUTPUT="$($CURLBASE $HTTP://$host 2>&1 | grep -E '^< HTTP/1.1')"

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

    dig +norec @$ns_to_ask $domain. NS | perl -lne 'print if (m(;; ADDITIONAL SECTION:) .. m(^$))' | grep -Ev '^(;;.*|)$'
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

# Get a list of all online hosts in the given net
function sec_get_given_net_online_hosts() {
    nmap -n -sn $1 -oG - | awk '/Up$/{print $2}'
}

# Verfiy that private key matches a certificate
function sec_verify_cert_key() {
    CERT=`openssl x509 -noout -modulus -in "$1" | sha256sum`
    KEY=`openssl rsa -noout -modulus -in "$2" | sha256sum`
    if [ "$CERT" == "$KEY" ]; then
        echo "Match"
    else
        echo "No Match"
    fi
}

# Verify that certificate matches CA
function sec_verify_cert_ca() {
    openssl verify -CAfile "$2" "$1"
}
