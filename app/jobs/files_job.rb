# frozen_string_literal: true

# Keep latest uploads updated.
class FilesJob < ApplicationJob
  queue_as :default

  def perform
    @blobs = ActiveStorage::Blob.joins(:attachments).merge(
      ActiveStorage::Attachment.where(record_type: "Folder")
    ).order(created_at: :desc).limit(10)
    ActionCable.server.broadcast(
      "files_channel",
      latest_uploads: AdminController.render(partial: "files/latest_uploads", locals: { blobs: @blobs })
    )
  end
end
