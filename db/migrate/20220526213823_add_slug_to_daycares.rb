class AddSlugToDaycares < ActiveRecord::Migration[7.0]
  def change
    add_column :daycares, :slug, :string
    add_index :daycares, :slug, unique: true
  end
end
