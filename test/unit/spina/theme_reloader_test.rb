require "test_helper"

module Spina
  class ThemeReloaderTest < ActiveSupport::TestCase
    setup do
      @reloader = Spina::ThemeReloader.new
      @theme = Rails.root.join("config/initializers/themes/demo.rb")
      @templates_dir = Rails.root.join("app/templates/spina/demo")
    end

    test "reload is triggered when theme changes" do
      assert_changes -> { @reloader.updated? }, from: false, to: true do
        FileUtils.touch(@theme)
      end
    end

    test "reload is triggered when a new template file is added" do
      new_template = @templates_dir.join("_reloader_new_template.rb")
      FileUtils.rm_f(new_template)

      begin
        assert_changes -> { @reloader.updated? }, from: false, to: true do
          File.write(new_template, <<~RUBY)
            Spina.define_template :reloader_new_template do
              part :body, :text
            end
          RUBY
        end
      ensure
        FileUtils.rm_f(new_template)
      end
    end
  end
end
