class ContactsController < ApplicationController

  def create
    @contact = Contact.new(safe_params)
    if @contact.save
      if @contact.message.present?
        ContactMailer.with(contact: @contact).contact_message.deliver_later
        success_text = ["Email sent!"]
      else
        success_text = []
      end
      if @contact.opt_in_emails.present?
        response = MailchimpService.new(safe_params).create_new_subscriber
        if response.status == 200
          success_text << "Successfully signed up for emails!"
        else
          success_text << "There was a problem signing you up for emails."
        end
      end
      flash[:success] = success_text.join(" ")
      redirect_to :root
    else
      flash[:error] = @contact.errors.full_messages
      redirect_to :root
    end
  end

  private

  def safe_params
    params.require(:contact).permit([
      :name,
      :email,
      :message,
      :opt_in_emails,
    ])
  end

end
  