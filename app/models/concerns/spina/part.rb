require 'active_support/concern'

module Spina
  module Part
    extend ActiveSupport::Concern

    included do
      attr_accessor :position

      validates :name, :title, :partable_type, presence: true

      scope :sorted, -> { order(:position) }
    end

    def to_s
      name
    end

    def content
      self.partable.try(:content)
    end

    def value
      self.partable.try(:value)
    end

    def partable_attributes=(attributes)
      if self.partable.present?
        self.partable.assign_attributes(attributes)
      else
        self.partable = self.partable_type.constantize.new(attributes)
      end
    end
  end
end
