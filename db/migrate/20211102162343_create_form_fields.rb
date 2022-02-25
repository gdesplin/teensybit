class CreateFormFields < ActiveRecord::Migration[6.1]
  def up
    execute "CREATE TYPE field_kind AS ENUM ('string', 'text', 'check_boxes', 'radio_buttons', 'select_box', 'file', 'datetime', 'date', 'time');"
    create_table :form_fields do |t|
      t.references :form, null: false, foreign_key: true
      t.string :question
      t.text :description
      t.integer :position, null: false, default: 1
      t.boolean :required

      t.timestamps
    end
    add_column :form_fields, :field_kind, :field_kind
    add_index :form_fields, [:position, :form_id]
    add_index :form_fields, [:question, :form_id], unique: true
  end

  def down
    drop_table :form_fields
    execute "DROP TYPE field_kind;"
  end
end
