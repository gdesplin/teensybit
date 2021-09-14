class StripeWebhooksController < ApplicationController
  protect_from_forgery except: :create

  def create
    Stripe.api_key = ENV['STRIPE_API_KEY']
    webhook_secret = ENV['STRIPE_WEB_HOOK_SECRET']
    payload = request.body.read
    if webhook_secret.present?
      # Retrieve the event by verifying the signature using the raw body and secret if webhook signing is configured.
      sig_header = request.env['HTTP_STRIPE_SIGNATURE']
      event = nil

      begin
        event = Stripe::Webhook.construct_event(
          payload, sig_header, webhook_secret
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
      data = JSON.parse(payload, symbolize_names: true)
      event = Stripe::Event.construct_from(data)
    end
    # Get the type of webhook event sent
    event_type = event['type']
    data = event['data']
    data_object = data['object']
    case event.type
      # other events to consider: customer.subscription.deleted, customer.subscription.updated
      # all events that happen when a user signs up in order: * the ones we aren't currently handling
      # checkout.session.completed, customer.created, customer.updated, 
      #   *setup_intent.created, *payment_method.attached, customer.updated, *setup_intent.succeeded, 
      #   *invoice.created, *invoice.finalized, invoice.paid, *invoice.payment_succeeded
      #   customer.subscription.created, *setup_intent.created

    when 'checkout.session.completed'
      # Payment is successful and the subscription is created.
      # You should provision the subscription and save the customer ID to your database.
      user = User.find_by(stripe_customer_id: data_object.customer)
      if user.blank?
        user = User.find_by(email: (data_object.customer_email || data_object.customer_details.email))
        user.update(stripe_customer_id: data_object.customer)
      end
    when 'customer.created'
      StripeCustomer.create(
        stripe_customer_id: data_object.id,
        email: data_object.email,
        name: data_object.name,
        phone: data_object.phone,
        delinquent: data_object.delinquent,
        balance: data_object.balance,
      )
    when 'customer.updated'
      StripeCustomer.find_by(stripe_customer_id: data_object.id).update(
        stripe_customer_id: data_object.id,
        email: data_object.email,
        name: data_object.name,
        phone: data_object.phone,
        delinquent: data_object.delinquent,
        balance: data_object.balance,
      )
    when 'payment_intent.succeeded'
      # So we can have a record of successful payments
      StripePaymentIntent.create(
        stripe_customer_id: data_object.customer,
        stripe_id: data_object.id,
        stripe_invoice_id: data_object.invoice&.id || data_object.invoice,
        amount_recieved: data_object.amount_recieved,
      )
    when 'customer.subscription.created'
      # so we can know if a subscription is created
      StripeSubscription.create(
        stripe_customer_id: data_object.customer,
        stripe_id: data_object.id,
        current_period_end: data_object.current_period_end,
        cancel_at_period_end: data_object.cancel_at_period_end,
        current_period_start: data_object.current_period_start,
        status: data_object.status,
        canceled_at: data_object.canceled_at,
        ended_at: data_object.ended_at,
        next_pending_invoice_item_invoice: data_object.next_pending_invoice_item_invoice,
        pending_invoice_item_interval: data_object.pending_invoice_item_interval,
        trial_start: data_object.trial_start,
        trial_end: data_object.trial_end
      )
      StripeMailer.with(stripe_subscription_id: data_object.id, stripe_customer_id: data_object.customer)
        .successful_subscription_payment.deliver_later
    when 'customer.subscription.updated'
      # so we can know if a subscription updated
      subscription = StripeSubscription.find_by(stripe_id: data_object.id)
      subscription.update(
        current_period_end: data_object.current_period_end,
        cancel_at_period_end: data_object.cancel_at_period_end,
        current_period_start: data_object.current_period_start,
        status: data_object.status,
        canceled_at: data_object.canceled_at,
        ended_at: data_object.ended_at,
        next_pending_invoice_item_invoice: data_object.next_pending_invoice_item_invoice,
        pending_invoice_item_interval: data_object.pending_invoice_item_interval,
        trial_start: data_object.trial_start,
        trial_end: data_object.trial_end
      )
    when 'customer.subscription.deleted'
      # so we can know if a subscription updated
      pp data_object
      subscription = StripeSubscription.find_by(stripe_id: data_object.id)
      subscription.update(
        current_period_end: data_object.current_period_end,
        cancel_at_period_end: data_object.cancel_at_period_end,
        current_period_start: data_object.current_period_start,
        status: data_object.status,
        canceled_at: data_object.canceled_at,
        ended_at: data_object.ended_at,
        next_pending_invoice_item_invoice: data_object.next_pending_invoice_item_invoice,
        pending_invoice_item_interval: data_object.pending_invoice_item_interval,
        trial_start: data_object.trial_start,
        trial_end: data_object.trial_end
      )
    when 'invoice.paid'
      # Continue to provision the subscription as payments continue to be made.
      # Store the status in your database and check when a user accesses your service.
      # This approach helps you avoid hitting rate limits.
      invoice = StripeInvoice.find_or_create_by(stripe_id: data_object.id, stripe_customer_id: data_object.customer)
      invoice.update(
        hosted_invoice_url: data_object.hosted_invoice_url,
        total: data_object.total,
        paid: data_object.paid,
        invoice_pdf: data_object.invoice_pdf,
        collection_method: data_object.collection_method,
        subscription_id: data_object.subscription
      )
      StripeMailer.with(stripe_invoice_id: data_object.id, stripe_customer_id: data_object.customer)
        .successful_invoice_payment.deliver_later
    when 'invoice.payment_failed'
      # The payment failed or the customer does not have a valid payment method.
      # The subscription becomes past_due. Notify your customer and send them to the
      # customer portal to update their payment information.
      user = Invoice.find_by(stripe_customer_id: data_object.customer)
      subscription = update_subscription(data_object.subscription)
      invoice = update_or_create_invoice(data_object)
      user.owned_daycare.update(active_subscription: false) if data_object.payment_status != "paid"
    else
      puts "Unhandled event type: #{event.type}"
    end
    head :no_content
  end

  private

  def update_subscription(subscription)
    subscription = StripeSubscription.find_by(stripe_id: subscription.subscription.id)
    subscription.update(
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
      total: invoice.total,
      paid: invoice.paid,
      invoice_pdf: invoice.invoice_pdf,
      collection_method: invoice.collection_method,
      subscription_id: invoice.subscription_id
    )
  end
end