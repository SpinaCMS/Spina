module Spina
  class ReplaceSignedIdJob < ApplicationJob
    queue_as { Spina.config.queues[:page_updates] }

    def perform(old_signed_id, new_signed_id)
      return if old_signed_id.blank? || new_signed_id.blank?

      pages = Spina::Page.all
      accounts = Spina::Account.all

      [pages, accounts].each do |records|
        records.find_each(batch_size: 100) do |record|
          json = record.json_attributes.to_json
          next unless json.include?(old_signed_id)

          new_json = json.gsub(old_signed_id, new_signed_id)
          record.update_columns(json_attributes: JSON.parse(new_json))
        end
      end
    end

  end
end
