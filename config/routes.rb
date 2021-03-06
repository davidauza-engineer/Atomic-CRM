Rails.application.routes.draw do
  # root
  root 'static_pages#home'
  # sessions
  resources :sessions, only: [:index, :new, :create]
  get 'login', to: 'sessions#new', as: 'login'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy', as: 'logout'
  get 'resetpassword', to: 'sessions#reset_password'
  # users
  resources :users, only: [:index, :new, :create]
  get 'signup', to: 'users#new', as: 'signup'
  post 'signup', to: 'users#create'
  get 'profile', to: 'users#profile'
  get 'uploadpicture', to: 'users#upload_picture'
  # transactions
  resources :transactions, only: [:index, :show, :new, :create]
  get 'transactions/actions/search', to: 'transactions#search'
  get '/transactions/category/uncategorized', to: 'transactions#uncategorized'
  # categories
  get '/categories', to: 'categories#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
