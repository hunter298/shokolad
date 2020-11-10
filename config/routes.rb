Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' } # to add cart to user after creation
  root to: 'products#index'

  resources :categories do
    resources :products, shallow: true do
      resources :cart_items, shallow: true, only: %i{create}
    end
  end

  resources :carts


end
