#!/usr/bin/env bash

set -e

PACKAGE_PROTOCOL="https"
PACKAGE_HOST="download.virtualbox.org"
CHECKSUM_URL_BASE="${PACKAGE_PROTOCOL}://www.virtualbox.org"
CASK_FILE="templates/generic.cask"

# shellcheck source=./VERSIONS.sh
. "./VERSIONS.sh"

# shellcheck source=../homebrew-tools/FUNCTIONS.sh
. "../homebrew-tools/FUNCTIONS.sh"

case "${1}" in
  virtualbox)
    BINARY="virtualbox"
    NAME="VirtualBox"
    HOMEPAGE="https:\/\/www.virtualbox.org\/"
    CASK_FILE="templates/virtualbox.cask"

    for PRODUCT_VERSION in "${VIRTUALBOX_5XX[@]}"; do
      VERSION="${PRODUCT_VERSION%%,*}" # split on comma and use first part
      BUILD="${PRODUCT_VERSION##*,}" # split on comma and use second part

      # TODO: implement a cleaner way of building `VERSION_CLEAN`
      VERSION_CLEAN="${VERSION/_/-}"
      VERSION_CLEAN="${VERSION_CLEAN/BETA/beta}"
      VERSION_CLEAN="${VERSION_CLEAN/RC/rc}"
      # shellcheck disable=SC2034
      PACKAGE_PATH="${NAME}-${VERSION}-${BUILD}-OSX.dmg"
      CHECKSUM_URL="${CHECKSUM_URL_BASE}/download/hashes/${VERSION}/SHA256SUMS"
      CHECKSUM_PATTERN="*${PACKAGE_PATH}"
      generate_cask
    done
    ;;
  virtualbox-extpack) #NOT IMP
    BINARY="virtualbox"
    NAME="Oracle_VM_VirtualBox_Extension_Pack"
    HOMEPAGE="https:\/\/www.virtualbox.org\/"
    CASK_FILE="templates/virtualbox-extpack.cask"

    for PRODUCT_VERSION in "${VIRTUALBOX_5XX[@]}"; do
      VERSION="${PRODUCT_VERSION%%,*}" # split on comma and use first part
      BUILD="${PRODUCT_VERSION##*,}" # split on comma and use second part

      # TODO: implement a cleaner way of building `VERSION_CLEAN`
      VERSION_CLEAN="${VERSION/_/-}"
      VERSION_CLEAN="${VERSION_CLEAN/BETA/beta}"
      VERSION_CLEAN="${VERSION_CLEAN/RC/rc}"
      # shellcheck disable=SC2034
      PACKAGE_PATH="${NAME}-${VERSION}-${BUILD}.vbox-extpack"
      CHECKSUM_URL="${CHECKSUM_URL_BASE}/download/hashes/${VERSION}/SHA256SUMS"
      CHECKSUM_PATTERN="*${PACKAGE_PATH}"
      generate_cask
    done
    ;;

  *)
    echo "missing product"
    ;;
esac
