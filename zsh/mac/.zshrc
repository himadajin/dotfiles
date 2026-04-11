# = Environment Variables =
export path=(
  $path
  "/opt/homebrew/bin"
  "/opt/homebrew/opt/binutils/bin"
  "${HOME}/.local/bin"
  "${HOME}/local/llvm/llvm@20/bin"
)

# = zsh =
source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

_setup_zsh_auto_complete() {
  skip_global_compinit=1

  zstyle ':autocomplete:*' add-space executables aliases functions builtins reserved-words commands
  zstyle ':autocomplete:*' add-semicolon no
  zstyle ':autocomplete:*' default-context ''
  zstyle ':autocomplete:*' fzf-completion no
  zstyle ':autocomplete:*' ignored-input '' # extended glob pattern
  zstyle ':autocomplete:*' list-lines 10  # int
  zstyle ':autocomplete:*' min-delay 0.05  # float
  zstyle ':autocomplete:*' min-input 0  # int
  zstyle ':autocomplete:*' recent-dirs cdr
  zstyle ':autocomplete:*complete*:*' insert-unambiguous yes
  zstyle ':autocomplete:history-search:*' list-lines 10  # int
  zstyle ':autocomplete:history-incremental-search-*:*' list-lines 10  # int

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

  bindkey -M menuselect '\t' .accept-line
}
_setup_zsh_auto_complete
unset -f _setup_zsh_auto_complete

zstyle ':completion:*' list-rows-first LIST_ROWS_FIRST
setopt interactive_comments
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_reduce_blanks
setopt share_history
setopt append_history
LISTMAX=1000

# = aliases =
alias ls="ls --color=auto"
alias la="ls --color=auto -a"
alias ll="ls --color=auto -lha"

alias python3="python3.14"
alias pip3="pip3.14"
alias pip="pip3"
alias python="python3"

# = zsh-abbr =
source "$(brew --prefix)/share/zsh-abbr/zsh-abbr.zsh"
abbr -S c="code" > /dev/null
abbr -S m="make" > /dev/null
abbr -S t="task" > /dev/null
abbr -S v="nvim" > /dev/null
abbr -S cl="clear" > /dev/null
abbr -S ch="cd ~" > /dev/null
abbr -S tm="tmux" > /dev/null
abbr -S dus="du -sh" > /dev/null
abbr -S dut="du -ch" > /dev/null
# == zsh-abbr for git ==
abbr -S g="git" > /dev/null
abbr -S ga="git add" > /dev/null
abbr -S gaa="git add --all" > /dev/null
abbr -S gd="git diff" > /dev/null
abbr -S gds="git diff --staged" > /dev/null
abbr -S gl="git log" > /dev/null
abbr -S gp="git push" > /dev/null
abbr -S gpl="git pull" > /dev/null
abbr -S gsw="git switch" > /dev/null
abbr -S gst="git status" > /dev/null

abbr -S gfp="git fetch --prune" > /dev/null
abbr -S gswm="git switch main" > /dev/null
abbr -S gplm="git pull origin main" > /dev/null

# = Other Settings =
# == nvm ==
export NVM_DIR="$HOME/.nvm"
[ -s "$(brew --prefix)/opt/nvm/nvm.sh" ] && \. "$(brew --prefix)/opt/nvm/nvm.sh"

# == pnpm ==
export PNPM_HOME="${HOME}/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# = Completions =
export fpath=(
  $fpath
  "${HOME}/.zsh/completions"
  "${HOME}/.zsh/zsh-completions/src"
  "$(brew --prefix)/share/zsh/site-functions"
)
eval "$(codex completion zsh)"
eval "$(task --completion zsh)"
eval "$(uv generate-shell-completion zsh)"

# = Starship =
eval "$(starship init zsh)"
