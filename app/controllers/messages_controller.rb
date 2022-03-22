class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_daycare
  before_action :set_chat
  before_action :set_message, only: %i[show edit update destroy]
  before_action :authorize_message, only: %i[show edit update destroy]

  def show
    @message = policy_scope(Message).find(params[:id])
  end

  def new
    @message = @daycare.messages.new
    authorize_message
  end

  def create
    @message = @chat.messages.new(permitted_attributes(Message))
    @message.user = current_user
    authorize_message
    if @message.save
      render turbo_stream: turbo_stream.prepend(@message.chat, @message)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @message.update_attributes(permitted_attributes(@message))
      render @message
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def recipient
    @recipient ||= User.find(params[:recipient_id])
  end

  def redirect_path
    @redirect_path = current_user.guardian? ? [:guardian_dashboard, :daycares] : [:provider_dashboard, :daycares]
  end

  def set_chat
    @chat = Chat.find(params[:chat_id])
  end

  def set_daycare
    @daycare = Daycare.find(params[:daycare_id])
  end

  def set_message
    @message = policy_scope(Message).find(params[:id])
  end

  def authorize_message
    authorize @message
  end

end
