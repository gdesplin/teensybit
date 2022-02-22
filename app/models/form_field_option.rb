class FormFieldOption < ApplicationRecord
  belongs_to :form_field, optional: true
  validates :name, presence: true, uniqueness: { scope: :form_field_id }
end
