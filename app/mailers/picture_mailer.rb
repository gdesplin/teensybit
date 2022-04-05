class PictureMailer < ApplicationMailer

  def picture_message
    @picture = Picture.find(params[:picture_id])
    @child = params[:child_name]
    mail(to: params[:email], subject: "Your child, #{@child_name} has been tagged in a photo")
  end

end
