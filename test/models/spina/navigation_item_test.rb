require "test_helper"

module Spina
  class NavigationItemTest < ActiveSupport::TestCase
    test "scope regular_pages returns pages without a specific resource" do
      resource = FactoryBot.create(:resource)
      regular_page = FactoryBot.create(:page, title: "Title")
      special_page = FactoryBot.create(:page, title: "Title", resource: resource)
      navigation = FactoryBot.create(:navigation)
      FactoryBot.create(:navigation_item, navigation: navigation, page: regular_page)
      FactoryBot.create(:navigation_item, navigation: navigation, page: special_page)
      
      regular_pages = navigation.navigation_items.regular_pages

      assert_equal regular_pages.size, 1
      assert_equal regular_pages.first.page, regular_page
    end

    test "scope sorted returns navigation_items ordered by their position" do
      navigation = FactoryBot.create(:navigation)
      page_1 = FactoryBot.create(:page, name: "Page 1", title: "Title")
      page_2 = FactoryBot.create(:page, name: "Page 2", title: "Title")
      page_3 = FactoryBot.create(:page, name: "Page 3", title: "Title")
      page_4 = FactoryBot.create(:page, name: "Page 4", title: "Title")

      FactoryBot.create(:navigation_item, navigation: navigation, page: page_1, position: 4)
      FactoryBot.create(:navigation_item, navigation: navigation, page: page_2, position: 3)
      FactoryBot.create(:navigation_item, navigation: navigation, page: page_3, position: 2)
      FactoryBot.create(:navigation_item, navigation: navigation, page: page_4, position: 1)

      sorted_items = navigation.navigation_items.sorted

      assert_equal sorted_items[0].page, page_4
      assert_equal sorted_items[1].page, page_3
      assert_equal sorted_items[2].page, page_2
      assert_equal sorted_items[3].page, page_1
    end

    test "scope live returns pages that are active and are not drafts" do
      live_page = FactoryBot.create(:page, active: true, draft: false, title: "Title")
      draft_page = FactoryBot.create(:page, active: true, draft: true, title: "Title")
      inactive_page = FactoryBot.create(:page, active: false, draft: false, title: "Title")
      draft_inactive_page = FactoryBot.create(:page, active: false, draft: true, title: "Title")
      navigation = FactoryBot.create(:navigation)
      FactoryBot.create(:navigation_item, navigation: navigation, page: live_page)
      FactoryBot.create(:navigation_item, navigation: navigation, page: draft_page)
      FactoryBot.create(:navigation_item, navigation: navigation, page: inactive_page)
      FactoryBot.create(:navigation_item, navigation: navigation, page: draft_inactive_page)
      
      live_pages = navigation.navigation_items.live

      assert_equal live_pages.size, 1
      assert_equal live_pages.first.page, live_page
    end
    
    test "scope in_menu returns pages that have show_in_menu set to true" do
      show_in_menu_page = FactoryBot.create(:page, show_in_menu: true, title: "Title")
      hide_in_menu_page = FactoryBot.create(:page, show_in_menu: false, title: "Title")
      navigation = FactoryBot.create(:navigation)
      FactoryBot.create(:navigation_item, navigation: navigation, page: show_in_menu_page)
      FactoryBot.create(:navigation_item, navigation: navigation, page: hide_in_menu_page)
      
      in_menu_pages = navigation.navigation_items.in_menu
  
      assert_equal in_menu_pages.size, 1
      assert_equal in_menu_pages.first.page, show_in_menu_page
    end
    
    test "scope active returns pages that are active" do
      active_page = FactoryBot.create(:page, active: true, title: "Title")
      inactive_page = FactoryBot.create(:page, active: false, title: "Title")
      navigation = FactoryBot.create(:navigation)
      FactoryBot.create(:navigation_item, navigation: navigation, page: active_page)
      FactoryBot.create(:navigation_item, navigation: navigation, page: inactive_page)
      
      active_pages = navigation.navigation_items.active
  
      assert_equal active_pages.size, 1
      assert_equal active_pages.first.page, active_page
    end
    
    test "pages are unique within the scope of the navigation" do
      page = FactoryBot.create(:page, title: "Title")
      first_navigation = FactoryBot.create(:navigation, name: "Main Navigation")
      second_navigation = FactoryBot.create(:navigation, name: "Secondary Navigation")
      nav_1_item_1 = FactoryBot.build(:navigation_item, navigation: first_navigation, page: page)
      nav_1_item_2 = FactoryBot.build(:navigation_item, navigation: first_navigation, page: page)
      nav_2_item_1 = FactoryBot.build(:navigation_item, navigation: second_navigation, page: page)

      assert nav_1_item_1.valid?
      nav_1_item_1.save
      
      assert nav_2_item_1.valid?
      nav_2_item_1.save

      assert nav_1_item_2.invalid?
    end

    test "url_title cannot be empty with a url present" do
      navigation_item = FactoryBot.build(:navigation_item, kind: :url, url: "URL", url_title: nil)
      assert navigation_item.invalid?
      assert_not_empty navigation_item.errors.where(:url_title)

      navigation_item.url_title = "Title"

      assert navigation_item.valid?
    end
    
    test "url cannot be empty with a url_title present" do
      navigation_item = FactoryBot.build(:navigation_item, kind: :url, url: nil, url_title: "Title")
      assert navigation_item.invalid?
      assert_not_empty navigation_item.errors.where(:url)

      navigation_item.url = "URL"

      assert navigation_item.valid?
    end
    
    test "url kind must have a url and url_title" do
      navigation_item = FactoryBot.build(:navigation_item, kind: :url, url: nil, url_title: nil)
      assert navigation_item.invalid?
      
      assert_not_empty navigation_item.errors.where(:url)
      assert_not_empty navigation_item.errors.where(:url_title)
  
      navigation_item.url = "URL"
      navigation_item.url_title = "Title"
  
      assert navigation_item.valid?
    end
    
    test "page kind must have a page" do
      navigation_item = FactoryBot.build(:navigation_item, kind: :page, page: nil)
      
      assert navigation_item.invalid?
      
      assert_not_empty navigation_item.errors.where(:page)
  
      navigation_item.page = FactoryBot.create(:page, title: "Title")
  
      assert navigation_item.valid?
    end
    
    test "menu_title returns the page's menu_title if it is of page kind" do
      page = FactoryBot.create(:page, title: "Title")
      navigation_item = FactoryBot.create(:navigation_item, page: page)

      assert_equal navigation_item.menu_title, page.menu_title
    end
    
    test "menu_title returns the url_title if it is of page kind" do
      navigation_item = FactoryBot.create(:navigation_item, kind: :url, url: "URL", url_title: "URL Title")
  
      assert_equal navigation_item.menu_title, navigation_item.url_title
    end
    
    test "materialized_path returns the page's materialized_path if there is a page" do
      page = FactoryBot.create(:page, title: "Title")
      navigation_item = FactoryBot.create(:navigation_item, page: page)

      assert_equal navigation_item.materialized_path, page.materialized_path
    end
    
    test "materialized_path returns the url if it is of url kind" do
      navigation_item = FactoryBot.create(:navigation_item, kind: :url, url: "URL", url_title: "URL Title")
  
      assert_equal navigation_item.materialized_path, navigation_item.url
    end

