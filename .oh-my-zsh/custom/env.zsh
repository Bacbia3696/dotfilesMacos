export PROMPT_EOL_MARK=''
export XDG_CONFIG_HOME="$HOME/.config"

# FZF
export FZF_DEFAULT_COMMAND="fd --type f"
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_CTRL_T_OPTS="
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"
export FZF_CTRL_R_OPTS="
  --preview 'echo {}' --preview-window up:3:hidden:wrap
  --bind 'ctrl-/:toggle-preview'
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --layout default
  --header 'Press CTRL-Y to copy command into clipboard'"
export FZF_ALT_C_OPTS="--preview 'tree -C {}'"
export FZF_DEFAULT_OPTS="--reverse --height 60% --cycle --border \
  --color='info:cyan,border:magenta,gutter:-1'"

# LESS
export LESS='-SRXF'

# EDITOR
export VISUAL=nvim
export EDITOR=$VISUAL

# golang
export PATH="$HOME/.local/bin:$HOME/go/bin:$PATH"
export PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH"
# gvm
[[ -s "$HOME/.gvm/scripts/gvm" ]] && \
  source "$HOME/.gvm/scripts/gvm"

# rust
source $HOME/.cargo/env
export RUSTC_WRAPPER=sccache

# DOCKER
export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1
export DOCKER_DEFAULT_PLATFORM=linux/amd64

# llvm
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"

#pyenv
export PATH="$HOME/.pyenv/bin:$HOME/.pyenv/shims:$PATH"
export PYENV_ROOT="$HOME/.pyenv"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# for brew
export HOMEBREW_NO_INSTALL_FROM_API=1
export LIBRARY_PATH="$LIBRARY_PATH:$(brew --prefix)/lib"
export CPATH="$CPATH:$(brew --prefix)/include"

# bat to show manpage
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# fnm is nvm writen in Rust
export PATH="$HOME/Library/Application Support/fnm:$PATH"
eval "`fnm env`"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end


# https://github.com/joshmedeski/t-smart-tmux-session-manager
# ~/.tmux/plugins
export PATH=$HOME/.tmux/plugins/t-smart-tmux-session-manager/bin:$PATH
# ~/.config/tmux/plugins
export PATH=$HOME/.config/tmux/plugins/t-smart-tmux-session-manager/bin:$PATH
