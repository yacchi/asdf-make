#!/usr/bin/env bash

set -euo pipefail
GNU_TOOL="make"
#GNU_FTP=https://ftpmirror.gnu.org
#GNU_KEYRING=$GNU_FTP/gnu/gnu-keyring.gpg
GNU_FTP=https://ftp.gnu.org/gnu
GNU_KEYRING=$GNU_FTP/gnu-keyring.gpg
TOOL_NAME="gnumake"
TOOL_TEST="make --version"

GNU_CHECK_SIGNATURES="${GNU_CHECK_SIGNATURES:-strict}"

fail() {
  echo -e "asdf-$TOOL_NAME: $*"
  exit 1
}

curl_opts=(-fsSL)

sort_versions() {
  sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
    LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_gnu_releases() {
  while read -r line; do
    if [[ "$line" =~ ${GNU_TOOL}-([1-9]+\.[0-9]+(:?\.[0-9]+)*)\.tar\.gz\.sig ]]; then
      echo "${BASH_REMATCH[1]}"
    fi
  done < <(curl "${curl_opts[@]}" ${GNU_FTP}/${GNU_TOOL}/) | uniq
}

list_all_versions() {
  list_gnu_releases
}

download_release() {
  local version filename url sig_url gnu_keyring gpg_command
  version="$1"
  filename="$2"

  url="${GNU_FTP}/${GNU_TOOL}/${GNU_TOOL}-${version}.tar.gz"
  sig_url="${GNU_FTP}/${GNU_TOOL}/${GNU_TOOL}-${version}.tar.gz.sig"
  gnu_keyring=$(dirname "$filename")/gnu-keyring.gpg

  gpg_command="$(command -v gpg gpg2 | head -n 1 || :)"

  if [ -z "${gpg_command}" ]; then
    fail 'gpg or gpg2 command not found. You must install GnuPG'
  fi

  echo "* Downloading $TOOL_NAME release $version..."
  curl "${curl_opts[@]}" -o "$filename" "$url" || fail "Could not download $url"
  curl "${curl_opts[@]}" -o "$filename.sig" "$sig_url" || fail "Could not download signature $sig_url"

  if [[ "${GNU_CHECK_SIGNATURES}" == "strict" ]]; then
    curl "${curl_opts[@]}" -o "$gnu_keyring" "$GNU_KEYRING" || fail "Could not download gpg key $gnu_keyring"
    ${gpg_command} -q --keyring "$gnu_keyring" --verify "$filename.sig" || fail "Failed to GPG verification"
  fi
}

install_version() {
  local install_type="$1"
  local version="$2"
  local install_path="$3"
  local install_log="$ASDF_DOWNLOAD_PATH/install.log"

  if [ "$install_type" != "version" ]; then
    fail "asdf-$TOOL_NAME supports release installs only"
  fi

  (
    mkdir -p "$install_path"
    cd "$ASDF_DOWNLOAD_PATH"

    echo "* Installing $TOOL_NAME release $version..."
    ./configure --prefix="$install_path" &&
      ./build.sh &&
      ./make &&
      ./make install &>"$install_log" || fail "Failed to build $TOOL_NAME release $version. install log is $install_log"

    local tool_cmd
    tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
    test -x "$install_path/bin/$tool_cmd" || fail "Expected $install_path/bin/$tool_cmd to be executable."

    echo "$TOOL_NAME $version installation was successful!"
  ) || (
    rm -rf "$install_path"
    fail "An error ocurred while installing $TOOL_NAME $version."
  )
}
