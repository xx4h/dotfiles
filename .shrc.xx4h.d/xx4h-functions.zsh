function h3lp () {
    echo "Some functions:"
    echo "  xx4hBashIsSources                      | return 0 if there are sources, return 1 if there are no sources"
    echo "  xtelnet                                | telnet replacement if telnet is not installed"
    echo "  getIP / myip                           | Get current IP (whichever is prefered by your system, IPv4 or IPv6)"
    echo "  getIPv4 / myip4                        | Get current IPv4"
    echo "  getIPv6 / myip6                        | Get current IPv6"
    echo ""
    echo "Sec Helpers"

    # ugly as hell, rewrite! at least a little bit...
    grep -B 1 '^function ' ~/.shrc.xx4h.d/*-sec_helpers.sh | perl -ne 'if (m(^#) .. m(^function )) {$line++; if ( $line > 1 ) {$function = $_; chomp $function} else {$help = $_}; if ($function && $help) {$function = $1 if $function =~ /^function\s+([^(]+).*/;$help = $1 if $help =~ /^# (.*)/;printf "  %-38s | %s\n", $function, $help} } else {$line=0; $function=""; $help=""}'

    echo ""
    echo "Misc Helpers"

    # ugly as hell, rewrite! at least a little bit...
    grep -B 1 '^function ' ~/.shrc.xx4h.d/*-misc_helpers.sh | perl -ne 'if (m(^#) .. m(^function )) {$line++; if ( $line > 1 ) {$function = $_; chomp $function} else {$help = $_}; if ($function && $help) {$function = $1 if $function =~ /^function\s+([^(]+).*/;$help = $1 if $help =~ /^# (.*)/;printf "  %-38s | %s\n", $function, $help} } else {$line=0; $function=""; $help=""}'

    echo ""
    echo "Cheat Sheets"

    # ugly as hell, rewrite! at least a little bit...
    grep -B 1 '^function ' ~/.shrc.xx4h.d/*-cheatsheet-*.sh | perl -ne 'if (m(^#) .. m(^function )) {$line++; if ( $line > 1 ) {$function = $_; chomp $function} else {$help = $_}; if ($function && $help) {$function = $1 if $function =~ /^function\s+([^(]+).*/;$help = $1 if $help =~ /^# (.*)/;printf "  %-38s | %s\n", $function, $help} } else {$line=0; $function=""; $help=""}'

    echo ""
    echo "NvChad"
    echo "  - On first run, start nvim and run ':Lazy sync'"

    echo ""
    echo "tmux"
    echo "  - On first run, start tmux and run '<strg>+<space>-I'"
}
