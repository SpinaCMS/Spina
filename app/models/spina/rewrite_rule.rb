module Spina
  class RewriteRule < ApplicationRecord
    validates :old_path, uniqueness: true
  end
end