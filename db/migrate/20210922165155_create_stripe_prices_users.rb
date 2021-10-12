class CreateStripePricesUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :stripe_prices_users do |t|
      t.belongs_to :stripe_price
      t.belongs_to :user

      t.timestamps
    end
  end
end
