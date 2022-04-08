class StripeWebhookService
  include Rails.application.routes.url_helpers

  attr_accessor :request, :payload, :webhook_secret, :event, :event_type, :data, :data_object

  def initialize(request, stripe_api_key)
    @request = request
    Stripe.api_key = stripe_api_key
    @webhook_secret = ENV['STRIPE_WEB_HOOK_SECRET']
    @payload = request.body.read
    retrieve_event
  end

  def retrieve_event
    if @webhook_secret.present?
      # Retrieve the event by verifying the signature using the raw body and secret if webhook signing is configured.
      sig_header = @request.env['HTTP_STRIPE_SIGNATURE']
      @event = nil

      begin
        @event = Stripe::Webhook.construct_event(
          @payload, sig_header, @webhook_secret
        )
      rescue JSON::ParserError => e
        # Invalid payload
        status 400
        return
      rescue Stripe::SignatureVerificationError => e
        # Invalid signature
        puts '⚠️  Webhook signature verification failed.'
        status 400
        return
      end
    else
      @data = JSON.parse(@payload, symbolize_names: true)
      @event = Stripe::Event.construct_from(data)
    end
    @event_type = event['type']
    @data = event['data']
    @data_object = data['object']
  end

  def log_event
    # other events to consider: customer.subscription.deleted, customer.subscription.updated
    # all events that happen when a user signs up in order: when the ones we aren't currently handling
    # checkout.session.completed, customer.created, customer.updated, 
    #   *setup_intent.created, *payment_method.attached, customer.updated, *setup_intent.succeeded, 
    #   *invoice.created, *invoice.finalized, invoice.paid, *invoice.payment_succeeded
    #   customer.subscription.created, *setup_intent.created
    event_method = event.type.gsub('.', '_').to_sym
    if self.respond_to? event_method
      send(event_method)
    else
      puts "Unhandled event type: #{event.type}"
    end
    return true
  end


  def account_updated
    account = StripeAccount.find_by(stripe_id: @data_object.id)
    account&.update(
      country: @data_object.country,
      charges_enabled: @data_object.charges_enabled,
      details_submitted: @data_object.details_submitted,
    )
    if account.stripe_products.blank?
      product = StripeSession.new.create_daycare_service_product(account.stripe_id)
      StripeProduct.create(stripe_id: product.id, name: product.name, description: product.description, stripe_account_id: account.stripe_id)
    end
    if account.stripe_billing_portal_configurations.blank?
      config = StripeSession.new.create_default_portal_configuration(account.stripe_id)
      StripeBillingPortalConfiguration.create(stripe_id: config.id, stripe_account_id: account.stripe_id, features: config.features, business_profile: config.business_profile)
    end
  end

  def checkout_session_completed
    # Payment is successful and the subscription is created.
    # You should provision the subscription and save the customer ID to your database.
    user = User.find_by(stripe_customer_id: @data_object.customer)
    if user.blank?
      user = User.find_by(email: (@data_object.customer_email || @data_object.customer_details.email))
      user.update(stripe_customer_id: @data_object.customer)
    end
  end

  def customer_created
    StripeCustomer.create(
      stripe_id: @data_object.id,
      email: @data_object.email,
      name: @data_object.name,
      phone: @data_object.phone,
      delinquent: @data_object.delinquent,
      balance: @data_object.balance,
    )
  end

  def customer_updated
    StripeCustomer.find_by(stripe_id: @data_object.id)&.update(
      stripe_id: @data_object.id,
      email: @data_object.email,
      name: @data_object.name,
      phone: @data_object.phone,
      delinquent: @data_object.delinquent,
      balance: @data_object.balance,
    )
  end

  def payment_intent_succeeded
    # So we can have a record of successful payments
    StripePaymentIntent.create(
      stripe_customer_id: @data_object.customer,
      stripe_id: @data_object.id,
      stripe_invoice_id: @data_object.invoice,
      amount_received_cents: @data_object.amount_received,
    )
  end

  def customer_subscription_created
    # so we can know if a subscription is created
    StripeSubscription.create(
      stripe_customer_id: @data_object.customer,
      stripe_id: @data_object.id,
      current_period_end: @data_object.current_period_end,
      cancel_at_period_end: @data_object.cancel_at_period_end,
      current_period_start: @data_object.current_period_start,
      status: @data_object.status,
      canceled_at: @data_object.canceled_at,
      ended_at: @data_object.ended_at,
      next_pending_invoice_item_invoice: @data_object.next_pending_invoice_item_invoice,
      pending_invoice_item_interval: @data_object.pending_invoice_item_interval,
      trial_start: @data_object.trial_start,
      trial_end: @data_object.trial_end,
      stripe_price_id: @data_object.items.data[0]&.plan&.id
    )
    stripe_price = StripePrice.find_by(stripe_id: @data_object.items.data[0]&.plan&.id)
    stripe_customer = StripeCustomer.find_by(stripe_id: @data_object.customer)
    if stripe_customer.user.provider?
      StripeMailer.with(stripe_subscription: @data_object.to_hash)
        .successful_subscription_created.deliver_later
    elsif stripe_customer.user.guardian?
      StripeMailer.with(stripe_price: stripe_price, email: stripe_customer.email, name: stripe_customer.name, daycare_name: stripe_customer.user.daycare.name)
      .successful_autopayment_created.deliver_later
      StripeMailer.with(stripe_price: stripe_price, email: stripe_customer.user.daycare.owner.email, name: stripe_customer.name, daycare_name: stripe_customer.user.daycare.name)
        .successful_autopayment_created.deliver_later
    end
  end

  def customer_subscription_updated
    # so we can know if a subscription updated
    subscription = StripeSubscription.find_by(stripe_id: @data_object.id)
    subscription&.update(
      current_period_end: @data_object.current_period_end,
      cancel_at_period_end: @data_object.cancel_at_period_end,
      current_period_start: @data_object.current_period_start,
      status: @data_object.status,
      canceled_at: @data_object.canceled_at,
      ended_at: @data_object.ended_at,
      next_pending_invoice_item_invoice: @data_object.next_pending_invoice_item_invoice,
      pending_invoice_item_interval: @data_object.pending_invoice_item_interval,
      trial_start: @data_object.trial_start,
      trial_end: @data_object.trial_end,
      stripe_price_id: @data_object.items.data[0]&.plan&.id
    )
  end

  def customer_subscription_deleted
    # so we can know if a subscription updated
    subscription = StripeSubscription.find_by(stripe_id: @data_object.id)
    subscription&.update(
      current_period_end: @data_object.current_period_end,
      cancel_at_period_end: @data_object.cancel_at_period_end,
      current_period_start: @data_object.current_period_start,
      status: @data_object.status,
      canceled_at: @data_object.canceled_at,
      ended_at: @data_object.ended_at,
      next_pending_invoice_item_invoice: @data_object.next_pending_invoice_item_invoice,
      pending_invoice_item_interval: @data_object.pending_invoice_item_interval,
      trial_start: @data_object.trial_start,
      trial_end: @data_object.trial_end,
    )
  end

  def invoice_paid
    # Continue to provision the subscription as payments continue to be made.
    # Store the status in your database and check when a user accesses your service.
    # This approach helps you avoid hitting rate limits.
    invoice = StripeInvoice.find_or_create_by(stripe_id: @data_object.id, stripe_customer_id: @data_object.customer)
    if invoice&.update(
      hosted_invoice_url: @data_object.hosted_invoice_url,
      total_cents: @data_object.total,
      paid: @data_object.paid,
      invoice_pdf: @data_object.invoice_pdf,
      collection_method: @data_object.collection_method,
      stripe_subscription_id: @data_object.subscription
    )
      StripeMailer.with(stripe_invoice_id: @data_object.id, stripe_customer_id: @data_object.customer, email_to: invoice.stripe_customer.email)
        .successful_invoice_payment.deliver_later
      if invoice.stripe_customer.user.guardian?
        StripeMailer.with(stripe_invoice_id: @data_object.id, stripe_customer_id: @data_object.customer, email_to: invoice.stripe_customer.user.daycare.owner.email)
          .successful_invoice_payment.deliver_later
      end
    end
  end

  def invoice_updated
    invoice = StripeInvoice.find_or_create_by(stripe_id: @data_object.id, stripe_customer_id: @data_object.customer)
    invoice&.update(
      hosted_invoice_url: @data_object.hosted_invoice_url,
      total_cents: @data_object.total,
      paid: @data_object.paid,
      invoice_pdf: @data_object.invoice_pdf,
      collection_method: @data_object.collection_method,
      stripe_subscription_id: @data_object.subscription
    )
  end

  def invoice_payment_failed
    # The payment failed or the customer does not have a valid payment method.
    # The subscription becomes past_due. Notify your customer and send them to the
    # customer portal to update their payment information.
    user = User.find_by(stripe_customer_id: @data_object.customer)
    subscription = update_subscription(@data_object.subscription)
    invoice = update_or_create_invoice(@data_object)
    StripeMailer.with(stripe_invoice_id: @data_object.id, stripe_customer_id: @data_object.customer, email_to: invoice.stripe_customer.email)
      .failed_invoice_payment.deliver_later
    StripeMailer.with(stripe_invoice_id: @data_object.id, stripe_customer_id: @data_object.customer, email_to: invoice.stripe_customer.user.daycare.owner.email)
      .failed_invoice_payment.deliver_later
  end
  def price_updated
    stripe_price = StripePrice.find_by(stripe_id: @data_object.id)
    stripe_price.update(
      active: @data_object.active,
      nickname: @data_object.nickname,
      recurring: @data_object.recurring,
      kind: @data_object.type,
      amount: @data_object.unit_amount
    )
    if !stripe_price.active
      stripe_price.stripe_subscriptions.each do |subscription|
        CancelSubscriptionJob.perform_later(subscription.stripe_id, stripe_price.stripe_product.stripe_account_id)
      end
    end
  end

  private

  def update_subscription(subscription)
    subscription = StripeSubscription.find_by(stripe_id: subscription.subscription.id)
    subscription&.update(
      stripe_customer_id: subscription.subscription.customer,
      stripe_id: subscription.subscription.id,
      current_period_end: subscription.subscription.current_period_end,
      cancel_at_period_end: subscription.subscription.cancel_at_period_end,
      current_period_start: subscription.subscription.current_period_start,
      status: subscription.subscription.status,
      canceled_at: subscription.subscription.canceled_at,
      ended_at: subscription.subscription.ended_at,
      next_pending_invoice_item_invoice: subscription.subscription.next_pending_invoice_item_invoice,
      pending_invoice_item_interval: subscription.subscription.pending_invoice_item_interval,
      trial_start: subscription.subscription.trial_start,
      trial_end: subscription.subscription.trial_end,
    )
  end

  def update_or_create_invoice(invoice)
    invoice = StripeInvoice.find_or_create_by(stripe_id: invoice.id)
    invoice.update(
      hosted_invoice_url: invoice.hosted_invoice_url,
      total_cents: invoice.total,
      paid: invoice.paid,
      invoice_pdf: invoice.invoice_pdf,
      collection_method: invoice.collection_method,
      stripe_subscription_id: invoice.subscription_id
    )
  end
end