require "test_helper"

module Spina
  class PageTest < ActiveSupport::TestCase
    def setup
      FactoryBot.create :account
      @homepage = FactoryBot.create :homepage
      @demo = FactoryBot.create :demo_page
    end

    test "homepage custom_page?" do
      assert_equal true, @homepage.custom_page?
    end

    test "demo custom_page?" do
      assert_equal false, @demo.custom_page?
    end

    test "homepage live?" do
      assert_equal true, @homepage.live?
    end

    test "demo live?" do
      assert_equal false, @demo.live?
    end

    test "url_title" do
      page = FactoryBot.build(:page, title: "Some long title")
      assert_equal "some-long-title", page.slug
    end

    test "url_title with specific locale" do
      Spina.config.transliterations = %i[latin bulgarian]
      page = FactoryBot.build(:page, title: "Тест страница")
      assert_equal "test-stranica", page.slug
    end

    test "custom slug" do
      @demo.update(url_title: "custom-slug")
      assert_equal "/custom-slug", @demo.materialized_path
    end

    test "url follows the title by default" do
      page = FactoryBot.create(:page, title: "First title")
      page.update(title: "Second title")

      assert_equal "/second-title", page.materialized_path
    end

    test "freeze_url_titles keeps the url of a live page when the title changes" do
      Spina.config.freeze_url_titles = true
      page = FactoryBot.create(:page, title: "First title")
      page.update(title: "Second title")

      assert_equal "/first-title", page.materialized_path
      assert_empty RewriteRule.all
    ensure
      Spina.config.freeze_url_titles = false
    end

    test "freeze_url_titles still allows changing the url through url_title" do
      Spina.config.freeze_url_titles = true
      page = FactoryBot.create(:page, title: "First title")
      page.update(url_title: "different-url")

      assert_equal "/different-url", page.materialized_path
      assert_equal [["/first-title", "/different-url"]], RewriteRule.pluck(:old_path, :new_path)
    ensure
      Spina.config.freeze_url_titles = false
    end

    test "freeze_url_titles keeps drafts following the title" do
      Spina.config.freeze_url_titles = true
      page = FactoryBot.create(:page, title: "First title", draft: true)
      page.update(title: "Second title")

      assert_equal "/second-title", page.materialized_path
    ensure
      Spina.config.freeze_url_titles = false
    end

    test "build slug from ancestors" do
      about = FactoryBot.create :about_page
      page = FactoryBot.create :services_page
      page.update(parent: about)
      assert_equal "/about/services", page.materialized_path
    end

    test "append decimal to duplicate paths" do
      page = FactoryBot.create :about_page, title: "About"
      assert_equal "/about", page.materialized_path

      duplicate_page = FactoryBot.create :about_page, title: "About"
      assert_equal "/about-1", duplicate_page.materialized_path
    end

    test "append decimal to multiple duplicate paths" do
      2.times do
        FactoryBot.create :about_page, title: "About"
      end

      page = FactoryBot.create :about_page, title: "About"
      assert_equal "/about-2", page.materialized_path
    end

    test "page has a position" do
      page = FactoryBot.create :about_page, title: "About"
      assert_not_nil page.position
    end
  end
end
