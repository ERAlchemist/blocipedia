Rails.application.routes.draw do

  resources :wikis do
    resources :collaborators
  end
  resources :charges, only: [:new, :create]
  resources :downgrade, only: [:new, :create]
  post 'downgrade/create'
  
  get 'about' => 'welcome#about'

  root 'welcome#index'
  
  devise_for :users

end
