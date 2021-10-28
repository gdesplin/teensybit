class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :trackable, :invitable

  enum kind: { provider: 0, guardian: 1 } # guardian is often refered to as parent, but parent is a reserved name in rails/ruby
  belongs_to :daycare, optional: true # daycare parent belongs to
  has_one :owned_daycare, class_name: 'Daycare', foreign_key: :user_id # daycare owner
  has_and_belongs_to_many :children
  has_many :pictures, through: :children
  has_and_belongs_to_many :documents
  has_many :stripe_prices
  belongs_to :stripe_customer, primary_key: "stripe_id", optional: true
  scope :childless, -> { where.missing(:children) }

  before_destroy :deactive_stripe_prices, :delete_children

  def viewable_pictures
    pictures_ids = pictures.pluck(:id)
    if guardian?
      daycare.pictures.public_to_daycare.or(Picture.where(id: pictures_ids))
    elsif provider?
      owned_daycare.pictures.public_to_daycare.or(Picture.where(id: pictures_ids))
    end
  end

  def viewable_documents
    documents_ids = documents.pluck(:id)
    if guardian?
      daycare.documents.public_to_daycare.or(Document.where(id: documents_ids))
    elsif provider?
      owned_daycare.documents.public_to_daycare.or(Document.where(id: documents_ids))
    end
  end

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

  private

  def deactive_stripe_prices
    return unless guardian?
    stripe_prices.each do |price|
      DeactivateStripePriceJob.perform_later(price.stripe_id, daycare.stripe_account.stripe_id)
    end
  end

  def delete_children
    return unless guardian? && children.present?
    # only destroy children records that don't have another parent
    dont_destroy_ids = children&.joins(:users).where.not(users: { id: id }).pluck(:id)
    children.where.not(id: dont_destroy_ids).destroy_all
  end
end
