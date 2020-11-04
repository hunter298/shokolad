Rails.application.routes.draw do
  devise_for :users
  root to: 'products#index'

  resources :categories do
    resources :products, shallow: true
  end
end
