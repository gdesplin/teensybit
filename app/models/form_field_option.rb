class FormFieldOption < ApplicationRecord
  belongs_to :form_field
  acts_as_list scope: :form_field, add_new_at: nil
  validates :name, presence: true, uniqueness: { scope: :form_field_id }
end
