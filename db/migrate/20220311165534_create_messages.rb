class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.references :recipient, null: false, foreign_key: { to_table: :users }
      t.references :user, null: false, foreign_key: true
      t.references :chat, null: false, foreign_key: true
      t.text :message_body
      t.datetime :recipient_read_at

      t.timestamps
    end
  end
end
