module Spina
  class ResourcePagesUpdateJob < ApplicationJob
    queue_as { Spina.config.queues[:page_updates] }

    def perform(resource_id)
      Page.where(resource_id: resource_id).roots.find_each(batch_size: 100) do |page|
        page.save
      end
    end
  end
end
