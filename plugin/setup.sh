if [[ -n "${VIM_TERMINAL}" ]]; then
  function vim() {
    ${EDITOR} "$@"
  }
fi
