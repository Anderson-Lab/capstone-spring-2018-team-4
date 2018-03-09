Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: { registrations: 'registrations' }

  resources :departments, only: [:index, :show]
  resources :targets, only: [:new, :create, :update]
  resources :users, only: [:show]

  get 'dashboard' => 'charts#index'

  root to: 'home#index'
end
