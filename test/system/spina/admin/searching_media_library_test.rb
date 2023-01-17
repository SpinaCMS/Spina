require "application_system_test_case"

module Spina
  class Admin::SearchingMediaLibraryTest < ApplicationSystemTestCase
    test "searching for a specific file" do
      spina_png = fixture_file_upload("spina.png", "image/png")
      Spina::Image.create(file: spina_png)

      other_image = Spina::Image.create(file: spina_png)
      other_image.file_blob.update(filename: "other.png")

      visit spina.admin_images.path
      assert_text "spina.png"

      fill_in "query", with: "other"
      refute_text "spina.png"
      assert_text "other.png"
    end
  end
end
