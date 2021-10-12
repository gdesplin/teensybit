class CreateStripeBillingPortalConfigurations < ActiveRecord::Migration[6.1]
  def change
    create_table :stripe_billing_portal_configurations do |t|
      t.string :stripe_id
      t.string :stripe_account_id
      t.jsonb :features
      t.jsonb :business_profile

      t.timestamps
    end
  end
end
