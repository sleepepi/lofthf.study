# frozen_string_literal: true

# Add methods to existing ActiveStorageBlog model.
class ActiveStorageBlob < ActiveStorage::Blob
  include PgSearch
  multisearchable against: [:filename]

  # Scopes
  scope :latest_files, -> do
    joins(:attachments).merge(
      ActiveStorage::Attachment.where(
        record_type: "Folder",
        record_id: Folder.where(archived: false).joins(:category).merge(Category.sidebar)
      )
    ).order(created_at: :desc).limit(10)
  end
end
