Rails.application.routes.draw do
  get '/sign_up', to: 'registrations#new', as: :sign_up
  post '/sign_up', to: 'registrations#create'

  get '/profile', to: 'profile#show', as: :profile
  patch '/profile', to: 'profile#update'

  get 'login', to: 'sessions#new', as: :login
  post 'login', to: 'sessions#create'
end
