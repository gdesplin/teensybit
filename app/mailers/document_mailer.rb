class DocumentMailer < ApplicationMailer

  def document_message
    @document = Document.find(params[:document_id])
    @child = params[:child_name]
    mail(to: params[:email], subject: "A #{@document.daycare.name} document is available for you to view.")
  end

end
