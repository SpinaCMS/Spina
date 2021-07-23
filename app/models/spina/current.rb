module Spina
  class Current < ActiveSupport::CurrentAttributes
    attribute :page
    attribute :account
    attribute :user
    attribute :theme
  end
end