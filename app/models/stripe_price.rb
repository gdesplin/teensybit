class StripePrice < ApplicationRecord
  belongs_to :stripe_product, primary_key: "stripe_id"
  belongs_to :user
  has_many :stripe_subscriptions, primary_key: "stripe_id"

  scope :active, -> { where(active: true) }

  monetize :amount_cents

  RECURRING_SCHEMA = {
    "required" => ["interval", "interval_count"],
    "properties" => {
      "interval" => { "type" => "string" },
      "interval_count" => { "type" => "integer" }
    }
  }
  validates :nickname, :recurring, :amount, presence: true
  validates :recurring, json_schema: true
  validates :stripe_id, uniqueness: true
  validates :amount, numericality: { greater_than: 0 }

  enum kind: { recurring: 0, one_time: 1 }
end
