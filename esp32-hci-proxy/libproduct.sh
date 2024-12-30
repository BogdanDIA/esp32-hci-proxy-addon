#
# Home Assistant Add-On product's library
#
function initConfigVariables() {

  ### Required Configuration Settings
  export BTATTACH_DEVICE="$(bashio::config 'btattach_device')"
  export SUDPFWD_DEVICE="$(bashio::config 'sudpfwd_device')"
  export SUDPFWD_SERVER="$(bashio::config 'sudpfwd_server')"

  ### Optional Configuration Settings
  if bashio::config.exists 'btattach_baud'; then
    export BTATTACH_BAUD="$(bashio::config 'btattach_baud')"
  else
    export BTATTACH_BAUD=""
  fi

  if bashio::config.exists 'btattach_protocol'; then
    export BTATTACH_PROTOCOL="$(bashio::config 'btattach_protocol')"
  else
    export BTATTACH_PROTOCOL=""
  fi

  if bashio::config.exists 'btattach_hwflow'; then
    export BTATTACH_HWFLOW="$(bashio::config 'btattach_hwflow')"
  else
    export BTATTACH_HWFLOW=""
  fi

  if bashio::config.exists 'sudpfwd_baud'; then                  
    export SUDPFWD_BAUD="$(bashio::config 'sudpfwd_baud')"
  else                                                          
    export SUDPFWD_BAUD=""                                   
  fi                 

  if bashio::config.exists 'sudpfwd_port'; then                     
    export SUDPFWD_PORT="$(bashio::config 'sudpfwd_port')"          
  else                                                              
    export SUDPFWD_PORT=""                                          
  fi 

  if bashio::config.exists 'sudpfwd_hwflow'; then                     
    export SUDPFWD_HWFLOW="$(bashio::config 'sudpfwd_hwflow')"          
  else                                                              
    export SUDPFWD_HWFLOW=""                                          
  fi

  if bashio::config.exists 'sudpfwd_flowdebug'; then                     
    export SUDPFWD_FLOWDEBUG="$(bashio::config 'sudpfwd_flowdebug')"          
  else                                                              
    export SUDPFWD_FLOWDEBUG=""                                          
  fi    

 if bashio::config.exists 'sudpfwd_datadebug'; then                
    export SUDPFWD_DATADEBUG="$(bashio::config 'sudpfwd_datadebug')"
  else                                                              
    export SUDPFWD_DATADEBUG=""                                     
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
