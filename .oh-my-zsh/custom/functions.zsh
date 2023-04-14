function pe() {
  if [ "$#" -eq 0 ]; then
    pyenv shell --unset
  else
    pyenv shell $1
  fi
}

function gr() {
  if [ "$#" -eq 0 ]; then
    go run .
  else
    go run "$@"
  fi
}

function rg() {
  # If outputting (fd 1 = stdout) directly to a terminal, page automatically:
  if [ -t 1 ]; then
    command rg -p "$@" |
      bat
  else
    command rg "$@"
  fi
}

function help() {
  "$@" --help 2>&1 | bat -p -l=help
}

function rfv() {
  rg --color=always --line-number --no-heading --smart-case "${*:-}" |
    fzf --ansi \
      --color "hl:-1:underline,hl+:-1:underline:reverse" \
      --delimiter : \
      --preview 'bat --color=always {1} --highlight-line {2}' \
      --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
      --bind 'enter:become(nvim {1} +{2})'
}

function storeCode() {
  fd -I -e wasm | fzf --bind 'enter:become(shareledger tx wasm store {} --from authority --gas auto --gas-adjustment 1.3)'
}
