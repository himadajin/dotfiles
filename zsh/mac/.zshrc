# PATH settings
export PATH="${PATH}:/opt/homebrew/bin"

LLVM_VERSION=14
export PATH="${PATH}:$(brew --prefix)/opt/llvm@${LLVM_VERSION}/bin"

export fpath=(
  $fpath
  "$(brew --prefix)/share/zsh/site-functions"
  "${HOME}/.zsh/zsh-completions/src"
)

source "$(brew --prefix)/share/zsh-syntax-highlighting/"
source "$(brew --prefix)/share/zsh-abbr/zsh-abbr.zsh"

setup_zsh_auto_complete() {
  skip_global_compinit=1

  zstyle ':autocomplete:*' default-context ''
  # '': Start each new command line with normal autocompletion.
  # history-incremental-search-backward: Start in live history search mode.

  zstyle ':autocomplete:*' min-delay 0.05  # float
  # Wait this many seconds for typing to stop, before showing completions.

  zstyle ':autocomplete:*' min-input 0  # int
  # Wait until this many characters have been typed, before showing completions.

  zstyle ':autocomplete:*' ignored-input '' # extended glob pattern
  # '':     Always show completions.
  # '..##': Don't show completions when the input consists of two or more dots.

  zstyle ':autocomplete:*' list-lines 16  # int
  # If there are fewer than this many lines below the prompt, move the prompt up
  # to make room for showing this many lines of completions (approximately).

  zstyle ':autocomplete:history-search:*' list-lines 16  # int
  # Show this many history lines when pressing ↑.

  zstyle ':autocomplete:history-incremental-search-*:*' list-lines 16  # int
  # Show this many history lines when pressing ⌃R or ⌃S.

  zstyle ':autocomplete:*' recent-dirs cdr
  # cdr:  Use Zsh's `cdr` function to show recent directories as completions.
  # no:   Don't show recent directories.
  # zsh-z|zoxide|z.lua|z.sh|autojump|fasd: Use this instead (if installed).
  # ⚠️ NOTE: This setting can NOT be changed at runtime.

  zstyle ':autocomplete:*' insert-unambiguous no
  # no:  Tab inserts the top completion.
  # yes: Tab first inserts a substring common to all listed completions, if any.

  zstyle ':autocomplete:*' widget-style complete-word
  # complete-word: (Shift-)Tab inserts the top (bottom) completion.
  # menu-complete: Press again to cycle to next (previous) completion.
  # menu-select:   Same as `menu-complete`, but updates selection in menu.
  # ⚠️ NOTE: This setting can NOT be changed at runtime.

  zstyle ':autocomplete:*' fzf-completion no
  # no:  Tab uses Zsh's completion system only.
  # yes: Tab first tries Fzf's completion, then falls back to Zsh's.
  # ⚠️ NOTE: This setting can NOT be changed at runtime and requires that you
  # have installed Fzf's shell extensions.

  # Add a space after these completions:
  zstyle ':autocomplete:*' add-space \
      executables aliases functions builtins reserved-words commands

  source ~/.zsh/zsh-autocomplete/zsh-autocomplete.plugin.zsh
  ##
  # NOTE: All configuration below should come AFTER sourcing zsh-autocomplete!
  #

  # Up arrow:
  bindkey '\e[A' up-line-or-search
  bindkey '\eOA' up-line-or-search
  # up-line-or-search:  Open history menu.
  # up-line-or-history: Cycle to previous history line.

  # Down arrow:
  bindkey '\e[B' down-line-or-select
  bindkey '\eOB' down-line-or-select
  # down-line-or-select:  Open completion menu.
  # down-line-or-history: Cycle to next history line.

  # Control-Space:
  bindkey '\0' list-expand
  # list-expand:      Reveal hidden completions.
  # set-mark-command: Activate text selection.

  # Uncomment the following lines to disable live history search:
  # zle -A {.,}history-incremental-search-forward
  # zle -A {.,}history-incremental-search-backward

  # Return key in completion menu & history menu:
  bindkey -M menuselect '\r' .accept-line
  # .accept-line: Accept command line.
  # accept-line:  Accept selection and exit menu.
}
setup_zsh_auto_complete
unset -f setup_zsh_auto_complete

setopt interactive_comments
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
zstyle ':completion:*' expand-tilde no

LS_OPTIONS='--color=auto'
alias ls="ls $LS_OPTIONS -a"
alias ll="ls $LS_OPTIONS -l"
alias la="ls $LS_OPTIONS -la"

abbr -S vim="nvim" > /dev/null
abbr -S vi="nvim" > /dev/null
abbr -S v="nvim" > /dev/null

abbr -S clc="clear" > /dev/null
abbr -S clewar="clear" > /dev/null
abbr -S cleawr="clear" > /dev/null


abbr -S srcz="source ~/.zshrc" > /dev/null

alias python="python3.12"

# setup nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$(brew --prefix)/opt/nvm/nvm.sh" ] && \. "$(brew --prefix)/opt/nvm/nvm.sh"  # This loads nvm

zshaddhistory() {
  local line=${1%%$'\n'}
  local cmd=${line%% *}

  # Only add to history if all of the follwing condition are met
  [[
    ${#line} -ge 5
    && ${cmd} != (l[sal]) # ls
    && ${cmd} != (cd|man|clear|which|true|false)
  ]]
}


eval "$(starship init zsh)"

