require 'test_helper'

module Spina
  class PagesTest < ActionDispatch::IntegrationTest
    setup do
      host! "dummy.test"

      I18n.locale = :en
      @routes = Engine.routes
      FactoryBot.create :account

      # UPDATE
      # To use new Spina::Page method
      @homepage = Spina::Page.find_by_path_locale_and_theme(theme_name: 'demo').presence || FactoryBot.create(:homepage)

      # Create translations for each page
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
        
      @child_page = FactoryBot.create :child_page
      @child_page.update(parent: @demo_page)
    end

    test "view homepage" do
      get "/"
      assert_select 'h1', 'Homepage'
    end

    test "view show page" do
      get "/about"
      assert_select 'h1', 'About'
    end

    test "view demo page" do
      get "/demo"
      assert_select 'h1', 'Demo'
    end
    
    test "view demo page with image" do
      spina_png = fixture_file_upload('spina.png','image/png')
      
      @image = Spina::Image.create
      @image.file.attach(io: spina_png, filename: 'spina.png')
      
      image_part = Spina::Parts::Image.new(name: "image", title: "Image", image_id: @image.id, signed_blob_id: @image.file.blob.signed_id, alt: "", filename: "spina.png")
      
      @demo_page.update(en_content: [image_part])
      get "/demo"
      assert_select 'img'
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
    
    test "helper methods parent app" do
      get "/"
      assert_select 'body', /This is some helper method/
    end
    
    test "add styles to active/current item in navigation" do
      get @child_page.materialized_path
      assert_select 'h1', 'Child page'
      
      assert_select ".list-item.active a", text: "Demo"
      assert_select ".list-item.current a", text: "Child page"
    end
  end
end
