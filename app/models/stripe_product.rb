class StripeProduct < ApplicationRecord
  belongs_to :stripe_account, primary_key: "stripe_id"
  has_many :stripe_prices, primary_key: "stripe_id"
  validates :stripe_id, uniqueness: true
end
