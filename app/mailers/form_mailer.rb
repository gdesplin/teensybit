class FormMailer < ApplicationMailer

  def form_message
    @form = Form.find(params[:form_id])
    @child = params[:child_name]
    mail(to: params[:email], subject: "A #{@form.daycare.name} form is available for you to fill out.")
  end

end
