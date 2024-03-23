require 'sidekiq/web'
Rails.application.routes.draw do
  authenticate :user, ->(u) { u.has_role? :admin } do
    mount Sidekiq::Web => '/sidekiq'
  end

  authenticate :user, ->(user) { user.has_role? :admin } do
    mount Avo::Engine, at: Avo.configuration.root_path
  end
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  root to: 'static_pages#root'

  # get "static_pages/root"
  # # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get 'service-worker' => 'rails/pwa#service_worker', as: :pwa_service_worker
  get 'manifest' => 'rails/pwa#manifest', as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"

  resources :options
  resources :workout_plans

  %w[401 404 422 500].each do |code|
    get code, to: 'errors#show', code: code
  end
end
