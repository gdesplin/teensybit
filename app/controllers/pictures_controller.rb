class PicturesController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_provider!, only: %i[new create edit update destroy]
  before_action :set_daycare
  before_action :set_picture, only: %i[show edit update destroy]
  before_action :authorize_picture, only: %i[show edit update destroy]

  def index
    authorize Picture
    @pagy, @pictures = pagy(policy_scope(Picture))
  end

  def show
    @picture = policy_scope(Picture).find(params[:id])
  end

  def new
    @picture = @daycare.pictures.new
    authorize_picture
  end

  def create
    @picture = policy_scope(Picture).new(safe_params)
    @picture.daycare_id = @daycare.id
    @picture.user = current_user
    authorize_picture
    if @picture.save
      redirect_to daycare_picture_path(@daycare, @picture), notice: "Picture successfully uploaded"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @picture.update(safe_params)
      redirect_to daycare_picture_path(@daycare, @picture), notice: "Picture successfully updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
   if @picture.destroy
      redirect_to dashboard_path, notice: "Picture successfully deleted"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_daycare
    @daycare = Daycare.find(params[:daycare_id])
  end

  def set_picture
    @picture = policy_scope(Picture).find(params[:id])
  end

  def safe_params
    params.require(:picture).permit(:title, :description, :public_to_daycare, :picture, child_ids: [])
  end

  def authorize_picture
    authorize @picture
  end

  def pundit_user
    DaycareUserContext.new(current_user, @daycare)
  end

end
