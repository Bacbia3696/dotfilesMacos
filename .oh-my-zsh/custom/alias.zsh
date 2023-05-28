alias q=exit
alias ls='lsd'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lst='ls --tree'
alias k=kubectl
alias i=ignite
alias c=cargo
alias g=git
alias e="OPENAI_API_KEY=$(gpg --decrypt ~/.config/nvim/chatgpt.gpg 2>/dev/null) nvim"
alias cl=clear
alias p=pnpm
alias px=pnpx
alias ef="nvim -c 'Telescope find_files'"
alias bathelp="bat -p -l help"
alias ssh='TERM=xterm-256color ssh'

alias sdcv="sdcv -2 ~/Library/stardict/dic"
alias gd='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
