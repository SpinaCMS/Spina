require "test_helper"

module Spina
  class AccountTest < ActiveSupport::TestCase    
    def setup
      @account = FactoryBot.create :account
      @theme = Spina::Theme.find_by_name(@account.theme)
    end

    test "after_save callback to bootstrap_navigations creates navigations" do
      @theme.navigations << {name: "navigation", label: "Navigation"}
      @account.save
      navigation = Spina::Navigation.find_by(name: "navigation")
      
      assert navigation
    end

    test "after_save callback to bootstrap_pages creates custom pages" do
      @theme.custom_pages << {name: "page", title: "Page", deletable: true, view_template: "page_template"}
      @account.save
      page = Spina::Page.find_by(name: "page")
      
      assert page
    end

    test "after_save callback to bootstrap_pages creates nested pages" do
      parent_page = FactoryBot.create :page, name: "parent"
      @theme.custom_pages << {name: "child", title: "Child", deletable: true, view_template: "child_page", parent: parent_page.name}
      @account.save
      child_page = Spina::Page.find_by(name: "child")

      assert_equal child_page.parent.id, parent_page.id
    end

    test "after_save callback to bootstrap_pages deactivates pages with unused templates" do
      @theme.custom_pages << {name: "page", title: "Page", deletable: true, active: true, view_template: "invalid_template"}
      @account.save
      page = Spina::Page.find_by(name: "page")

      assert_not page.active
    end

    test "after_save callback to bootstrap_pages activates pages with used templates" do
      @theme.view_templates << {name: "valid_template", title: "Template", parts: []}
      @theme.custom_pages << {name: "page", title: "Page", deletable: true, active: false, view_template: "valid_template"}
      @account.save
      page = Spina::Page.find_by(name: "page")

      assert page.active
    end

    test "after_save callback to bootstrap_resources creates resources" do
      @theme.resources << {name: "resource", label: "Resource", view_template: "resource_template", slug: "resource"}
      @account.save
      resource = Spina::Resource.find_by(name: "resource")
      
      assert resource
    end
  end
end
