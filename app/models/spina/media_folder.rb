module Spina
  class MediaFolder < ApplicationRecord
    has_many :photos, dependent: :nullify

    validates :name, presence: true, uniqueness: true
  end
end