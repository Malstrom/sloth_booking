Rails.application.routes.draw do
  resources :clubs
  resources :slots do
    collection do
      put :set_working_time
      put :set_working_time_club
    end
  end

  resources :timetable
  resources :clubs do
    resources :tournaments
    resources :trainings
  end

  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "timetable#index"
end
