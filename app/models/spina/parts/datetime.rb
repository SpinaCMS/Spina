module Spina
  module Parts
    class Datetime < Base
      attr_json :content, :datetime, default: ""

      attr_accessor :options
    end
  end
end
