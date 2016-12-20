module Spina
  class Navigation < ApplicationRecord
    has_many :navigation_items, dependent: :destroy
    has_many :pages, through: :navigation_items

    scope :sorted, -> { order(:position) }

    validates :name, :label, presence: true
    validates :name, uniqueness: true
  end
end