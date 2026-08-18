# = zsh =
zstyle ':completion:*' file-sort name reverse
zstyle ':completion:*' list-rows-first LIST_ROWS_FIRST

setopt interactive_comments
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_reduce_blanks
setopt share_history

# turn off cursor blinking
echo -ne '\e[?12l'

# = General Settings =
export HISTFILE="${HOME}/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000

alias ls="ls --color=auto"
alias la="ls --color=auto -a"
alias ll="ls --color=auto -lha"

# = zsh-abbr =
source "${HOME}/repos-zsh/zsh-abbr/zsh-abbr.zsh"
abbr -S cl="clear" > /dev/null
# ==  git ==
abbr -S gita="git add -A" > /dev/null
abbr -S gitaa="git add -A" > /dev/null
abbr -S gitc="git commit -m" > /dev/null
abbr -S gitf="git fetch --prune" > /dev/null
abbr -S gitsc="git switch -c" > /dev/null
abbr -S gitsm="git switch main" > /dev/null
abbr -S gitp="git switch main && git fetch --prune && git pull origin main" > /dev/null

# = Completions =
autoload -Uz compinit && compinit
source <("${HOME}/repos-zsh/zrush/target/release/zrush" init zsh)

# = Starship =
eval "$(starship init zsh)"