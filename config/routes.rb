Rails.application.routes.draw do
  root to: "searches#index"

  resources :searches, only: [:index]
end
