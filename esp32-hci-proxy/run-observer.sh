#!/bin/ash

DOWN_COUNT=0

while :; do
  HCINUM=$(hciconfig | grep hci | wc -l)
  HCINUM=$(($HCINUM-1))                 
  echo "HCINUM: $HCINUM"                
                        
  #kill btattach after a number or tries                                                                  
  if [[ $HCINUM -ge 0 ]]; then
    res=$(hciconfig hci${HCINUM} | grep DOWN)
    if [[ -n $res ]]; then                   
      echo "trying up: hci$HCINUM"      
      hciconfig hci${HCINUM} up        
      DOWN_COUNT=$(($DOWN_COUNT+1))    
      echo "DOWN_COUNT: $DOWN_COUNT"
      if [[ $DOWN_COUNT -ge 6 ]]; then   
        echo "killing btattach"    
        killall -SIGKILL btattach           
      fi                             
    fi
  fi
  sleep 20
done
