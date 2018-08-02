# frozen_string_literal: true

Rails.application.routes.draw do
  root "external#landing"

  scope module: :external do
    get :contact
    get :version
  end
end
