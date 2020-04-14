Rails.application.routes.draw do
  root 'static_pages#home'
  get 'login', to: 'static_pages#log_in'
  get 'signup', to: 'static_pages#sign_up'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
