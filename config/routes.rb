Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  root to: 'home#index'

  resources :group, only: [:index, :new, :create, :destroy] do
    resources :expense, only: [:index, :new, :create, :destroy]
  end
  resources :home, only: [:index]
  
  post '/set_income', to: 'group#set_income'

end
