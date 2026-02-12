#!/bin/bash

set -e

[ -n "$DEBUG" ] && set -o xtrace

port="$1"
QBT_PORT=80

echo "Setting qBittorrent port settings ($port)..."

# Very basic retry logic so we don't fail if qBittorrent isn't running yet
while ! curl --silent --retry 10 --retry-delay 15 --max-time 10 \
  --data 'json={"listen_port": "'"$port"'"}' \
  http://localhost:${QBT_PORT}/api/v2/app/setPreferences
do
  sleep 10
done

echo "qBittorrent port updated successfully ($port)..."

