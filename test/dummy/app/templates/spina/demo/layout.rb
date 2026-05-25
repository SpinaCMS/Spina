# frozen_string_literal: true

LayoutParts.define do
  part :line, :line
  part :body, :text
  repeater :repeater do
    part :line, :line
    part :body, :text
    part :image, :image
    part :image_collection, :image_collection
  end
end
