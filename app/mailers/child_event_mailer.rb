class ChildEventMailer < ApplicationMailer

  def child_event_message
    @child_event = ChildEvent.find(params[:child_event_id])
    mail(to: params[:email], subject: "A #{@child_event.child.daycare.name} child event is available for you to view.")
  end

end
