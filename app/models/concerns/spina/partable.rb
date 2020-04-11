module Spina
  module Partable
    extend ActiveSupport::Concern

    included do

      def part(attributes)
        5.times { Rails.logger.info attributes.inspect}
        part = find_part(attributes[:name]) || attributes[:part_type].constantize.new
        part.name = attributes[:name]
        part.title = attributes[:title]
        part
      end

      def find_part(name)
        (parts || []).find{|part| part.name.to_s == name.to_s}
      end

      # def part(attributes)
      #   part = page_parts.where(name: attributes[:name]).first_or_initialize(attributes)
      #   part.partable = part.partable_type.constantize.new if part.partable.blank?
      #   part.options = attributes[:options]
      #   part
      # end

      # def has_content?(name)
      #   content(name).present?
      # end

      # def content(name)
      #   part = page_parts.find_by(name: name)
      #   part.try(:content)
      # end

    end
  end
end
