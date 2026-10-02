# frozen_string_literal: true

Spina.define_template :show do
  title "Page"
  part :text, :text, title: "Body", hint: "Your main content"
end
