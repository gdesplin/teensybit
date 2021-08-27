class Daycare < ApplicationRecord
  has_many :users
  has_many :children
  belongs_to :owner, class_name: 'User', foreign_key: :user_id
end
