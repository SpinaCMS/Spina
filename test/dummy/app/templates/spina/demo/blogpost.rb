# frozen_string_literal: true

PageTemplate.define :blogpost do
  description "Article template"
  exclude_from %w[main]
  part :body, :text
end
