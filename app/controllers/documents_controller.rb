class DocumentsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_provider!, only: %i[new create edit update destroy]
  before_action :set_daycare
  before_action :set_document, only: %i[show edit update destroy]
  before_action :authorize_document, only: %i[show edit update destroy]

  def index
   @pagy, @documents = pagy(policy_scope(Document))
  end

  def show
    @document = policy_scope(Document).find(params[:id])
  end

  def new
    @document = @daycare.documents.new
    authorize_document
  end

  def create
    @document = policy_scope(Document).new(safe_params)
    @document.daycare_id = @daycare.id
    @document.user = current_user
    authorize_document
    if @document.save
      redirect_to redirect_path, notice: "Document successfully uploaded"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @document.update(safe_params)
      redirect_to redirect_path, notice: "Document successfully updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
   if @document.destroy
      redirect_to redirect_path, notice: "Document successfully deleted"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def redirect_path
    @redirect_path = current_user.guardian? ? [:guardian_dashboard, :daycares] : [:provider_dashboard, :daycares]
  end

  def set_daycare
    @daycare = Daycare.find(params[:daycare_id])
  end

  def set_document
    @document = policy_scope(Document).find(params[:id])
  end

  def safe_params
    params.require(:document).permit(:title, :description, :public_to_daycare, :document, user_ids: [])
  end

  def authorize_document
    authorize @document
  end

end