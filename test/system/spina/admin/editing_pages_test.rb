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
      assert_selector "button", text: "Publish"
      click_button "Publish"
      assert_selector "turbo-frame", text: "Page published"
    end

    test "embedding a youtube video" do
      visit spina.admin_pages_path
      click_on "Homepage"
      find_link(nil, href: /\/admin\/embeds\/new/).click
      # Wait for embed modal to fully load before clicking Youtube
      assert_selector "[data-controller='embed']", wait: 5
      click_link "Youtube"
      # Wait for the input field to be present and ready
      assert_selector "input[name='embeddable[url]']", wait: 5
      fill_in "embeddable[url]", with: "https://www.youtube.com/watch?v=dQw4w9WgXcQ"
      click_button "Embed component"
      # Don't check for specific video title as it requires a network call to YouTube
      assert_selector "trix-editor spina-embed", wait: 10
      click_button "Save changes"
      assert_selector "turbo-frame", text: "Page saved"
      visit "/"
      assert_selector "iframe", id: "ytplayer"
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
