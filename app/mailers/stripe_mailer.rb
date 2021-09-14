class StripeMailer < ApplicationMailer

  def successful_invoice_payment
    @stripe_customer = StripeCustomer.find_by(stripe_customer_id: params[:stripe_customer_id])
    @stripe_invoice = StripeInvoice.find_by(stripe_id: params[:stripe_invoice_id])
    mail(to: @stripe_customer.email, subject: "Teensy Bit Invoice Paid")
  end


  def successful_subscription_created
    @stripe_customer = StripeCustomer.find_by(stripe_customer_id: params[:stripe_customer_id])
    @stripe_subscription = StripeSubscription.find_by(stripe_id: params[:stripe_invoice_id])
    mail(to: @stripe_customer.email, subject: "Teensy Bit Subscription Started")
  end

  def subscription_updated

  end

  def subscription_deleted

  end
end
