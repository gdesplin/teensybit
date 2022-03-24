class EmailMessageJob < ApplicationJob
  queue_as :default

  def perform(message_id, email)
    MessageMailer.with(message_id: message_id, email: email).email_message.deliver_later
    # send twilio sms
  end
end
