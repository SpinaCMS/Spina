module Spina
  class PagePart < ActiveRecord::Base
    include ApplicationHelper

    belongs_to :page
    belongs_to :page_partable, polymorphic: true

    accepts_nested_attributes_for :page_partable, allow_destroy: true
    attr_accessor :position

    validates_presence_of :name, :page_partable_type, :title
    validates_uniqueness_of :name, scope: :page_id

    scope :sorted, -> { order(:position) }

    alias_method :partable, :page_partable

    def to_s
      name
    end

    def position(theme)
      page_parts = theme.config.view_templates[self.page.try(:view_template) || "show"][:page_parts]
      page_parts.index { |page_part| page_part == self.name }.to_i
    end

    def content
      self.page_partable.try(:content) || self.page_partable
    end

    def page_partable_attributes=(attributes)
      if self.page_partable.present?
        self.page_partable.assign_attributes(attributes)
      else
        self.page_partable = self.page_partable_type.constantize.new(attributes)
      end
    end

    def partable_type
      page_partable_type
    end

  end
end
