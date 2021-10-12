class CreateStripeInvoices < ActiveRecord::Migration[6.1]
  def change
    create_table :stripe_invoices do |t|
      t.string :stripe_customer_id
      t.string :stripe_id
      t.string :hosted_invoice_url
      t.monetize :total
      t.boolean :paid
      t.string :invoice_pdf
      t.string :collection_method
      t.string :stripe_subscription_id
      t.index :stripe_customer_id
      t.index :stripe_subscription_id
      t.index :stripe_id

      t.timestamps
    end
  end
end
