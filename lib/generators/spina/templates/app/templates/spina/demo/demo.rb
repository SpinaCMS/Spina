# frozen_string_literal: true

PageTemplate.define :demo do
  exclude_from %w[articles]
  part :body, :text, hint: "Your content"
  part :image_collection, :image_collection
  part :image, :image
  repeater :repeater, title: "Repeater", item_name: "item" do
    part :line, :line
    part :image, :image
    part :headline, :line, hint: "Used in the header"
  end
end
