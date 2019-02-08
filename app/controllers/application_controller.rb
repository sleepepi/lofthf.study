# frozen_string_literal: true

# Main controller for LOFT-HF. Handles friendly forwarding.
class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token, if: :devise_login?
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :sign_up,
      keys: [
        :username, :full_name, :email, :password, :emails_enabled
      ]
    )
  end

  def devise_login?
    params[:controller] == "sessions" && params[:action] == "create"
  end

  def check_admin!
    redirect_to dashboard_path unless current_user.admin?
  end

  def check_editor!
    redirect_to dashboard_path unless current_user.editor?
  end

  def empty_response_or_root_path(path = root_path)
    respond_to do |format|
      format.html { redirect_to path }
      format.js { head :ok }
      format.json { head :no_content }
      format.pdf { redirect_to path }
    end
  end

  # Expects an "Uploader" type class, ex: uploader = @project.logo
  def send_file_if_present(uploader, *args)
    if uploader.present?
      send_file uploader.path, *args
    else
      head :ok
    end
  end

  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end
end
