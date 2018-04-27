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

    test 'url_title' do
      page = FactoryGirl.build(:page, title: 'Some long title')
      assert_equal page.url_title, 'some-long-title'
    end

    test 'url_title with specific locale' do
      Spina.config.transliterations = %i(latin bulgarian)
      page = FactoryGirl.build(:page, title: 'Тест страница')
      assert_equal page.url_title, 'test-stranica'
    end

    test 'url_title without valid title' do
      page = FactoryGirl.build(:page, title: nil)
      page.save(validate: false)
      assert_equal page.url_title, "page-#{page.id}"
    end
  end
end
