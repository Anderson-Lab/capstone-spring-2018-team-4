Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: { registrations: 'registrations' }

  resources :departments, only: [:index, :show]
  resources :indicators, only: [:create, :update]
  resources :targets, only: [:new, :create, :update, :destroy]
  resources :categories, only: [:index, :new, :create]

  get 'dashboard' => 'charts#index'

  root to: 'home#index'
end
