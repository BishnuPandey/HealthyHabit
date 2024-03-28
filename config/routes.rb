require 'sidekiq/web'
Rails.application.routes.draw do
  # authenticate :user, ->(u) { u.has_role? :admin } do
  #   mount Sidekiq::Web => '/sidekiq'
  # end

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  root to: 'homes#index'
  get "/contact_us", to: "homes#new"

  resources :options
  resources :workout_plans
  resources :homes, only: %i[index create]

  %w[401 404 422 500].each do |code|
    get code, to: 'errors#show', code: code
  end

  authenticate :user, ->(user) { user.has_role? :admin } do
    mount Sidekiq::Web => '/sidekiq'
    mount Avo::Engine , at: Avo.configuration.root_path
  end
end
