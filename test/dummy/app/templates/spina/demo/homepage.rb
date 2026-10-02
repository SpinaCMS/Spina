# frozen_string_literal: true

Spina.define_template :homepage do
  part :headline, :line, hint: "This will be shown in your header"
  part :body, :text
  part :image_collection, :image_collection
end
