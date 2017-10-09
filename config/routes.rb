Rails.application.routes.draw do
  resources :db_instances, only: [:index, :show]
  resources :instances, only: [:index, :show]
  resources :accounts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'dashboard#index'
end
