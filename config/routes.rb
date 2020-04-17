Rails.application.routes.draw do
  # root
  root 'static_pages#home'
  # sessions
  resources :sessions
  get 'login', to: 'sessions#new', as: 'login'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy', as: 'logout'
  get 'resetpassword', to: 'sessions#reset_password'
  # users
  resources :users
  get 'signup', to: 'users#new', as: 'signup'
  post 'signup', to: 'users#create'
  get 'uploadpicture', to: 'users#upload_picture'
  get '/profile', to: 'users#show', as: 'profile'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
