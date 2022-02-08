class StripeSessionsController < ApplicationController
  before_action :authenticate_user!, except: %i[subscription_checkout subscription_success subscription_checkout_canceled]

  def subscription_checkout
    session[:price_id] = params[:price_id] if params[:price_id].present?
    if current_user
      stripe_params = {
        price_id: session[:price_id],
        email: current_user.email,
        name: current_user.name,
        customer: current_user.stripe_customer_id,
        stripe_account_id: current_user.daycare&.stripe_account&.stripe_id
      }
      stripe_params.delete(:email) if stripe_params[:customer].present?
      stripe_session = StripeSession.new.subscription(stripe_params)
      if current_user.stripe_customer.blank? && current_user.provider? # All new customers get free trial
        stripe_session[:subscription_data] = { trial_period_days: ENV['TRIAL_DAYS_AMOUNT'] }
      end
      session[:price_id] = nil
      redirect_to stripe_session.url
    else
      redirect_to %i[new user registration]
    end
  end

  def subscription_success
    flash.notice = "Your subscription was successful"
    # session = Stripe::Checkout::Session.retrieve(params[:session_id])
    # customer = Stripe::Customer.retrieve(session.customer)
    redirect_to provider_dashboard_daycares_url
  end

  def subscription_checkout_canceled
    flash.alert = "Your subscription was not successful, try again."
    redirect_to :root
  end

  def customer_portal
    session_params = { 
      stripe_customer_id: current_user.stripe_customer_id,
      return_url: provider_dashboard_daycares_url,
      stripe_account_id: current_user.daycare&.stripe_account&.stripe_id,
      configuration: current_user.daycare&.stripe_account&.stripe_billing_portal_configurations&.last&.stripe_id 
    }
    stripe_session = StripeSession.new.customer_portal(session_params)
    redirect_to stripe_session.url
  end

  def create_account_link
    if current_user.owned_daycare.stripe_account.blank?
      account_id = StripeSession.new.create_customer_account(current_user.email).id
      StripeAccount.create(daycare_id: current_user.owned_daycare.id, stripe_id: account_id)
    else
      account_id = current_user.owned_daycare.stripe_account.stripe_id
    end
    account_link = StripeSession.new.create_account_link(account_id)
    redirect_to account_link.url
  end

end