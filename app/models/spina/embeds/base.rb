module Spina::Embeds
  class Base
    extend ActiveModel::Naming
    
    include ActiveModel::Conversion
    include Spina::Embeddable
    include Spina::Embeds::TrixConversion
  end
end