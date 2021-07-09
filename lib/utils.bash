#!/usr/bin/env bash

set -euo pipefail
GNU_TOOL="make"
#GNU_FTP=https://ftpmirror.gnu.org
#GNU_KEYRING=$GNU_FTP/gnu/gnu-keyring.gpg
GNU_FTP=https://ftp.gnu.org/gnu
GNU_KEYRING=$GNU_FTP/gnu-keyring.gpg
TOOL_NAME="make"
TOOL_TEST="make --version"

MAKE_CHECK_SIGNATURES="${MAKE_CHECK_SIGNATURES:-strict}"
MAKE_PRINT_BUILD_LOG="${MAKE_PRINT_BUILD_LOG:-no}"
MAKE_BUILD_OPTIONS="${MAKE_BUILD_OPTIONS:---with-guile=no}"

current_script_path=${BASH_SOURCE[0]}
# shellcheck disable=SC2046
plugin_dir=$(
  cd $(dirname "$(dirname "$current_script_path")")
  pwd
)

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

  if [[ "${MAKE_CHECK_SIGNATURES}" == "strict" ]]; then
    curl "${curl_opts[@]}" -o "$gnu_keyring" "$GNU_KEYRING" || fail "Could not download gpg key $gnu_keyring"
    ${gpg_command} --keyring "$gnu_keyring" --verify "$filename.sig" 2>/dev/null || fail "Failed to GPG verification"
  fi
}

patch_source() {
  local version="$1"
  local glibc_version comparable_version
  comparable_version=$(echo "$version" | awk -F . '{printf "%2d%02d%02d", $1, $2, $3}')

  case $(uname) in
  Linux)
    glibc_version=$(ldd --version | grep -oE '2\.[0-9]{2}' | uniq | awk -F. '{printf "%2d%02d", $1, $2}')

    # glibc glob interface patch
    # http://gnu-make.2324884.n4.nabble.com/undefined-reference-to-alloca-td18308.html
    if [[ 226 -lt $glibc_version && $comparable_version -le 40201 ]]; then
      echo "* Patching glob interface of $TOOL_NAME release $version..."
      patch -p1 -s <"$plugin_dir/patchers/support-glibc-glob-interface-version2.patch"
    fi

    # segmentation fault on make install fix patch
    # https://stackoverflow.com/questions/52618055/gnu-make-3-82-on-ubuntu-18-04-segfault-in-glob-call
    if [[ $comparable_version -eq 38200 ]]; then
      echo "* Patching lstat interface of $TOOL_NAME release $version..."
      patch -s <"$plugin_dir/patchers/fix-segmentation-fault-3.82-on-linux.patch"
    fi

    ;;
  Darwin) ;;

  esac
}

patch_build_sh() {
  local version="$1"
  local comparable_version
  comparable_version=$(echo "$version" | awk -F . '{printf "%2d%02d%02d", $1, $2, $3}')

  if [[ $comparable_version -eq 40000 && ${MAKE_BUILD_OPTIONS} =~ --with-guile=no ]]; then
    # shellcheck disable=SC2016
    sed -i.bak -e 's/guile.${OBJEXT}//' build.sh
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

    patch_source "$version"

    echo "* Installing $TOOL_NAME release $version..."
    # If the make command is not installed on system old version, may get an error like the following:
    #
    #   config.status: error: Something went wrong bootstrapping makefile fragments
    #      for automatic dependency tracking.  Try re-running configure with the
    #      '--disable-dependency-tracking' option to at least be able to build
    #      the package (albeit without support for automatic dependency tracking).
    #
    # If try to make install in this state, the installation will fail because the
    # Makefile of the po directory does not exist.
    #
    # Will not use make, which is installed on the system, to ensure a reliable build.
    # First run configure to generate build.sh.
    # Then, configure to use the make generated by build.sh and run configure again.
    # At this time, can speed up second time configure by enabling configure caching (-C).
    if [[ "${MAKE_PRINT_BUILD_LOG}" == "yes" ]]; then
      {
        # shellcheck disable=SC2086
        ./configure -C --prefix="$install_path" ${MAKE_BUILD_OPTIONS}
        patch_build_sh "$version"
        ./build.sh &&
          PATH=$ASDF_DOWNLOAD_PATH:$PATH ./configure -C --prefix="$install_path" &&
          ./make install
      } 2>&1 | tee "$install_log"
    else
      {
        # shellcheck disable=SC2086
        ./configure -C --prefix="$install_path" ${MAKE_BUILD_OPTIONS}
        patch_build_sh "$version"
        ./build.sh &&
          PATH=$ASDF_DOWNLOAD_PATH:$PATH ./configure -C --prefix="$install_path" ${MAKE_BUILD_OPTIONS} &&
          ./make install
      } &>"$install_log"
    fi

    local tool_cmd
    tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
    test -x "$install_path/bin/$tool_cmd" || fail "Expected $install_path/bin/$tool_cmd to be executable."

    echo "$TOOL_NAME $version installation was successful!"
  ) || (
    rm -rf "$install_path"
    fail "An error ocurred while installing $TOOL_NAME $version. install log is $install_log"
  )
}
