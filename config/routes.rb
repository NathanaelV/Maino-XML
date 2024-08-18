Rails.application.routes.draw do
  devise_for :users
  root "home#index"

  resources :einvoices, only: %i[new create]
end
