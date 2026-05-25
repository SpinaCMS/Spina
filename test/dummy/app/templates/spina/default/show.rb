# frozen_string_literal: true

PageTemplate.define :show do
  title "Default"
  description "A simple page"
  usage "Use for your content"
  part :text, :text, title: "Text", hint: "Your main content"
  part :attachment, :attachment, title: "Attachment"
end
