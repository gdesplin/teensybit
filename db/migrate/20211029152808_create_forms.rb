class CreateForms < ActiveRecord::Migration[6.1]
  def change
    create_table :forms do |t|
      t.references :daycare, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.boolean :published_to_daycare

      t.timestamps
    end
    add_index :forms, [:daycare_id, :title], unique: true
  end
end
