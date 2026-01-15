#!/usr/bin/env bash

source core.bash

blog.set_level_debug() {
  __blog.set_log_level "0"
}

blog.debug() {
  __blog.log "0"
}

blog.set_level_info() {
  __blog.set_log_level "1"
}

blog.info() {
  __blog.log "1"
}

blog.set_level_warn() {
  __blog.set_log_level "2"
}

blog.warn() {
  __blog.log "2"
}

blog.set_level_error() {
  __blog.set_log_level "3"
}

blog.error() {
  __blog.log "3"
}

blog.set_level_fatal() {
  __blog.set_log_level "4"
}

blog.fatal() {
  __blog.log "4"
}

blog.set_level_off() {
  # find the largest integer
  # representable in this bash session
  local -i maxint=1 
  while :; do 
    next=$((maxint * 2)) 
    (( next > maxint )) || break 
    maxint=$next 
  done 

  # set the log level to maxint
  __blog.set_log_level "$maxint"
}
