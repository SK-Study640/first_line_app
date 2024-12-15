Rails.application.routes.draw do
  root "home#index"

  # Registrations
  resource :registrations, only: [ :new ] do
    collection do
      post "confirm"
      post "complete"
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
