Rails.application.routes.draw do
  root to: 'dashboard#show'

  resources :athletes, only: :show
  resources :events, only: [:index, :show]
end
