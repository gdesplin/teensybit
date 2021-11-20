class EnteredFormField < ApplicationRecord
  belongs_to :entered_form
  has_one_attached :attachment
end
