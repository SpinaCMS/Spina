module Spina
  class PartType
    class UnknownPartType < ArgumentError; end

    BUILT_IN = {
      line: "Spina::Parts::Line",
      multi_line: "Spina::Parts::MultiLine",
      text: "Spina::Parts::Text",
      image: "Spina::Parts::Image",
      image_collection: "Spina::Parts::ImageCollection",
      attachment: "Spina::Parts::Attachment",
      option: "Spina::Parts::Option",
      repeater: "Spina::Parts::Repeater",
      page_link: "Spina::Parts::PageLink",
      page: "Spina::Parts::PageLink",
      resource_link: "Spina::Parts::ResourceLink",
      page_group: "Spina::Parts::ResourceLink"
    }.freeze

    class << self
      def resolve(type)
        case type
        when Symbol
          BUILT_IN.fetch(type) { raise UnknownPartType, "Unknown part type: #{type.inspect}" }
        when String
          type
        when Class
          type.name
        else
          raise ArgumentError, "Part type must be a Symbol, String, or Class (got #{type.class})"
        end
      end

      def symbol_for(class_name)
        BUILT_IN.key(class_name)
      end

      def built_in?(class_name)
        BUILT_IN.value?(class_name)
      end
    end
  end
end
