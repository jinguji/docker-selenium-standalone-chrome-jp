#! /bin/bash

set -eu
trap 'exit 1' ERR

function is_valid () {
  if [ -z "$1" ]; then
    echo 'Version is empty.'
    return 1
  fi
  if ! [[ "$1" =~ ^[0-9.-]+$ ]]; then
    echo "Invalid version. ($1)"
    return 1
  fi
}

echo 'Get Java version'
JAVA_VERSION="$(curl https://www.java.com/ja/download/ | grep Version | awk '{print $2}')"
is_valid "$JAVA_VERSION"

echo 'Get Selenium version'
SELENIUM_VERSION="$(
  curl https://api.github.com/repos/SeleniumHQ/selenium/releases \
    | grep tag_name \
    | head -n 1 \
    | sed -e 's/[^0-9.]//g'
)"
is_valid "$SELENIUM_VERSION"

echo 'Get Driver version'
DRIVER_VERSION="$(curl https://chromedriver.storage.googleapis.com/LATEST_RELEASE)"
is_valid "$DRIVER_VERSION"

echo 'Get Chrome version'
CHROME_VERSION="$(
  curl http://dl.google.com/linux/chrome/deb/dists/stable/main/binary-amd64/Packages \
    | sed -n '/Package: google-chrome-stable/{n;p;}' \
    | sed -r 's/Version: (.+)/\1/'
)"
is_valid "$CHROME_VERSION"

cat << EOS > "$(dirname "$0")"/VERSIONS
JAVA_VERSION=$JAVA_VERSION
SELENIUM_VERSION=$SELENIUM_VERSION
DRIVER_VERSION=$DRIVER_VERSION
CHROME_VERSION=$CHROME_VERSION
EOS
