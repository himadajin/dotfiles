# = Environment Variables =
export path=(
  "${HOME}/local/bin"
  "${HOME}/.local/bin"
  "/opt/homebrew/bin"
  "/opt/homebrew/opt/binutils/bin"
  "${HOME}/local/llvm/llvm@20/bin"
  $path
)

# = zsh =
source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

_setup_zsh_auto_complete() {
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

  zstyle ':autocomplete:*' list-lines 10  # int
  # If there are fewer than this many lines below the prompt, move the prompt up
  # to make room for showing this many lines of completions (approximately).

  zstyle ':autocomplete:history-search:*' list-lines 10  # int
  # Show this many history lines when pressing ↑.

  zstyle ':autocomplete:history-incremental-search-*:*' list-lines 10  # int
  # Show this many history lines when pressing ⌃R or ⌃S.

  zstyle ':autocomplete:*' recent-dirs cdr
  # cdr:  Use Zsh's `cdr` function to show recent directories as completions.
  # no:   Don't show recent directories.
  # zsh-z|zoxide|z.lua|z.sh|autojump|fasd: Use this instead (if installed).
  # ⚠️ NOTE: This setting can NOT be changed at runtime.

  zstyle ':autocomplete:*' insert-unambiguous yes
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

copilot() {
  local -a allowed_dirs=(
    "${HOME}/.agents/skills"
    "${HOME}/.claude/skills"
    "${HOME}/.codex/skills"
    "${HOME}/compiler"
    "${HOME}/repos-skills"
    "${HOME}/works"
  )
  local -a allow_tools=(
    'shell(awk:*)'
    'shell(basename:*)'
    'shell(cat:*)'
    'shell(clang:*)'
    'shell(clang++:*)'
    'shell(cmake:*)'
    'shell(cut:*)'
    'shell(df:*)'
    'shell(diff:*)'
    'shell(dirname:*)'
    'shell(du:*)'
    'shell(date:*)'
    'shell(echo:*)'
    'shell(env:*)'
    'shell(file:*)'
    'shell(find:*)'
    'shell(gcc:*)'
    'shell(g++:*)'
    'shell(git branch)'
    'shell(git diff)'
    'shell(git log)'
    'shell(git remote)'
    'shell(git grep)'
    'shell(git ls-files)'
    'shell(git rev-parse)'
    'shell(git show)'
    'shell(git status)'
    'shell(grep:*)'
    'shell(head:*)'
    'shell(hostname:*)'
    'shell(llc:*)'
    'shell(llvm-as:*)'
    'shell(llvm-dis:*)'
    'shell(llvm-lit:*)'
    'shell(llvm-nm:*)'
    'shell(llvm-objdump:*)'
    'shell(llvm-readelf:*)'
    'shell(llvm-size:*)'
    'shell(llvm-strings:*)'
    'shell(lit:*)'
    'shell(ls:*)'
    'shell(make:*)'
    'shell(mkdir:*)'
    'shell(nm:*)'
    'shell(not:*)'
    'shell(opt:*)'
    'shell(printenv:*)'
    'shell(printf:*)'
    'shell(pwd:*)'
    'shell(python:*)'
    'shell(python3:*)'
    'shell(sed:*)'
    'shell(readlink:*)'
    'shell(realpath:*)'
    'shell(rg:*)'
    'shell(sort:*)'
    'shell(stat:*)'
    'shell(tail:*)'
    'shell(task:*)'
    'shell(tee:*)'
    'shell(touch:*)'
    'shell(tr:*)'
    'shell(whoami:*)'
    'shell(uname:*)'
    'shell(uniq:*)'
    'shell(uv:*)'
    'shell(wc:*)'
    'shell(which:*)'
    'shell(xargs:*)'
  )
  local -a deny_tools=(
    'shell(curl:*)'
    'shell(ssh:*)'
    'shell(sudo:*)'
    'shell(wget:*)'
  )
  local -a copilot_args=()
  local pattern
  for pattern in "${allowed_dirs[@]}"; do
    copilot_args+=( "--add-dir=${pattern}" )
  done
  for pattern in "${allow_tools[@]}"; do
    copilot_args+=( "--allow-tool=${pattern}" )
  done
  for pattern in "${deny_tools[@]}"; do
    copilot_args+=( "--deny-tool=${pattern}" )
  done
  command copilot "${copilot_args[@]}" "$@"
}

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
# == go ==
export PATH="${HOME}/go/bin:${PATH}"

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
