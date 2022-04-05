class FormFieldOption < ApplicationRecord
  belongs_to :form_field, inverse_of: :form_field_options
  acts_as_list scope: :form_field, add_new_at: nil
  validates :name, presence: true, uniqueness: { scope: :form_field_id }
end
