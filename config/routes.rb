Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations",
    invitations: 'users/invitations',
  }
  resources :contacts, only: :create
  resources :daycares do
    resources :broadcast_messages, only: [:create, :new]
    resources :chats do
      resources :messages, only: [:edit, :update, :create] do
        patch :mark_as_read, on: :member
      end
    end
    resources :children
    resources :child_events
    resources :documents
    resources :forms
    resources :entered_forms
    resources :pictures
    resources :stripe_prices, except: [:edit]
    resources :users, only: [:show, :destroy]
  
    collection do
      get :provider_dashboard
      get :guardian_dashboard
    end
  end

  resources :stripe_sessions do
    collection do
      post :customer_portal
      post :subscription_checkout
      get :create_account_link
      get :subscription_success
      get :subscription_checkout_canceled
    end
  end

  resources :stripe_webhooks, only: :create do
    post :connect, on: :collection
  end
  get 'sitemap.xml.gz', :to => 'home#sitemap'
  get 'terms', :to => 'home#terms'
  get 'privacy_policy', :to => 'home#privacy_policy'
  get 'check_email', :to => 'home#check_email'
  get '/user' => "daycares#guardian_dashboard", :as => :user_root
  root to: 'home#index'
end
