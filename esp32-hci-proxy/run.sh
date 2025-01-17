#!/bin/ash -e

. /app/libproduct.sh

log_info "Entering main loop..."

if [[ $DEBUG_TESTS -eq "false" ]]; then
  log_info "Starting btattach"
  ./app/set-link/set-btattach.sh &

  log_info "Starting sudpforwarder"
  ./app/set-link/set-udp.sh &
else
  log_debug "debug_tests mode enabled"
  log_debug "Starting sudpforwarder"
  ./app/set-link/set-udp.sh &
fi

while :; do
  log_debug "serial ports: $(ls -al /dev/serial/by-path/)"
  log_debug "\n$(hciconfig)"
  sleep 60
done

