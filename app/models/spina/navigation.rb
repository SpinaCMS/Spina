module Spina
  class Navigation < ApplicationRecord
    extend Mobility

    has_many :navigation_items, dependent: :destroy
    has_many :pages, through: :navigation_items

    scope :sorted, -> { order(:position) }

    validates :name, :label, presence: true
    validates :name, uniqueness: true

    translates :label

    def cache_key
      super + "_" + Mobility.locale.to_s
    end
  end
end
