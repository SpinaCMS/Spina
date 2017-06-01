require 'simplecov'
SimpleCov.start

# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rails/test_help"
require "minitest/reporters"
require 'factory_girl'

Minitest::Reporters.use! Minitest::Reporters::DefaultReporter.new

class Minitest::Unit::TestCase
  include FactoryGirl::Syntax::Methods
end

FactoryGirl.find_definitions

# Load fixtures from the engine
# ActiveSupport::TestCase.fixture_path = File.expand_path("../fixtures", __FILE__)
# ActionDispatch::IntegrationTest.fixture_path = File.expand_path("../fixtures", __FILE__)
#
# class ActiveSupport::TestCase
#   fixtures :all
# end
#
# class ActionDispatch::IntegrationTest
#   fixtures :all
# end
