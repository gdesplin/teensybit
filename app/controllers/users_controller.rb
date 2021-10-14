# This is for managing a providers parents/guardians
class UsersController < ApplicationController
  before_action :authenticate_provider!
  before_action :set_user
  before_action :set_daycare

  def show
  end

  def destroy
    @user.destroy
    redirect_to [:dashboard, :daycares], notice: "Parent/Guardian successfully destroyed."
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def set_daycare
    @daycare = Daycare.find(params[:daycare_id])
  end

  def safe_params
    params.require(:user).permit(:name)
  end

end