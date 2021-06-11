module Spina
  class PageUpdateJob < ApplicationJob
    queue_as :default

    def perform(resource_id)
      Spina::Page.where(resource_id: resource_id).each(&:save)
    end
  end
end
