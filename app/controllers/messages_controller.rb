class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_daycare
  before_action :set_chat
  before_action :set_message, only: %i[show edit update destroy mark_as_read]
  before_action :authorize_message, only: %i[show edit update destroy mark_as_read]

  def create
    @message = @chat.messages.new(permitted_attributes(Message))
    @message.user = current_user
    authorize_message
    if @message.save
      render turbo_stream: turbo_stream.prepend(@message.chat, @message)
    else
      head :unprocessable_entity, content_type: "text/html"
    end
  end

  def edit
  end

  def update
    if @message.update(permitted_attributes(@message))
      render turbo_stream: turbo_stream.update(@message)
    else
      head :unprocessable_entity, content_type: "text/html"
    end
  end

  def mark_as_read
    if @message.update(recipient_read_at: Time.now)
      render turbo_stream: turbo_stream.update(@message)
    end
  end

  private

  def recipient
    @recipient ||= User.find(params[:recipient_id])
  end

  def set_chat
    @chat = Chat.find(params[:chat_id])
  end

  def set_daycare
    @daycare = Daycare.friendly.find(params[:daycare_id])
  end

  def set_message
    @message = policy_scope(Message).find(params[:id])
  end

  def authorize_message
    authorize @message
  end

end
