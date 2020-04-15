Rails.application.routes.draw do
  # sessions
  resources :sessions
  get 'sessions/new'
  get 'login', to: 'sessions#new', as: 'login'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'password-reset', to: 'sessions#reset_password'
  # users
  resources :users
  get 'signup', to: 'users#new', as: 'signup'
  # root
  root 'static_pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
