require 'active_support/concern'

module Spina
  module Part
    extend ActiveSupport::Concern

    included do
      attr_accessor :position

      validates :name, :title, :partable_type, presence: true

      after_save -> { partable.try(:save) }

      scope :sorted, -> { order(:position) }
    end

    def to_s
      name
    end

    def content
      (partable || partable_type.constantize.new).content
    end

    def value
      partable.try(:value)
    end

    def partable_attributes=(attributes)
      if partable.present?
        partable.assign_attributes(attributes)
      else
        self.partable = self.partable_type.constantize.new(attributes)
      end
    end

  end
end
