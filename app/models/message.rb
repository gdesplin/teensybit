class Message < ApplicationRecord
  belongs_to :chat
  belongs_to :user
  belongs_to :recipient, class_name: "User"

  after_create_commit { broadcast_prepend_to(chat, partial: 'messages/message') } 

  validates :message_body, presence: true
end
