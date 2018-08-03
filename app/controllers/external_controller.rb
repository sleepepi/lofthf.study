# frozen_string_literal: true

# Public pages.
class ExternalController < ApplicationController
  # # GET /
  # def landing
  # end

  # # GET /contact
  # def contact
  # end

  # GET /version
  # GET /version.json
  def version
    render layout: "layouts/full_page"
  end
end
