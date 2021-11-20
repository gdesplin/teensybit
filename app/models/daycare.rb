class Daycare < ApplicationRecord
  has_many :users
  has_many :children
  has_many :forms
  has_many :pictures
  has_many :documents
  belongs_to :owner, class_name: 'User', foreign_key: :user_id
  has_one :stripe_account

  def has_active_subscription?
    owner.has_active_subscription?
  end

end
