class CreateStripePrices < ActiveRecord::Migration[6.1]
  def change
    create_table :stripe_prices do |t|
      t.string :stripe_id
      t.string :stripe_product_id
      t.boolean :active
      t.string :nickname
      t.jsonb :recurring
      t.integer :type
      t.monetize :amount
      t.index :stripe_id
      t.index :stripe_product_id

      t.timestamps
    end
  end
end
