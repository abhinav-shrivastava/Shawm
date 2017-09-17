Rails.application.routes.draw do
  get 'searches/new', as: 'search'
  get 'sessions/new'
  get 'users/new'
  root 'static_pages#home', as: 'home'
  get '/signup', to: 'users#new', as: 'signup'
  get '/history', to: 'users#show', as: 'history'
  resources :users
  resources :searches
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
