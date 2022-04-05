class RenameStripePriceTypeToKind < ActiveRecord::Migration[6.1]
  def change
    rename_column :stripe_prices, :type, :kind
  end
end
