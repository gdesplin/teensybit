class ChildrenController < ApplicationController
  before_action :authenticate_user!

  def new
    @child = Child.new
  end

  def create
    @child = current_user.children.create({name: safe_params[:name], daycare_id: current_user.daycare_id})
    if @child.errors.blank?
      redirect_to [:dashboard, :daycares]
    else
      puts @child.errors.full_messages
      render :new
    end
  end

  def edit
    @child = Child.find(params[:id])
  end

  def update
    @child = Child.find(params[:id])
    redirect_to :root and return if @child.users.where(id: current_user.id).blank? && (current_user.owned_daycare.id != @child.daycare_id && !current_user.admin?)

    if @child.update(safe_params)
      redirect_to [:dashboard, :daycares] 
    else
      render :edit
    end
  end

  private

  def safe_params
    params.require(:child).permit(:name, user_ids: [])
  end

end