Rails.application.routes.draw do
  resources :contracts
  resources :tools
  resources :users

  resources :sessions
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'sessions#new'
end
