class StripeSubscription < ApplicationRecord
  belongs_to :stripe_customer, primary_key: "stripe_id"
  belongs_to :stripe_price, primary_key: "stripe_id", optional: true
  has_many :stripe_invoices, primary_key: "stripe_id"
  enum status: { active: 0, past_due: 1, unpaid: 2, canceled: 3, incomplete: 4, incomplete_expired: 5, trialing: 6 }
  validates :stripe_id, uniqueness: true
  validates :stripe_id, presence: true
end
