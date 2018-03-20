Rails.application.routes.draw do
  root to: 'dashboard#show'

  resources :athletes, only: :show
  resources :events, only: [:index, :show]

  namespace :stats do
    namespace :summary do
      resource :athlete_event_wins, only: :show
      resource :event_distribution, controller: "event_distribution", only: :show
    end

    # resources :movements, only: :show
  end
end
