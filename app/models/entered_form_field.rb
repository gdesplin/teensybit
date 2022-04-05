class EnteredFormField < ApplicationRecord
  belongs_to :entered_form
  belongs_to :form_field
  has_one_attached :attachment

  def answer
    puts form_field.field_kind
    return nil if form_field.field_kind == :file
    if %w[string check_boxes radio_buttons select_box].include?(form_field.field_kind)
      entered_string
    elsif %w[time datetime].include?(form_field.field_kind)
      puts "time"
      entered_time
    elsif form_field.field_kind == "date"
      puts "date found"
      puts entered_date
      puts self.inspect
      entered_date
    elsif form_field.field_kind == :text
      entered_text
    end
  end
end
