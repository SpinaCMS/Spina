require "test_helper"

module Spina
  class ThemeReloaderTest < ActiveSupport::TestCase
    
    setup do
      @reloader = Spina::ThemeReloader.new
      @theme = Rails.root.join("config/initializers/themes/demo.rb")
    end
    
    test "reload is triggered when theme changes" do
      assert_changes -> { @reloader.updated? }, from: false, to: true do
        touch_theme
      end
    end
    
    private
    
      def touch_theme
        FileUtils.touch(@theme)
      end
  end
end