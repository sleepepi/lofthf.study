# frozen_string_literal: true

# Keep latest uploads updated.
class FilesJob < ApplicationJob
  queue_as :default

  def perform
    @blobs = ActiveStorageBlob.latest_files
    ActionCable.server.broadcast(
      "files_channel",
      latest_uploads: AdminController.render(partial: "files/latest_uploads", locals: { blobs: @blobs })
    )
  end
end
