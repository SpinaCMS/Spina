module Spina
  module Partable
    extend ActiveSupport::Concern

    included do

      def part(attributes)
        part = find_part(attributes[:name]) || attributes[:part_type].constantize.new

        # Copy all attributes to part
        %w(name title options).each do |attribute|
          if part.respond_to?(attribute)
            part.public_send("#{attribute}=", attributes[attribute.to_sym])
          end
        end

        part
      end

      def has_content?(name)
        find_part(name).present?
      end

      def content(name)
        find_part(name)&.content
      end

      def image(name)
        find_part(name)
      end

    end
  end
end
