class StripeAccount < ApplicationRecord
  belongs_to :daycare
  has_many :stripe_products, primary_key: "stripe_id"
  has_many :stripe_subscriptions, primary_key: "stripe_id"
  has_many :stripe_products, primary_key: "stripe_id"
  has_many :stripe_billing_portal_configurations, primary_key: "stripe_id"
  validates :stripe_id, uniqueness: true
end
