Rails.application.routes.draw do
  devise_for :users
  root "home#index"

  resources :xml_files, only: %i[new create]
end
