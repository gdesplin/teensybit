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
    respond_to do |entered_format|
      entered_format.html
      entered_format.turbo_stream { render turbo_stream: turbo_stream.replace(
        @entered_form,
        partial: 'entered_form',
        locals: { entered_form: @entered_form, daycare: @daycare }
      ) }
    end
  end

  def create
    @entered_form = policy_scope(EnteredForm).new(safe_params)
    authorize_entered_form
    if params[:entered_form][:new_entered_form_field_kind].present?
      @entered_form.entered_form_fields.build(field_kind: params[:entered_form].delete(:new_entered_form_field_kind).to_sym)
      render :new, status: :unprocessable_entity
    elsif params[:entered_form][:entered_form_fields_attributes].select { |k, v| v[:new_option].present? }.present?
      params[:entered_form][:entered_form_fields_attributes].each do |k, v|
        if v[:new_option].present?
          @entered_form.entered_form_fields[k.to_i].entered_form_field_options.build(name: v[:new_option])
        end
      end
      render :new, status: :unprocessable_entity
    elsif @entered_form.save
      redirect_to dashboard_path, notice: "Form successfully saved"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @entered_form.update(safe_params)
      redirect_to dashboard_path, notice: "Form successfully updated"
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
    @daycare = Daycare.find(params[:daycare_id])
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
