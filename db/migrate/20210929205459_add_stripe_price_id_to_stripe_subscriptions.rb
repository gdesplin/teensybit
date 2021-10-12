class AddStripePriceIdToStripeSubscriptions < ActiveRecord::Migration[6.1]
  def change
    add_column :stripe_subscriptions, :stripe_price_id, :string
  end
end
