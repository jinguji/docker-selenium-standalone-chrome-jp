#! /bin/bash

JAVA_VERSION="$(curl https://www.java.com/ja/download/ | grep Version | awk '{print $2}')"
SELENIUM_VERSION="$(
  wget https://api.github.com/repos/SeleniumHQ/selenium/releases -O - \
    | grep tag_name \
    | head -n 1 \
    | sed -e 's/[^0-9.]//g'
)"
DRIVER_VERSION="$(wget https://chromedriver.storage.googleapis.com/LATEST_RELEASE -O -)"
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
