module Spina
  module Parts
    class Base
      include AttrJson::Model

      attr_json :title, :string
      attr_json :name, :string
      
      validates :name, :title, presence: true
    end
  end
end