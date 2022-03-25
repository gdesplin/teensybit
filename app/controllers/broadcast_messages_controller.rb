class BroadcastMessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_provider!
  before_action :set_daycare
  before_action :authorize_broadcast_message, only: :show

  def create
    @broadcast_message = BroadcastMessage.new(permitted_attributes(BroadcastMessage))
    @broadcast_message.sender = current_user
    if @broadcast_message.save
      redirect_to redirect_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def new
    @broadcast_message = BroadcastMessage.new(sender: current_user)
    authorize @broadcast_message
  end

  private
  
  def redirect_path
    @redirect_path = current_user.guardian? ? [:guardian_dashboard, :daycares] : [:provider_dashboard, :daycares]
  end

  def set_daycare
    @daycare = Daycare.find(params[:daycare_id])
  end
end
