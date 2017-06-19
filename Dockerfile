FROM ubuntu:latest

MAINTAINER jinguji

ARG java_version
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
      wget \
      unzip \
      "openjdk-${java_version}-jre-headless" \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

RUN wget -q https://noto-website-2.storage.googleapis.com/pkgs/NotoSansCJKjp-hinted.zip \
    && mkdir /usr/share/fonts/noto \
    && unzip NotoSansCJKjp-hinted.zip \
      NotoSansCJKjp-Regular.otf \
      NotoSansCJKjp-Bold.otf \
      -d /usr/share/fonts/noto/ \
    && rm NotoSansCJKjp-hinted.zip

ARG selenium_version
ARG selenium_version_short
RUN wget -q -O selenium-server-standalone.jar \
      "http://selenium-release.storage.googleapis.com/${selenium_version_short}/selenium-server-standalone-${selenium_version}.jar"

ARG driver_version
RUN wget -q "https://chromedriver.storage.googleapis.com/${driver_version}/chromedriver_linux64.zip" \
    && unzip chromedriver_linux64.zip \
    && rm chromedriver_linux64.zip

ARG chrome_version
RUN echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' > /etc/apt/sources.list.d/google.list \
    && wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
      google-chrome-stable="$chrome_version" \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

ENTRYPOINT ["java", "-jar", "selenium-server-standalone.jar"]
