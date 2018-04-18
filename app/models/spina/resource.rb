module Spina
  class Resource < ApplicationRecord
    has_many :pages, dependent: :restrict_with_exception
  end
end