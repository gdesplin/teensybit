class EnteredForm < ApplicationRecord
  belongs_to :form
  belongs_to :user
  has_one :daycare, through: :form
  has_many :entered_form_fields, dependent: :destroy

  accepts_nested_attributes_for :entered_form_fields, reject_if: :all_blank, allow_destroy: true

end
