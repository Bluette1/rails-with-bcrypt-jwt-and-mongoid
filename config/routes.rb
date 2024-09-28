Rails.application.routes.draw do


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  # devise_for :users, controllers: {
  #   registrations: 'users/registrations',
  #   sessions: 'users/sessions'
  # }, defaults: { format: :json }


  post 'users', to: 'users/registrations#create' # Route for user registration
  post 'login', to: 'users/sessions#login'                    # Route for logging in
  delete 'logout', to: 'users/sessions#logout'   
  
end
