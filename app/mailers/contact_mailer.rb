class ContactMailer < ApplicationMailer

  def contact_message
    @contact = params[:contact]
    mail(to: ENV['CONTACT_EMAIL'], subject: "New Contact Message From Teensy Bit", reply_to: @contact.email)
  end

end
