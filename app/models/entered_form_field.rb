class EnteredFormField < ApplicationRecord
  belongs_to :entered_form
  belongs_to :form_field
  has_one_attached :attachment

  def answer
    return nil if form_field.field_kind == :file

    if %w[string radio_buttons select_box].include?(form_field.field_kind)
      entered_string
    elsif %w[time datetime].include?(form_field.field_kind)
      entered_datetime
    elsif form_field.field_kind == "date"
      entered_date
    elsif form_field.field_kind == "text"
      entered_text
    elsif form_field.field_kind == "check_boxes"
      entered_array.reject(&:blank?).join(", ")
    end
  end
end
