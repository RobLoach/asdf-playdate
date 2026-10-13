function _asdf_playdate_absolute_dir_path {
  local absolute_path
  absolute_path="$(cd -P "$(dirname "$1")" && pwd)"
  echo "$absolute_path"
}

function _asdf_playdate_update_playdate_home() {
  local playdate_path
  playdate_path="$(asdf which pdc 2>/dev/null)"
  if [[ -n "${playdate_path}" ]]; then
    PLAYDATE_SDK_PATH="$(dirname "$(_asdf_playdate_absolute_dir_path "${playdate_path}")")"
    export PLAYDATE_SDK_PATH
  fi
}

function _asdf_playdate_prompt_command() {
  local e=$?
  if [[ "${PWD}" == "${LAST_PWD}" ]]; then
    return $e
  fi
  LAST_PWD="${PWD}"
  _asdf_playdate_update_playdate_home
  return $e
}

if ! [[ "${PROMPT_COMMAND:-}" =~ _asdf_playdate_prompt_command ]]; then
  PROMPT_COMMAND="_asdf_playdate_prompt_command${PROMPT_COMMAND:+;$PROMPT_COMMAND}"
fi
