# frozen_string_literal: true

# Internal pages.
class InternalController < ApplicationController
  before_action :authenticate_user!

  layout "layouts/full_page_sidebar"

  # # GET /dashboard
  # def dashboard
  # end

  # GET /directory
  def directory
    scope = User.current.search(params[:search], match_start: false)
    @users = scope_order(scope).page(params[:page]).per(20)
  end

  # # GET /folder
  # def folder
  # end

  # # GET /reports
  # def reports
  # end

  # # GET /data-health
  # def data_health
  # end

  # GET /search
  def search
    @search_documents = PgSearch.multisearch(params[:search]).page(params[:page]).per(10)
    render layout: "layouts/full_page"
  end

  private

  def scope_order(scope)
    @order = params[:order]
    scope.order(Arel.sql(User::ORDERS[params[:order]] || User::DEFAULT_ORDER))
  end
end
