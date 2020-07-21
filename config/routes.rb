Rails.application.routes.draw do
  devise_for :users
  root to: 'equipments#index'

  resources :equipments do
    resources :bookings, only: %i[new create show]
  end

  resources :bookings, except: %i[new create]

end
