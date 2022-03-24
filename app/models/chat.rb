class Chat < ApplicationRecord
  belongs_to :guardian, class_name: "User"
  belongs_to :provider, class_name: "User"
  has_many :messages

  def mark_messages_read_at(recipient)
    unread_messages = messages.where(recipient_read_at: nil, recipient: recipient)
    unread_messages.update_all(recipient_read_at: Time.now) if unread_messages.present?
  end

  def unread_messages_count(recipient)
    messages.where(recipient: recipient, recipient_read_at: nil).count
  end
end
