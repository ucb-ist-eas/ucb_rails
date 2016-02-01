Rails.application.routes.draw do
  root to: 'ucb_rails/home#index'
  
  match 'ucb_rails', :to => 'ucb_rails/home#index', via: [:get]
  
  match '/login', :to => 'ucb_rails/sessions#new', :as => 'login', via: [:get]
  match '/logout', :to => 'ucb_rails/sessions#destroy', :as => 'logout', via: [:all]
  match '/auth/:omniauth_provider/callback' => 'ucb_rails/sessions#create', via: [:get]
  match '/auth/failure' => "ucb_rails/sessions#failure", via: [:get]
  match '/not_authorized', :to => 'ucb_rails/sessions#not_authorized', as: 'not_authorized', via: [:get]
  
  match '/ucb_rails/bootstrap(/:uid)' => 'ucb_rails/bootstrap#index', via: [:get]
  
  resources :hidden_announcements, path: '/announcements', only: [:index, :create, :destroy]

  namespace :ucb_rails do
    get '/ldap_person_search' => 'ldap_person_search#search', :as => :ldap_person_search
    
    namespace :admin do
      resources :announcements
      get 'configuration' => 'configuration#index'
      get 'email_test' => 'email_test#index'
      post 'email_test' => 'email_test#send_email'
      get 'force_exception' => 'force_exception#index'
      get 'toggle_admin' => 'users#toggle_admin', as: "toggle_admin"

      resources :users do
        get 'ldap_search', on: :collection
        get 'typeahead_search', on: :collection
        get 'omni_typeahead_search', on: :collection
      end
    end
  end
  
end
