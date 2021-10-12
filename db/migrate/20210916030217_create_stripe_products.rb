class CreateStripeProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :stripe_products do |t|
      t.string :stripe_id
      t.string :name
      t.boolean :active
      t.text :description
      t.text :stripe_account_id
      t.index :stripe_id
      t.index :stripe_account_id

      t.timestamps
    end
  end
end
