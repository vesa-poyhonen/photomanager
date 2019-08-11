Rails.application.routes.draw do
  root to: 'sessions#new'

  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy', as: 'logout'

  get '/oauth/request', to: 'tweets#oauth_request', as: 'oauth_request'
  get '/oauth/callback', to: 'tweets#oauth_callback', as: 'oauth_callback'
  get '/tweet/:id', to: 'tweets#submit', as: 'tweet'

  resources :pictures, except: [:edit, :update, :show]
end