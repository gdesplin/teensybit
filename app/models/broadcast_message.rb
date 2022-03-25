# No database table
class BroadcastMessage
  include ActiveModel::Model
  include ActiveModel::Callbacks

  attr_accessor :id, :message_body, :recipient_ids, :users, :sender, :messages

  validates :message_body, :users, :sender, presence: true

  def users
    @users ||= User.where(id: recipient_ids)
  end
  
  def messages
    @messages ||= []
  end

  def save
    users.each do |user|
      if user.as_guardian_chat.blank?
        unless user.as_guardian_chat.create(provider_id: sender.id)
          errors.add(:base, :chat_couldnt_create)
        end
      end
      messages.push({
        message_body: message_body,
        recipient_id: user.id,
        chat_id: user.as_guardian_chat.id,
        user_id: sender.id
      })
    end
    Message.insert_all(messages)
  end
end