test "url cannot use an unsafe scheme" do
  [
    "javascript:alert(1)",
    "JavaScript:alert(1)",
    "  javascript:alert(1)",
    "\tjavascript:alert(1)",
    "java\nscript:alert(1)",
    "java\tscript:alert(1)",
    "data:text/html;base64,PHNjcmlwdD5hbGVydCgxKTwvc2NyaXB0Pg==",
    "vbscript:msgbox(1)",
    "ftp://example.com"
  ].each do |url|
    navigation_item = FactoryBot.build(:navigation_item, kind: :url, url: url, url_title: "Title")

    assert navigation_item.invalid?, "expected #{url.inspect} to be invalid"
    assert_not_empty navigation_item.errors.where(:url, :unsafe_url), "expected an unsafe_url error for #{url.inspect}"
  end
end

test "url allows safe schemes and relative urls" do
  [
    "https://example.com",
    "HTTP://EXAMPLE.COM/path?query=1#fragment",
    "//example.com",
    "/about",
    "about",
    "#contact",
    "?locale=nl",
    "mailto:hello@example.com",
    "tel:+31612345678"
  ].each do |url|
    navigation_item = FactoryBot.build(:navigation_item, kind: :url, url: url, url_title: "Title")

    assert navigation_item.valid?, "expected #{url.inspect} to be valid, got: #{navigation_item.errors.full_messages}"
  end
end

test "unsafe url has a translated error message" do
  navigation_item = FactoryBot.build(:navigation_item, kind: :url, url: "javascript:alert(1)", url_title: "Title")
  navigation_item.validate

  assert_includes navigation_item.errors[:url], "must be a relative path or start with http://, https://, mailto: or tel:"
end

  end
end
