Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' } # to add cart to user after creation
  root to: 'products#index'

  resources :categories, only: %i{index show new create} do
    resources :products, shallow: true, only: %i{index show new create} do
      resources :cart_items, shallow: true, only: %i{create}
    end
  end

  resources :carts, only: %i{show} do
    resources :orders, only: %i{new create}, shallow: true
  end
end
