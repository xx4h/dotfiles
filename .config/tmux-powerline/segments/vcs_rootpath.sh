# Source lib to get the function get_tmux_pwd
source "${TMUX_POWERLINE_DIR_LIB}/tmux_adapter.sh"

run_segment() {
  tmux_path=$(get_tmux_cwd)
  cd "$tmux_path"
  __parse_git_root_path
  return 0
}

__parse_git_root_path() {
  type git >/dev/null 2>&1
  if [ "$?" -ne 0 ]; then
    return
  fi

  root_path=$(git rev-parse --show-toplevel)
  root_path=${root_path/#$HOME/\~}
  echo -n "#[fg=${TMUX_POWERLINE_CUR_SEGMENT_FG}]${root_path}"
}
