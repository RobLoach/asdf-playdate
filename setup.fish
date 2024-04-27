function asdf_update_playdate_home --on-event fish_prompt
  set --local playdate_path (asdf which pdc)
  if test -n "$playdate_path"
    set --local full_path (builtin realpath "$playdate_path")

    # `builtin realpath` returns $PLAYDATE_SDK_PATH/bin/playdate, so we need two `dirname` calls
    # in order to get the correct PLAYDATE_SDK_PATH directory
    set -gx PLAYDATE_SDK_PATH (dirname (dirname "$full_path"))
    set -gx PLAYDATE_SDK_PATH "$PLAYDATE_SDK_PATH"
  end
end
