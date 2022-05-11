# No database table
class BroadcastMessage
  include ActiveModel::Model
  include ActiveModel::Callbacks

  attr_accessor :id, :message_body, :recipient_ids, :users, :sender_id, :sender, :messages

  validates :message_body, :sender_id, :recipient_ids, presence: true

  def sender
    @sender ||= User.find(sender_id)
  end

  def users
    @users ||= sender.owned_daycare.users.where(id: recipient_ids)
  end
  
  def messages
    @messages ||= []
  end

  def save
    return false unless valid?
    
    users.each do |user|
      chat = user.as_guardian_chat
      if chat.blank?
        chat = Chat.create(guardian_id: user.id, provider_id: sender.id)
        errors.add(:base, :chat_couldnt_create) unless chat.errors.blank?
      end
      messages.push({
        message_body: message_body,
        recipient_id: user.id,
        chat_id: chat.id,
        user_id: sender.id
      })
    end
    Message.insert_all(messages)
  end
end
