#!/bin/sh
set -e

_term() {
  echo "SIGTERM signal received, shutdown in progress..."
  kill -TERM "$child" 2>/dev/null
}

trap _term SIGTERM

./main.sh
/usr/sbin/crond -f -l 8 &
wait "$!"
