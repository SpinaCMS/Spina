require 'active_support/concern'

module Spina
  module Optionable
    extend ActiveSupport::Concern

    included do
      attr_accessor :options
    end

  end
end
