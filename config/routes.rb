Rails.application.routes.draw do
  get 'timetable/index'
  resources :clubs do

    resources :tournaments
    resources :trainings
  end
  resources :timecells
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "timetable#index"
end
