class ChildrenController < ApplicationController
  before_action :authenticate_user!
  before_action :set_daycare
  before_action :set_child, only: %i[show edit update destroy]
  before_action :authorize_child, only: %i[show edit update destroy]

  def show
  end

  def new
    @child = Child.new(daycare_id: @daycare.id)
    authorize @child
  end

  def create
    @child = Child.new(permitted_attributes(Child))
    @child.daycare_id = @daycare.id
    @child.users << current_user if current_user.guardian?
    authorize @child
    if @child.save
      redirect_to dashboard_path, notice: "Child successfully created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @child.update(permitted_attributes(Child))
      redirect_to dashboard_path, notice: "Child successfully updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @child.destroy
      redirect_to dashboard_path, notice: "Child record successfully deleted"
    else 
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_child
    @child = Child.find(params[:id]) || Child.new(permitted_attributes(Child))
  end

  def set_daycare
    @daycare = Daycare.friendly.find(params[:daycare_id])
  end

  def authorize_child
    authorize @child
  end

end