#!/bin/sh
set -e

_term() {
  echo "Signal SIGTERM reçu, arrêt en cours..."
  kill -TERM "$child" 2>/dev/null
}

trap _term SIGTERM

./main.sh
/usr/sbin/crond -f -l 8 &
wait "$!"
