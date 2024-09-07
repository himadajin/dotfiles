export PATH="$PATH:/opt/homebrew/bin"

# setup prompt
prompt() {
  local ret="[%F{red}%?%f]"
  local dir="%F{blue}%~%f"
  local usr="%#"
  echo -e "${ret} ${dir}\n${usr} "
}
export PROMPT="$(prompt)"
unset -f prompt

export LS_OPTIONS='--color=auto'
alias ls='ls $LS_OPTIONS -a'
alias ll='ls $LS_OPTIONS -l'
alias la='ls $LS_OPTIONS -la'

# setup nvm
export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completionnp

[[ -s "/opt/homebrew/etc/bash_completion.d/brew" ]] && source "/opt/homebrew/etc/bash_completion.d/brew"

zshaddhistory() {
  local line=${1%%$'\n'}
  local cmd=${line%% *}

  # Only add to history if all of the following conditions are met
  [[
      ${#line} -ge 5
      && ${cmd} != (l[sal]) # ls
      && ${cmd} != (cd)
      && ${cmd} != (man)
      && ${cmd} != (clear)
      && ${cmd} != (which)
      && ${cmd} != (true|false)
  ]]
}

source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/repositories/zsh-autocomplete/zsh-autocomplete.plugin.zsh
