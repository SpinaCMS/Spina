module Spina
  module Parts
    class Base
      include AttrJson::Model

      attr_json_config(unknown_key: :strip)

      attr_json :title, :string
      attr_json :name, :string
    end
  end
end