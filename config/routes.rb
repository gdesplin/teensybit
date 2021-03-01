Rails.application.routes.draw do
  resources :contacts, only: [:create]
  get 'terms', :to => 'home#terms'
  get 'privacy_policy', :to => 'home#privacy_policy'
  root to: 'home#index'
end
