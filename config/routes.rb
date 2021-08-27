Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations",
    invitations: 'users/invitations',
  }
  resources :contacts, only: [:create]
  resources :children, only: %i[create new edit update]
  resources :daycares do
    collection do
      get :dashboard
      post :subscription_checkout
    end
  end
  get 'terms', :to => 'home#terms'
  get 'privacy_policy', :to => 'home#privacy_policy'
  root to: 'home#index'
end
