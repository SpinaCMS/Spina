require "application_system_test_case"

module Spina
  class Admin::EditingPagesTest < ApplicationSystemTestCase
    test "visiting the pages index" do
      visit spina.admin_pages_path
      assert_selector "button", text: "New page"
    end

    test "editing a page" do
      visit spina.admin_pages_path
      click_on "Homepage"
      find("trix-editor").click.set("This is my new body")
      assert_selector "button", text: "Save changes"
      click_button "Save changes"
      assert_selector "turbo-frame", text: "Page saved"
      visit "/"
      assert_selector "body", text: "This is my new body"
    end

    test "creating a new page" do
      visit spina.admin_pages_path
      click_button "New page"
      click_on "Simple page"
      fill_in "Title", with: "My new page"
      click_button "Create page"
      # Wait for page to be created and redirected to edit view
      assert_selector "button", text: "Publish", wait: 10
      click_button "Publish"
      assert_selector "turbo-frame", text: "Page published"
    end

    test "embedding a button component" do
      visit spina.admin_pages_path
      click_on "Homepage"
      find_link(nil, href: /\/admin\/embeds\/new/).click
      # Wait for embed modal to fully load
      assert_selector "[data-controller='embed']", wait: 5
      # Button is the first/default embed type, fill in the fields
      fill_in "embeddable[url]", with: "https://example.com"
      fill_in "embeddable[label]", with: "Click me"
      click_button "Embed component"
      # Verify embed was inserted into trix editor
      assert_selector "trix-editor spina-embed", wait: 5
      click_button "Save changes"
      assert_selector "turbo-frame", text: "Page saved"
      visit "/"
      assert_selector "a", text: "Click me"
    end

    setup do
      @resource = FactoryBot.create :breweries

      30.times do
        FactoryBot.create :page, title: "A brewery", resource: @resource
      end
    end

    test "manually order page" do
      visit spina.admin_pages_path
      click_on "Breweries"

      assert_selector "button", class: "sort-down"

      find_button(nil, class: "sort-down", match: :first).click

      assert_selector "turbo-frame", text: "Sorting saved"
    end
  end
end
