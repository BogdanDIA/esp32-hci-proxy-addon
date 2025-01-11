#
# Home Assistant Add-On product's library
#
function initConfigVariables() {

  ### Required Configuration Settings
  export BLE_BTATTACH_DEVICE="$(bashio::config 'ble_btattach_device')"
  export BLE_SUDPFWD_DEVICE="$(bashio::config 'ble_sudpfwd_device')"
  export BLE_SUDPFWD_SERVER="$(bashio::config 'ble_sudpfwd_server')"

  ### Optional Configuration Settings
  if bashio::config.exists 'ble_btattach_baud'; then
    export BLE_BTATTACH_BAUD="$(bashio::config 'ble_btattach_baud')"
  else
    export BLE_BTATTACH_BAUD=""
  fi

  if bashio::config.exists 'ble_btattach_protocol'; then
    export BLE_BTATTACH_PROTOCOL="$(bashio::config 'ble_btattach_protocol')"
  else
    export BLE_BTATTACH_PROTOCOL=""
  fi

  if bashio::config.exists 'ble_btattach_hwflow'; then
    export BLE_BTATTACH_HWFLOW="$(bashio::config 'ble_btattach_hwflow')"
  else
    export BLE_BTATTACH_HWFLOW=""
  fi

  if bashio::config.exists 'ble_ble_sudpfwd_baud'; then                  
    export BLE_SUDPFWD_BAUD="$(bashio::config 'ble_sudpfwd_baud')"
  else                                                          
    export BLE_SUDPFWD_BAUD=""                                   
  fi                 

  if bashio::config.exists 'ble_sudpfwd_port'; then                     
    export BLE_SUDPFWD_PORT="$(bashio::config 'ble_sudpfwd_port')"          
  else                                                              
    export BLE_SUDPFWD_PORT=""                                          
  fi 

  if bashio::config.exists 'ble_sudpfwd_hwflow'; then                     
    export BLE_SUDPFWD_HWFLOW="$(bashio::config 'ble_sudpfwd_hwflow')"          
  else                                                              
    export BLE_SUDPFWD_HWFLOW=""                                          
  fi

  if bashio::config.exists 'ble_sudpfwd_flowdebug'; then                     
    export BLE_SUDPFWD_FLOWDEBUG="$(bashio::config 'ble_sudpfwd_flowdebug')"          
  else                                                              
    export BLE_SUDPFWD_FLOWDEBUG=""                                          
  fi    

 if bashio::config.exists 'ble_sudpfwd_datadebug'; then                
    export BLE_SUDPFWD_DATADEBUG="$(bashio::config 'ble_sudpfwd_datadebug')"
  else                                                              
    export BLE_SUDPFWD_DATADEBUG=""                                     
  fi

  if bashio::config.exists 'debug'; then
    export DEBUG="$(bashio::config 'debug')"
    if [ $DEBUG == "true" ]; then
      bashio::log.level debug
    fi
  else
    export DEBUG=""
  fi

  # Prevent bashio to complain for "unbound variable"
  export WHAT_VAR=""
}

#
# Definition functions to call bashio::log
#
function log_debug() {
  bashio::log.debug "$1"
}
function log_info() {
  bashio::log.info "$1"
}
function log_notice() {
  bashio::log.notice "$1"
}
function log_warning() {
  bashio::log.warning "$1"
}
function log_error() {
  bashio::log.error "$1"
}
function log_fatal() {
  bashio::log.fatal "$1"
}


#
# initProduct
#
initConfigVariables
