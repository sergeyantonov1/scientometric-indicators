Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_for :users, controllers: { registrations: "users/registrations" }

  ActiveAdmin.routes(self)

  get :dashboard, to: "dashboard#index"

  root to: "pages#home"
end
