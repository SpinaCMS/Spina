module Spina
  module Parts
    class Line
      include AttrJson::Model

      attr_json :title, :string
      attr_json :name, :string
      attr_json :content, :string, default: ""

      validates :name, :title, presence: true
    end
  end
end
