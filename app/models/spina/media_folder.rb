module Spina
  class MediaFolder < ApplicationRecord
    has_many :images, dependent: :nullify

    validates :name, presence: true, uniqueness: true
  end
end