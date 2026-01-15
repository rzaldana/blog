#!/usr/bin/env bash

test_debug() {
  set -euo pipefail
  source ../blog.bash

  tmpfile="$(mktemp)"
  # shellcheck disable=SC2064
  trap "rm '$tmpfile'" EXIT

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

