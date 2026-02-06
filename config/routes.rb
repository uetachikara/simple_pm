Rails.application.routes.draw do
  get "dashboard/index"
  root "dashboard#index"

  resources :tasks
  resources :projects
  resources :users
end
