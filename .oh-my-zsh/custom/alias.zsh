alias q=exit
alias o="xdg-open"
# alias e="nvim"
alias se=sudoedit
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias gd=dotfiles
alias g=git
alias pysetup='pip install "python-language-server[yapf]"'
alias ls='lsd'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lst='ls --tree'
alias pyclean='find . -type d -name __pycache__ -exec rm -rf {} +'
alias k=kubectl
alias i=ignite

# edit config file
alias egf="e $HOME/.gitconfig"
alias ekf="e $HOME/.config/kitty/kitty.conf"

# nmp
# alias ns="npm start"
# alias ni="npm install"
# alias nu="npm uninstall"
# alias nr="npm run"
# alias nt="npm test"
# alias ny="npm init -y"
# alias nli="npm list --depth=0"

alias react="pbpaste > /tmp/file.html && htmltojsx /tmp/file.html | pbcopy"
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"

alias c=cargo

alias sdcv="sdcv -2 ~/Library/stardict/dic"
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
