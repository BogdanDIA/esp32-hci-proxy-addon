#!/bin/ash -e

. /app/libproduct.sh

log_info "Entering main loop..."

./app/set-link/set-btattach.sh &
./app/set-link/set-udp.sh &

while :; do
  log_info "\n$(hciconfig)"
  sleep 60
done

