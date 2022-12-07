module Spina
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true

    # Remove Spina namespace from partial paths
    def to_partial_path
      super.gsub(/\Aspina\//, "")
    end
  end
end
