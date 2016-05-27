require 'test_helper'

module Spina
  class PageTest < ActiveSupport::TestCase

    def setup
      @homepage = spina_pages(:homepage)
      @demo = spina_pages(:demo)
    end

    test 'homepage custom_page?' do
      assert_equal true, @homepage.custom_page?
    end

    test 'demo custom_page?' do
      assert_equal false, @demo.custom_page?
    end

  end
end
