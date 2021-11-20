class FormFieldOption < ApplicationRecord
  belongs_to :form_field, optional: true
  validates :name, presence: true

end
