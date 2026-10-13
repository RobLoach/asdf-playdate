def --env asdf_update_playdate_home [] {
  let pdc_path = (do --ignore-errors { asdf which pdc } | default "" | str trim)

  if ($pdc_path | is-not-empty) {
    $env.PLAYDATE_SDK_PATH = ($pdc_path | path expand | path dirname | path dirname)
  }
}

# Nushell has no prompt hook to attach to automatically. Register the function
# yourself in your config.nu, for example:
#
#   $env.config.hooks.env_change.PWD ++= [{ |before, after| asdf_update_playdate_home }]
