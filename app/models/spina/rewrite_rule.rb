module Spina
  class RewriteRule < ApplicationRecord
    validates :old_path, uniqueness: true

    # Records a redirect from old_path to new_path without leaving
    # loops (A -> B and B -> A) or chains (A -> B -> C) behind.
    def self.record(old_path, new_path)
      return if old_path.blank? || old_path == new_path

      where(old_path: new_path).delete_all
      where(new_path: old_path).update_all(new_path: new_path)
      where(old_path: old_path).first_or_create.update(new_path: new_path)
    end
  end
end
