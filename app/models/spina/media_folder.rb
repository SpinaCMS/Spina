module Spina
  class MediaFolder < ApplicationRecord
    self.table_name = 'spina_media_folders'

    has_many :photos, dependent: :nullify

    validates :name, presence: true, uniqueness: true
  end
end