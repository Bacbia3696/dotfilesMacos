export PROMPT_EOL_MARK=''

# FZF
export FZF_DEFAULT_COMMAND="rg --files --hidden --no-ignore-vcs -g '!**/.git/**' -g '!**/node_modules/**'"
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_DEFAULT_OPTS="--border"

# LESS
export LESS='-SRXF'

# EDITOR
export EDITOR=nvim
export VISUAL=nvim

# golang
export PATH="$HOME/.local/bin:$HOME/go/bin:$PATH"
export PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH"
# gvm
[[ -s "/Users/nguyenthanhdat/.gvm/scripts/gvm" ]] && source "/Users/nguyenthanhdat/.gvm/scripts/gvm"

# rust
source $HOME/.cargo/env
export RUSTC_WRAPPER=sccache

# DOCKER
export DOCKER_BUILDKIT=0
export COMPOSE_DOCKER_CLI_BUILD=0
export DOCKER_DEFAULT_PLATFORM=linux/amd64

# llvm
export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"

#pyenv
export PATH="$HOME/.pyenv/bin:$HOME/.pyenv/shims:$PATH"
export PYENV_ROOT="$HOME/.pyenv"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
