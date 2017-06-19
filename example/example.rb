require 'capybara'
require 'selenium-webdriver'

Capybara.register_driver :remote_chrome do |app|
  Capybara::Selenium::Driver.new(
    app,
    browser: :remote,
    url: 'http://localhost:4444/wd/hub',
    desired_capabilities: Selenium::WebDriver::Remote::Capabilities.chrome(
      chromeOptions: {
        args: [
          '--headless',
          '--no-sandbox',
          '--window-size=1366,768'
        ]
      }
    )
  )
end

session = Capybara::Session.new(:remote_chrome)

# yahooトップの最初のニュースのURLを表示
session.visit('http://www.yahoo.co.jp')
first_news = session.find('.emphasis li:nth-child(1) a')
puts first_news.text
puts first_news[:href]

# スクリーンショット取得
session.save_screenshot('screenshot.png')
