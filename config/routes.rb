Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  root to: 'home#index'

  resources :group, only: [:index, :new, :create, :destroy, :update, :edit] do
    resources :expense, only: [:index, :new, :create, :destroy, :update, :edit]
  end
  resources :home, only: [:index]
  
  post '/set_income', to: 'group#set_income'
  get '/render_sleeping', to: 'home#render_sleeping'
end
