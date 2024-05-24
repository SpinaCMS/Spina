module Spina
  module Parts
    class ResourceLink < Base
      attr_json :resource_id, :integer, default: nil

      attr_accessor :options

      def content
        ::Spina::Resource.find_by(id: resource_id)
      end
    end
  end
end
