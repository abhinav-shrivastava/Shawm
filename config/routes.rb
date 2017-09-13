Rails.application.routes.draw do
  get 'users/new'

  root 'static_pages#home', as: 'home'
  get  '/signup', to: 'users#new', as: 'signup'
  resources :users
end
