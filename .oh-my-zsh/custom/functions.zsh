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
