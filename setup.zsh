asdf_update_playdate_home() {
  local playdate_path
  playdate_path="$(asdf which pdc 2>/dev/null)"
  if [[ -n "${playdate_path}" ]]; then
    PLAYDATE_SDK_PATH="$(dirname "$(dirname "${playdate_path:A}")")"
    export PLAYDATE_SDK_PATH
  fi
}

autoload -U add-zsh-hook
add-zsh-hook precmd asdf_update_playdate_home
