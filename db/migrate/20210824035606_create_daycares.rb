class CreateDaycares < ActiveRecord::Migration[6.1]
  def change
    create_table :daycares do |t|
      t.string :name
      t.integer :user_id
      t.string :address
      t.string :address_two
      t.string :city
      t.string :state
      t.string :zip
      t.string :phone

      t.timestamps
    end
  end
end
