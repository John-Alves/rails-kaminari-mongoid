Rails.application.routes.draw do
  root to: 'products#index'
  resources :products do
    resources :tickets do
      resources :prices
    end
  end
end
