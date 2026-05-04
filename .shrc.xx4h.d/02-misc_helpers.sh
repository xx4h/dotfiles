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

# activate venv (order: ~/.venv, ~/.virtualenvs)
function venv() {
    local venv
    local venv_dirs
    venv_dirs="$HOME/.venv $HOME/.virtualenvs"
    if [ -z "$1" ]; then
      echo "Usage: venv NAME"
      return
    fi
    venv=$1
    for dir in $venv_dirs; do
      if [ -d "$dir/$venv" ]; then
        activate="$dir/$venv/bin/activate"
        if [ -f "$activate" ]; then
          echo "Enabling VirtualEnv $dir/$venv"
          source "$activate"
        else
          echo "Found VirtualEnv $dir/$venv, but no bin/activate"
          return
        fi
      fi
    done
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

# force delete kubernetes namespace hanging in finalizer
function kubernetes_delete_namespace_finalizer() {
  namespace="$1"
  cat <<EOF | curl -X PUT localhost:8001/api/v1/namespaces/${namespace}/finalize -H "Content-Type: application/json" --data-binary @-
{
  "kind": "Namespace",
  "apiVersion": "v1",
  "metadata": {
    "name": "${namespace}"
  },
  "spec": {
    "finalizers": null
  }
}
EOF
}

function _nix_shell_info() {
  if [ -n "${IN_NIX_SHELL}" ]; then
    echo "${IN_NIX_SHELL}"
  else
    echo $PATH | awk 'BEGIN{RS=":"} /\/nix\/store\//{sub(/\/nix\/store\/[^-]*-/,""); sub(/-[0-9].*/,""); printf sep$0; sep=","} END{if(sep)print ""}'
  fi
}

# oh my posh Helper
function set_poshcontext() {
  POSH_IN_NIX_SHELL=$IN_NIX_SHELL
  POSH_NIX_SHELL_INFO=$(_nix_shell_info)

  export POSH_IN_NIX_SHELL POSH_NIX_SHELL_INFO
}

# clean and reset git repo with recursive submodules
function git_clean_reset_sub_recursive() {
  git clean -xfd
  git submodule foreach --recursive git clean -xfd
  git reset --hard
  git submodule foreach --recursive git reset --hard
  git submodule update --init --recursive
}

function _xx4h_asdf_manage() {
  local tool
  local version
  local location
  local plugin_list
  local local_plugin_list
  local found

  location=$1
  tool=$2
  version=${3:-latest}
  found=no

  local_plugin_list=$(asdf plugin list)
  while read -r plugin; do
    read -r name repo <<<"$plugin"
    if [ "$name" = "$tool" ]; then
      found=yes
      asdf plugin add "$name" "$repo"
      asdf install "$name" "$version"
      asdf set "$location" "$name" "$version"
      break
    fi
  done <<<"$local_plugin_list"

  if [ "$found" = "no" ]; then
    plugin_list=$(asdf plugin list all)

    while read -r plugin; do
      read -r name repo <<<"$plugin"
      if [ "$name" = "$tool" ]; then
        found=yes
        asdf plugin add "$name" "$repo"
        asdf install "$name" "$version"
        asdf set "$location" "$name" "$version"
        break
      fi
    done <<<"$plugin_list"
  fi

  if [ "$found" = "no" ]; then
    echo "Tool $tool not found."
    while read -r plugin; do
      echo "Did you mean:"
      echo "  $plugin"
    done < <(echo "$plugin_list" | grep -E "^[^[:space:]]*${tool}[^[:space:]]* .*")
  fi
}

function _xx4h_asdf_plugin() {
  while read -r plugin; do
    if asdf plugin add "$plugin" >/dev/null 2>&1; then
      echo "Plugin successfully installed: $plugin"
    else
      echo "Plugin could not be installed: $plugin"
    fi
  done < <(awk '{ print $1 }' ~/.tool-versions)
}

function _xx4h_asdf_plugin_search() {
  tool=$1
  asdf plugin list all | grep -E "^[^[:space:]]*${tool}[^[:space:]]*"
}

function _xx4h_asdf_manage_set_home() {
  _xx4h_asdf_manage "--home" "$@"
}

function _xx4h_asdf_manage_set() {
  _xx4h_asdf_manage "" "$@"
}

function _xx4h_asdf_help() {
  echo "Help for asdf xx4h patched sub commands:"
  echo "  asdf set user [latest|VERSION]         | add plugin, install version and set user global version"
  echo "  asdf set [latest|VERSION]              | add plugin, install version and set local version"
  echo "  asdf search SEARCH                     | search for plugin"
  echo "  asdf plugin                           | install all plugins for global .tool-versions"
  echo "  asdf xhelp                             | this help"
}

# Wrapper function for asdf, adding some additional functions, see "xasdf xhelp" for details
# tmux project session manager
# Data stored in ${XDG_DATA_HOME:-$HOME/.local/share}/tmux-project/
function tp() {
    local base_dir="${XDG_DATA_HOME:-$HOME/.local/share}/tmux-project"
    local socket_dir="/tmp/tmux-$(id -u)"

    # Helper: list project sessions with optional state filter
    _tp_list() {
        local filter="${1:-all}"  # all, running, attached, detached, stopped
        local running_projects=()

        # Find running project sockets
        if [ -d "$socket_dir" ]; then
            for sock in "$socket_dir"/project-*; do
                [ -S "$sock" ] || continue
                local name="${sock##*/project-}"
                running_projects+=("$name")
                local state
                state=$(tmux -L "project-${name}" list-sessions -F '#{session_attached}' 2>/dev/null)
                case "$filter" in
                    running|all)  printf "%-20s %s\n" "$name" "$([ "$state" = "1" ] && echo "attached" || echo "detached")" ;;
                    attached)     [ "$state" = "1" ] && printf "%-20s %s\n" "$name" "attached" ;;
                    detached)     [ "$state" != "1" ] && printf "%-20s %s\n" "$name" "detached" ;;
                esac
            done
        fi

        # Find stopped projects (data dir exists, no socket)
        if [ "$filter" = "all" ] || [ "$filter" = "stopped" ]; then
            if [ -d "$base_dir" ]; then
                for dir in "$base_dir"/*/; do
                    [ -d "$dir" ] || continue
                    local name="${dir%/}"
                    name="${name##*/}"
                    local is_running=false
                    for rp in "${running_projects[@]}"; do
                        [ "$rp" = "$name" ] && is_running=true && break
                    done
                    $is_running || printf "%-20s %s\n" "$name" "stopped"
                done
            fi
        fi
    }

    case "${1:-}" in
        -l|--list)     _tp_list all ;;
        -r|--running)  _tp_list running ;;
        -a|--attached) _tp_list attached ;;
        -d|--detached) _tp_list detached ;;
        -s|--stopped)  _tp_list stopped ;;
        -h|--help)
            echo "Usage: tp [OPTIONS] [PROJECT_NAME] [WORKDIR]"
            echo ""
            echo "  tp PROJECT_NAME             Create or attach to project session"
            echo "  tp PROJECT_NAME WORKDIR     Set/update default working directory"
            echo "                              (used as start-directory on session create)"
            echo "  tp -l, --list      List all project sessions"
            echo "  tp -r, --running   List running sessions (attached + detached)"
            echo "  tp -a, --attached  List attached sessions"
            echo "  tp -d, --detached  List detached sessions"
            echo "  tp -s, --stopped   List stopped sessions (data dir exists, no socket)"
            echo "  tp -h, --help      Show this help"
            ;;
        "")
            echo "Usage: tp [OPTIONS] PROJECT_NAME [WORKDIR] (see tp --help)"
            return 1
            ;;
        -*)
            echo "Unknown option: $1 (see tp --help)"
            return 1
            ;;
        *)
            local project="$1"
            local workdir="${2:-}"
            local data_dir="${base_dir}/${project}"
            local socket="project-${project}"
            local has_socket=false
            [ -S "${socket_dir}/${socket}" ] && has_socket=true

            if [ -n "$workdir" ]; then
                if [ ! -d "$workdir" ]; then
                    echo "Working directory '$workdir' does not exist."
                    return 1
                fi
                workdir="$(cd "$workdir" && pwd)"
            fi

            _tp_save_workdir() {
                [ -n "$workdir" ] || return 0
                mkdir -p "$data_dir"
                printf '%s\n' "$workdir" > "$data_dir/workdir"
            }

            _tp_new_and_attach() {
                mkdir -p "$data_dir/resurrect"
                local start_dir=""
                [ -n "$workdir" ] && start_dir="$workdir"
                [ -z "$start_dir" ] && [ -f "$data_dir/workdir" ] && start_dir="$(cat "$data_dir/workdir")"
                local new_session_args=(-d -s "$project")
                [ -n "$start_dir" ] && new_session_args=(-d -c "$start_dir" -s "$project")
                TMUX_PROJECT_DATA_DIR="$data_dir" tmux -f ~/.tmux-project.conf -L "$socket" new-session "${new_session_args[@]}"
                TMUX_PROJECT_DATA_DIR="$data_dir" tmux -f ~/.tmux-project.conf -L "$socket" set -g @resurrect-dir "$data_dir/resurrect"
                TMUX_PROJECT_DATA_DIR="$data_dir" tmux -f ~/.tmux-project.conf -L "$socket" attach-session -t "$project"
            }

            if $has_socket && tmux -L "$socket" has-session -t "$project" 2>/dev/null; then
                if [ -n "$workdir" ]; then
                    _tp_save_workdir
                    echo "Updated default working directory for '$project': $workdir"
                    echo "(applies to next session create; running session unchanged)"
                fi
                local attached
                attached=$(tmux -L "$socket" list-sessions -t "$project" -F '#{session_attached}' 2>/dev/null)
                if [ "$attached" = "1" ]; then
                    echo "Project '$project' is already attached elsewhere."
                    echo "  [a] Attach here too (shared)"
                    echo "  [d] Detach other client and attach here"
                    echo "  [q] Abort"
                    printf "Choose [a/d/q]: " && read -r choice
                    case "$choice" in
                        a) TMUX_PROJECT_DATA_DIR="$data_dir" tmux -f ~/.tmux-project.conf -L "$socket" attach-session -t "$project" ;;
                        d) TMUX_PROJECT_DATA_DIR="$data_dir" tmux -f ~/.tmux-project.conf -L "$socket" attach-session -d -t "$project" ;;
                        *) echo "Aborted." ; return 0 ;;
                    esac
                else
                    TMUX_PROJECT_DATA_DIR="$data_dir" tmux -f ~/.tmux-project.conf -L "$socket" attach-session -t "$project"
                fi
            elif [ -d "$data_dir" ]; then
                _tp_save_workdir
                _tp_new_and_attach
            else
                echo "No project '$project' found."
                printf "Create and start? [y/N]: " && read -r choice
                case "$choice" in
                    y|Y)
                        mkdir -p "$data_dir"
                        _tp_save_workdir
                        _tp_new_and_attach
                        ;;
                    *) echo "Aborted." ; return 0 ;;
                esac
            fi
            ;;
    esac
}

function xasdf() {
  sub=$1
  subsub=$2
  if [ "$sub" = "set" ] && [ "$subsub" = "user" ]; then
    shift
    shift
    _xx4h_asdf_manage_set_home "$@"
  elif [ "$sub" = "set" ]; then
    shift
    _xx4h_asdf_manage_set "$@"
  elif [ "$sub" = "gplugin" ]; then
    shift
    _xx4h_asdf_plugin "$@"
  elif [ "$sub" = "search" ]; then
    shift
    _xx4h_asdf_plugin_search "$@"
  elif [ "$sub" = "xhelp" ]; then
    _xx4h_asdf_help
  else
    asdf "$@"
  fi
}
