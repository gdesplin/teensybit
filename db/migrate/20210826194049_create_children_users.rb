class CreateChildrenUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :children_users, id: false do |t|
      t.belongs_to :child
      t.belongs_to :user

      t.timestamps
    end
  end
end
