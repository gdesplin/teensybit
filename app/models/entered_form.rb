class EnteredForm < ApplicationRecord
  belongs_to :form
  belongs_to :user
end
