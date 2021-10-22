class Document < ApplicationRecord
  belongs_to :daycare
  belongs_to :user
  has_and_belongs_to_many :users

  has_one_attached :document # Provider uploaded
  has_one_attached :response_document # Parent Uploaded (perhaps the document filled out and scanned in)

  validates :document, attached: true

  after_save :message_parents

  private

  def message_parents
    users.each do |user|
      MessageDocumentJob.perform_later(id, user.email)
    end
  end

end
