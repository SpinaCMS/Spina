require "application_system_test_case"

module Spina
  class Admin::EditingResourcesTest < ApplicationSystemTestCase
    test "visiting the blog resource index" do
      visit spina.admin_pages_path
      click_on "Blog"
      assert_selector "a", text: "Blog settings"
    end

    test "set a custom slug for blog (resource)" do
      visit spina.admin_pages_path
      click_on "Blog"
      click_on "Blog settings"
      fill_in "Slug", with: "blog"
      click_button "Save changes"
      assert_selector "turbo-frame", text: "Page collection saved"
    end

    test "set a custom slug for a different locale for blog resource" do
      visit spina.admin_pages_path
      click_on "Blog"
      click_on "Blog settings"
      fill_in "Slug", with: "blog"
      click_button "Save changes"
      click_on "Blog settings"
      click_button "EN"
      click_on "Edit Dutch translation"
      fill_in "Slug", with: "weblog"
      click_button "Save changes"
      assert_selector "turbo-frame", text: "Page collection saved"
    end
  end
end
