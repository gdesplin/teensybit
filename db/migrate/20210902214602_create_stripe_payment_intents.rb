class CreateStripePaymentIntents < ActiveRecord::Migration[6.1]
  def change
    create_table :stripe_payment_intents do |t|
      t.monetize :amount_received
      t.string :stripe_invoice_id
      t.string :stripe_id
      t.string :stripe_customer_id
      t.index :stripe_invoice_id
      t.index :stripe_customer_id
      t.index :stripe_id

      t.timestamps
    end
  end
end
