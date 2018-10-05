# frozen_string_literal: true

# Provides framework for friendly forwarding.
module Forwardable
  extend ActiveSupport::Concern

  included do
    before_action :store_location
  end

  def after_sign_in_path_for(resource)
    session[:previous_internal_url] || session[:previous_external_url] || dashboard_path
  end

  def after_sign_out_path_for(resource_or_scope)
    session[:previous_external_url] || root_path
  end

  private

  def store_location
    return unless !request.post? && !request.xhr? && params[:format] != "atom" && params[:format] != "pdf"
    store_internal_location_in_session if internal_action?(params[:controller], params[:action])
    clear_location_in_session if params[:controller] == "external" && params[:action] == "landing"
  end

  def internal_action?(controller, action)
    internal_controllers[controller.to_sym] && (
      internal_controllers[controller.to_sym].empty? ||
      internal_controllers[controller.to_sym].include?(action.to_sym)
    )
  end

  def store_internal_location_in_session
    session[:previous_internal_url] = request.fullpath
  end

  def clear_location_in_session
    session[:previous_internal_url] = nil
    session[:previous_external_url] = nil
  end

  # # Override in application controller.
  # def internal_controllers
  #   {}
  # end
end
