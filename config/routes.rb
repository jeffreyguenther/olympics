Rails.application.routes.draw do
  root to: 'dashboard#show'

  resources :athletes, only: :show
  resources :events, only: [:index, :show]

  namespace :stats do
    namespace :summary do
      resources :athlete_event_wins, only: :index
    end
  end
end
