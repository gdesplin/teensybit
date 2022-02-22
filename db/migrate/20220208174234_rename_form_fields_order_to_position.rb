class RenameFormFieldsOrderToPosition < ActiveRecord::Migration[6.1]
  def change
    rename_column :form_fields, :order, :position
  end
end
