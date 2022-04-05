class StripeMailer < ApplicationMailer

  def successful_invoice_payment
    @stripe_customer = StripeCustomer.find_by(stripe_id: params[:stripe_customer_id])
    @stripe_invoice = StripeInvoice.find_by(stripe_id: params[:stripe_invoice_id])
    mail(to: @stripe_customer.email, subject: "Teensy Bit Invoice Paid")
  end

  def successful_invoice_payment
    @stripe_customer = StripeCustomer.find_by(stripe_id: params[:stripe_customer_id])
    @stripe_invoice = StripeInvoice.find_by(stripe_id: params[:stripe_invoice_id])
    mail(to: @stripe_customer.email, subject: "Teensy Bit Invoice Paid")
  end

  def successful_subscription_created
    @stripe_subscription = params[:stripe_subscription]
    mail(to: @stripe_subscription.customer.email, subject: "Teensy Bit Subscription Started")
  end

  def successful_autopayment_created
    @stripe_price = params[:stripe_price]
    @name = params[:name]
    mail(to: params[:email], subject: "#{params[:daycare_name]} - Teensy Bit Autopayment Started")
  end

  def subscription_updated

  end

  def subscription_deleted

  end
end
