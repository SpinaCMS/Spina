module Spina
  module AdminSectionable
    extend ActiveSupport::Concern

    included do |base|
      extend ClassMethods

      helper_method :admin_section
      attr_accessor :admin_section
    end

    module ClassMethods
      def admin_section(name)
        before_action do |controller|
          controller.send(:admin_section=, name.to_sym)
        end
      end
    end
  end
end
