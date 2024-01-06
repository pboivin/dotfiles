function phpserver {
  local port="$1"

  if [ "$port" == "" ]; then
    port="8000"
  fi

  php -S "0.0.0.0:$port"
}
