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

  def parse_date(date_string, default_date = "")
    if date_string.to_s.split("/").last.size == 2
      Date.strptime(date_string, "%m/%d/%y")
    else
      Date.strptime(date_string, "%m/%d/%Y")
    end
  rescue ArgumentError, NoMethodError
    default_date
  end

  def parse_date_if_key_present(object, key)
    return unless params[object].key?(key)

    params[object][key] = parse_date(params[object][key]) if params[object].key?(key)
  end
end
