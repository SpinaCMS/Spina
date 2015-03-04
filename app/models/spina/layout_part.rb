module Spina
  class LayoutPart < ActiveRecord::Base
    include ApplicationHelper

    belongs_to :account
    belongs_to :layout_partable, polymorphic: true

    accepts_nested_attributes_for :layout_partable, allow_destroy: true
    attr_accessor :position

    validates_presence_of :name, :layout_partable_type, :title
    validates_uniqueness_of :name, scope: :account_id

    scope :sorted, -> { order(:position) }

    def to_s
      name
    end

    def position(theme)
      layout_parts = theme.config.layout_template[:layout_parts]
      layout_parts.index { |layout_part| layout_part == self.name }.to_i
    end

    def content
      self.layout_partable.try(:content) || self.layout_partable
    end

    def layout_partable_attributes=(attributes)
      if self.layout_partable.present?
        self.layout_partable.update_attributes(attributes)
      else
        self.layout_partable = self.layout_partable_type.constantize.create(attributes)
      end
    end

  end
end
