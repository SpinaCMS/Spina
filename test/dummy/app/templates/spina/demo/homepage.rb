# frozen_string_literal: true

PageTemplate.define :homepage do
  part :headline, :line, hint: "This will be shown in your header"
  part :body, :text
  part :image_collection, :image_collection
end
