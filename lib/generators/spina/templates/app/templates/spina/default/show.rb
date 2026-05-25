# frozen_string_literal: true

PageTemplate.define :show do
  title "Page"
  part :text, :text, title: "Body", hint: "Your main content"
end
