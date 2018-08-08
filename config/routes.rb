# frozen_string_literal: true

Rails.application.routes.draw do
  root "external#landing"

  get :admin, to: "admin#dashboard"
  namespace :admin do
    get :debug
    resources :users
  end

  scope module: :external do
    get :contact
    get :version
  end

  scope module: :internal do
    get :dashboard
  end

  devise_for :users,
             controllers: {
               confirmations: "confirmations",
               passwords: "passwords",
               registrations: "registrations",
               sessions: "sessions",
               unlocks: "unlocks"
             },
             path_names: { sign_up: "join", sign_in: "login" },
             path: ""
end
