module Spina::Embeds
  class Base
    include ActiveModel::Model
    include Spina::Embeddable
    include Spina::Embeds::TrixConversion
  end
end
