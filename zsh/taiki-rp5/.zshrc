DOTFILES_DIR="${${(%):-%N}:A:h:h:h}"

# = Environment Variables =
() {
  local env_file="${DOTFILES_DIR}/.env"
  [[ -r "${env_file}" ]] || return 0
  setopt localoptions allexport
  source "${env_file}"
}

export path=(
  "${HOME}/local/bin"
  "${HOME}/.local/bin"
  $path
)

# = General Settings =
export HISTFILE="${HOME}/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000
setopt interactive_comments
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_reduce_blanks
setopt share_history

echo -ne '\e[?12l'

alias ls="ls --color=auto"
alias la="ls --color=auto -a"
alias ll="ls --color=auto -lha"

# = zsh-abbr =
source "${HOME}/repos-zsh/zsh-abbr/zsh-abbr.zsh"
abbr -S m="make" > /dev/null
abbr -S t="task" > /dev/null
abbr -S v="nvim" > /dev/null
abbr -S cl="clear" > /dev/null
abbr -S cdh='cd "${HOME}"' > /dev/null
abbr -S cdt='cd "$(tddir)"' > /dev/null
abbr -S codet='code "$(tddir)"' > /dev/null
abbr -S tm="tmux" > /dev/null
# ==  git ==
abbr -S gita="git add -A" > /dev/null
abbr -S gitaa="git add -A" > /dev/null
abbr -S gitc="git commit -m" > /dev/null
abbr -S gitf="git fetch --prune" > /dev/null
abbr -S gitsc="git switch -c" > /dev/null
abbr -S gitsm="git switch main" > /dev/null
abbr -S gitp="git switch main && git fetch --prune && git pull origin main" > /dev/null

# = Completions =
export fpath=(
  $fpath
  "${HOME}/repos-zsh/zsh-completions/src"
)
autoload -Uz compinit && compinit

source <("${HOME}/repos-zsh/zrush/target/release/zrush" init zsh)

# = Starship =
eval "$(starship init zsh)"
