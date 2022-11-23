module Spina
  module Partable
    extend ActiveSupport::Concern

    attr_accessor :view_context

    included do

      def part(attributes)
        part = find_part(attributes[:name]) || attributes[:part_type].constantize.new

        # Copy all attributes to part
        %w(name title hint options item_name).each do |attribute|
          part.public_send("#{attribute}=", attributes[attribute.to_sym]) if part.respond_to?(attribute)
        end

        part
      end

      def has_content?(name)
        find_part(name).present?
      end

      def content(name = nil)
        name ? find_part(name)&.content : content_presenter
      end

      private

        def content_presenter
          @content_presenter ||= ContentPresenter.new(view_context, self)
        end

    end
  end
end
