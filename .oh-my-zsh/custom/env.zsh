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

export PATH="$HOME/.local/bin:$HOME/go/bin:$PATH"
export PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH"

export RUSTC_WRAPPER=sccache
