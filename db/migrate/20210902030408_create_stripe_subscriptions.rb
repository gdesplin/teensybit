class CreateStripeSubscriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :stripe_subscriptions do |t|
      t.string :stripe_customer_id
      t.string :stripe_id
      t.datetime :current_period_end
      t.boolean :cancel_at_period_end
      t.datetime :current_period_start
      t.datetime :canceled_at
      t.datetime :ended_at
      t.datetime :next_pending_invoice_item_invoice
      t.jsonb :pending_invoice_item_interval
      t.datetime :trial_start
      t.datetime :trial_end
      t.integer :status
      t.index :status
      t.index :stripe_customer_id
      t.index :stripe_id

      t.timestamps
    end
  end
end
