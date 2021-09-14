Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations",
    invitations: 'users/invitations',
  }
  resources :contacts, only: :create
  resources :children, only: %i[create new edit update]
  resources :daycares do
    collection do
      get :dashboard
    end
  end

  resources :stripe_sessions do
    collection do
      post :subscription_checkout
      post :customer_portal
      get :subscription_success
      get :subscription_checkout_canceled
    end
  end

  resources :stripe_webhooks, only: :create
  get 'terms', :to => 'home#terms'
  get 'privacy_policy', :to => 'home#privacy_policy'
  get '/user' => "daycares#dashboard", :as => :user_root
  root to: 'home#index'
end
