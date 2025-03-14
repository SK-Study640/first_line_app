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
    get "/users/:id", to: "users#mypage", as: "users"
    # 開発用機能
    get "index", to: "users#index", as: "index"
    get "switch_user", to: "users#switch_user", as: "switch_user"
  end

  # Requests
  namespace :requests do
    get "confirm"
    get "remove"
    get "cancel"
  end
end
