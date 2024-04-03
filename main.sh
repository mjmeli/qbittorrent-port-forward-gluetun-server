#!/bin/sh
set -e

qbt_username="${QBT_USERNAME:-admin}"
qbt_password="${QBT_PASSWORD:-adminadmin}"
qbt_addr="${QBT_ADDR:-http://localhost:8080}" # ex. http://10.0.1.48:8080
gtn_addr="${GTN_ADDR:-http://localhost:8000}" # ex. http://10.0.1.48:8000

port_number=$(curl --fail --silent --show-error  $GTN_ADDR/v1/openvpn/portforwarded | jq '.port')
if [ ! "$port_number" ] || [ "$port_number" = "0" ]; then
    echo "Could not get current forwarded port from gluetun, exiting..."
    exit 1
fi

curl --fail --silent --show-error --cookie-jar /tmp/cookies.txt --cookie /tmp/cookies.txt --header "Referer: $qbt_addr" --data-urlencode "username=$qbt_username" --data-urlencode "password=$qbt_password" $qbt_addr/api/v2/auth/login 1> /dev/null

listen_port=$(curl --fail --silent --show-error --cookie-jar /tmp/cookies.txt --cookie /tmp/cookies.txt $qbt_addr/api/v2/app/preferences | jq '.listen_port')

if [ ! "$listen_port" ]; then
    echo "Could not get current listen port, exiting..."
    exit 1
fi

if [ "$port_number" = "$listen_port" ]; then
    echo "Port already set, exiting..."
    exit 0
fi

echo "Updating port to $port_number"

curl --fail --silent --show-error --cookie-jar /tmp/cookies.txt --cookie /tmp/cookies.txt --data-urlencode "json={\"listen_port\": $port_number}"  $qbt_addr/api/v2/app/setPreferences

echo "Successfully updated port"
