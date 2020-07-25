Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :equipments do
    resources :bookings, only: %i[new create]

    collection do
      get :my
    end

  end

  resources :bookings, except: %i[new create] do
    resources :reviews, only: %i[new create]

    member do
      get :accept, :reject, :cancel
    end

  end

  resources :reviews, except: %i[new create]
end
