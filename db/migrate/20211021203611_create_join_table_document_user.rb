class CreateJoinTableDocumentUser < ActiveRecord::Migration[6.1]
  def change
    create_join_table :documents, :users do |t|
      t.index [:document_id, :user_id], unique: true
      # t.index [:user_id, :document_id]
    end
  end
end
