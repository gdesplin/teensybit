class StripeInvoice < ApplicationRecord
  belongs_to :stripe_customer, primary_key: "stripe_id"
  belongs_to :stripe_subscription, primary_key: "stripe_id", optional: true

  monetize :total_cents
  validates :stripe_id, uniqueness: true
end
