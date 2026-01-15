__blog.format_fn.helper.get_log_level_name() {
  local log_level
  log_level="$1"
  case "$log_level" in
    0)
      echo "DEBUG"
      ;;
    1)
      echo "INFO"
      ;;
    2)
      echo "WARN"
      ;;
    3)
      echo "ERROR"
      ;;
    4)
      echo "FATAL"
      ;;
    *)
      echo "UNKNOWN"
      ;;
  esac
}

__blog.format_fn.raw() {
  while IFS= read -r line; do
    echo "$line"
  done
}

__blog.format_fn.bracketed() {
  local log_level
  log_level="$1"
  local log_level_name
  # shellcheck disable=SC2119
  log_level_name="$(__blog.format_fn.helper.get_log_level_name "$log_level")"
  while IFS= read -r line; do
    printf "[%7s]: %s\n" "$log_level_name" "$line"
  done
}
