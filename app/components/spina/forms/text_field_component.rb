module Spina
  module Forms
    class TextFieldComponent < ApplicationComponent
      attr_accessor :f, :method, :size, :autofocus
      
      def initialize(f, method, size: "md", autofocus: false)
        @f = f
        @method = method
        @size = size
        @autofocus = autofocus
      end
      
      def controllers
        contr = []
        contr << "autofocus" if autofocus
        contr.join(" ")
      end
      
      def size_styles
        case size
        when "lg"
          "px-4 py-3"
        else
          "text-sm"
        end
      end
      
      def error_styles
        if has_errors?
          "border-red-500 ring-red-500 ring-1"
        else
          ""
        end
      end
      
      def error_messages
        f.object.errors[method.to_sym]
      end
      
      def has_errors?
        error_messages.present?
      end
      
      def placeholder
        f.object.class.human_attribute_name(method)
      end
      
    end
  end
end