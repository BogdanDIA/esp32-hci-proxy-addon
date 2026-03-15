#!/bin/ash -e

. /app/libproduct.sh

log_info "Entering main loop..."

if [[ $DEBUG_TESTS == "false" ]]; then
  log_info "Starting btattach"
  /app/set-link/set-btattach.sh &

  log_info "Starting sudpforwarder"
  /app/set-link/set-udp.sh &
else
  log_debug "debug_tests mode enabled"
  log_debug "Starting sudpforwarder"
  /app/set-link/set-udp.sh &
  sleep 2
  log_debug "Starting run-test"
  log_debug "$(/app/set-link/run-test.sh)"
fi

while :; do
  log_debug "serial ports: $(ls -al /dev/serial/by-path/)"
  log_debug "\n$(hciconfig)"
  
  #obtain default HCINUM    
  HCINUM=$(hciconfig | grep hci | wc -l)
  HCINUM=$(($HCINUM-1))                 
  log_debug "HCINUM: $HCINUM"                
                        
  #kill btattach after a number or tries
  DOWN_COUNT=0                          
                                            
  if [[ $HCINUM -ge 0 ]]; then
    res=$(hciconfig hci${HCINUM} | grep DOWN)
    if [[ -n $res ]]; then                   
      log_debug "trying up: hci$HCINUM"      
      hciconfig hci${HCINUM} up&        
      DOWN_COUNT=$(($DOWN_COUNT+1))    
      log_debug "DOWN_COUNT: $DOWN_COUNT"
      if [[ $DOWN_COUNT -ge 6 ]]; then   
        log_debug: "killing btattach"    
        //killall -9 btattach           
      else
        DOWN_COUNT=0
      fi                             
    fi  
  fi
  
  sleep 60
done

