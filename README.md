# selenium-standalone-chrome-jp

Google Chrome and Japanese fonts for use in the CUI.
It includes the following items.

- Google Chrome stable
- ChromeDriver
- Selenium Standalone Server
- Noto Sans CJK JP

## Usage

```shell
docker run --rm -p 4444:4444 jinguji/selenium-standalone-chrome-jp
```

## Building

- automatic

  ```shell
  export IMAGE_NAME=selenium-standalone-chrome-jp
  ./hooks/build
  ```

- manually

  ```shell
  docker build -t selenium-standalone-chrome-jp . \
    --build-arg java_version=8 \
    --build-arg selenium_version=3.4.0 \
    --build-arg selenium_version_short=3.4 \
    --build-arg driver_version=2.29
    --build-arg chrome_version=59.0.3071.104-1
  ```
