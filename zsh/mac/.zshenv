export path=(
  "/opt/homebrew/bin"
  "/opt/homebrew/opt/binutils/bin"
  $path
)

# = cargo =
. "$HOME/.cargo/env"

# = go =
export PATH="${HOME}/go/bin:${PATH}"

# = nvm =
export NVM_DIR="$HOME/.nvm"
[ -s "$(brew --prefix)/opt/nvm/nvm.sh" ] && \. "$(brew --prefix)/opt/nvm/nvm.sh"

# = pnpm =
export PNPM_HOME="${HOME}/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
