# = zsh =
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

setup_zsh_auto_complete() {
  skip_global_compinit=1

  zstyle ':autocomplete:*' add-space executables aliases functions builtins reserved-words commands
  zstyle ':autocomplete:*' add-semicolon no
  zstyle ':autocomplete:*' default-context ''
  zstyle ':autocomplete:*' ignored-input ''
  zstyle ':autocomplete:*' list-lines 16  # int
  zstyle ':autocomplete:*' min-delay 0.1  # float
  zstyle ':autocomplete:*' min-input 0  # int
  zstyle ':autocomplete:*complete*:*' insert-unambiguous yes
  zstyle ':autocomplete:history-incremental-search-*:*' list-lines 16  # int
  zstyle ':autocomplete:history-search:*' list-lines 16  # int
  zstyle ':autocomplete:*' recent-dirs cdr
  zstyle ':autocomplete:*' fzf-completion no

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

  # Tab: insert unambiguous prefix (default). Use ↓ to enter menu.
  # bindkey '^I' complete-word  # (default, no override needed)
  bindkey -M menuselect '^I' accept-search
}
setup_zsh_auto_complete
unset -f setup_zsh_auto_complete

zstyle ':completion:*' file-sort name reverse
zstyle ':completion:*' list-rows-first LIST_ROWS_FIRST

setopt interactive_comments
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_reduce_blanks
setopt share_history
# setopt append_history

# turn off cursor blinking
echo -ne '\e[?12l'

# = General Settings =
export HISTFILE="${HOME}/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000

export RISCV="${HOME}/opt/riscv"

export path=(
  $path
  "/mnt/c/Users/${USER}/AppData/Local/Programs/Microsoft VS Code/bin"
  "/opt/llvm/llvm@19/bin"
  "${HOME}/.local/bin"
  "${HOME}/local/mold/bin"
  "${HOME}/opt/bin"
  "${RISCV}/bin"
)

alias ls="ls --color=auto"
alias la="ls --color=auto -a"
alias ll="ls --color=auto -lha"

# = zsh-abbr =
source "${HOME}/.zsh/zsh-abbr/zsh-abbr.zsh"
abbr -S m="make" > /dev/null
abbr -S t="task" > /dev/null
abbr -S v="nvim" > /dev/null
abbr -S cl="clear" > /dev/null
abbr -S ch="cd ~" > /dev/null
abbr -S tm="tmux" > /dev/null
abbr -S codet="code $(tddir)" > /dev/null
# == zsh-abbr for git ==
abbr -S g="git" > /dev/null
abbr -S gaa="git add -A" > /dev/null

abbr -S gcm="git commit -m" > /dev/null
abbr -S gfp="git fetch --prune" > /dev/null
abbr -S gsfp="git switch main && git fetch --prune && git pull origin main" > /dev/null
abbr -S gswm="git switch main" > /dev/null

# = Other Settings =
# == nvm ==
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# == rust ==
. "${HOME}/.cargo/env"

# = Completions =
export fpath=(
  $fpath
  "${HOME}/.zsh/zsh-completions/src"
)
eval "$(codex completion zsh)"
eval "$(task --completion zsh)"
eval "$(tddir -c zsh)"
eval "$(uv generate-shell-completion zsh)"

# = Starship =
eval "$(starship init zsh)"
