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
    end
  end
end
