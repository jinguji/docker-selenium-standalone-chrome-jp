#! /bin/bash

JAVA_VERSION="$(curl https://www.java.com/ja/download/ | grep Version | awk '{print $2}')"
SELENIUM_VERSION="$(
  curl https://api.github.com/repos/SeleniumHQ/selenium/releases \
    | grep tag_name \
    | head -n 1 \
    | sed -e 's/[^0-9.]//g'
)"
DRIVER_VERSION="$(curl https://chromedriver.storage.googleapis.com/LATEST_RELEASE)"
CHROME_VERSION="$(
  curl https://www.ubuntuupdates.org/package/google_chrome/stable/main/base/google-chrome-stable \
    | grep Version: \
    | head -n 1 \
    | sed -e 's/.*>//'
)"

cat << EOS > "$(dirname "$0")"/VERSIONS
JAVA_VERSION=$JAVA_VERSION
SELENIUM_VERSION=$SELENIUM_VERSION
DRIVER_VERSION=$DRIVER_VERSION
CHROME_VERSION=$CHROME_VERSION
EOS
