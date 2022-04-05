class DaycaresController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_provider!, only: %i[new create edit update]

  def provider_dashboard
    @daycare = Daycare.find_by(user_id: current_user.id)
    if @daycare.blank?
      redirect_to [:new, :daycare]
      return
    end
  
    authorize @daycare
  end

  def guardian_dashboard
    @daycare = current_user.daycare
    authorize @daycare
  end

  def new
    @daycare = Daycare.new(user_id: current_user.id)
  end

  def create
    @daycare = Daycare.new(safe_params)
    @daycare.user_id = current_user.id
    if @daycare.save
      redirect_to action: :provider_dashboard, notice: "Daycare successfully created"
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def edit # TODO: implement in views
    @daycare = current_user.owned_daycare
    authorize @daycare
  end

  def update # TODO: implement in views
    @daycare = current_user.owned_daycare
    authorize @daycare
    if @daycare.update(safe_params)
      redirect_to action: :provider_dashboard, notice: "Daycare successfully updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def safe_params
    params.require(:daycare).permit(%i[name address user_id address address_two city state zip phone])
  end

end
