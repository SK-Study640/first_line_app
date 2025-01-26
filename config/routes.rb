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
  resources :users, only: [ :show ] do
    collection do
      get "pending"
      get "incoming"
      get "registered"
    end
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
