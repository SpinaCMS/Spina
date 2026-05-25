# frozen_string_literal: true

PageTemplate.define :demo do
  description "Example including all parts"
  exclude_from %w[guides]
  repeater :repeater do
    part :line, :line
    part :body, :text
    part :image, :image
    part :image_collection, :image_collection
  end
  repeater :repeater2, title: "Repeater", item_name: "item" do
    part :line, :line
    part :image, :image
  end
  part :attachment, :attachment
  part :option, :option, options: [["Left", "left"], ["Center", "center"], ["Right", "right"]]
  part :body, :text
  part :image_collection, :image_collection
  part :image, :image
  part :portrait, :image, options: {ratio: "portrait"}
  part :landscape, :image, options: {ratio: "landscape"}
  part :wide, :image, options: {ratio: "wide"}
  part :page_group, :resource_link, title: "Pagegroup"
end
