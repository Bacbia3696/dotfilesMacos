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

function rg(){
    # If outputting (fd 1 = stdout) directly to a terminal, page automatically:
    if [ -t 1 ]; then
        command rg -p "$@" \
            | bat
    else
        command rg "$@"
    fi
}

function help() {
    "$@" --help 2>&1 | bat -p -l=help
}
