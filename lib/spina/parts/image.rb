module Spina
  module Parts
    class Image < Part

      def content
        Spina::Image.find_by(id: value).file
      end

    end
  end
end