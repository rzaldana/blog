#!/usr/bin/env bash

test_debug() {
  set -euo pipefail
  source ../blog.bash

  tmpfile="$(mktemp)"
  # shellcheck disable=SC2064
  trap "rm '$tmpfile'" EXIT

  blog.set_format_raw
  blog.set_level_debug

  blog.debug <<<"hello!" 2>"$tmpfile"
  assert_no_diff "$tmpfile" <( echo "hello!")
  : > "$tmpfile" # clear file contents

  blog.info <<<"hello!" 2>"$tmpfile"
  assert_no_diff "$tmpfile" <( echo "hello!")
  : > "$tmpfile" # clear file contents

  blog.warn <<<"hello!" 2>"$tmpfile"
  assert_no_diff "$tmpfile" <( echo "hello!")
  : > "$tmpfile" # clear file contents

  blog.error <<<"hello!" 2>"$tmpfile"
  assert_no_diff "$tmpfile" <( echo "hello!")
  : > "$tmpfile" # clear file contents

  blog.fatal <<<"hello!" 2>"$tmpfile"
  assert_no_diff "$tmpfile" <( echo "hello!")
  : > "$tmpfile" # clear file contents
}


test_info() {
  set -euo pipefail
  source ../blog.bash

  tmpfile="$(mktemp)"
  # shellcheck disable=SC2064
  trap "rm '$tmpfile'" EXIT

  blog.set_format_raw
  blog.set_level_info

  blog.debug <<<"hello!" 2>"$tmpfile"
  assert_no_diff "$tmpfile" <( echo -n "")
  : > "$tmpfile" # clear file contents

  blog.info <<<"hello!" 2>"$tmpfile"
  assert_no_diff "$tmpfile" <( echo "hello!")
  : > "$tmpfile" # clear file contents

  blog.warn <<<"hello!" 2>"$tmpfile"
  assert_no_diff "$tmpfile" <( echo "hello!")
  : > "$tmpfile" # clear file contents

  blog.error <<<"hello!" 2>"$tmpfile"
  assert_no_diff "$tmpfile" <( echo "hello!")
  : > "$tmpfile" # clear file contents

  blog.fatal <<<"hello!" 2>"$tmpfile"
  assert_no_diff "$tmpfile" <( echo "hello!")
  : > "$tmpfile" # clear file contents
}

test_warn() {
  set -euo pipefail
  source ../blog.bash

  tmpfile="$(mktemp)"
  # shellcheck disable=SC2064
  trap "rm '$tmpfile'" EXIT

  blog.set_format_raw
  blog.set_level_warn

  blog.debug <<<"hello!" 2>"$tmpfile"
  assert_no_diff "$tmpfile" <( echo -n "")
  : > "$tmpfile" # clear file contents

  blog.info <<<"hello!" 2>"$tmpfile"
  assert_no_diff "$tmpfile" <( echo -n "")
  : > "$tmpfile" # clear file contents

  blog.warn <<<"hello!" 2>"$tmpfile"
  assert_no_diff "$tmpfile" <( echo "hello!")
  : > "$tmpfile" # clear file contents

  blog.error <<<"hello!" 2>"$tmpfile"
  assert_no_diff "$tmpfile" <( echo "hello!")
  : > "$tmpfile" # clear file contents

  blog.fatal <<<"hello!" 2>"$tmpfile"
  assert_no_diff "$tmpfile" <( echo "hello!")
  : > "$tmpfile" # clear file contents
}

test_error() {
  set -euo pipefail
  source ../blog.bash

  tmpfile="$(mktemp)"
  # shellcheck disable=SC2064
  trap "rm '$tmpfile'" EXIT

  blog.set_format_raw
  blog.set_level_error

  blog.debug <<<"hello!" 2>"$tmpfile"
  assert_no_diff "$tmpfile" <( echo -n "")
  : > "$tmpfile" # clear file contents

  blog.info <<<"hello!" 2>"$tmpfile"
  assert_no_diff "$tmpfile" <( echo -n "")
  : > "$tmpfile" # clear file contents

  blog.warn <<<"hello!" 2>"$tmpfile"
  assert_no_diff "$tmpfile" <( echo -n "")
  : > "$tmpfile" # clear file contents

  blog.error <<<"hello!" 2>"$tmpfile"
  assert_no_diff "$tmpfile" <( echo "hello!")
  : > "$tmpfile" # clear file contents

  blog.fatal <<<"hello!" 2>"$tmpfile"
  assert_no_diff "$tmpfile" <( echo "hello!")
  : > "$tmpfile" # clear file contents
}

