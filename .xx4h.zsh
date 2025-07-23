autoload -Uz compinit && compinit

# source pre.shrc.d
for rc_file in $(find ~/.pre.shrc.d -name '*.sh' -o -name '*.zsh' 2>/dev/null | sort); do
  source "$rc_file"
done

# source xx4h sh & zsh stuff
for rc_file in $(find ~/.shrc.xx4h.d -name '*.sh' -o -name '*.zsh' 2>/dev/null | sort); do
  source "$rc_file"
done

for rc_file in $(find ~/.shrc.d -name '*.sh' -o -name '*.zsh' 2>/dev/null | sort); do
  source "$rc_file"
done

eval "$(oh-my-posh init zsh --config ~/.config/omp/xx4h.omp.yaml)"

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
fi


ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

HISTFILE=~/.zsh_history
HISTSIZE=999999
SAVEHIST=999999

# append to the history file, don't overwrite it
setopt  APPEND_HISTORY
setopt  HIST_IGNORE_SPACE
setopt  HIST_REDUCE_BLANKS
setopt  HIST_VERIFY
setopt  HIST_SAVE_NO_DUPS
setopt  HIST_IGNORE_ALL_DUPS
#setopt  HIST_IGNORE_DUPS
setopt  SHARE_HISTORY
#setopt  INC_APPEND_HISTORY
setopt  EXTENDED_HISTORY
#setopt  CORRECT
#setopt  AUTO_CD
#setopt  AUTO_LIST
#setopt  AUTO_MENU
#setopt  AUTO_PARAM_KEYS
#setopt  AUTO_PARAM_SLASH
#setopt  AUTO_PUSHD
#setopt  AUTO_RESUME
#setopt  NO_BEEP
#setopt  BRACE_CCL
#setopt  EQUALS
#setopt  NO_FLOW_CONTROL
#setopt  EXTENDED_GLOB
#setopt  EXTENDED_HISTORY
##setopt  HIST_NO_STORE
#setopt  NO_HUP
#setopt  INTERACTIVE_COMMENTS
#setopt  LIST_PACKED
#setopt  LIST_ROWS_FIRST
#setopt  LIST_TYPES
#setopt  LONG_LIST_JOBS
#setopt  MAGIC_EQUAL_SUBST
#setopt  MARK_DIRS
#setopt  MULTIOS
#setopt  NUMERIC_GLOB_SORT
#setopt  PRINT_EIGHT_BIT
#setopt  PROMPT_CR
#setopt  PROMPT_SUBST
#setopt  PUSHD_IGNORE_DUPS
#
#setopt  RC_EXPAND_PARAM
#setopt  SHORT_LOOPS
#setopt  TRANSIENT_RPROMPT

zinit light zsh-users/zsh-syntax-highlighting
#zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit load zdharma-continuum/history-search-multi-word

#{ atuin config
zinit ice as"command" from"gh-r" bpick"atuin-*.tar.gz" mv"atuin*/atuin -> atuin" \
    atclone"./atuin init zsh > init.zsh; ./atuin gen-completions --shell zsh > _atuin" \
    atpull"%atclone" src"init.zsh"
zinit light atuinsh/atuin
#} atuin config

zstyle ':completion:*' menu select
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'

bindkey -e
bindkey "^[." insert-last-word
bindkey "^[w" kill-region

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# This will be our new default `alt+backspace` command
my-backward-delete-word() {
    # Copy the global WORDCHARS variable to a local variable. That way any
    # modifications are scoped to this function only
    local WORDCHARS=$WORDCHARS
    # Use bash string manipulation to remove `:` so our delete will stop at it
    WORDCHARS="${WORDCHARS//:}"
    # Use bash string manipulation to remove `/` so our delete will stop at it
    WORDCHARS="${WORDCHARS//\/}"
    # Use bash string manipulation to remove `.` so our delete will stop at it
    WORDCHARS="${WORDCHARS//.}"
    # zle <widget-name> will run an existing widget.
    zle backward-kill-word
}
# `zle -N` will create a new widget that we can use on the command line
zle -N my-backward-delete-word
# bind this new widget to `ctrl+w`
bindkey '^[^?' my-backward-delete-word

autoload -Uz compinit && compinit
