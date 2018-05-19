require 'test_helper'

module Spina
  class PagesTest < ActionDispatch::IntegrationTest
    setup do
      I18n.locale = :en
      @routes = Engine.routes
      FactoryBot.create :account

      # Create translations for each page
      @homepage = Spina::Page.find_by(name: 'homepage')
      FactoryBot.create :page_translation,
        spina_page_id: @homepage.id, title: 'Beginpagina',
        materialized_path: '/nl', locale: 'nl'
      @about_page = FactoryBot.create :about_page
      page = FactoryBot.create :page_translation,
        spina_page_id: @about_page.id, title: 'Over ons',
        materialized_path: '/nl/over-ons', locale: 'nl'

      @demo_page = Spina::Page.find_by(name: 'demo')
      FactoryBot.create :page_translation,
        spina_page_id: @demo_page.id, title: 'Demo',
        materialized_path: '/nl/demo', locale: 'nl'
    end

    test "view homepage" do
      get "/"
      assert_select 'h1', 'Homepage'
    end

    test "view show page" do
      get "/about"
      assert_select 'h1', 'About'
    end

    # Different languages
    test "view homepage in another language" do
      get "/nl"
      assert_select 'h1', 'Beginpagina'
    end

    test "view show page in another language" do
      get "/nl/over-ons"
      assert_select 'h1', 'Over ons'
    end
  end
end
