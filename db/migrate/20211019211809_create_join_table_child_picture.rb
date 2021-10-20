class CreateJoinTableChildPicture < ActiveRecord::Migration[6.1]
  def change
    create_join_table :children, :pictures do |t|
      t.index [:child_id, :picture_id], unique: true
      # t.index [:picture_id, :child_id]
    end
  end
end
