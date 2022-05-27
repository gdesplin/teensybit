# This is for managing a providers parents/guardians
class UsersController < ApplicationController
  before_action :authenticate_provider!
  before_action :set_user
  before_action :set_daycare
  before_action :authorize_user

  def show
  end

  def destroy
    @user.destroy
    redirect_to [:provider_dashboard, :daycares], notice: "Parent/Guardian successfully destroyed."
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def set_daycare
    @daycare = Daycare.friendly.find(params[:daycare_id])
  end

  def safe_params
    params.require(:user).permit(:name)
  end

  def authorize_user
    authorize @user
  end
end