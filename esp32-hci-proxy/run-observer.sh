#!/bin/ash -e

. /app/libproduct.sh

log_info "Entering run-observer loop..."
while :; do
  HCINUM=$(hciconfig | grep hci | wc -l)
  HCINUM=$(($HCINUM-1))                 
  echo "HCINUM: $HCINUM"                
                        
  #kill btattach after a number or tries
  DOWN_COUNT=0                          
                                            
  if [[ $HCINUM -ge 0 ]]; then
    res=$(hciconfig hci${HCINUM} | grep DOWN)
    if [[ -n $res ]]; then                   
      log_debug "trying up: hci$HCINUM"      
      hciconfig hci${HCINUM} up        
      DOWN_COUNT=$(($DOWN_COUNT+1))    
      log_debug "DOWN_COUNT: $DOWN_COUNT"
      if [[ $DOWN_COUNT -ge 6 ]]; then   
        log_debug: "killing btattach"    
        #killall -9 btattach           
      fi                             
    fi  
  fi  
  
  sleep 60
done
