#!/usr/bin/env xonsh

def asdf_update_playdate_home() -> None:
  $playdate_path=$(asdf which pdc)
  if len($playdate_path) > 0:
    $PLAYDATE_SDK_PATH=$(dirname $(dirname $(realpath $playdate_path))).rstrip('\n')
  del $playdate_path

@events.on_chdir
def update_playdate_home_on_chdir(olddir, newdir, **kw) -> None:
  asdf_update_playdate_home()

@events.on_post_init
def update_playdate_home_on_post_init() -> None:
  asdf_update_playdate_home()
