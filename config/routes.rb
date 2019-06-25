Rails.application.routes.draw do
  get 'sign_up', to: 'registrations#new', as: :sign_up
  post 'sign_up', to: 'registrations#create'

  get 'profile', to: 'profile#edit', as: :profile
  patch 'profile', to: 'profile#update'

  get 'login', to: 'sessions#new', as: :login
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy', as: :logout
  delete 'logout', to: 'sessions#destroy'

  get 'password/forget', to: 'password#forget', as: :forget_password
  post 'password/reset', to: 'password#reset', as: :reset_password
  get 'password/new', to: 'password#new', as: :new_password
  post 'password', to: 'password#create', as: :password
end
