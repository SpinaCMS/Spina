module Spina
  module Partable
    extend ActiveSupport::Concern

    included do
      def part(part)
        options = part[:options] || {}
        part = parts.where(name: part[:name]).first || parts.build(part)
        part.options = options unless part.options
        if part.partable_type.present?
          part.partable = part.partable_type.constantize.new unless part.partable.present?
        end
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
