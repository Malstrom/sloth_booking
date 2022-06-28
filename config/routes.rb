# frozen_string_literal: true

Rails.application.routes.draw do
  resources :clubs
  resources :slots do
    collection do
      put :set_working_time
    end
  end

  resources :timetable
  resources :clubs do
    resources :events
    resources :tournaments
    resources :trainings
  end

  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'timetable#index'
end
