class MessageMailer < ApplicationMailer

  def email_message
    @message = Message.find(params[:message_id])
    puts "getting ready to email message #{@message.message_body}"
    return if @message.recipient_read_at.present?
    puts "mailing #{@message.message_body}"
    mail(to: params[:email], subject: "You have an unread message from #{@message.user.name} at Teensy Bit")
  end

end
