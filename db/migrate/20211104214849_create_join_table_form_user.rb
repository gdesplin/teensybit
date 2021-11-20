class CreateJoinTableFormUser < ActiveRecord::Migration[6.1]
  def change
    create_join_table :forms, :users do |t|
      t.index [:form_id, :user_id], unique: true
      # t.index [:user_id, :form_id]
    end
  end
end
