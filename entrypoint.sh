#!/bin/sh
set -e

./main.sh

INTERVAL="${INTERVAL:-1}"

echo "*/${INTERVAL} * * * * /bin/sh /usr/src/app/main.sh" | crontab -
echo "$(date): Cron job Configured to run every ${INTERVAL} minute(s)"

/usr/sbin/crond -f -l 8