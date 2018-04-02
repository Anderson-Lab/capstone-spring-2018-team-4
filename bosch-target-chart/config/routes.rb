Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: { registrations: 'registrations' }

  resources :charts, only: [:create]
  resources :departments, only: [:index, :show]
  resources :indicators, only: [:create, :update, :destroy]
  resources :targets, only: [:new, :create, :update, :destroy]

  get 'dashboard' => 'charts#index'

  root to: 'home#index'
end
