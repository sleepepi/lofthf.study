# frozen_string_literal: true

# Internal pages.
class InternalController < ApplicationController
  before_action :authenticate_user!

  layout "layouts/full_page_sidebar"

  # # GET /dashboard
  # def dashboard
  # end

  # # GET /reports
  # def reports
  # end

  # # GET /data-health
  # def data_health
  # end
end
