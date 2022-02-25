class Form < ApplicationRecord
  belongs_to :daycare
  has_many :form_fields, -> { order(position: :asc) }, dependent: :destroy
  has_many :entered_forms, dependent: :destroy
  has_and_belongs_to_many :users
  accepts_nested_attributes_for :form_fields, reject_if: :all_blank, allow_destroy: true
  validates :title, presence: true, uniqueness: { scope: :daycare_id }

  scope :published_to_daycare, -> { where(published_to_daycare: true) }

end
