class EnteredForm < ApplicationRecord
  belongs_to :form
  belongs_to :user
  has_one :daycare, through: :form
  has_many :entered_form_fields, dependent: :destroy

  accepts_nested_attributes_for :entered_form_fields, reject_if: :all_blank, allow_destroy: true
  validates :form_id,
            inclusion: { in: ->(i) { [i.form_id_was] } },
            on: :update

  validates :user_id,
            inclusion: { in: ->(i) { [i.user_id_was] } },
            on: :update
end
