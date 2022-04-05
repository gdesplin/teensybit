class CreateEnteredForms < ActiveRecord::Migration[6.1]
  def change
    create_table :entered_forms do |t|
      t.references :form, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
