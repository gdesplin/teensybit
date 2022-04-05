class AddUserIdToStripePrices < ActiveRecord::Migration[6.1]
  def change
    add_reference :stripe_prices, :user, index: true
  end
end
