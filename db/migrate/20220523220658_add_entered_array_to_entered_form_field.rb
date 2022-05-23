class AddEnteredArrayToEnteredFormField < ActiveRecord::Migration[7.0]
  def change
    add_column :entered_form_fields, :entered_array, :string, array: true, default: []
  end
end
