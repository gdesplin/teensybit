class FormsController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_provider!
  before_action :set_daycare
  before_action :set_form, only: %i[show edit update destroy]
  before_action :authorize_form, only: %i[show edit update destroy]

  def index
   @pagy, @forms = pagy(policy_scope(Form))
  end

  def show
    @form = policy_scope(Form).find(params[:id])
  end

  def new
    @form = @daycare.forms.new
    authorize_form
    respond_to do |format|
      format.html
      format.turbo_stream { render turbo_stream: turbo_stream.replace(
        "new_form",
        partial: 'form',
        locals: { form: @form, daycare: @daycare }
      ) }
    end
  end

  def create
    @form = policy_scope(Form).new(safe_params)
    @form.daycare_id = @daycare.id
    authorize_form
    if @form.save
      if params[:commit] == "Save Progress"
        render turbo_stream: turbo_stream.replace(
          "new_form",
          partial: 'form',
          locals: { form: @form, daycare: @daycare }
        )
      else
        redirect_to daycare_form_path(@daycare.id, @form.id), notice: "Form successfully uploaded"
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @form.update(safe_params)
      if params[:commit] == "Save Progress"
        render turbo_stream: turbo_stream.replace(
          "edit_form_#{@form.id}",
          partial: 'form',
          locals: { form: @form, daycare: @daycare }
        )
      else
        redirect_to daycare_form_path(@daycare.id, @form.id), notice: "Form successfully updated"
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
   if @form.destroy
      redirect_to dashboard_path, notice: "Form successfully deleted"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_daycare
    @daycare = Daycare.find(params[:daycare_id])
  end

  def set_form
    @form = policy_scope(Form).find(params[:id])
  end

  def safe_params
    params.require(:form).permit(policy(Form).permitted_attributes)
  end

  def authorize_form
    authorize @form
  end

end
