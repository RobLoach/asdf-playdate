#!/usr/bin/env bash

# Probes the Panic CDN for available Playdate SDK releases and rewrites
# share/versions.txt with every version that exists.

set -euo pipefail

plugin_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
versions_file="$plugin_dir/share/versions.txt"
base_url="https://download-cdn.panic.com/playdate_sdk"

candidates() {
  local major minor patch
  for major in $(seq 1 5); do
    for minor in $(seq 0 20); do
      for patch in $(seq 0 15); do
        echo "$major.$minor.$patch"
      done
    done
  done
}

# Discover into a temporary file first: redirecting straight into the tracked
# file would empty it before the sanity check below ever runs.
discovered="$(mktemp)"
trap 'rm -f "$discovered"' EXIT

candidates |
  xargs -P 8 -I {} bash -c \
    "curl -sfI -o /dev/null '$base_url/Linux/PlaydateSDK-{}.tar.gz' && echo {} || true" |
  sort -V >"$discovered"

if [ ! -s "$discovered" ]; then
  echo "No versions discovered; refusing to write an empty $versions_file" >&2
  exit 1
fi

cp "$discovered" "$versions_file"

echo "Discovered $(wc -l <"$versions_file") versions:"
cat "$versions_file"
