class DaycaresController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_provider!, only: %i[new create edit update]

  def index # for admin

  end

  def dashboard # loads different partial based on user kind
    case current_user.kind.to_sym
    when :provider
      @daycare = Daycare.find_by(user_id: current_user.id)
    when :guardian
      @daycare = current_user.daycare
    else
      @daycares = Daycare.all if current_user.admin?
    end
  end

  def show # admin
  end

  def new # for providers
    @daycare = Daycare.new(user_id: current_user.id)
  end

  def create # for providers
    @daycare = Daycare.new(safe_params)
    @daycare.user_id = current_user.id
    if @daycare.save
      redirect_to action: :dashboard, notice: "Daycare successfully created"
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def edit # for providers
    @daycare = current_user.daycare
  end

  def update # for providers
    @daycare = current_user.daycare
    if @daycare.update(safe_params)
      redirect_to :index, notice: "Daycare successfully updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy # for admins

  end

  private

  def safe_params
    params.require(:daycare).permit(%i[name address user_id address address_two city state zip phone])
  end
end
