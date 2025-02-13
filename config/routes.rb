Rails.application.routes.draw do
  devise_for :users
  root "home#index"

  # LINE認証
  get "/auth/line/callback", to: "line_auth#callback"

  # Registrations
  resource :registrations, only: [ :new ] do
    collection do
      get "confirm"
      post "create"
      get "complete"
    end
  end

  # Users
  scope :users do
    get "/users/:id", to: "users#route", as: "users"
    get "unset", to: "users#unset", as: "users_unset"
    get "pending", to: "users#pending", as: "users_pending"
    get "incoming", to: "users#incoming", as: "users_incoming"
    get "registered", to: "users#registered", as: "users_registered"
  end

  # Requests
  namespace :requests do
    get "confirm"
    get "remove"
    get "cancel"
  end
end
