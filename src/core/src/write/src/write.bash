
__log.core.write.get_default_destination_fd() {
  echo "2"
}

__log.core.write.is_destination_fd_set() {
  if [[ -n "${__BLOG_WRITE_DESTINATION_FD:-}" ]]; then
    return 0
  else
    return 1
  fi
}

__log.core.write.set_destination_fd() {
  __BLOG_WRITE_DESTINATION_FD="$1"
  export __BLOG_WRITE_DESTINATION_FD
}

__log.core.write.write() {
  local destination_fd
  destination_fd="${__BLOG_WRITE_DESTINATION_FD}"
  while IFS= read -r log_line; do
    echo "$log_line" >&"$destination_fd"
  done
}
