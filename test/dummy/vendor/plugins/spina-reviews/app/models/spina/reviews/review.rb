module Spina
  module Reviews
    class Review < ActiveRecord::Base

      validates :name, :rating, presence: true

      scope :confirmed, -> { where.not(confirmed_at: nil) }
      scope :ordered, -> { order('created_at DESC') }
      scope :concept, -> { where(confirmed_at: nil) }

    end
  end
end
