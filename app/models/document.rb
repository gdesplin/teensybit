class Document < ApplicationRecord
  belongs_to :daycare
  belongs_to :user
  has_and_belongs_to_many :users

  has_one_attached :document
  has_one_attached :response_document
  validates :document, attached: true

  after_save :message_parents

  scope :public_to_daycare, -> { where(public_to_daycare: true) }

  private

  def message_parents
    users.each do |user|
      MessageDocumentJob.perform_later(id, user.email)
    end
  end

end
