Rails.application.routes.draw do

  resources :wikis
  resources :charges, only: [:new, :create]
  resources :downgrade, only: [:new, :create]
  post 'downgrade/create'
  
  get 'about' => 'welcome#about'

  root 'welcome#index'
  
  devise_for :users

end
