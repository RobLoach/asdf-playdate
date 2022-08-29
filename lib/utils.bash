#!/usr/bin/env bash

set -euo pipefail

# TODO: Ensure this is the correct GitHub homepage where releases can be downloaded for playdate.
GH_REPO="https://download-keycdn.panic.com/playdate_sdk"
TOOL_NAME="playdate"
TOOL_TEST="bin/pdc --version"

fail() {
  echo -e "asdf-$TOOL_NAME: $*"
  exit 1
}

curl_opts=(-fsSL)

# NOTE: You might want to remove this if playdate is not hosted on GitHub releases.
if [ -n "${GITHUB_API_TOKEN:-}" ]; then
  curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
  sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
    LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
  git ls-remote --tags --refs "$GH_REPO" |
    grep -o 'refs/tags/.*' | cut -d/ -f3- |
    sed 's/^v//' # NOTE: You might want to adapt this sed to remove non-version strings from tags
}

list_all_versions() {
  # TODO: Adapt this. By default we simply list the tag names from GitHub releases.
  # Change this function if playdate has other means of determining installable versions.
  #list_github_tags

  # List all from https://download-keycdn.panic.com/playdate_sdk/Linux .
  echo "1.10.0"
  echo "1.11.0"
  echo "1.11.1"
  echo "1.12.0"
  echo "1.12.1"
  echo "1.12.2"
  echo "1.12.3"
  echo "1.9.0"
  echo "1.9.1"
  echo "1.9.2"
  echo "1.9.3"
}

download_release() {
  local version filename url platform extension
  version="$1"
  filename="$2"

  if [ "$(uname)" == "Darwin" ]; then
    platform="/"
    extension="zip"
  elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    platform="/Linux"
    extension="tar.gz"
  elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
    platform="/Windows"
    extension="exe"
  elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]; then
    platform="/Windows"
    extension="exe"
  fi

  # TODO: Adapt the release URL convention for playdate
  url="$GH_REPO${platform}/PlaydateSDK-${version}.${extension}"

  echo "* Downloading $TOOL_NAME release $version..."
  curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
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
    cp -r "$ASDF_DOWNLOAD_PATH"/* "$install_path"

    # TODO: Assert playdate executable exists.
    local tool_cmd
    tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
    test -x "$install_path/$tool_cmd" || fail "Expected $install_path/$tool_cmd to be executable."

    echo "$TOOL_NAME $version installation was successful!"
  ) || (
    rm -rf "$install_path"
    fail "An error occurred while installing $TOOL_NAME $version."
  )
}
