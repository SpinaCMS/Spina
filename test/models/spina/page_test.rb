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

    test 'url_title' do
      page = FactoryBot.build(:page, title: 'Some long title')
      assert_equal 'some-long-title', page.slug
    end

    test 'url_title with specific locale' do
      Spina.config.transliterations = %i(latin bulgarian)
      page = FactoryBot.build(:page, title: 'Тест страница')
      assert_equal 'test-stranica', page.slug
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
    
    test 'append decimal to duplicate paths' do
      page = FactoryBot.create :about_page, title: "About"
      assert_equal "/about", page.materialized_path
      
      duplicate_page = FactoryBot.create :about_page, title: "About"
      assert_equal "/about-1", duplicate_page.materialized_path
    end
    
    test 'append decimal to multiple duplicate paths' do
      2.times do
        FactoryBot.create :about_page, title: "About"
      end
      
      page = FactoryBot.create :about_page, title: "About"
      assert_equal "/about-2", page.materialized_path
    end
    
    test 'page has a position' do
      page = FactoryBot.create :about_page, title: "About"
      assert_not_nil page.position
    end

  end
end
