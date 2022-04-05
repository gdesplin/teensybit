class CreateEnteredFormFields < ActiveRecord::Migration[6.1]
  def change
    create_table :entered_form_fields do |t|
      t.references :entered_form, null: false, foreign_key: true
      t.string :entered_string
      t.text :entered_text
      t.datetime :entered_datetime
      t.date :entered_date
      t.time :entered_time
      t.references :form_field, null: true

      t.timestamps
    end
  end
end
