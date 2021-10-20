class CreatePictures < ActiveRecord::Migration[6.1]
  def change
    create_table :pictures do |t|
      t.references :daycare, null: false, foreign_key: true
      t.string :title
      t.string :description
      t.references :user, null: false, foreign_key: true
      t.boolean :public_to_daycare, default: false

      t.timestamps
    end
  end
end
