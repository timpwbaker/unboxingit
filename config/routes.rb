Rails.application.routes.draw do

  root to: 'index#index'

  resources :gitsearches, only: [:index]
  
end
