require 'test_helper'

module Spina
  class PageTest < ActiveSupport::TestCase

    def setup
      FactoryBot.create :account
      @homepage = FactoryBot.create :homepage
      @demo = FactoryBot.create :demo_page
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

    test 'custom slug' do
      @demo.update(url_title: "custom-slug")
      assert_equal "/custom-slug", @demo.materialized_path
    end

    test 'build slug from ancestors' do
      about = FactoryBot.create :about_page
      page = FactoryBot.create :services_page
      page.update(parent: about)
      assert_equal "/about/services", page.materialized_path
    end

  end
end
