# xx4h bashrc
## Getting started
Just add the following at the end of your `.bashrc`
```
source ~/.xx4h.bash
```

## How it works
xx4h bashrc comes with some extra features and helpers bultin, as well as a custom PS1.

While it already provides the following features (for more details see Features section below):
- Custom PS1
- Helper Functions
- Cheatsheets

It is also supposed to support you in easily extend the functionality without moving away from
the upstream repository and eventually added features and helpers in the future.
To achieve this, xx4h bashrc is sourcing `.bash` files from two locations.
```
# before xx4h bashrc functionality is sourced
~/.pre.bashrc.d

# after xx4h bashrc functionality is sourced
~/.bashrc.d
```

the folders do not have to exist and are not part of the repository.

## Features

### Custom PS1
xx4h bashrc comes with a two-line PS1, initially inspired by ParrotOS, providing integrations for:
- bash background jobs
- identifier for exit != 0
- identifier for active virtualenv
- identifier for active nodeenv
- identifier for current git repository, including branch, changes indicator
- identifier for active kubernetes context

Most of the features above can be deactivated through environment variables:
```
# disable git PS1 parse 
export XX4H_DISABLE_GIT_PARSE=1
# disable kubernetes PS1 parse
export XX4H_DISABLE_KUBERNETES_PARSE=1
# disable virtualenv PS1 parse
export XX4H_DISABLE_VIRTUALENV_PARSE=1
# disable nodeenv PS1 parse
export XX4H_DISABLE_NODEENV_PARSE=1
```

### Helper Functions
#### Some tools
```
  xx4hBashGetSourceOrder                 | List source order of .bash files
  xx4hBashStartDebug                     | Enable profiling and debug for bash startup
  xx4hBashStartProfiling                 | Enable profiling and debug for bash startup (same es xx4hBashStartDebug)
  xx4hBashStopDebug                      | Disable profiling and debug for bash startup
  xx4hBashStopProfiling                  | Disable profiling and debug for bash startup (same es xx4hBashStopDebug)
  xx4hBashGet256Colors                   | Get all 256 bash colors
  xx4hBashReload                         | Reload ~/.bashrc (re-source)
```

#### Some functions
```
  xx4hBashIsSources                      | return 0 if there are sources, return 1 if there are no sources
  xtelnet                                | telnet replacement if telnet is not installed
  getIP / myip                           | Get current IP (whichever is prefered by your system, IPv4 or IPv6)
  getIPv4 / myip4                        | Get current IPv4
  getIPv6 / myip6                        | Get current IPv6
```

#### Sec Helpers
```
  sec_check_http_trace_enabled           | Check if HTTP method TRACE is enabled
  sec_get_glue_records                   | Return all Glue Records for given Domain
  sec_get_fulltext_cert_nosni            | Return certificate in fulltext from https site (no SNI)
  sec_get_fulltext_cert_sni              | Return certificate in fulltext from https site (SNI)
  sec_get_given_net_online_hosts         | Get a list of all online hosts in the given net
  sec_verify_cert_key                    | Verfiy that private key matches a certificate
  sec_verify_cert_ca                     | Verify that certificate matches CA
```

#### Misc Helpers
```
  add                                    | Returns summary of all lines (default column 1)
  urlencode                              | Return encoded url
  urldecode                              | Return decoded url
  pjson                                  | Pretty print json
  video2gif                              | Video to gif
  3pointmen                              | 3-Point Fatcalc Men
  check_ipv6_ip_ipv6_net                 | check if ipv6 ip is in ipv6 network
  kubernetes_delete_namespace_finalizer  | force delete kubernetes namespace hanging in finalizer
  git_clean_reset_sub_recursive          | clean and reset git repo with recursive submodules
```
