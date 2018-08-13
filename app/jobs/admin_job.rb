# frozen_string_literal: true

class AdminJob < ApplicationJob
  queue_as :default

  def perform
    ActionCable.server.broadcast(
      "admin_channel",
      files_count: AdminController.render(partial: "admin/files_count", locals: { number: rand(10_000) })
    )
  end
end
