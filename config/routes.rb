Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :searches, only: [:new, :create]

  resources :gift_cards, only: [:new]

  root to: 'searches#new'
end
