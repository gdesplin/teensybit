class ChildrenController < ApplicationController
  before_action :authenticate_user!
  before_action :set_daycare, only: %i[new create edit update destroy]
  before_action :set_child, only: %i[show edit update destroy]
  before_action :authorize_child, only: %i[show edit update destroy]

  def new
    @child = Child.new(daycare_id: @daycare.id)
    authorize @child
  end

  def create
    @child = Child.new(safe_params)
    @child.daycare_id = @daycare.id
    @child.users << current_user if current_user.guardian?
    authorize @child
    if @child.save
      redirect_to redirect_path, notice: "Child successfully created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @child.update(safe_params)
      redirect_to redirect_path, notice: "Child successfully updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @child.destroy
      redirect_to redirect_path, notice: "Child record successfully deleted"
    else 
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def redirect_path
    @redirect_path = current_user.guardian? ? [:guardian_dashboard, :daycares] : [:provider_dashboard, :daycares]
  end

  def set_child
    @child = Child.find(params[:id]) || Child.new(safe_params)
  end

  def set_daycare
    @daycare = Daycare.find(params[:daycare_id])
  end

  def safe_params
    params.require(:child).permit(:name, :photo, user_ids: [])
  end

  def authorize_child
    authorize @child
  end

end