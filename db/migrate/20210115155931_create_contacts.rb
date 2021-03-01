class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.text :notes
      t.text :message
      t.boolean :opt_in_emails

      t.timestamps
    end
  end
end
