module Spina
  class RewriteRule < ActiveRecord::Base
    validates :old_path, uniqueness: true
  end
end