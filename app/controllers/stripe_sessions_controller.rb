class StripeSessionsController < ApplicationController
  before_action :authenticate_user!, except: %i[subscription_checkout subscription_success subscription_checkout_canceled]

  def subscription_checkout
    session[:price_id] = params[:price_id] if params[:price_id].present?
    if current_user
      stripe_session = StripeSession.new.subscription({ price_id: session[:price_id], email: current_user.email, name: current_user.name })
      session[:price_id] = nil
      redirect_to stripe_session.url
    else
      redirect_to %i[new user registration]
    end
  end

  def subscription_success
    flash.notice = "Your subscription was successful"
    session = Stripe::Checkout::Session.retrieve(params[:session_id])
    customer = Stripe::Customer.retrieve(session.customer)
    redirect_to new_user_registration_path(email: customer.email, name: customer.name, stripe_customer_id: session.customer)
  end

  def subscription_checkout_canceled
    flash.alert = "Your subscription was not successful, try again."
    redirect_to :root
  end

  def customer_portal
    session_params = { stripe_customer_id: current_user.stripe_customer_id, return_url: dashboard_daycares_url }
    stripe_session = StripeSession.new.customer_portal(session_params)
    redirect_to stripe_session.url
  end

end