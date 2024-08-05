Rails.application.routes.draw do
  root 'home#index'

  get 'signup', to: 'usuarios#new', as: 'signup'
  post 'usuarios', to: 'usuarios#create'

  get 'login', to: 'sessions#new', as: 'login'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy', as: 'logout'

  resources :autors
  resources :livros
  resources :generos
end

