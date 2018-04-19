module Spina
  class Resource < ApplicationRecord
    has_many :pages, dependent: :restrict_with_exception

    belongs_to :parent_page, class_name: "Spina::Page"
  end
end