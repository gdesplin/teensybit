class Form < ApplicationRecord
  attr_accessor :new_form_field_kind
  belongs_to :daycare
  has_many :form_fields
  has_and_belongs_to_many :users
  accepts_nested_attributes_for :form_fields, reject_if: :all_blank, allow_destroy: true
  validates :title, presence: true, unless: :new_form_field_kind
end
