Rails.application.routes.draw do
  root "users#index"

  resources :users, only: [:show, :index]
  resources :tests, only: [:new, :create, :index]
end
