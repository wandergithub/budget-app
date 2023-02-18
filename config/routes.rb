Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  root to: 'home#index'

  resources :group, only: [:index, :new, :create] do
    resources :expense, only: [:index, :new, :create]
  end
  resources :home, only: [:index]
  
 
end
