Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }

  get :dashboard, to: "dashboard#index"

  root to: "pages#home"
end
