Rails.application.routes.draw do
  root to: 'dashboard#show'

  resources :athletes, only: :show
  resources :events, only: [:index, :show]

  namespace :stats do
    namespace :summary do
      resource :athlete_event_wins, only: :show
      resource :event_distribution, controller: "event_distribution", only: :show
      resource :runs, only: :show
      resource :rows, only: :show
    end

    resources :movement_maximums, only: :show
    resources :lift_successes_and_failures, only: :show
  end
end
