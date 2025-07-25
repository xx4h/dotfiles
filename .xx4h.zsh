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


HISTFILE=~/.zsh_history
HISTSIZE=999999
SAVEHIST=999999

# append to the history file, don't overwrite it
setopt  APPEND_HISTORY
# don't append to history if first character is a space
setopt  HIST_IGNORE_SPACE
# remove redundant/needless blanks
setopt  HIST_REDUCE_BLANKS
# history expansion into editing buffer instead of direct executing
setopt  HIST_VERIFY
# on history write, older duplicate commands are ommited
setopt  HIST_SAVE_NO_DUPS
# new command that duplicates older one, older one is removed
setopt  HIST_IGNORE_ALL_DUPS
# write & load lines immediately, you basically have the same history on all shell sessions
# disabled: we don't want immediate reload when we use "atuin", as we already have global
# history in "strg-r", but use native history for "arrow-up"
# setopt  SHARE_HISTORY
setopt  EXTENDED_HISTORY
# allow comments even in interactive shell (alt-#)
setopt  INTERACTIVE_COMMENTS


### ZINIT SECTION ###

#{ ensure zinit is installed and loaded
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"
#}

# zsh syntax highlighting {
zinit light zsh-users/zsh-syntax-highlighting

ZSH_HIGHLIGHT_STYLES[comment]='fg=#bcbcbc'
# }


#zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit load zdharma-continuum/history-search-multi-word

# atuin {
# if we change something in ice, we need to "zinit delete atuinsh/atuin"
# afterwards so it gets reloaded on next zsh exec
zinit ice as"command" from"gh-r" bpick"atuin-*.tar.gz" mv"atuin*/atuin -> atuin" \
    atclone"./atuin init zsh --disable-up-arrow > init.zsh; ./atuin gen-completions --shell zsh > _atuin" \
    atpull"%atclone" src"init.zsh"
zinit light atuinsh/atuin
# }

### END ZINIT SECTION ###

zstyle ':completion:*' menu select
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'

# enable emacs mode
bindkey -e

# enable vim mode
bindkey -v
bindkey "^[." insert-last-word
bindkey "^[w" kill-region

# vim mode {
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line
# }

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

# TODO: some completions need "compinit" before and some after (e.g. asdf) the completion sourcing
autoload -Uz compinit && compinit
