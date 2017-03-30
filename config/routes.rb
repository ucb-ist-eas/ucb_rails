Rails.application.routes.draw do
  resources :home, only: :index

  root to: "home#index"

  match "/login", :to => "sessions#new", :as => "login", via: [:get]
  match "/logout", :to => "sessions#destroy", :as => "logout", via: [:all]
  match "/auth/:omniauth_provider/callback" => "sessions#create", via: [:get]
  match "/auth/failure" => "sessions#failure", via: [:get]
  match "/not_authorized", :to => "sessions#not_authorized", as: "not_authorized", via: [:get]

  namespace :admin do
    get "toggle_superuser" => "users#toggle_superuser", as: "toggle_superuser"
    resources :users
  end
end
