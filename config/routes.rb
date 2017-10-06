Rails.application.routes.draw do
  resources :db_instances
  resources :instances
  resources :accounts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
