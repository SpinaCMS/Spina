# frozen_string_literal: true

Spina.define_template :blogpost do
  description "Article template"
  exclude_from %w[main]
  part :body, :text
end
