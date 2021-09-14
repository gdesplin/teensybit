class StripePaymentIntent < ApplicationRecord
  belongs_to :stripe_customer, primary_key: "stripe_customer_id"
  belongs_to :stripe_invoice, primary_key: "stripe_id", optional: true
end
