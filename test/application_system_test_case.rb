require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  Webdrivers::Chromedriver.required_version = "114.0.5735.90"
  driven_by :selenium, using: :headless_chrome, screen_size: [1400, 1400]

  setup do
    FactoryBot.create :account
    @user = FactoryBot.create :user

    # Login
    visit spina.admin_login_path
    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password
    click_button "Login"
    assert_selector "div", text: "Pages"
  end
end
