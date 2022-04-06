class MessageMailer < ApplicationMailer

  def email_message
    @message = Message.find(params[:message_id])
    return if @message.recipient_read_at.present?

    mail(to: params[:email], subject: "You have an unread message from #{@message.user.name} at Teensy Bit")
  end

end
