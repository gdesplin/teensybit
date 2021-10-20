class MessagePictureJob < ApplicationJob
  queue_as :default

  def perform(picture_id, email, child_name)
    PictureMailer.with(picture_id: picture_id, email: email, child_name: child_name).picture_message.deliver_later
    # send in app message
    # send twilio sms
  end
end
