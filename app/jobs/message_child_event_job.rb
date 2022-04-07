class MessageChildEventJob < ApplicationJob
  queue_as :default

  def perform(child_event_id, email)
    ChildEventMailer.with(child_event_id: child_event_id, email: email).child_event_message.deliver_later
  end
end
