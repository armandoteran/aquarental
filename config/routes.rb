Rails.application.routes.draw do
  devise_for :users
  root to: 'equipments#index'
  get 'equipments', to: 'equipments#index', as: :equipments
  get 'equipments/new', to: 'equipments#new', as: :new_equipment

  get 'equipments/:id', to: 'equipments#show', as: :equipment
  post 'equipment', to: 'equipment#create'

  delete 'equipment/:id', to: 'equipments#destroy'

  resources :equipments

end
