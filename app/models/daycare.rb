class Daycare < ApplicationRecord
  has_many :users
  has_many :children
  belongs_to :owner, class_name: 'User', foreign_key: :user_id

  def has_active_subscription?
    owner.has_active_subscription?
  end

end
