class Daycare < ApplicationRecord
  extend FriendlyId

  friendly_id :slug_candidates, use: :slugged
  def slug_candidates
    [
      :name,
      [:name, :city],
      [:name, :city, :state],
      [:name, :address, :city, :state],
      [:name, :address, :address_two, :city, :state],
      [:name, :address, :address_two, :city, :state, :zip],
    ]
  end

  has_many :children
  has_many :child_events, through: :children
  has_many :documents
  has_many :forms
  has_many :entered_forms, through: :forms
  has_many :pictures
  has_many :users
  belongs_to :owner, class_name: 'User', foreign_key: :user_id
  has_one :stripe_account

  validates :name, presence: true

  def has_active_subscription?
    owner.has_active_subscription?
  end

end
