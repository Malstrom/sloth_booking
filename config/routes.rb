Rails.application.routes.draw do
  resources :tournaments
  resources :trainings
  resources :timecells
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "timecells#index"
end
