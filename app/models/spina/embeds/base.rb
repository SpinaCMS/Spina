module Spina::Embeds
  class Base
    extend ActiveModel::Naming
    
    include ActiveModel::Model
    include Spina::Embeddable
    include Spina::Embeds::TrixConversion
  end
end