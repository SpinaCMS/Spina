require "test_helper"

module Spina
  class NavigationItemTest < ActiveSupport::TestCase
    test "scope regular_pages returns pages without a specific resource" do
      resource = FactoryBot.create :resource
      regular_page = FactoryBot.create :page
      special_page = FactoryBot.create :page, resource: resource
      navigation = FactoryBot.create :navigation
      FactoryBot.create :navigation_item, navigation: navigation, page: regular_page
      FactoryBot.create :navigation_item, navigation: navigation, page: special_page
      
      regular_pages = navigation.navigation_items.regular_pages

      assert_equal regular_pages.size, 1
      assert_equal regular_pages.first.page, regular_page
    end

    test "scope sorted returns navigation_items ordered by their position" do
      page_1 = FactoryBot.create :page
      page_2 = FactoryBot.create :page
      page_3 = FactoryBot.create :page
      page_4 = FactoryBot.create :page
      navigation = FactoryBot.create :navigation
      FactoryBot.create :navigation_item, navigation: navigation, page: page_1, position: 4
      FactoryBot.create :navigation_item, navigation: navigation, page: page_2, position: 3
      FactoryBot.create :navigation_item, navigation: navigation, page: page_3, position: 2
      FactoryBot.create :navigation_item, navigation: navigation, page: page_4, position: 1

      sorted_items = navigation.navigation_items.sorted

      assert_equal sorted_items[0].page, page_4
      assert_equal sorted_items[1].page, page_3
      assert_equal sorted_items[2].page, page_2
      assert_equal sorted_items[3].page, page_1
    end

    test "scope live returns pages that are active and are not drafts" do
      live_page = FactoryBot.create :page, active: true, draft: false
      draft_page = FactoryBot.create :page, active: true, draft: true
      inactive_page = FactoryBot.create :page, active: false, draft: false
      draft_inactive_page = FactoryBot.create :page, active: false, draft: true
      navigation = FactoryBot.create :navigation
      FactoryBot.create :navigation_item, navigation: navigation, page: live_page
      FactoryBot.create :navigation_item, navigation: navigation, page: draft_page
      FactoryBot.create :navigation_item, navigation: navigation, page: inactive_page
      FactoryBot.create :navigation_item, navigation: navigation, page: draft_inactive_page
      
      live_pages = navigation.navigation_items.live

      assert_equal live_pages.size, 1
      assert_equal live_pages.first.page, live_page
    end
    
    test "scope in_menu returns pages that have show_in_menu set to true" do
      show_in_menu_page = FactoryBot.create :page, show_in_menu: true
      hide_in_menu_page = FactoryBot.create :page, show_in_menu: false
      navigation = FactoryBot.create :navigation
      FactoryBot.create :navigation_item, navigation: navigation, page: show_in_menu_page
      FactoryBot.create :navigation_item, navigation: navigation, page: hide_in_menu_page
      
      in_menu_pages = navigation.navigation_items.in_menu
  
      assert_equal in_menu_pages.size, 1
      assert_equal in_menu_pages.first.page, show_in_menu_page
    end
    
    test "scope active returns pages that are active" do
      active_page = FactoryBot.create :page, active: true
      inactive_page = FactoryBot.create :page, active: false
      navigation = FactoryBot.create :navigation
      FactoryBot.create :navigation_item, navigation: navigation, page: active_page
      FactoryBot.create :navigation_item, navigation: navigation, page: inactive_page
      
      active_pages = navigation.navigation_items.active
  
      assert_equal active_pages.size, 1
      assert_equal active_pages.first.page, active_page
    end
    
    test "pages are unique within the scope of the navigation" do
      page = FactoryBot.create :page
      first_navigation = FactoryBot.create :navigation, name: "Main Navigation"
      second_navigation = FactoryBot.create :navigation, name: "Secondary Navigation"
      FactoryBot.create :navigation_item, navigation: first_navigation, page: page
      FactoryBot.create :navigation_item, navigation: second_navigation, page: page
      assert_raises (ActiveRecord::RecordInvalid) { FactoryBot.create :navigation_item, navigation: first_navigation, page: page }
    end
    
    test "multiple nil pages are allowed within the same navigation" do
      page = FactoryBot.create :page
      first_navigation = FactoryBot.create :navigation, name: "Main Navigation"
      second_navigation = FactoryBot.create :navigation, name: "Secondary Navigation"
      FactoryBot.create :navigation_item, navigation: first_navigation
      assert_nothing_raised { FactoryBot.create :navigation_item, navigation: first_navigation }
    end

    test "url cannot be present without a url_label" do
      navigation = FactoryBot.create :navigation
      assert_raises (ActiveRecord::RecordInvalid) { FactoryBot.create :navigation_item, navigation: navigation, url: "URL" }
    end
    
    test "url_label cannot be present without a url" do
      navigation = FactoryBot.create :navigation
      assert_raises (ActiveRecord::RecordInvalid) { FactoryBot.create :navigation_item, navigation: navigation, url_label: "URL Label" }
    end
    
    test "url or page must be present" do
      navigation = FactoryBot.create :navigation
      assert_raises (ActiveRecord::RecordInvalid) { FactoryBot.create :navigation_item, navigation: navigation, page: nil, url: nil, url_label: nil }
    end
    
    test "menu_title returns the page's menu_title if there is a page" do      
      navigation = FactoryBot.create :navigation
      page = FactoryBot.create :page
      navigation_item = FactoryBot.create :navigation_item, navigation: navigation, page: page

      assert_equal navigation_item.menu_title, page.menu_title
    end
    
    test "menu_title returns the url_label if there is no page" do
      navigation = FactoryBot.create :navigation
      page = FactoryBot.create :page
      navigation_item = FactoryBot.create :navigation_item, navigation: navigation, page: nil, url: "URL", url_label: "URL Label"
  
      assert_equal navigation_item.menu_title, navigation_item.url_label
    end
    
    test "materialized_path returns the page's materialized_path if there is a page" do      
      navigation = FactoryBot.create :navigation
      page = FactoryBot.create :page
      navigation_item = FactoryBot.create :navigation_item, navigation: navigation, page: page

      assert_equal navigation_item.materialized_path, page.materialized_path
    end
    
    test "materialized_path returns the url if there is no page" do
      navigation = FactoryBot.create :navigation
      page = FactoryBot.create :page
      navigation_item = FactoryBot.create :navigation_item, navigation: navigation, page: nil, url: "URL", url_label: "URL Label"
  
      assert_equal navigation_item.materialized_path, navigation_item.url
    end
  end
end
