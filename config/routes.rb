Rails.application.routes.draw do
  devise_for :users
  root to: "items#index"
  resources :items do
    resources :purchases, only: [:index, :create]
    resources :messages, only: :create
  end
  
end
