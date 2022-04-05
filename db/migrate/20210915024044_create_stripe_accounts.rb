class CreateStripeAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :stripe_accounts do |t|
      t.string :stripe_id
      t.string :country
      t.boolean :charges_enabled
      t.boolean :details_submitted
      t.integer :daycare_id
      t.index :stripe_id
      t.index :daycare_id

      t.timestamps
    end
  end
end
