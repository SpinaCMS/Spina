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
      find('trix-editor').click.set('This is my new body')
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
      click_link "Youtube"
      assert_selector "label", text: "Youtube URL", wait: 5
      fill_in "embeddable[url]", with: "https://www.youtube.com/watch?v=dQw4w9WgXcQ"
      click_button "Embed component"
      assert_selector "trix-editor spina-embed", text: "Rick Astley - Never Gonna Give You Up (Official Music Video)"
      click_button "Save changes"
      assert_selector "turbo-frame", text: "Page saved"
      visit "/"
      assert_selector "iframe", id: "ytplayer"
    end
    
  end
end
