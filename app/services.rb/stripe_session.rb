class StripeSession
  include Rails.application.routes.url_helpers

  attr_accessor

  def initialize
    Stripe.api_key = ENV['STRIPE_API_KEY']
  end

  def subscription(params)
    params = setup_subscription_params(params)
    stripe_session_data = {
      success_url: params[:success_url],
      cancel_url: params[:cancel_url],
      payment_method_types: params[:payment_method_types],
      mode: 'subscription',
      customer_email: params[:email],
      line_items: [{
        quantity: 1,
        price: params[:price_id],
      }],

    }
    if params[:customer_id].blank? # All new customers get free trial
      stripe_session_data[:subscription_data] = { trial_period_days: ENV['TRIAL_DAYS_AMOUNT'] }
    end
    Stripe::Checkout::Session.create(stripe_session_data)
  end

  def customer_portal(params)
    stripe_billing_session_data = {
      customer: params[:stripe_customer_id],
      return_url: params[:return_url]
    }
    Stripe::BillingPortal::Session.create(stripe_billing_session_data)
  end

  private

  def setup_subscription_params(params)
    params[:customer_id] ||= nil
    params[:email] ||= nil
    params[:name] ||= nil
    params[:success_url] ||= subscription_success_stripe_sessions_url + "?session_id={CHECKOUT_SESSION_ID}"
    params[:cancel_url] ||= subscription_checkout_canceled_stripe_sessions_url
    params[:payment_method_types] ||= ['card']
    params
  end
  
end