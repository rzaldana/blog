# Get the directory of the script that's currently running
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

test_log_sends_message_through_filter_format_write_pipeline() {
  set -euo pipefail
  source "$SCRIPT_DIR/../blog.bash"
  local message="my message"
  # Create tmpfile to store output
  tmpfile="$(mktemp)"
  # shellcheck disable=SC2064
  trap "rm $tmpfile" EXIT

  # mock filter function
  __blog.filter.filter() {
    while IFS= read -r line; do
      echo "[filtered] $line"
    done
  }
  
  # mock format function
  __blog.format.format() {
    while IFS= read -r line; do
      echo "[formatted] $line"
    done
  }

  # mock write function
  __blog.write.write() {
    while IFS= read -r line; do
      echo "[written] $line"
    done
  }
  

  __blog.format.set_format_function "mock_format"
  # shellcheck disable=SC2119
  __blog.log.log "3" <<<"$message" >"$tmpfile"

  assert_no_diff "$tmpfile" <(echo "[written] [formatted] [filtered] $message")
}


test_log_uses_default_format_fn_if_no_format_fn_is_configured() {
  set -euo pipefail
  source ../blog.bash

  tmpfile="$(mktemp)"
  # shellcheck disable=SC2064
  trap "rm '$tmpfile'" EXIT


  # mock bracketed format_fn
  mock_format_fn() {
  # shellcheck disable=SC2317
    while IFS= read -r line; do
     echo "[bracket]: $line" 
    done
  }

  # shellcheck disable=SC2317
  __blog.log.default_format_fn() {
    echo "mock_format_fn" 
  }

  __blog.log.set_level "DEBUG"
  __blog.log.set_destination_fd "3"
  __blog.log.log "DEBUG" <<<"hello!" 3>"$tmpfile"
  assert_no_diff "$tmpfile" <( echo "[bracket]: hello!" )
  : > "$tmpfile" # clear file contents
}


test_log_uses_default_destination_fd_if_no_destination_fd_is_configured() {
  set -euo pipefail
  source ../blog.bash

  tmpfile="$(mktemp)"
  # shellcheck disable=SC2064
  trap "rm '$tmpfile'" EXIT


  # mock bracketed format_fn
  mock_format_fn() {
  # shellcheck disable=SC2317
    while IFS= read -r line; do
     echo "[bracket]: $line" 
    done
  }

  # shellcheck disable=SC2317
  __blog.log.default_format_fn() {
    echo "mock_format_fn" 
  }

  __blog.log.default_destination_fd() {
    echo "6"
  }


  __blog.log.set_level "DEBUG"
  __blog.log.set_format_fn "__blog.log.raw_format_fn"
  __blog.log.log "DEBUG" <<<"hello!" 6>"$tmpfile"
  assert_no_diff "$tmpfile" <( echo "hello!" )
  : > "$tmpfile" # clear file contents
}
