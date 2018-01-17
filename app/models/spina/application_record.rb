module Spina
  class ApplicationRecord < ActiveRecord::Base
    extend Mobility
    
    self.abstract_class = true
  end
end