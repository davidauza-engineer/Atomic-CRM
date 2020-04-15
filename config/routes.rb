Rails.application.routes.draw do
  get 'sessions/new'
  resources :users
  resources :sessions
  root 'static_pages#home'
  get 'login', to: 'sessions#new', as: 'login'
  post 'login', to: 'sessions#create'
  get 'signup', to: 'users#new', as: 'signup'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'password-reset', to: 'sessions#reset_password'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
