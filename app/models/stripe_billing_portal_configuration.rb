class StripeBillingPortalConfiguration < ApplicationRecord
  belongs_to :stripe_account, primary_key: "stripe_id"
  validates :stripe_id, uniqueness: true
end
