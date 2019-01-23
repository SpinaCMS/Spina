module Spina
  module Partable
    extend ActiveSupport::Concern

    included do
      # def part(attributes)
      #   part = parts.where(name: attributes[:name]).first_or_initialize(attributes)
      #   part.partable = part.partable_type.constantize.new if part.partable.blank?
      #   part.options = attributes[:options]
      #   part
      # end

      def get_part(name)
        return nil unless content[name.to_s]
        part = content[name.to_s]["partable_type"].constantize.new(name.to_s)
        part.value = content[name.to_s]["value"]
        part
      end

      def part(attributes)
        matches = attributes.match(/\A(.*):(.*)\z/)
        Spina::Part.new(matches[1], matches[2])
      end

      def has_content?(name)
        content(name).present?
      end

    end
  end
end