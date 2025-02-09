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
    namespace :users
      get "/:id", to: "users#route"
      get "unset"
      get "pending"
      get "incoming"
      get "registered"
  end

  # Requests
  resources :requests, only: [] do
    collection do
      get "confirm"
      get "remove"
      get "cancel"
    end
  end
end
