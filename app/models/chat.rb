class Chat < ApplicationRecord
  belongs_to :guardian, class_name: "User"
  belongs_to :provider, class_name: "User"
  has_many :messages
end
