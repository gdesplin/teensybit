class CreateDocuments < ActiveRecord::Migration[6.1]
  def change
    create_table :documents do |t|
      t.references :daycare, null: false, foreign_key: true
      t.string :title
      t.string :description
      t.boolean :public_to_daycare
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
