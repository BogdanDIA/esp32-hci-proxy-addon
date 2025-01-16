#!/bin/ash -e

. /app/libproduct.sh

log_info "Entering main loop..."

log_info "Starting btattach"
./app/set-link/set-btattach.sh &

log_info "Starting sudpforwarder"
./app/set-link/set-udp.sh &

while :; do
  log_debug "serial ports: $(ls -al /dev/serial/by-path/)"
  log_debug "\n$(hciconfig)"
  sleep 60
done

