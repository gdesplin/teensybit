class CreateChats < ActiveRecord::Migration[6.1]
  def change
    create_table :chats do |t|
      t.references :guardian, null: false, foreign_key: { to_table: :users }
      t.references :provider, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
