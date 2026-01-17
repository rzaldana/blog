test_basic() {
  tmpfile="$(mktemp)"
  # shellcheck disable=SC2064
  trap "rm $tmpfile" EXIT

  ./test_scripts/test.bash >&2 2>"$tmpfile"

  assert_no_diff "./expected_outputs/test.txt" "$tmpfile"
}
