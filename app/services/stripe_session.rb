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
      customer: params[:customer],
      line_items: [{
        quantity: 1,
        price: params[:price_id],
      }],
      subscription_data: params[:subscription_data]
    }
    Stripe::Checkout::Session.create(stripe_session_data, stripe_account: params[:stripe_account_id])
  end

  def cancel_subscription(subscription_id, stripe_account_id)
    Stripe::Subscription.delete(subscription_id, {}, { stripe_account: stripe_account_id })
  end

  def customer_portal(params)
    stripe_billing_session_data = {
      customer: params[:stripe_customer_id],
      return_url: params[:return_url],
      configuration: params[:configuration]
    }
    Stripe::BillingPortal::Session.create(stripe_billing_session_data, stripe_account: params[:stripe_account_id])
  end

  def create_customer_account(email)
    Stripe::Account.create({
      type: 'standard',
      email: email,
      country: "US"
    })
  end

  def create_account_link(id)
    Stripe::AccountLink.create({
      account: id,
      refresh_url: create_account_link_stripe_sessions_url,
      return_url: dashboard_daycares_url,
      type: 'account_onboarding',
    })
  end

  def create_daycare_service_product(providers_stripe_account_id)
    Stripe::Product.create({
      name: 'Daycare Service',
      description: 'The product which represents the standard daycare service provided for children/parents.'
    }, stripe_account: providers_stripe_account_id)
  end

  def create_price(params)
    Stripe::Price.create({
      product: params[:stripe_product_id],
      nickname: params[:nickname],
      unit_amount: params[:amount_cents].to_i,
      recurring: params[:recurring],
      currency: params[:amount_currency],
    }, stripe_account: params[:stripe_account_id])
  end

  def set_price_to_inactive(price_id, stripe_account_id)
    Stripe::Price.update(price_id, {
      active: false,
    }, stripe_account: stripe_account_id)
  end

  def create_default_portal_configuration(providers_stripe_account_id)
    Stripe::BillingPortal::Configuration.create({
      features: {
        payment_method_update: { enabled: true },
        invoice_history: { enabled: true },
      },
      business_profile: {
        privacy_policy_url: privacy_policy_url,
        terms_of_service_url: terms_url,
      },
    }, stripe_account: providers_stripe_account_id)
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