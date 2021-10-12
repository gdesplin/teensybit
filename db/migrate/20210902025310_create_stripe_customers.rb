class CreateStripeCustomers < ActiveRecord::Migration[6.1]
  def change
    create_table :stripe_customers do |t|
      t.string :stripe_id
      t.string :email
      t.string :name
      t.string :phone
      t.boolean :delinquent
      t.integer :balance
      t.index :stripe_id

      t.timestamps
    end
  end
end
