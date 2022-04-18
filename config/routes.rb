Rails.application.routes.draw do
  resources :expenses
  root 'expenses#index'
  get 'session/login'
  post 'session/create'
  get 'session/logout'
  resources :posts
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
