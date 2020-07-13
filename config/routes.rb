Rails.application.routes.draw do
  devise_for :users
  root to: 'equipments#index'
  get 'equipments', to: 'equipments#index', as: :equipments
  get 'equipments', to: 'equipments#show', as: :equipment
end
