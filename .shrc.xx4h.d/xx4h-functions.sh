function xtelnet() {
    ( echo "import telnetlib"
      echo "try:"
      echo "    telnetlib.Telnet('$1', $2, 2)"
      echo "    print('Reachable.')"
      echo "except:"
      echo "    print('Unreachable.')"
    ) | python
}

## prepare for getIP/getIPv4/getIPv6
GET_IP_URL="https://ip.secu.re.it"
GET_IP_CMD="curl -s $GET_IP_URL"

function getIP() {
    $GET_IP_CMD
}
alias myip='getIP'

function getIPv4() {
    $GET_IP_CMD -4 2>/dev/null || echo "You don't have an IPv4?!?"
}
alias myip4='getIPv4'

function getIPv6() {
    $GET_IP_CMD -6 2>/dev/null || echo "You don't have an IPv6?!?"
}
alias myip6='getIPv6'
