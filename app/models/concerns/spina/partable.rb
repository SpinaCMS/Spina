module Spina
  module Partable
    extend ActiveSupport::Concern

    included do

      def part(attributes)
        part = find_part(attributes[:name]) || attributes[:part_type].constantize.new
        part.name = attributes[:name]
        part.title = attributes[:title]
        part
      end

      def find_part(name)
        (parts || []).find{|part| part.name.to_s == name.to_s}
      end

      def has_content?(name)
        find_part(name).present?
      end

      def content(name)
        find_part(name)&.content
      end

    end
  end
end
