class EnteredFormsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_daycare
  before_action :set_entered_form, only: %i[show edit update destroy]
  before_action :authorize_entered_form, only: %i[show edit update destroy]

  def index
   @pagy, @entered_forms = pagy(policy_scope(EnteredForm))
  end

  def show
    @entered_form = policy_scope(EnteredForm).find(params[:id])
  end

  def new
    @entered_form = current_user.entered_forms.new(form_id: params[:form_id])
    authorize_entered_form
    build_entered_form
  end

  def create
    @entered_form = policy_scope(EnteredForm).new(safe_params)
    authorize_entered_form
    if @entered_form.save
      redirect_to daycare_entered_form_path(@daycare.friendly_id, @entered_form.id),
        notice: "Form successfully saved"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @entered_form.update(safe_params)
      redirect_to daycare_entered_form_path(@daycare.friendly_id, @entered_form.id),
        notice: "Form successfully updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
   if @entered_form.destroy
      redirect_to dashboard_path, notice: "Form successfully deleted"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def build_entered_form
    @entered_form.form.form_fields.order(:position).each do |form_field|
      @entered_form.entered_form_fields << EnteredFormField.new(form_field_id: form_field.id)
    end
  end

  def set_daycare
    @daycare = Daycare.friendly.find(params[:daycare_id])
  end

  def set_entered_form
    @entered_form = policy_scope(EnteredForm).find(params[:id])
  end

  def safe_params
    params.require(:entered_form).permit(policy(EnteredForm).permitted_attributes)
  end

  def authorize_entered_form
    authorize @entered_form
  end

end
