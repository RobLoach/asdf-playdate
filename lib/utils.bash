#!/usr/bin/env bash

set -euo pipefail

DOWNLOAD_BASE_URL="https://download-cdn.panic.com/playdate_sdk"
TOOL_NAME="playdate"
TOOL_TEST="bin/pdc --version"

plugin_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

fail() {
  echo -e "asdf-$TOOL_NAME: $*" >&2
  exit 1
}

curl_opts=(-fsSL)

sort_versions() {
  sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
    LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_all_versions() {
  # Discovered from the Panic CDN by scripts/discover-versions.bash
  cat "$plugin_dir/share/versions.txt"
}

release_extension() {
  local version="$1"

  case "$(uname -s)" in
  Darwin)
    # The earliest macOS releases shipped as a bare .pkg. Everything from
    # 1.9.3 onwards ships as a .zip holding PlaydateSDK.pkg.
    case "$version" in
    1.9.0 | 1.9.1 | 1.9.2)
      echo "pkg"
      ;;
    *)
      echo "zip"
      ;;
    esac
    ;;
  Linux)
    echo "tar.gz"
    ;;
  *)
    fail "Unsupported platform $(uname -s). The Playdate SDK is only available for Linux, macOS and Windows, and this plugin supports Linux and macOS."
    ;;
  esac
}

release_url() {
  local version="$1"

  case "$(uname -s)" in
  Darwin)
    echo "$DOWNLOAD_BASE_URL/PlaydateSDK-${version}.$(release_extension "$version")"
    ;;
  Linux)
    if [ "$(uname -m)" != "x86_64" ]; then
      fail "The Playdate SDK for Linux is only available for x86_64, not $(uname -m)."
    fi
    echo "$DOWNLOAD_BASE_URL/Linux/PlaydateSDK-${version}.tar.gz"
    ;;
  *)
    fail "Unsupported platform $(uname -s). The Playdate SDK is only available for Linux, macOS and Windows, and this plugin supports Linux and macOS."
    ;;
  esac
}

download_release() {
  local version filename url
  version="$1"
  filename="$2"
  url="$(release_url "$version")"

  echo "* Downloading $TOOL_NAME release $version..."
  # Not resuming with `-C -`: a complete leftover file makes the CDN answer the
  # out-of-range Range request with a 416, which `-f` turns into a hard failure.
  curl "${curl_opts[@]}" --retry 3 --retry-delay 2 -o "$filename" "$url" || fail "Could not download $url"
}

install_version() {
  local install_type="$1"
  local version="$2"
  local install_path="${3%/bin}"

  if [ "$install_type" != "version" ]; then
    fail "asdf-$TOOL_NAME supports release installs only"
  fi

  (
    mkdir -p "$install_path"
    # `-R`, not `-r`: BSD/macOS cp dereferences symlinks with the latter, which
    # would flatten the symlinks inside the SDK's .app bundles.
    cp -R "$ASDF_DOWNLOAD_PATH"/* "$install_path"

    local tool_cmd
    tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
    test -x "$install_path/$tool_cmd" || fail "Expected $install_path/$tool_cmd to be executable."

    echo "$TOOL_NAME $version installation was successful!"
  ) || (
    rm -rf "$install_path"
    fail "An error occurred while installing $TOOL_NAME $version."
  )
}
