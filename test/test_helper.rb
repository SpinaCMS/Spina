require "simplecov"
SimpleCov.start "rails"

# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../dummy/config/environment.rb", __FILE__)
require "rails/test_help"
require "minitest/unit"
require "minitest/reporters"
require "factory_bot"
require "mocha/minitest"

Minitest::Reporters.use! Minitest::Reporters::DefaultReporter.new

class Minitest::Unit::TestCase
  include FactoryBot::Syntax::Methods
end

FactoryBot.find_definitions

# Load file fixtures from the engine
ActiveSupport::TestCase.file_fixture_path = File.expand_path("fixtures/files", __dir__)

module AuthenticationHelper
  def change_authentication(auth)
    Spina.config.authentication = auth
    Spina::Admin.send(:remove_const, :AdminController)
    Spina::Admin.send(:remove_const, :PagesController)
    load("app/controllers/spina/admin/admin_controller.rb")
    load("app/controllers/spina/admin/pages_controller.rb")
  end
end
