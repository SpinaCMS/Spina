require 'test_helper'

module Spina
  class PageTest < ActiveSupport::TestCase

    def setup
      FactoryGirl.create :account
      @homepage = FactoryGirl.create :homepage
      @demo = FactoryGirl.create :demo_page
    end

    test 'homepage custom_page?' do
      assert_equal true, @homepage.custom_page?
    end

    test 'demo custom_page?' do
      assert_equal false, @demo.custom_page?
    end

    test 'homepage live?' do
      assert_equal true, @homepage.live?
    end

    test 'demo live?' do
      assert_equal false, @demo.live?
    end

  end
end
