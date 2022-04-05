class MessageFormJob < ApplicationJob
  queue_as :default

  def perform(form_id, email)
    FormMailer.with(form_id: form_id, email: email).form_message.deliver_later
    # send in app message
    # send twilio sms
  end
end
