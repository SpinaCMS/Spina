module Spina
  class Setting < ApplicationRecord
    attribute :preferences, :json, default: -> { {} }

    validates :plugin, presence: true
  end
end
