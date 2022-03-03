class CreateChildEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :child_events do |t|
      t.references :child, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.datetime :happened_at
      t.text :description

      t.timestamps
    end
    add_index :child_events, [:happened_at, :child_id]
  end
end
