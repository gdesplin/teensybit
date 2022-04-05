class ChatsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_daycare
  before_action :set_chat, only: :show
  before_action :authorize_chat, only: :show

  def show
    @chat.mark_messages_read_at(current_user)
  end

  def create
    build_chat
    authorize_chat
    if @chat.save
      redirect_to [@daycare, @chat]
    else
      redirect_to dashboard_path
    end
  end

  private

  def recipient
    @recipient ||= User.find(params[:recipient_id])
  end

  def set_daycare
    @daycare = Daycare.find(params[:daycare_id])
  end

  def set_chat
    @chat = policy_scope(Chat)
    @chat = @chat.find(params[:id]) if current_user.provider?
  end

  def build_chat
    @chat ||= Chat.new(permitted_attributes(Chat))
    @chat.provider = @daycare.owner
    if current_user.guardian?
      @chat.guardian = current_user
    end
  end

  def authorize_chat
    authorize @chat
  end

end
