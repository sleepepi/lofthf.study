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

  resources :folders, except: [:show, :edit], path: "docs" do
    member do
      post :attach_file, path: "attach-file"
      post :attach_files, path: "attach-files"
    end
  end
  get "docs/:category/:folder", to: "folders#show", as: :category_folder
  get "docs/:category/:folder/edit", to: "folders#edit", as: :edit_category_folder
  get "docs/:category/:folder/upload", to: "folders#upload", as: :upload_category_folder

  scope module: :internal do
    get :dashboard
    get :directory
    get :reports
    get :data_health, path: "data-health"
    get :report_card, path: "report-card"
    get :search
  end

  resources :sites

  get :coordinating_centers, to: "sites#coordinating_centers", path: "coordinating-centers"
  get :recruiting_centers, to: "sites#recruiting_centers", path: "recruiting-centers"


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
