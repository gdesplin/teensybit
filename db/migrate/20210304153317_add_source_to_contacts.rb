class AddSourceToContacts < ActiveRecord::Migration[6.1]
  def up
    add_column :contacts, :source, :integer
  end
end
