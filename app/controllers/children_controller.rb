class ChildrenController < ApplicationController
  before_action :authenticate_user!
  before_action :set_daycare, only: %i[new create edit update destroy]
  before_action :set_child, only: %i[show edit update destroy]
  before_action :authorize_child_update, only: %i[update destroy]
  before_action :authorize_daycare_create, only: :create

  def new
    @child = Child.new
  end

  def create
    @child = Child.new(safe_params)
    @child.daycare_id = @daycare.id
    @child.users << current_user if current_user.guardian?
    if @child.save
      redirect_to [:dashboard, :daycares], notice: "Child successfully created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @child.update(safe_params)
      redirect_to [:dashboard, :daycares], notice: "Child successfully updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @child.destroy
  end

  private

  def set_child
    @child = Child.find(params[:id])
  end

  def set_daycare
    @daycare = Daycare.find(params[:daycare_id])
  end

  def authorize_daycare_create
    authorized_id = current_user.daycare_id || current_user.owned_daycare&.id
    redirect_to :root, alert: "Unauthorized" unless authorized_id.to_i == params[:daycare_id].to_i
  end

  def authorize_child_update
    parents_child = @child.users.where(id: current_user.id).present?
    providers_child = current_user.owned_daycare.id == @child.daycare_id
    redirect_to :root, alert: "Unauthorized" unless parents_child || providers_child || current_user.admin?
  end

  def safe_params
    params.require(:child).permit(:name, user_ids: [])
  end

end