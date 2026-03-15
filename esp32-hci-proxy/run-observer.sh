#!/bin/ash

DOWN_COUNT=0
res=""

while :; do
  HCINUM=$(hciconfig | grep hci | wc -l)
  HCINUM=$(($HCINUM-1))                 
  echo "HCINUM: $HCINUM"                
                        
  #kill btattach after a number or tries                                                                  
  if [[ $HCINUM -ge 0 ]]; then
    res=$(hciconfig hci${HCINUM} | grep DOWN)
    if [[ ! -z $res ]]; then                   
      echo "Trying hciconfig up: hci$HCINUM"      
      hciconfig hci${HCINUM} up        
      DOWN_COUNT=$(($DOWN_COUNT+1))    
      echo "DOWN_COUNT: $DOWN_COUNT"
      if [[ $DOWN_COUNT -ge 6 ]]; then   
        echo "killing btattach"    
        killall -SIGKILL btattach
        DOWN_COUNT=0
      fi
    else
      DOWN_COUNT=0
    fi
  fi
  sleep 20
done