test_fatal() {
  set -euo pipefail
  source ../blog.bash

  tmpfile="$(mktemp)"
  # shellcheck disable=SC2064
  trap "rm '$tmpfile'" EXIT

  blog.set_format_raw
  blog.set_level_fatal

  blog.debug <<<"hello!" 2>"$tmpfile"
  assert_no_diff "$tmpfile" <( echo -n "")
  : > "$tmpfile" # clear file contents

  blog.info <<<"hello!" 2>"$tmpfile"
  assert_no_diff "$tmpfile" <( echo -n "")
  : > "$tmpfile" # clear file contents

  blog.warn <<<"hello!" 2>"$tmpfile"
  assert_no_diff "$tmpfile" <( echo -n "")
  : > "$tmpfile" # clear file contents

  blog.error <<<"hello!" 2>"$tmpfile"
  assert_no_diff "$tmpfile" <( echo -n "")
  : > "$tmpfile" # clear file contents

  blog.fatal <<<"hello!" 2>"$tmpfile"
  assert_no_diff "$tmpfile" <( echo "hello!")
  : > "$tmpfile" # clear file contents
}

test_off() {
  set -euo pipefail
  source ../blog.bash

  tmpfile="$(mktemp)"
  # shellcheck disable=SC2064
  trap "rm '$tmpfile'" EXIT

  blog.set_format_raw
  blog.set_level_off

  blog.debug <<<"hello!" 2>"$tmpfile"
  assert_no_diff "$tmpfile" <( echo -n "")
  : > "$tmpfile" # clear file contents

  blog.info <<<"hello!" 2>"$tmpfile"
  assert_no_diff "$tmpfile" <( echo -n "")
  : > "$tmpfile" # clear file contents

  blog.warn <<<"hello!" 2>"$tmpfile"
  assert_no_diff "$tmpfile" <( echo -n "")
  : > "$tmpfile" # clear file contents

  blog.error <<<"hello!" 2>"$tmpfile"
  assert_no_diff "$tmpfile" <( echo -n "")
  : > "$tmpfile" # clear file contents

  blog.fatal <<<"hello!" 2>"$tmpfile"
  assert_no_diff "$tmpfile" <( echo -n "")
  : > "$tmpfile" # clear file contents
}


test_function_returned_by_default_func_is_default_format_function_for_debug() {
  set -euo pipefail
  source ../blog.bash

  tmpfile="$(mktemp)"
  # shellcheck disable=SC2064
  trap "rm '$tmpfile'" EXIT

  blog.set_level_debug

  # mock bracketed format_fn
  __blog.format_fn.mock() {
  # shellcheck disable=SC2317
    while IFS= read -r line; do
     echo "[bracket]: $line" 
    done
  }

  # shellcheck disable=SC2317
  __blog.defaults.format_fn() {
    echo "__blog.format_fn.mock" 
  }

  blog.debug <<<"hello!" 2>"$tmpfile"
  assert_no_diff "$tmpfile" <( echo "[bracket]: hello!" )
  : > "$tmpfile" # clear file contents
}

test_set_format_bracketed_sets_bracketed_format_fn() {
  set -euo pipefail
  source ../blog.bash

  tmpfile="$(mktemp)"
  # shellcheck disable=SC2064
  trap "rm '$tmpfile'" EXIT

  blog.set_level_debug
  blog.set_format_bracketed
  assert_equals "$__BLOG_FORMAT_FUNCTION" "__blog.format_fn.bracketed"
}

