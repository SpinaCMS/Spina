# frozen_string_literal: true

PageTemplate.define :homepage do
  part :headline, :line, hint: "Used in the header"
  part :body, :text, hint: "Your content"
  part :image_collection, :image_collection
end
