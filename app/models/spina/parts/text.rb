module Spina
  module Parts
    class Text < Base
      attr_json :content, :string, default: ""
    end
  end
end
