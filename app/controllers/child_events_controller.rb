class ChildEventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_daycare
  before_action :set_child_event, only: %i[show edit update destroy]
  before_action :authorize_child_event, only: %i[show edit update destroy]

  def index
   @pagy, @child_events = pagy(policy_scope(ChildEvent))
  end

  def show
    @child_event = policy_scope(ChildEvent).find(params[:id])
  end

  def new
    @child_event = ChildEvent.new
    authorize_child_event
  end

  def create
    @child_event = current_user.created_child_events.new(safe_params)
    @child_event.user = current_user
    authorize_child_event
    if @child_event.save
      redirect_to dashboard_path, notice: "Child event successfully uploaded"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @child_event.update(safe_params)
      redirect_to dashboard_path, notice: "Child event successfully updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
   if @child_event.destroy
      redirect_to dashboard_path, notice: "Child event successfully deleted"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_daycare
    @daycare = Daycare.friendly.find(params[:daycare_id])
  end

  def set_child_event
    @child_event = policy_scope(ChildEvent).find(params[:id])
  end

  def safe_params
    params.require(:child_event).permit(:child_id, :description, :happened_at)
  end

  def authorize_child_event
    authorize @child_event
  end

end
