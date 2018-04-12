Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: { registrations: 'registrations' }

  resources :charts, only: [:create]
  resource :chart_target, only: [:create, :destroy]
  resources :departments, only: [:show, :new, :create, :edit, :update]
  resources :indicators, only: [:create, :update, :destroy]
  resources :targets, only: [:new, :create, :update, :destroy]
  resources :categories, only: [:index, :new, :create, :edit, :update]

  get 'dashboard' => 'charts#index'

  root to: 'home#index'
end
