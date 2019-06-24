Rails.application.routes.draw do


  get '/sign_up', to: 'registrations#new', as: :sign_up
  post '/sign_up', to: 'registrations#create'

  get '/profile', to: 'profile#show', as: :profile
end
