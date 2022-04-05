module MessagesHelper
  def chat_message_class(message)
    if message.user == message.chat.guardian
      return "chat-message-right"
    else
      return "chat-message-left"
    end
  end
end