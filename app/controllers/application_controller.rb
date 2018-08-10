# frozen_string_literal: true

# Main controller for LOFT-HF. Handles friendly forwarding.
class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token, if: :devise_login?
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    session[:previous_internal_url] || session[:previous_external_url] || dashboard_path
  end

  def after_sign_out_path_for(resource_or_scope)
    session[:previous_external_url] || root_path
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :sign_up,
      keys: [
        :username, :full_name, :email, :password, :emails_enabled # :password_confirmation
      ]
    )
  end

  def devise_login?
    params[:controller] == "sessions" && params[:action] == "create"
  end

  def check_admin!
    return if current_user.admin?
    redirect_to dashboard_path
  end

  def check_editor!
    return if current_user.editor?
    redirect_to dashboard_path
  end

  def empty_response_or_root_path(path = root_path)
    respond_to do |format|
      format.html { redirect_to path }
      format.js { head :ok }
      format.json { head :no_content }
      format.pdf { redirect_to path }
    end
  end
end
