module Spina
  class ReplaceSignedIdJob < ApplicationJob
    queue_as { Spina.config.queues[:page_updates] }

    def perform(old_signed_id, new_signed_id)
      return if old_signed_id.blank? || new_signed_id.blank?

      replace_in_records(Spina::Page, old_signed_id, new_signed_id)
      replace_in_records(Spina::Account, old_signed_id, new_signed_id)
    end

    private

    def replace_in_records(model, old_signed_id, new_signed_id)
      model.find_each(batch_size: 100) do |record|
        next unless record.json_attributes.present?

        json_string = record.json_attributes.to_json
        next unless json_string.include?(old_signed_id)

        updated_json = json_string.gsub(old_signed_id, new_signed_id)
        record.update_column(:json_attributes, JSON.parse(updated_json))
      end
    end
  end
end
