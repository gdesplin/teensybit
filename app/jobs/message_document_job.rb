class MessageDocumentJob < ApplicationJob
  queue_as :default

  def perform(document_id, email, child_name)
    DocumentMailer.with(document_id: document_id, email: email, child_name: child_name).document_message.deliver_later
    # send in app message
    # send twilio sms
  end
end
