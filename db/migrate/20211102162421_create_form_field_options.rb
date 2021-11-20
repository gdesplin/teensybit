class CreateFormFieldOptions < ActiveRecord::Migration[6.1]
  def change
    create_table :form_field_options do |t|
      t.string :name
      t.references :form_field, null: false, foreign_key: true

      t.timestamps
    end
    add_index :form_field_options, [:name, :form_field_id], unique: true
  end
end
