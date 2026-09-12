require "test_helper"

module Spina
  module Embeds
    class ButtonTest < ActiveSupport::TestCase
      test "url and label are required" do
        button = Button.new(url: nil, label: nil)

        assert button.invalid?
        assert_not_empty button.errors.where(:url, :blank)
        assert_not_empty button.errors.where(:label, :blank)
      end

      test "url cannot use an unsafe scheme" do
        [
          "javascript:alert(1)",
          "JavaScript:alert(1)",
          "java\nscript:alert(1)",
          "data:text/html,<script>alert(1)</script>",
          "vbscript:msgbox(1)"
        ].each do |url|
          button = Button.new(url: url, label: "Click me")

          assert button.invalid?, "expected #{url.inspect} to be invalid"
          assert_not_empty button.errors.where(:url, :unsafe_url), "expected an unsafe_url error for #{url.inspect}"
        end
      end

      test "url allows safe schemes and relative urls" do
        [
          "https://example.com",
          "http://example.com/path?query=1#fragment",
          "/about",
          "#contact",
          "mailto:hello@example.com",
          "tel:+31612345678"
        ].each do |url|
          button = Button.new(url: url, label: "Click me")

          assert button.valid?, "expected #{url.inspect} to be valid, got: #{button.errors.full_messages}"
        end
      end
    end
  end
end
