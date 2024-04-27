def asdf_update_playdate_home [] {
  let $playdate_path = (asdf which pdc)

  if $playdate_path {
    let $full_path = (realpath $playdate_path | lines | nth 0 | str trim)

    let $PLAYDATE_SDK_PATH = ($full_path | path dirname | path dirname)
    let-env PLAYDATE_SDK_PATH = $PLAYDATE_SDK_PATH
  }
}
