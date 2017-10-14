module Spina
  module Partable
    extend ActiveSupport::Concern

    included do
      def part(attributes)
        part = parts.where(name: attributes[:name]).first_or_initialize(attributes)
        part.partable = part.partable_type.constantize.new if part.partable.blank?
        part.options = attributes[:options]
        part
      end

      def has_content?(name)
        content(name).present?
      end

      def content(name)
        part = parts.find_by(name: name)
        part.try(:content)
      end

    end
  end
end
