class StripeCustomer < ApplicationRecord
  has_one :user, primary_key: "stripe_customer_id", foreign_key: "stripe_customer_id"
  has_many :stripe_subscriptions, primary_key: "stripe_customer_id"
  has_many :stripe_invoices, primary_key: "stripe_customer_id"
  has_many :stripe_payment_intents, primary_key: "stripe_customer_id"
end
