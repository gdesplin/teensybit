class StripePaymentIntent < ApplicationRecord
  belongs_to :stripe_customer, primary_key: "stripe_id"
  belongs_to :stripe_invoice, primary_key: "stripe_id", optional: true

  monetize :amount_received_cents
  validates :stripe_id, uniqueness: true
  validates :stripe_id, presence: true
end
