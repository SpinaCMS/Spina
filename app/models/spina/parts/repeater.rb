module Spina
  module Parts
    class Repeater < Base
      include AttrJson::NestedAttributes

      attr_json :content, RepeaterContent.to_type, array: true
      attr_json_accepts_nested_attributes_for :content
    end
  end
end
