class BroadcastMessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_provider!
  before_action :set_daycare
  before_action :authorize_broadcast_message, only: :show

  def create
    @broadcast_message = BroadcastMessage.new(permitted_attributes(BroadcastMessage))
    @broadcast_message.sender = current_user
    if @broadcast_message.save
      redirect_to dashboard_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def new
    @broadcast_message = BroadcastMessage.new(sender_id: current_user.id)
    authorize @broadcast_message
  end

  private
  
  def set_daycare
    @daycare = Daycare.find(params[:daycare_id])
  end
end
