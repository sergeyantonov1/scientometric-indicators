require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users, controllers: { registrations: "users/registrations" }

  ActiveAdmin.routes(self)

  get :dashboard, to: "dashboard#index"

  root to: "dashboard#index"
end
