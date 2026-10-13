function asdf_update_playdate_home --on-event fish_prompt
  set --local playdate_path (asdf which pdc 2>/dev/null)
  if test -n "$playdate_path"
    set --local full_path (builtin realpath "$playdate_path")

    # `builtin realpath` returns $PLAYDATE_SDK_PATH/bin/pdc, so we need two `dirname` calls
    # in order to get the correct PLAYDATE_SDK_PATH directory
    set -gx PLAYDATE_SDK_PATH (dirname (dirname "$full_path"))
  end
end
