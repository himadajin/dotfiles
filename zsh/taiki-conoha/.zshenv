export path=(
  $path
  "${HOME}/.local/bin"
  "${HOME}/local/bin"
)

# = cargo =
. "$HOME/.cargo/env"

# = nvm =
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
