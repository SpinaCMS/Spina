# frozen_string_literal: true

PageTemplate.define :show do
  title "Default"
  part :body, :text, hint: "Your content"
  part :image, :image
  repeater :repeater, title: "Repeater", item_name: "item" do
    part :line, :line
    part :image, :image
    part :headline, :line, hint: "Used in the header"
  end
end
