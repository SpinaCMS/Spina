module Spina
  module UserInterface
    class FlashMessageComponent < ApplicationComponent
      def initialize(type:, message:)
        @type = type
        @message = message
      end

      def confetti?
        @type == "confetti" && !Spina.config.party_pooper
      end

      def theme
        case @type
        when "alert", "error"
          "bg-red-400"
        else
          "bg-gray-400"
        end
      end
    end
  end
end
