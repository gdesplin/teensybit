class Message < ApplicationRecord
  belongs_to :chat
  belongs_to :user
  belongs_to :recipient, class_name: "User"

  after_create_commit { broadcast_prepend_to(chat, partial: 'messages/message') } 
  after_update_commit { broadcast_update_to(broadcast_replace, partial: 'messages/message') } 

  validates :message_body, presence: true

  after_create :email_recipient

  private

  def email_recipient
    EmailMessageJob.set(wait: 5.seconds).perform_later(id, recipient.email)
  end
end
