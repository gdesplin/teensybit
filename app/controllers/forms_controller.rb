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
    # @form.form_fields.build(field_kind: :string)
    respond_to do |format|
      format.html
      format.turbo_stream { render turbo_stream: turbo_stream.replace(
        @form,
        partial: 'form',
        locals: { form: @form, daycare: @daycare }
      ) }
    end
  end

  def create
    @form = policy_scope(Form).new(safe_params)
    @form.daycare_id = @daycare.id
    authorize_form
    if params[:form][:new_form_field_kind].present?
      @form.form_fields.build(field_kind: params[:form].delete(:new_form_field_kind).to_sym)
      render :new, status: :unprocessable_entity
    elsif params[:form][:form_fields_attributes].select { |k, v| v[:new_option].present? }.present?
      params[:form][:form_fields_attributes].each do |k, v|
        if v[:new_option].present?
          @form.form_fields[k.to_i].form_field_options.build(name: v[:new_option])
          puts @form.form_fields[k.to_i].form_field_options.inspect
        end
      end
      render :new, status: :unprocessable_entity
    elsif @form.save
      redirect_to redirect_path, notice: "Form successfully uploaded"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @form.update(safe_params)
      redirect_to redirect_path, notice: "Form successfully updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
   if @form.destroy
      redirect_to redirect_path, notice: "Form successfully deleted"
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

  def set_form
    @form = policy_scope(Form).find(params[:id])
  end

  def safe_params
    params.require(:form).permit(
      :title,
      :description,
      :published_to_daycare,
      form_fields_attributes: [:id, :form_id, :question, :description, :order, :required, :field_kind, form_field_options_attributes: [:id, :name]],
      user_ids: []
    )
  end

  def authorize_form
    authorize @form
  end

end
