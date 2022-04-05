class StripeCustomer < ApplicationRecord
  has_one :user, primary_key: "stripe_id"
  has_many :stripe_subscriptions, primary_key: "stripe_id"
  has_many :stripe_invoices, primary_key: "stripe_id"
  has_many :stripe_payment_intents, primary_key: "stripe_id"
  validates :stripe_id, uniqueness: true
end
