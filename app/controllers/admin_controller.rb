# frozen_string_literal: true

# Allows admins to configure the site.
class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin!

  layout "layouts/full_page_sidebar"

  # # GET /admin
  # def dashboard
  # end

  # GET /admin/debug
  def debug
    AdminJob.perform_later
    ActionCable.server.broadcast("files_channel", files_count: ActiveStorage::Blob.count)
  end
end
