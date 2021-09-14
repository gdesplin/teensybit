class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :trackable, :invitable

  enum kind: { provider: 0, guardian: 1 }
  belongs_to :daycare, optional: true # daycare guardian belongs to
  has_one :owned_daycare, class_name: 'Daycare', foreign_key: :user_id # daycare owner
  has_and_belongs_to_many :children
  belongs_to :stripe_customer, primary_key: "stripe_customer_id", optional: true

  def first_name
    name.split(" ")[0]
  end

  def last_name
    name.split(" ")[-1]
  end

  def invited_by
    User.find(invited_by_id)
  end

  def has_active_subscription?
    stripe_customer&.stripe_subscriptions&.find_by(status: %i[active trialing]).present?
  end
end
