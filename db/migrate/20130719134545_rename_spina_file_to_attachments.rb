class RenameSpinaFileToAttachments < ActiveRecord::Migration
  def change
    rename_table :spina_files, :spina_attachments
    rename_table :spina_file_collections, :spina_attachment_collections
    rename_table :spina_file_collections_files, :spina_attachment_collections_attachments
    rename_column :spina_attachment_collections_attachments, :file_id, :attachment_id
    rename_column :spina_attachment_collections_attachments, :file_collection_id, :attachment_collection_id
  end
end
