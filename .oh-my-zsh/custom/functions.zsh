function pe() {
  if [ "$#" -eq 0 ]; then
    pyenv shell --unset
  else
    pyenv shell $1
  fi
}

function gdp() {
  message='update config'
  if [ "$#" -eq 1 ]; then
    message=$1
  fi
  gd au
  gd cm $message
  gd p
}

function gr() {
  if [ "$#" -eq 0 ]; then
    go run .
  else
    go run "$@"
  fi
}

function e() {
  if [ "$#" -ge 1 ]; then
    IFS=:
    read fn ln <<<$1
    [ -z ${ln} ] && nvim $1 || nvim ${fn} "+${ln}"
  else
    nvim
    # nvim -c "SessionManager load_session"
  fi
}
